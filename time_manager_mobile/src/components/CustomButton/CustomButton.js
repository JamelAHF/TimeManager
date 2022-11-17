import React from 'react';
import {Text, StyleSheet, Pressable} from 'react-native';

const CustomButton = ({onPress, text, type}) => {
  if (type == 'Login') {
    return (
      <Pressable onPress={onPress} style={styles.login}>
        <Text style={styles.text}>{text}</Text>
      </Pressable>
    );
  } else if (type == 'Logout') {
    return (
      <Pressable onPress={onPress} style={styles.logout}>
        <Text style={styles.text}>{text}</Text>
      </Pressable>
    );
  } else if (type == 'Clock') {
    return (
      <Pressable onPress={onPress} style={styles.clock}>
        <Text style={styles.text}>{text}</Text>
      </Pressable>
    );
  } else if (type == 'Edit') {
    return (
      <Pressable onPress={onPress} style={styles.edit}>
        <Text style={styles.text}>{text}</Text>
      </Pressable>
    );
  } else if (type == 'Search') {
    return (
      <Pressable onPress={onPress} style={styles.search}>
        <Text style={styles.text}>{text}</Text>
      </Pressable>
    );
  }
};

const styles = StyleSheet.create({
  edit: {
    backgroundColor: '#FF6700',
    width: '25%',
    padding: 10,
    marginVertical: 10,
    alignItems: 'center',
    borderRadius: 10,
  },
  login: {
    backgroundColor: '#FF6700',
    width: '100%',
    padding: 10,
    marginVertical: 10,
    alignItems: 'center',
    borderRadius: 10,
  },
  logout: {
    backgroundColor: '#FF6700',
    width: '100%',
    padding: 10,
    marginVertical: 10,
    alignItems: 'center',
    borderRadius: 10,
  },
  search: {
    backgroundColor: '#FF6700',
    width: "90%",
    height: "5%",
    marginTop:"17%",
    marginLeft:"5%",
    alignItems: 'center',
    justifyContent:"center",
    borderRadius: 10,

  },

  clock: {
    backgroundColor: '#FF6700',
    width: 150,
    height: 150,
    borderRadius: 100,
    justifyContent: 'center',
    alignItems: 'center',
  },
  text: {
    color: 'white',
    fontWeight: 'bold',
  },
});

export default CustomButton;
