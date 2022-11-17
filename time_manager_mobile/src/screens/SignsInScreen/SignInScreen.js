import axios from 'axios';
import React, {useState} from 'react';
import {View, Text, Image, StyleSheet, useWindowDimensions} from 'react-native';
import Logo from '../../../assets/images/logo.png';
import CustomButton from '../../components/CustomButton';
import CustomInput from '../../components/CustomInput';
import SyncStorage from 'sync-storage';

const SignInScreen = ({navigation}) => {
  const [username, set_username] = useState('');
  const [password, set_password] = useState('');

  const {height} = useWindowDimensions();

  async function maj_user() {
    let token = SyncStorage.get('token');
    let config = {headers: {Authorization: `Bearer ${JSON.parse(token)}`}};
    await axios
      .get('http://localhost:4000/api/user/', config)
      .then(async res => {
        console.log('okokokokokokok');
        console.log(res.data.data.id);
        console.log('okokokokokokok');
        SyncStorage.set('userID', res.data.data.id);
      });
  }

  function PressSignIn() {
    axios
      .post('http://localhost:4000/api/auth/users/login/', {
        username: username,
        password: password,
      })
      .then(async res => {
        if (res.data.success) {
          SyncStorage.set('token', JSON.stringify(res.data.token));
          await axios
            .get('http://localhost:4000/api/user', {
              headers: {Authorization: `Bearer ${res.data.token}`},
            })
            .then(async res => {
              SyncStorage.set('currentUser', res.data.data);
            });
          await maj_user();
          navigation.navigate('Home');
        } else {
          console.warn('Undified User');
        }
      })
      .catch(error => {
        console.log(error);
      });
  }

  return (
    <View style={styles.root}>
      <Image
        source={Logo}
        style={[styles.logo, {height: height * 0.3}]}
        resizeMode="contain"
        tintColor="red"
      />

      <CustomInput
        placeholder="Username"
        value={username}
        set_value={set_username}
        secureTextEntry={false}
      />

      <CustomInput
        placeholder="Password"
        value={password}
        set_value={set_password}
        secureTextEntry={true}
      />

      <CustomButton text="Sign In" onPress={PressSignIn} type="Login" />
    </View>
  );
};

const styles = StyleSheet.create({
  root: {
    color: 'red',
    height: '100%',
    alignItems: 'center',
    padding: 20,
    backgroundColor: '#10131A',
  },
  logo: {
    paddingVertical: 200,
    width: '70%',
    maxWidth: 300,
    maxHeight: 200,
  },
});

export default SignInScreen;
