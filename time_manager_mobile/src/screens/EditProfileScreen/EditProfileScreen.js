import React, {useEffect, useState} from 'react';
import axios from 'axios';
import SyncStorage from 'sync-storage';
import {Text, View, StyleSheet, Pressable} from 'react-native';
import CustomButton from '../../components/CustomButton';
import CustomInput from '../../components/CustomInput';
//import CustomButton from '../../components/CustomButton';

const EditProfileScreen = ({ route, navigation }) => {
  var user = SyncStorage.get('currentUser');
  const [username, setUsername] = useState(user.username);
  const [email, setEmail] = useState(user.email);

  function submitChange() {
    let token = SyncStorage.get('token');
    let config = {headers: {Authorization: `Bearer ${JSON.parse(token)}`}};
    axios
      .put(
        'http://localhost:4000/api/users/' + user.id + '/',
        {username: username, email: email},
        config,
      )
      .then(res => {
        SyncStorage.set('currentUser', res.data.data);
        navigation.navigate('SettingScreen');
      });
  }

  return (
    <View style={styles.root}>
      <CustomInput
        placeholder="Email"
        value={email}
        set_value={setEmail}
        secureTextEntry={false}
      />
      <CustomInput
        placeholder="Username"
        value={username}
        set_value={setUsername}
        secureTextEntry={false}
      />
      <CustomButton text="Submit" onPress={submitChange} type="Edit" />
    </View>
  );
};

const styles = StyleSheet.create({
  root: {
    flex: 1,
    display: 'flex',
    backgroundColor: '#1E222D',
  },
});

export default EditProfileScreen;
