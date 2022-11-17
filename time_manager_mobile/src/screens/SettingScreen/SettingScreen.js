import React, {useEffect, useState} from 'react';
import axios from 'axios';
import SyncStorage from 'sync-storage';
import {Text, View, StyleSheet, Pressable} from 'react-native';
import CustomButton from '../../components/CustomButton';
//import CustomButton from '../../components/CustomButton';

const SettingScreen = ({navigation}) => {
  var [currentUser, setCurrentUser] = useState([]);

  useEffect(() => {
    setCurrentUser(SyncStorage.get('currentUser'));
  }, []);

  useEffect(() => {
    const focusHandler = navigation.addListener('focus', () => {
      setCurrentUser(SyncStorage.get('currentUser'));
    });
    return focusHandler;
  }, [navigation]);

  function edit() {
    navigation.navigate('EditProfile');
  }

  return (
    <View style={styles.root}>
      <View style={styles.body}>
        <Text style={styles.textStyle}>Username :{currentUser.username}</Text>
        <Text style={styles.textStyle}>Email : {currentUser.email}</Text>
        <Text style={styles.textStyle}>
          Team : {SyncStorage.get('currentUser').team_id.name}
        </Text>
        <CustomButton text="Edit" onPress={edit} type="Edit" />
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  root: {
    flex: 1,
    display: 'flex',
    backgroundColor: '#1E222D',
  },
  title: {
    marginTop: 80,
    marginLeft: 50,
    alignItems: 'flex-start',
    paddingBottom: 0,
    marginBottom: 0,
  },
  textStyle: {
    fontSize: 20,
    color: 'white',
  },
  headerBar: {
    marginTop: 0,
    paddingTop: 0,
    width: '100%',
    height: 1,
    backgroundColor: 'black',
  },
  body: {
    marginTop: 20,
    marginLeft: 20,
    //alignItems: 'flex-end',
  },
});

export default SettingScreen;
