﻿// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// 2017/01/30 changed by Yoshiharu Ishikawa
// 
// purpose of change: test DoCheck
//
// Line No    Changes
// 23         comment out
// 24         insert
// 46---56    insert
 
import 'dart:async';
import 'package:angular2/core.dart';
import 'name_service.dart';

@Component(
    selector: 'pirate-badge',
    templateUrl: 'badge_component.html',
    styleUrls: const ['badge_component.css'],
    providers: const [NameService])
//class BadgeComponent implements OnInit {
class BadgeComponent implements OnInit,DoCheck {
  final NameService _nameService;
  String badgeName = '';
  String buttonText = 'Aye! Gimme a name!';
  bool isButtonEnabled = false;
  bool isInputEnabled = false;

  BadgeComponent(this._nameService);

  @override
  Future ngOnInit() async {
    try {
      await _nameService.readyThePirates();
      //on success
      isButtonEnabled = true;
      isInputEnabled = true;
    } catch (arrr) {
      badgeName = 'Arrr! No names.';
      print('Error initializing pirate names: $arrr');
    }
  }

  @override
  ngDoCheck(){
    String old_badgeName = '';
    if (badgeName != old_badgeName) {
      print('badgeName : $badgeName');
    } else {
      print('badgeName : No Change');
    }

  }

  void generateBadge() {
    setBadgeName();
  }

  void updateBadge(String inputName) {
    setBadgeName(inputName);
    if (inputName.trim().isEmpty) {
      buttonText = 'Aye! Gimme a name!';
      isButtonEnabled = true;
    } else {
      buttonText = 'Arrr! Write yer name!';
      isButtonEnabled = false;
    }
  }

  void setBadgeName([String newName = '']) {
    if (newName == null) return;
    badgeName = _nameService.getPirateName(newName);
  }
}
