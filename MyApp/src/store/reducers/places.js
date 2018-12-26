import { SET_PLACES, REMOVE_PLACE } from "../actions/actionTypes";

const intialState = {
  places: []
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
    default:
      return state;
  }
};

export default reducer;
