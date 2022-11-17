/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import { NavigationContainer } from '@react-navigation/native';
import React from 'react';
import {SafeAreaView, StyleSheet, Text, StatusBar} from 'react-native';
import Navigation from './src/navigation';
import AuthNavigator from './src/navigation/AuthNavigator';

const App = () => {
  return (
    <NavigationContainer>
      <StatusBar barStyle="light-content" />
      <AuthNavigator />
    </NavigationContainer>
  );
};

const styles = StyleSheet.create({
  root:{
    flex:1,
    backgroundColor: "#1E222D"
  },
});

export default App;
 