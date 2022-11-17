import React from 'react';
import {createStackNavigator, Header} from '@react-navigation/stack';
import BottomTabNavigator from './BottomTabNavigator';

import SignInScreen from '../screens/SignsInScreen/SignInScreen';
import EditProfileScreen from '../screens/EditProfileScreen';

const Stack = createStackNavigator();

function AuthNavigator() {
  return (
    <Stack.Navigator initialRouteName="SignInScreen">
      <Stack.Screen
        name="SignInScreen"
        component={SignInScreen}
        options={{headerShown: false}}
      />
      <Stack.Screen
        name="Home"
        component={BottomTabNavigator}
        options={{headerShown: false}}
      />
      <Stack.Screen
        name="EditProfile"
        component={EditProfileScreen}
        options={{
          title: 'Edit',
          headerTintColor:'white',
          headerStyle: {backgroundColor: '#1E222D'},
        }}
      />
    </Stack.Navigator>
  );
}

export default AuthNavigator;
