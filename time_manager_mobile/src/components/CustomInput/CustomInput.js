import React from 'react';
import {View, Text, TextInput, StyleSheet} from 'react-native';

const CustomInput = ({value, set_value, placeholder, secureTextEntry}) => {
  return (
    <View style={styles.container}>
      <TextInput
        value={value}
        onChangeText={set_value}
        placeholder={placeholder}
        placeholderTextColor="white"
        style={styles.input}
        secureTextEntry={secureTextEntry}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#1E222D',
    width: '100%',
    height: '7%',

    borderColor: 'black',
    borderWidth: 1,
    borderRadius: 10,

    paddingTop: '4%',
    marginVertical: 10,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 3,
    },
    shadowOpacity: 0.27,
    shadowRadius: 4.65,

    elevation: 6,
  },
  input: {
    textAlignVertical: 'bottom',
    textAlign: 'center',
    color: 'white',
  },
});

export default CustomInput;
