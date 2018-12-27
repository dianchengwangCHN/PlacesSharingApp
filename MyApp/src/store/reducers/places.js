import {
  SET_PLACES,
  REMOVE_PLACE,
  PLACE_ADDED,
  START_ADD_PLACE
} from "../actions/actionTypes";

const intialState = {
  places: [],
  placeAdded: false
};

const reducer = (state = intialState, action) => {
  switch (action.type) {
    case SET_PLACES:
      return {
        ...state,
        places: action.places
      };
    case REMOVE_PLACE:
      return {
        ...state,
        places: state.places.filter(place => {
          return place.key !== action.key;
        })
      };
    case PLACE_ADDED:
      return {
        ...state,
        placeAdded: true
      };
    case START_ADD_PLACE:
      return {
        ...state,
        placeAdded: false
      };
    default:
      return state;
  }
};

export default reducer;
