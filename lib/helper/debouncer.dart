import 'dart:async';
// Creditos
// https://stackoverflow.com/a/52922130/7834829

class Debouncer<T> {

  Debouncer({ 
    required this.duration,// cantidad de tiempo a esperar antes de emitir un valor
    this.onValue //metodo que se dispara cuando tenga un valor
  });

  final Duration duration;

  void Function(T value)? onValue;

  T? _value;
  Timer? _timer;
  
  T get value => _value!;

  set value(T val) {
    _value = val;
    _timer?.cancel();// vancelar el timer
    _timer = Timer(duration, () => onValue!(_value!)); // si el timer se cumple se llama la fucnion on vlaue
  }  
}