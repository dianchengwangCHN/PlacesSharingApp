import React, { Component } from "react";
import {
  View,
  Text,
  Button,
  TextInput,
  StyleSheet,
  ImageBackground,
  Dimensions,
  KeyboardAvoidingView,
  Keyboard,
  TouchableWithoutFeedback,
  ActivityIndicator
} from "react-native";
import { connect } from "react-redux";

import DefaultInput from "../../components/UI/DefaultInput/DefaultInput";
import HeadingText from "../../components/UI/HeadingText/HeadingText";
import MainText from "../../components/UI/MainText/MainText";
import ButtonWithBackground from "../../components/UI/ButtonWithBackground/ButtonWithBackground";
import validate from "../../utility/validation";
import backgroundImage from "../../assets/background.jpg";
import { tryAuth, authAutoSignIn } from "../../store/actions/index";

class AuthScreen extends Component {
  state = {
    viewMode: Dimensions.get("window").height > 500 ? "portrait" : "landscape",
    authMode: "login",
    controls: {
      email: {
        value: "",
        valid: false,
        touched: false,
        validationRules: {
          isEmail: true
        }
      },
      password: {
        value: "",
        valid: false,
        touched: false,
        validationRules: {
          minLength: 6
        }
      },
      confirmPassword: {
        value: "",
        valid: false,
        touched: false,
        validationRules: {
          equalTo: "password"
        }
      }
    }
  };

  constructor(props) {
    super(props);
    Dimensions.addEventListener("change", this.updateStyles);
  }

  switchAuthModeHandler = () => {
    this.setState(prevState => {
      return {
        authMode: prevState.authMode === "login" ? "signup" : "login"
      };
    });
  };

  componentWillUnmount() {
    Dimensions.removeEventListener("change", this.updateStyles);
  }

  componentDidMount() {
    this.props.onAutoSignIn();
  }

  updateStyles = dims => {
    this.setState({
      viewMode: dims.window.height > 500 ? "portrait" : "landscape"
    });
  };

  authHandler = () => {
    const authData = {
      email: this.state.controls.email.value,
      password: this.state.controls.password.value
    };
    this.props.onTryAuth(authData, this.state.authMode);
  };

  updateInputState = (key, value) => {
    let connectedValue = {};
    if (this.state.controls[key].validationRules.equalTo) {
      const equalControl = this.state.controls[key].validationRules.equalTo;
      const equalValue = this.state.controls[equalControl].value;
      connectedValue = {
        ...connectedValue,
        equalTo: equalValue
      };
    }
    if (key === "password") {
      connectedValue = {
        ...connectedValue,
        equalTo: value
      };
    }
    this.setState(prevState => {
      return {
        controls: {
          ...prevState.controls,
          confirmPassword: {
            ...prevState.controls.confirmPassword,
            valid:
              key === "password"
                ? validate(
                    prevState.controls.confirmPassword.value,
                    prevState.controls.confirmPassword.validationRules,
                    connectedValue
                  )
                : prevState.controls.confirmPassword.valid
          },
          [key]: {
            ...prevState.controls[key],
            value: value,
            valid: validate(
              value,
              prevState.controls[key].validationRules,
              connectedValue
            ),
            touched: true
          }
        }
      };
    });
  };

  render() {
    let headingText = null;
    let confirmPasswordView = null;
    let submitButton = (
      <ButtonWithBackground
        color='#29aaf4'
        onPress={this.authHandler}
        disabled={
          !this.state.controls.email.valid ||
          !this.state.controls.password.valid ||
          (this.state.authMode === "signup" &&
            !this.state.controls.confirmPassword.valid)
        }
      >
        Submit
      </ButtonWithBackground>
    );

    if (this.props.isLoading) {
      submitButton = <ActivityIndicator />;
    }
    if (this.state.viewMode === "portrait") {
      headingText = (
        <MainText>
          <HeadingText>Please {this.state.authMode === "login" ? "Login" : "Sign Up"}</HeadingText>
        </MainText>
      );
    }
    if (this.state.authMode === "signup") {
      confirmPasswordView = (
        <View
          style={
            this.state.viewMode === "portrait"
              ? styles.portraitPasswordWrapper
              : styles.landscapePasswordWrapper
          }
        >
          <DefaultInput
            placeholder='Confirm Password'
            value={this.state.controls.confirmPassword.value}
            valid={this.state.controls.confirmPassword.valid}
            touched={this.state.controls.confirmPassword.touched}
            onChangeText={val => this.updateInputState("confirmPassword", val)}
            secureTextEntry={true}
          />
        </View>
      );
    }
    return (
      <ImageBackground source={backgroundImage} style={styles.backgroundImage}>
        <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
          <KeyboardAvoidingView style={styles.container} behavior='padding'>
            {headingText}
            <ButtonWithBackground
              color='#29aaf4'
              onPress={this.switchAuthModeHandler}
            >
              Switch to {this.state.authMode === "login" ? "Sign Up" : "Login"}
            </ButtonWithBackground>
            <View style={styles.inputContainer}>
              <DefaultInput
                placeholder='Your E-Mail Address'
                value={this.state.controls.email.value}
                valid={this.state.controls.email.valid}
                touched={this.state.controls.email.touched}
                onChangeText={val => this.updateInputState("email", val)}
                autoCapitalize='none'
                autoCorrect={false}
                keyboardType='email-address'
              />
              <View
                style={
                  this.state.viewMode === "portrait"
                    ? styles.portraitPasswordContainer
                    : styles.landscapePasswordContainer
                }
              >
                <View
                  style={
                    this.state.viewMode === "portrait" ||
                    this.state.authMode === "login"
                      ? styles.portraitPasswordWrapper
                      : styles.landscapePasswordWrapper
                  }
                >
                  <DefaultInput
                    placeholder='Password'
                    value={this.state.controls.password.value}
                    valid={this.state.controls.password.valid}
                    touched={this.state.controls.password.touched}
                    onChangeText={val => this.updateInputState("password", val)}
                    secureTextEntry={true}
                  />
                </View>
                {confirmPasswordView}
              </View>
            </View>
            {submitButton}
          </KeyboardAvoidingView>
        </TouchableWithoutFeedback>
      </ImageBackground>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center"
  },
  backgroundImage: {
    width: "100%",
    height: "100%",
    flex: 1
  },
  inputContainer: {
    width: "80%"
  },
  landscapePasswordContainer: {
    flexDirection: "row",
    justifyContent: "space-between"
  },
  portraitPasswordContainer: {
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  landscapePasswordWrapper: {
    width: "45%"
  },
  portraitPasswordWrapper: {
    width: "100%"
  }
});

const mapStateToProps = state => {
  return {
    isLoading: state.ui.isLoading
  };
};

const mapDispatchToProps = dispatch => {
  return {
    onTryAuth: (authData, authMode) => dispatch(tryAuth(authData, authMode)),
    onAutoSignIn: () => dispatch(authAutoSignIn())
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(AuthScreen);
