import React from 'react';
import {StyleSheet} from 'react-native';
import {createBottomTabNavigator} from '@react-navigation/bottom-tabs';
import WorkingTimesScreen from '../screens/WorkingTimesScreen';
import ClockScreen from '../screens/ClockScreen';
import Icon from 'react-native-vector-icons/MaterialCommunityIcons';
import CustomTabBarButton from '../components/CustomTabBarButton';
import CustomTabBar from '../components/CustomTabBar';
import SettingScreen from '../screens/SettingScreen';

const Tab = createBottomTabNavigator();

function BottomTabNavigator() {
  return (
    <Tab.Navigator
      initialRouteName="ClockScreen"
      tabBar={props => <CustomTabBar {...props} />}
      screenOptions={({route}) => ({
        tabBarShowLabel: false,
        tabBarStyle: styles.tabBarStyle,
        tabBarInactiveTintColor: 'white',
        tabBarActiveTintColor: '#FF6700',
        tabBarIcon: ({color, size, focused}) => {
          let iconName;
          if (route.name === 'ClockScreen') {
            iconName = focused ? 'home' : 'home-outline';
          } else if (route.name === 'WorkingTimesScreen') {
            iconName = focused ? 'calendar-clock' : 'calendar-clock-outline';
          } else if (route.name === 'SettingScreen') {
            iconName = focused ? 'account' : 'account-outline';
          }
          return <Icon name={iconName} size={22} color={color} />;
        },
      })}>
      <Tab.Screen
        name="WorkingTimesScreen"
        component={WorkingTimesScreen}
        options={{
          headerShown: false,
          tabBarButton: props => <CustomTabBarButton route="home" {...props} />,
        }}
      />
      <Tab.Screen
        name="ClockScreen"
        component={ClockScreen}
        options={{
          headerStyle: {backgroundColor:'#1E222D'},
          headerShown: false,
          tabBarButton: props => (
            <CustomTabBarButton route="ClockScreen" {...props} />
          ),
        }}
      />
      <Tab.Screen
        name="SettingScreen"
        component={SettingScreen}
        options={{
          title: 'Profile',
          headerTintColor: 'white',
          headerStyle: {backgroundColor: '#1E222D'},
          tabBarButton: props => (
            <CustomTabBarButton route="settings" {...props} />
          ),
        }}
      />
    </Tab.Navigator>
  );
}

export default BottomTabNavigator;

const styles = StyleSheet.create({
  tabBarStyle: {
    position: 'absolute',
    backgroundColor: 'transparent',
    borderTopWidth: 0,
    bottom: 15,
    right: 10,
    left: 10,
    height: 92,
  },
});