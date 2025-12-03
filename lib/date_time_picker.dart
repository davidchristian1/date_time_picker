library date_time_picker;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum DateTimePickerType { date, time, dateTime, dateTimeSeparate }

class DateTimePicker extends FormField<String> {
  DateTimePicker({
    Key? key,
    this.type = DateTimePickerType.date,
    this.controller,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.initialTime,
    this.dateMask,
    this.icon,
    this.dateLabelText,
    this.timeLabelText,
    this.dateHintText,
    this.timeHintText,
    this.calendarTitle,
    this.cancelText,
    this.confirmText,
    this.fieldLabelText,
    this.fieldHintText,
    this.errorFormatText,
    this.errorInvalidText,
    this.initialEntryMode,
    this.initialDatePickerMode,
    this.selectableDayPredicate,
    this.textDirection,
    this.locale,
    this.useRootNavigator = false,
    this.routeSettings,
    this.use24HourFormat = true,
    this.timeFieldWidth,
    this.timePickerEntryModeInput = false,
    String? initialValue,
    FocusNode? focusNode,
    InputDecoration? decoration,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions? toolbarOptions,
    bool showCursor = false,
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    bool autovalidate = false,
    MaxLengthEnforcement? maxLengthEnforcement,
    int maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    this.onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatters,
    bool enabled = true,
    double cursorWidth = 2.0,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
  })  : assert(initialValue == null || controller == null),
        assert(type == DateTimePickerType.time || firstDate != null),
        assert(type == DateTimePickerType.time || lastDate != null),
        assert(maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(
          !expands || (minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(
          !obscureText || maxLines == 1,
          'Obscured fields cannot be multiline.',
        ),
        assert(maxLength == null || maxLength > 0),
        super(
          key: key,
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          enabled: enabled,
          builder: (FormFieldState<String> field) {
            final state = field as _DateTimePickerState;

            void onChangedHandler(String value) {
              if (onChanged != null) {
                onChanged(value);
              }
              field.didChange(value);
            }

            Widget buildField(DateTimePickerType peType) {
              GestureTapCallback lfOnTap;
              TextEditingController loCtrl;
              InputDecoration loDecoration;

              switch (peType) {
                case DateTimePickerType.time:
                  lfOnTap = state._showTimePickerDialog;
                  loCtrl = state._timeLabelController;
                  loDecoration = InputDecoration(
                    labelText: timeLabelText,
                    icon: icon,
                    hintText: timeHintText,
                  );

                  if (type == DateTimePickerType.dateTimeSeparate) {
                    loDecoration = InputDecoration(
                      labelText: timeLabelText,
                      hintText: timeHintText,
                    );
                  }
                  break;
                case DateTimePickerType.dateTime:
                  lfOnTap = state._showDateTimePickerDialog;
                  loCtrl = state._dateLabelController;
                  loDecoration = InputDecoration(
                    labelText: dateLabelText,
                    icon: icon,
                    hintText: dateHintText,
                  );
                  break;
                default:
                  lfOnTap = state._showDatePickerDialog;
                  loCtrl = state._dateLabelController;
                  loDecoration = InputDecoration(
                    labelText: dateLabelText,
                    icon: icon,
                    hintText: dateHintText,
                  );
              }

              loDecoration = decoration ?? loDecoration
                ..applyDefaults(
                  Theme.of(field.context).inputDecorationTheme,
                );

              return TextField(
                readOnly: true,
                onTap: readOnly ? null : lfOnTap,
                controller: loCtrl,
                decoration: loDecoration.copyWith(
                  errorText: field.errorText,
                ),
                focusNode: focusNode,
                keyboardType: TextInputType.datetime,
                textInputAction: textInputAction,
                style: style,
                strutStyle: strutStyle,
                textAlign: textAlign,
                textAlignVertical: textAlignVertical,
                //textDirection: textDirection,
                textCapitalization: textCapitalization,
                autofocus: autofocus,
                toolbarOptions: toolbarOptions,
                showCursor: showCursor,
                obscureText: obscureText,
                autocorrect: autocorrect,
                smartDashesType: smartDashesType ??
                    (obscureText
                        ? SmartDashesType.disabled
                        : SmartDashesType.enabled),
                smartQuotesType: smartQuotesType ??
                    (obscureText
                        ? SmartQuotesType.disabled
                        : SmartQuotesType.enabled),
                enableSuggestions: enableSuggestions,
                maxLengthEnforcement: maxLengthEnforcement,
                maxLines: maxLines,
                minLines: minLines,
                expands: expands,
                maxLength: maxLength,
                onChanged: onChangedHandler,
                onEditingComplete: onEditingComplete,
                onSubmitted: onFieldSubmitted,
                inputFormatters: inputFormatters,
                enabled: enabled,
                cursorWidth: cursorWidth,
                cursorRadius: cursorRadius,
                cursorColor: cursorColor,
                scrollPadding: scrollPadding,
                scrollPhysics: scrollPhysics,
                keyboardAppearance: keyboardAppearance,
                enableInteractiveSelection: enableInteractiveSelection,
                buildCounter: buildCounter,
              );
            }

            switch (type) {
              case DateTimePickerType.time:
                return buildField(DateTimePickerType.time);
              case DateTimePickerType.dateTime:
                return buildField(DateTimePickerType.dateTime);
              case DateTimePickerType.dateTimeSeparate:
                return Row(children: <Widget>[
                  Expanded(child: buildField(DateTimePickerType.date)),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: timeFieldWidth ?? 100,
                    child: buildField(DateTimePickerType.time),
                  )
                ]);
              default:
                return buildField(DateTimePickerType.date);
            }
          },
        );
  final DateTimePickerType type;
  final TextEditingController? controller;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final TimeOfDay? initialTime;
  final String? dateMask;
  final Widget? icon;
  final String? dateLabelText;
  final String? timeLabelText;
  final String? dateHintText;
  final String? timeHintText;
  final String? calendarTitle;
  final String? cancelText;
  final String? confirmText;
  final String? fieldLabelText;
  final String? fieldHintText;
  final String? errorFormatText;
  final String? errorInvalidText;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool useRootNavigator;
  final RouteSettings? routeSettings;
  final DatePickerEntryMode? initialEntryMode;
  final DatePickerMode? initialDatePickerMode;
  final bool Function(DateTime)? selectableDayPredicate;
  final bool use24HourFormat;
  final double? timeFieldWidth;
  final bool timePickerEntryModeInput;
  final ValueChanged<String>? onChanged;

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends FormFieldState<String> {
  TextEditingController? _stateController;
  final TextEditingController _dateLabelController = TextEditingController();
  final TextEditingController _timeLabelController = TextEditingController();
  DateTime _dDate = DateTime.now();
  TimeOfDay _tTime = TimeOfDay.now();

  // _sValue = stored parseable value
  // For dateTime: 'yyyy-MM-dd HH:mm'
  // For date only: 'yyyy-MM-dd'
  // For time only: 'HH:mm'
  String _sValue = '';
  // Human display strings
  String _sDate = '';
  String _sTime = '';
  String _sPeriod = '';

  @override
  DateTimePicker get widget => super.widget as DateTimePicker;

  TextEditingController? get _effectiveController =>
      widget.controller ?? _stateController;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _stateController = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller?.addListener(_handleControllerChanged);
    }

    initValues();
  }

  // ---------- helpers ----------
  String _intlLocaleString() {
    final loc = widget.locale;
    if (loc == null) return Intl.getCurrentLocale();
    final cc = loc.countryCode;
    if (cc != null && cc.isNotEmpty) {
      return '${loc.languageCode}-${cc}'; // en-AU
    }
    return loc.languageCode; // 'en'
  }

  DateTime _parseStoredDateTime(String v) {
    // expects 'yyyy-MM-dd HH:mm'
    return DateFormat('yyyy-MM-dd HH:mm').parse(v, false);
  }

  DateTime _parseStoredDate(String v) {
    // expects 'yyyy-MM-dd'
    return DateFormat('yyyy-MM-dd').parse(v, false);
  }

  TimeOfDay _parseStoredTime(String v) {
    final dt = DateFormat('HH:mm').parse(v, false);
    return TimeOfDay.fromDateTime(dt);
  }

  String _formatStoredDateTime(DateTime dt) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dt);
  }

  String _formatStoredDate(DateTime dt) {
    return DateFormat('yyyy-MM-dd').format(dt);
  }

  String _formatStoredTime(DateTime dt) {
    return DateFormat('HH:mm').format(dt);
  }

  // ---------- initialization ----------
  void initValues() {
    _dDate = widget.initialDate ?? DateTime.now();
    _tTime = widget.initialTime ?? TimeOfDay.now();

    final lsValue = _effectiveController?.text.trim();
    final localeStr = _intlLocaleString();

    if (lsValue != null && lsValue != '' && lsValue != 'null') {
      if (widget.type == DateTimePickerType.time) {
        // stored format: 'HH:mm'
        try {
          _tTime = _parseStoredTime(lsValue);
          _sTime = widget.use24HourFormat
              ? DateFormat('HH:mm', localeStr)
                  .format(DateFormat('HH:mm').parse(lsValue))
              : DateFormat('hh:mm a', localeStr)
                  .format(DateFormat('HH:mm').parse(lsValue));
          _sPeriod = widget.use24HourFormat
              ? ''
              : ' ' + DateFormat('a', localeStr)
                  .format(DateFormat('HH:mm').parse(lsValue));
          _sValue = lsValue;
          _timeLabelController.text = _sTime + _sPeriod;
        } catch (_) {
          // fallback
          _sValue = '';
        }
      } else if (widget.type == DateTimePickerType.date) {
        // stored format: 'yyyy-MM-dd'
        try {
          _dDate = _parseStoredDate(lsValue);
          _sDate = _formatStoredDate(_dDate);
          // display date
          if (widget.dateMask != null && widget.dateMask!.isNotEmpty) {
            _dateLabelController.text =
                DateFormat(widget.dateMask!, localeStr).format(_dDate);
          } else {
            _dateLabelController.text =
                DateFormat('MMM dd, yyyy', localeStr).format(_dDate);
          }
          _sValue = _sDate;
        } catch (_) {
          _sValue = '';
        }
      } else {
        // dateTime or dateTimeSeparate — stored format: 'yyyy-MM-dd HH:mm'
        try {
          final dt = _parseStoredDateTime(lsValue);
          _dDate = DateTime(dt.year, dt.month, dt.day);
          _tTime = TimeOfDay.fromDateTime(dt);

          // display time
          _sTime = widget.use24HourFormat
              ? DateFormat('HH:mm', localeStr).format(dt)
              : DateFormat('hh:mm', localeStr).format(dt);
          _sPeriod =
              widget.use24HourFormat ? '' : ' ' + DateFormat('a', localeStr).format(dt);

          // display date
          _sDate = DateFormat('yyyy-MM-dd').format(_dDate);

          // date label (with mask if provided)
          if (widget.dateMask != null && widget.dateMask!.isNotEmpty) {
            _dateLabelController.text =
                DateFormat(widget.dateMask!, localeStr).format(dt);
          } else {
            final lsMask = _sTime != '' ? 'MMM dd, yyyy - HH:mm' : 'MMM dd, yyyy';
            _dateLabelController.text =
                DateFormat(lsMask, localeStr).format(dt);
          }

          _timeLabelController.text = (_sTime + _sPeriod).trim();
          _sValue = _formatStoredDateTime(dt);
        } catch (_) {
          _sValue = '';
        }
      }
    } else {
      // No existing value — show initial if available
      if (widget.type == DateTimePickerType.time) {
        _tTime = widget.initialTime ?? TimeOfDay.now();
        final built = DateTime(
            _dDate.year, _dDate.month, _dDate.day, _tTime.hour, _tTime.minute);
        _sTime = widget.use24HourFormat
            ? DateFormat('HH:mm', _intlLocaleString()).format(built)
            : DateFormat('hh:mm', _intlLocaleString()).format(built);
        _sPeriod = widget.use24HourFormat
            ? ''
            : ' ' + DateFormat('a', _intlLocaleString()).format(built);
        _timeLabelController.text = (_sTime + _sPeriod).trim();
      } else {
        // date or dateTime
        final built = widget.initialDate ?? DateTime.now();
        _dDate = built;
        if (widget.type == DateTimePickerType.date) {
          _sDate = DateFormat('yyyy-MM-dd').format(_dDate);
          _dateLabelController.text = widget.dateMask != null && widget.dateMask!.isNotEmpty
              ? DateFormat(widget.dateMask!, _intlLocaleString()).format(_dDate)
              : DateFormat('MMM dd, yyyy', _intlLocaleString()).format(_dDate);
          _sValue = _sDate;
        } else {
          // dateTime initial
          final initialTime = widget.initialTime ?? TimeOfDay.fromDateTime(DateTime.now());
          final combined = DateTime(
              _dDate.year, _dDate.month, _dDate.day, initialTime.hour, initialTime.minute);
          _sTime = widget.use24HourFormat
              ? DateFormat('HH:mm', _intlLocaleString()).format(combined)
              : DateFormat('hh:mm', _intlLocaleString()).format(combined);
          _sPeriod = widget.use24HourFormat
              ? ''
              : ' ' + DateFormat('a', _intlLocaleString()).format(combined);
          _timeLabelController.text = (_sTime + _sPeriod).trim();

          _dateLabelController.text = widget.dateMask != null && widget.dateMask!.isNotEmpty
              ? DateFormat(widget.dateMask!, _intlLocaleString()).format(combined)
              : DateFormat('MMM dd, yyyy - HH:mm', _intlLocaleString()).format(combined);

          _sValue = _formatStoredDateTime(combined);
        }
      }
    }
  }

  @override
  void didUpdateWidget(DateTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    final localeStr = _intlLocaleString();

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _stateController =
            TextEditingController.fromValue(oldWidget.controller?.value);
      }

      if (widget.controller != null) {
        setValue(widget.controller?.text);

        if (oldWidget.controller == null) {
          _stateController = null;
        }
      }
    }

    final effectiveText = _effectiveController?.text;
    if (effectiveText != null && effectiveText.trim().isNotEmpty) {
      final lsValue = effectiveText.trim();

      if (widget.type == DateTimePickerType.time) {
        try {
          _tTime = _parseStoredTime(lsValue);
          final dt = DateFormat('HH:mm').parse(lsValue);
          _sTime = widget.use24HourFormat
              ? DateFormat('HH:mm', localeStr).format(dt)
              : DateFormat('hh:mm', localeStr).format(dt);
          _sPeriod = widget.use24HourFormat ? '' : ' ' + DateFormat('a', localeStr).format(dt);
          _timeLabelController.text = (_sTime + _sPeriod).trim();
          _sValue = lsValue;
        } catch (_) {}
      } else if (widget.type == DateTimePickerType.date) {
        try {
          final dt = _parseStoredDate(lsValue);
          _dDate = dt;
          _sDate = DateFormat('yyyy-MM-dd').format(_dDate);
          _dateLabelController.text = widget.dateMask != null && widget.dateMask!.isNotEmpty
              ? DateFormat(widget.dateMask!, localeStr).format(_dDate)
              : DateFormat('MMM dd, yyyy', localeStr).format(_dDate);
          _sValue = _sDate;
        } catch (_) {}
      } else {
        // dateTime or dateTimeSeparate
        try {
          final dt = _parseStoredDateTime(lsValue);
          _dDate = DateTime(dt.year, dt.month, dt.day);
          _tTime = TimeOfDay.fromDateTime(dt);

          _sTime = widget.use24HourFormat
              ? DateFormat('HH:mm', localeStr).format(dt)
              : DateFormat('hh:mm', localeStr).format(dt);
          _sPeriod = widget.use24HourFormat ? '' : ' ' + DateFormat('a', localeStr).format(dt);

          _sDate = DateFormat('yyyy-MM-dd').format(_dDate);

          if (widget.dateMask != null && widget.dateMask!.isNotEmpty) {
            _dateLabelController.text = DateFormat(widget.dateMask!, localeStr).format(dt);
          } else {
            final lsMask = _sTime != '' ? 'MMM dd, yyyy - HH:mm' : 'MMM dd, yyyy';
            _dateLabelController.text = DateFormat(lsMask, localeStr).format(dt);
          }

          _timeLabelController.text = (_sTime + _sPeriod).trim();
          _sValue = _formatStoredDateTime(dt);
        } catch (_) {}
      }
    } else {
      _dateLabelController.clear();
      _timeLabelController.clear();
      initValues();
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _dateLabelController.dispose();
    _timeLabelController.dispose();
    super.dispose();
  }

  @override
  void reset() {
    super.reset();

    setState(() {
      _effectiveController?.text = widget.initialValue ?? '';
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController?.text != value) {
      didChange(_effectiveController?.text);
    }
  }

  void onChangedHandler(String value) {
    widget.onChanged?.call(value);
    didChange(value);
  }

  // ---------- show date picker ----------
  Future<void> _showDatePickerDialog() async {
    final ldDatePicked = await showDatePicker(
      context: context,
      initialDate: _dDate,
      firstDate: widget.firstDate ?? DateTime.now(),
      lastDate: widget.lastDate ?? DateTime.now(),
      helpText: widget.calendarTitle,
      cancelText: widget.cancelText,
      confirmText: widget.confirmText,
      initialDatePickerMode: widget.initialDatePickerMode ?? DatePickerMode.day,
      initialEntryMode: widget.initialEntryMode ?? DatePickerEntryMode.calendar,
      selectableDayPredicate: widget.selectableDayPredicate,
      fieldLabelText: widget.fieldLabelText,
      fieldHintText: widget.fieldHintText,
      errorFormatText: widget.errorFormatText,
      errorInvalidText: widget.errorInvalidText,
      //textDirection: widget.textDirection,
      locale: widget.locale,
      useRootNavigator: widget.useRootNavigator,
      routeSettings: widget.routeSettings,
    );

    final localeStr = _intlLocaleString();
    if (ldDatePicked != null) {
      _dDate = ldDatePicked;
      _sDate = _formatStoredDate(_dDate);
      final lsOldValue = _sValue;

      if (widget.type == DateTimePickerType.dateTimeSeparate && _sTime != '') {
        // keep existing time and combine
        final full = DateFormat('yyyy-MM-dd').parse(_sDate);
        final combined = DateTime(
            _dDate.year,
            _dDate.month,
            _dDate.day,
            _tTime.hour,
            _tTime.minute);
        _sValue = _formatStoredDateTime(combined);
      } else {
        _sValue = _sDate;
      }

      // date label for display
      if (widget.dateMask != null && widget.dateMask!.isNotEmpty) {
        _dateLabelController.text =
            DateFormat(widget.dateMask!, localeStr).format(_dDate);
      } else {
        _dateLabelController.text =
            DateFormat('MMM dd, yyyy', localeStr).format(_dDate);
      }

      _effectiveController?.text = _sValue;

      if (_sValue != lsOldValue) {
        onChangedHandler(_sValue);
      }
    }
  }

  // ---------- 12-hour helper ----------
  String _set12HourTimeValues(final TimeOfDay ptTimePicked) {
    final built = DateTime(
      _dDate.year,
      _dDate.month,
      _dDate.day,
      ptTimePicked.hour,
      ptTimePicked.minute,
    );
    final localeStr = _intlLocaleString();

    final formatted = DateFormat('hh:mm a', localeStr).format(built); // e.g. "07:30 PM"
    final parts = formatted.split(' ');
    _sTime = parts.isNotEmpty ? parts[0] : DateFormat('hh:mm', localeStr).format(built);
    _sPeriod = parts.length > 1 ? ' ${parts[1]}' : '';
    // return parseable stored 24-hour time 'HH:mm'
    return _formatStoredTime(built);
  }

  // ---------- show time picker ----------
  Future<void> _showTimePickerDialog() async {
    final ltTimePicked = await showTimePicker(
      context: context,
      initialTime: _tTime,
      initialEntryMode: widget.timePickerEntryModeInput
          ? TimePickerEntryMode.input
          : TimePickerEntryMode.dial,
      useRootNavigator: widget.useRootNavigator,
      routeSettings: widget.routeSettings,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(alwaysUse24HourFormat: widget.use24HourFormat),
          child: child ?? const SizedBox(),
        );
      },
    );

    if (ltTimePicked != null) {
      _tTime = ltTimePicked;

      final localeStr = _intlLocaleString();

      // Build a DateTime with the currently selected date + picked time
      final selectedDateTime = DateTime(
        _dDate.year,
        _dDate.month,
        _dDate.day,
        ltTimePicked.hour,
        ltTimePicked.minute,
      );

      // Display string depends on 24-hour setting
      final displayTime = widget.use24HourFormat
          ? DateFormat('HH:mm', localeStr).format(selectedDateTime)
          : DateFormat('hh:mm a', localeStr).format(selectedDateTime);

      // stored time always HH:mm
      final storedTime = DateFormat('HH:mm').format(selectedDateTime);

      // update display components
      if (widget.use24HourFormat) {
        _sTime = DateFormat('HH:mm', localeStr).format(selectedDateTime);
        _sPeriod = '';
      } else {
        // set using helper to guarantee correct AM/PM
        final stored = _set12HourTimeValues(ltTimePicked);
        _sTime = widget.use24HourFormat
            ? DateFormat('HH:mm', localeStr).format(selectedDateTime)
            : _sTime; // already set by helper
        // helper returns stored HH:mm, but we also set _sPeriod in helper
      }

      _timeLabelController.text = displayTime.trim();

      final lsOldValue = _sValue;

      // Update stored value depending on type
      if (widget.type == DateTimePickerType.time) {
        _sValue = storedTime;
      } else if (widget.type == DateTimePickerType.dateTimeSeparate && _sDate != '') {
        _sValue = '${_sDate} $storedTime'; // yyyy-MM-dd HH:mm
      } else {
        // When used inside a dateTime widget, the date should already be managed elsewhere
        _sValue = storedTime;
      }

      _effectiveController?.text = _sValue;

      if (_sValue != lsOldValue) {
        onChangedHandler(_sValue);
      }
    }
  }

  // ---------- show date + time picker ----------
  Future<void> _showDateTimePickerDialog() async {
    String lsFormatedDate;

    final ldDatePicked = await showDatePicker(
      context: context,
      initialDate: _dDate,
      firstDate: widget.firstDate ?? DateTime.now(),
      lastDate: widget.lastDate ?? DateTime.now(),
      helpText: widget.calendarTitle,
      cancelText: widget.cancelText,
      confirmText: widget.confirmText,
      initialDatePickerMode: widget.initialDatePickerMode ?? DatePickerMode.day,
      initialEntryMode: widget.initialEntryMode ?? DatePickerEntryMode.calendar,
      selectableDayPredicate: widget.selectableDayPredicate,
      fieldLabelText: widget.fieldLabelText,
      fieldHintText: widget.fieldHintText,
      errorFormatText: widget.errorFormatText,
      errorInvalidText: widget.errorInvalidText,
      //textDirection: widget.textDirection,
      locale: widget.locale,
      useRootNavigator: widget.useRootNavigator,
      routeSettings: widget.routeSettings,
    );

    final localeStr = _intlLocaleString();
    if (ldDatePicked != null) {
      _dDate = ldDatePicked;

      final ltTimePicked = await showTimePicker(
        context: context,
        initialTime: _tTime,
        initialEntryMode: widget.timePickerEntryModeInput
            ? TimePickerEntryMode.input
            : TimePickerEntryMode.dial,
        useRootNavigator: widget.useRootNavigator,
        routeSettings: widget.routeSettings,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(alwaysUse24HourFormat: widget.use24HourFormat),
            child: child ?? const SizedBox(),
          );
        },
      );

      DateTime combined;
      if (ltTimePicked != null) {
        _tTime = ltTimePicked;
        combined = DateTime(
            _dDate.year, _dDate.month, _dDate.day, ltTimePicked.hour, ltTimePicked.minute);

        if (widget.use24HourFormat) {
          _sTime = DateFormat('HH:mm', localeStr).format(combined);
          _sPeriod = '';
        } else {
          _sTime = DateFormat('hh:mm', localeStr).format(combined);
          _sPeriod = ' ' + DateFormat('a', localeStr).format(combined);
        }

        _timeLabelController.text = (_sTime + _sPeriod).trim();
      } else {
        // user cancelled time selection -> keep existing _tTime
        combined = DateTime(
            _dDate.year, _dDate.month, _dDate.day, _tTime.hour, _tTime.minute);

        if (widget.use24HourFormat) {
          _sTime = DateFormat('HH:mm', localeStr).format(combined);
          _sPeriod = '';
        } else {
          _sTime = DateFormat('hh:mm', localeStr).format(combined);
          _sPeriod = ' ' + DateFormat('a', localeStr).format(combined);
        }
        _timeLabelController.text = (_sTime + _sPeriod).trim();
      }

      final lsOldValue = _sValue;

      // store as 'yyyy-MM-dd HH:mm' so parsing is stable
      _sValue = _formatStoredDateTime(combined);

      // build formatted date label for display (uses dateMask if provided)
      if (widget.dateMask != null && widget.dateMask!.isNotEmpty) {
        lsFormatedDate = DateFormat(widget.dateMask!, localeStr).format(combined);
      } else {
        final lsMask = _sTime != '' ? 'MMM dd, yyyy - HH:mm' : 'MMM dd, yyyy';
        lsFormatedDate = DateFormat(lsMask, localeStr).format(combined);
      }

      _dateLabelController.text = lsFormatedDate;
      _effectiveController?.text = _sValue;

      if (_sValue != lsOldValue) {
        onChangedHandler(_sValue);
      }
    }
  }
}
