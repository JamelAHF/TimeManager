import AsyncStorage from '@react-native-async-storage/async-storage';

export async function storeToken(value) {
  try {
    const jsonValue = JSON.stringify(value);
    await AsyncStorage.setItem('@token', jsonValue);
  } catch (e) {
    // saving error
  }
}

export async function getToken() {
  try {
    const jsonValue = await AsyncStorage.getItem('@token');
    return jsonValue != null ? JSON.parse(jsonValue) : null;
  } catch (e) {
    // error reading value
  }
}


