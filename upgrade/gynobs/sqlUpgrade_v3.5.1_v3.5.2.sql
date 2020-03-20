-- upgrade n° de version
UPDATE `system` SET `value`='v3.5.2' WHERE `name`='gynobs';

-- ajustement formulaires : inclusion du JS + reduction des rows (autosize)

update `forms` set javascript = '$(document).ready(function() {\r\n\r\n  //calcul IMC\r\n  if ($(\'#id_imc_id\').length > 0) {\r\n\r\n    imc = imcCalc($(\'#id_poids_id\').val(), $(\'#id_taillePatient_id\').val());\r\n    if (imc > 0) {\r\n      $(\'#id_imc_id\').val(imc);\r\n    }\r\n\r\n    $(\"#patientLatCol\").on(\"keyup\", \"#id_poids_id , #id_taillePatient_id\", function() {\r\n      poids = $(\'#id_poids_id\').val();\r\n      taille = $(\'#id_taillePatient_id\').val();\r\n      imc = imcCalc(poids, taille);\r\n      $(\'#id_imc_id\').val(imc);\r\n      patientID = $(\'#identitePatient\').attr(\"data-patientID\");\r\n      setPeopleDataByTypeName(imc, patientID, \'imc\', \'#id_imc_id\', \'0\');\r\n\r\n    });\r\n  }\r\n  \r\n  //ajutement auto des textarea en hauteur\r\n  autosize($(\'#formName_gynObsATCD textarea\'));\r\n\r\n});' where internalName = 'gynObsATCD';

UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'atcdObs,rows=6', 'atcdObs,rows=2') where internalName = 'gynObsATCD';
UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'atcdPersoGyneco,rows=6', 'atcdPersoGyneco,rows=2') where internalName = 'gynObsATCD';
UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'atcdMedicChir,rows=6', 'atcdMedicChir,rows=2') where internalName = 'gynObsATCD';
UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'atcdFamiliaux,rows=6', 'atcdFamiliaux,rows=2') where internalName = 'gynObsATCD';
UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'allergies,rows=2', 'allergies,rows=1') where internalName = 'gynObsATCD';
UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, '- job', '- job,rows=1') where internalName = 'gynObsATCD';
UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, '- toxiques', '- toxiques,rows=1') where internalName = 'gynObsATCD';

update `forms` set javascript = '$(document).ready(function() {\r\n	//bouton de nouvelle grossesse\r\n	$(\"a.newGro\").on(\"click\", function(e) {\r\n  		if (!confirm(\'Voulez-vous installer un nouveau suivi de grossesse ?\')) {\r\n    		e.preventDefault();\r\n  		}\r\n	});\r\n\r\n	//autoresize\r\n	autosize($(\'#formName_gynObsSyntheseGyn textarea\'));\r\n});' where internalName = 'gynObsSyntheseGyn';

UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'synthese,rows=8', 'synthese,rows=2') where internalName = 'gynObsSyntheseGyn';

update `forms` set javascript = '$(document).ready(function() {\r\n\r\n  //autoresize\r\n  autosize($(\'#formName_gynObsSyntheseObs textarea\'));\r\n\r\n  // Si on change la DDR\r\n  $(\"#before_DDR\").on(\"dp.change\", function(e) {\r\n    calcAndDisplayTdj();\r\n    calcAndDisplayDdgt();\r\n    calcAndDisplayT9m();\r\n    if (typeof(dicomAutoSendPatient) != \"undefined\") {\r\n      if (dicomAutoSendPatient == true) {\r\n        prepareEcho(\'nopopup\');\r\n      }\r\n    }\r\n  });\r\n\r\n\r\n  // Si on change la DDG retenue\r\n  $(\"#before_ddgReel\").on(\"dp.change\", function(e) {\r\n    calcAndDisplayTdj();\r\n    calcAndDisplayT9m();\r\n    if (typeof(dicomAutoSendPatient) != \"undefined\") {\r\n      if (dicomAutoSendPatient == true) {\r\n        prepareEcho(\'nopopup\');\r\n      }\r\n    }\r\n  });\r\n\r\n  //close grossesseEnCours\r\n  $(\'body\').on(\"click\", \"#closeGro\", function(e) {\r\n    if (confirm(\"Voulez-vous fermer définitivement ce suivi de grossesse ?\")) {\r\n      if (confirm(\"Confirmez-vous réellement ?\")) {\r\n\r\n      } else {\r\n        e.preventDefault();\r\n      }\r\n    } else {\r\n      e.preventDefault();\r\n    }\r\n  });\r\n\r\n  calcAndDisplayDdgt();\r\n  calcAndDisplayTdj();\r\n  calcAndDisplayT9m()\r\n});\r\n\r\n// calculer et afficher terme du jour\r\nfunction calcAndDisplayTdj() {\r\n  tdj = tdjCalc($(\'#id_DDR_id\').val(), $(\'#id_ddgReel_id\').val());\r\n  if (tdj[\'status\'] == \'ok\') {\r\n    $(\'#id_termeDuJour_id\').val(tdj[\'human\']);\r\n    $(\'#id_termeDuJour_id\').attr(\'data-tdj4math\', tdj[\'math\']);\r\n  } else {\r\n    $(\'#id_termeDuJour_id\').val(\'\');\r\n    $(\'#id_termeDuJour_id\').attr(\'data-tdj4math\', \'\');\r\n  }\r\n}\r\n\r\n// calculer et afficher terme 9 mois\r\nfunction calcAndDisplayT9m() {\r\n  t9 = terme9mCalc($(\'#id_DDR_id\').val(), $(\'#id_ddgReel_id\').val());\r\n  if (t9[\'status\'] == \'ok\') {\r\n    $(\'#id_terme9mois_id\').val(t9[\'human\']);\r\n  } else {\r\n    $(\'#id_terme9mois_id\').val(\'\');\r\n  }\r\n}\r\n\r\n\r\n//calculer et afficher DDG théo\r\nfunction calcAndDisplayDdgt() {\r\n  ddgt = ddgtCalc($(\'#id_DDR_id\').val());\r\n  $(\'#id_ddg_id\').val(ddgt);\r\n}' where internalName ='gynObsSyntheseObs';

UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'syntheseGrossesse,rows=5', 'syntheseGrossesse,rows=2') where internalName = 'gynObsSyntheseObs';

UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'examenGynDuJour,rows=10', 'examenGynDuJour,rows=4') where internalName = 'gynObsConsultGyn';
UPDATE `forms` SET `javascript` ='$(document).ready(function() {\r\n\r\n  //ajutement auto des textarea en hauteur\r\n  autosize($(\'#formName_gynObsConsultGyn textarea\')); \r\n\r\n});' where internalName = 'gynObsConsultGyn';

UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'examenObsDuJour,rows=10', 'examenObsDuJour,rows=4') where internalName = 'gynObsConsultObs';
UPDATE `forms` SET `javascript` ='$(document).ready(function() {\r\n\r\n  //ajutement auto des textarea en hauteur\r\n  autosize($(\'#formName_gynObsConsultObs textarea\')); \r\n\r\n});' where internalName = 'gynObsConsultObs';

UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'e11conclusion,rows=8', 'e11conclusion,rows=3') where internalName = 'gynObsEchoAvt11';
UPDATE `forms` SET `javascript` ='$(document).ready(function() {\r\n\r\n  //ajutement auto des textarea en hauteur\r\n  autosize($(\'#formName_gynObsEchoAvt11 textarea\')); \r\n  \r\n  // observation nombre foetus\r\n  $(\'body\').on(\"keyup, change\", \'#id_e11nbembryons_id\', function() {\r\n    afficherFxNbFoetus();\r\n  });\r\n\r\n  //calcul du terme en fonction lcc\r\n  $(\'body\').on(\"change, keyup\", \"#id_e11embryLCCFA_id, #id_e11embryLCCFB_id, #id_e11embryLCCFC_id\", function() {\r\n    //E11\r\n    if ($(\'#id_e11embryLCCFA_id\').val() > 0) majLCC2Terme($(\'#id_e11embryLCCFA_id\').val(), \'#id_E11termeLCCFA_id\');\r\n    if ($(\'#id_e11embryLCCFB_id\').val() > 0) majLCC2Terme($(\'#id_e11embryLCCFB_id\').val(), \'#id_E11termeLCCFB_id\');\r\n    if ($(\'#id_e11embryLCCFC_id\').val() > 0) majLCC2Terme($(\'#id_e11embryLCCFC_id\').val(), \'#id_E11termeLCCFC_id\');\r\n  });\r\n\r\n  //définir comme DGE\r\n  $(\'body\').on(\"dblclick\", \" #id_E11termeLCCFA_id, #id_E11termeLCCFB_id, #id_E11termeLCCFC_id\", function(event) {\r\n    setDGE(event);\r\n  });\r\n  $(\'body\').on(\"click\", \" #id_E11termeLCCFA_idAddOn, #id_E11termeLCCFB_idAddOn, #id_E11termeLCCFC_idAddOn\", function(event) {\r\n    event.preventDefault();\r\n    setDGE(event);\r\n  });\r\n\r\n  // Restaurer à l\'édition \r\n  if ($(\'#id_e11embryLCCFA_id\').val() > 0) majLCC2Terme($(\'#id_e11embryLCCFA_id\').val(), \'#id_E11termeLCCFA_id\');\r\n  if ($(\'#id_e11embryLCCFB_id\').val() > 0) majLCC2Terme($(\'#id_e11embryLCCFB_id\').val(), \'#id_E11termeLCCFB_id\');\r\n  if ($(\'#id_e11embryLCCFC_id\').val() > 0) majLCC2Terme($(\'#id_e11embryLCCFC_id\').val(), \'#id_E11termeLCCFC_id\');\r\n});' where internalName = 'gynObsEchoAvt11';

UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'conclusionE12,rows=4', 'conclusionE12,rows=3') where internalName = 'gynObsEcho12';
UPDATE `forms` SET `javascript` ='$(document).ready(function() {\r\n\r\n  //ajutement auto des textarea en hauteur\r\n  autosize($(\'#formName_gynObsEcho12 textarea\')); \r\n  \r\n  //observation nombre foetus\r\n  $(\'body\').on(\"keyup, change\", \'#id_nbFoetusEcho12_id\', function() {\r\n    afficherFxNbFoetus();\r\n  });\r\n\r\n  //calcul du terme en fonction lcc\r\n  $(\'body\').on(\"change, keyup\", \"#id_lccA_id, #id_lccB_id, #id_lccC_id\", function() {\r\n    if ($(\'#id_lccA_id\').val() > 0) majLCC2Terme($(\'#id_lccA_id\').val(), \'#id_termeLCCFA_id\');\r\n    if ($(\'#id_lccB_id\').val() > 0) majLCC2Terme($(\'#id_lccB_id\').val(), \'#id_termeLCCFB_id\');\r\n    if ($(\'#id_lccC_id\').val() > 0) majLCC2Terme($(\'#id_lccC_id\').val(), \'#id_termeLCCFC_id\');\r\n  });\r\n\r\n  //définir comme DGE\r\n  $(\'body\').on(\"dblclick\", \"#id_termeLCCFA_id, #id_termeLCCFB_id, #id_termeLCCFC_id\", function(event) {\r\n    setDGE(event);\r\n  });\r\n  $(\'body\').on(\"click\", \"#id_termeLCCFA_idAddOn, #id_termeLCCFB_idAddOn, #id_termeLCCFC_idAddOn\", function(event) {\r\n    event.preventDefault();\r\n    setDGE(event);\r\n  });\r\n\r\n  // Restaurer à l\'édition\r\n  if ($(\'#id_lccA_id\').val() > 0) majLCC2Terme($(\'#id_lccA_id\').val(), \'#id_termeLCCFA_id\');\r\n  if ($(\'#id_lccB_id\').val() > 0) majLCC2Terme($(\'#id_lccB_id\').val(), \'#id_termeLCCFB_id\');\r\n  if ($(\'#id_lccC_id\').val() > 0) majLCC2Terme($(\'#id_lccC_id\').val(), \'#id_termeLCCFC_id\');\r\n\r\n});' where internalName = 'gynObsEcho12';

UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'conclusionE22,rows=5', 'conclusionE22,rows=4') where internalName = 'gynObsEcho22';
UPDATE `forms` SET `javascript` ='$(document).ready(function() {\r\n\r\n  //ajutement auto des textarea en hauteur\r\n  autosize($(\'#formName_gynObsEcho22 textarea\')); \r\n  \r\n  // observation nombre foetus\r\n  $(\'body\').on(\"keyup, change\", \'#id_nbFoetusEcho22_id\', function() {\r\n    afficherFxNbFoetus();\r\n  });\r\n\r\n  // calcul du poids et percentils\r\n  $(\'body\').on(\"change, keyup\", \"#id_e22bipFA_id, #id_e22bipFB_id, #id_e22bipFC_id, #id_e22pcFA_id, #id_e22paFA_id, #id_e22femurA_id, #id_e22pcFB_id, #id_e22paFB_id, #id_e22femurB_id, #id_e32pcFC_id, #id_e22paFC_id, #id_e22femurC_id\", function() {\r\n\r\n    poidsFoetal(\'#id_e22pcFA_id\', \'#id_e22paFA_id\', \'#id_e22femurA_id\', \'#id_e22poidsFA_id\');\r\n    poidsFoetal(\'#id_e22pcFB_id\', \'#id_e22paFB_id\', \'#id_e22femurB_id\', \'#id_e22poidsFB_id\');\r\n    poidsFoetal(\'#id_e22pcFC_id\', \'#id_e22paFC_id\', \'#id_e22femurC_id\', \'#id_e22poidsFC_id\');\r\n\r\n    //foetus A\r\n    displayPercentiles(\'#id_e22bipFA_id\', \'bip\');\r\n    displayPercentiles(\'#id_e22pcFA_id\', \'pc\');\r\n    displayPercentiles(\'#id_e22paFA_id\', \'pa\');\r\n    displayPercentiles(\'#id_e22femurA_id\', \'lf\');\r\n\r\n    //foetus B\r\n    if ($(\'.foetusB\').is(\':visible\')) {\r\n      displayPercentiles(\'#id_e22bipFB_id\', \'bip\');\r\n      displayPercentiles(\'#id_e22pcFB_id\', \'pc\');\r\n      displayPercentiles(\'#id_e22paFB_id\', \'pa\');\r\n      displayPercentiles(\'#id_e22femurB_id\', \'lf\');\r\n    }\r\n\r\n    //foetus C\r\n    if ($(\'.foetusC\').is(\':visible\')) {\r\n      displayPercentiles(\'#id_e22bipFC_id\', \'bip\');\r\n      displayPercentiles(\'#id_e22pcFC_id\', \'pc\');\r\n      displayPercentiles(\'#id_e22paFC_id\', \'pa\');\r\n      displayPercentiles(\'#id_e22femurC_id\', \'lf\');\r\n    }\r\n  });\r\n\r\n  // MoM\r\n  $(\'body\').on(\"change, keyup\", \"#id_e22dopACMVFA_id, #id_e22dopACMVFB_id, #id_e22dopACMVFC_id\", function() {\r\n    if($(this).val() > 0) {\r\n      mom = momCalc($(this).val(), $(\'#id_termeDuJour_id\').attr(\'data-tdj4math\'));\r\n    } else {\r\n      mom = \'\';\r\n    }\r\n    idsource = $(this).attr(\'id\');\r\n    if (idsource == \'id_e22dopACMVFA_id\') $(\'#id_e22dopACMMoMFA_id\').val(mom);\r\n    if (idsource == \'id_e22dopACMVFB_id\') $(\'#id_e22dopACMMoMFB_id\').val(mom);\r\n    if (idsource == \'id_e22dopACMVFC_id\') $(\'#id_e22dopACMMoMFC_id\').val(mom);\r\n  });\r\n\r\n  // Restaurer à l\'édition \r\n  $(\"#id_e22bipFA_id, #id_e22bipFB_id, #id_e22bipFC_id\").trigger( \"keyup\" );\r\n\r\n});' where internalName = 'gynObsEcho22';


UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'conclusione32,rows=5', 'conclusione32,rows=4') where internalName = 'gynObsEcho32';
UPDATE `forms` SET `javascript` ='function conclusionComp() {\r\n  txt = \'\';\r\n  nbFoetus = parseInt($(\'#id_nbFoetusEcho32_id\').val());\r\n  if (nbFoetus == \'1\') {\r\n    if ($(\'#id_e32poidsFA_id\').val() > 0) txt = \'EPF : \' + $(\'#id_e32poidsFA_id\').val() + \'g (\' + $(\'#id_e32poidsFA_idAddOn\').text() + \') - Présentation : \' + $(\'#id_e32presentationFA_id option:selected\').text();\r\n  } else if (nbFoetus > 1) {\r\n    if ($(\'#id_e32poidsFA_id\').val() > 0) txt = $.trim(\'Foetus A - EPF : \' + $(\'#id_e32poidsFA_id\').val() + \'g (\' + $(\'#id_e32poidsFA_idAddOn\').text() + \') / Présentation : \' + $(\'#id_e32presentationFA_id option:selected\').text());\r\n\r\n    if ($(\'#id_e32poidsFB_id\').val() > 0) txt = txt + \"\\n\" + $.trim(\'Foetus B - EPF : \' + $(\'#id_e32poidsFB_id\').val() + \'g (\' + $(\'#id_e32poidsFB_idAddOn\').text() + \') / Présentation : \' + $(\'#id_e32presentationFB_id option:selected\').text());\r\n\r\n    if ($(\'#id_e32poidsFC_id\').val() > 0) txt = txt + \"\\n\" + $.trim(\'Foetus C - EPF : \' + $(\'#id_e32poidsFC_id\').val() + \'g (\' + $(\'#id_e32poidsFC_idAddOn\').text() + \') / Présentation : \' + $(\'#id_e32presentationFC_id option:selected\').text());\r\n\r\n  }\r\n\r\n  $(\'#id_e32concluAutomat_id\').val(txt);\r\n}\r\n\r\n$(document).ready(function() {\r\n\r\n  //ajutement auto des textarea en hauteur\r\n  autosize($(\'#formName_gynObsEcho32 textarea\')); \r\n\r\n  //observation nombre foetus\r\n  $(\'body\').on(\"keyup, change\", \'#id_nbFoetusEcho32_id\', function() {\r\n    afficherFxNbFoetus();\r\n  });\r\n\r\n  // calcul du poids et percentils\r\n  $(\'body\').on(\"change, keyup\", \"#id_e32bipFA_id, #id_e32bipFB_id, #id_e32bipFC_id, #id_e32pcFA_id, #id_e32paFA_id, #id_e32femurA_id, #id_e32pcFB_id, #id_e32paFB_id, #id_e32femurB_id, #id_e32pcFC_id, #id_e32paFC_id, #id_e32femurC_id\", function() {\r\n    poidsFoetal(\'#id_e32pcFA_id\', \'#id_e32paFA_id\', \'#id_e32femurA_id\', \'#id_e32poidsFA_id\');\r\n    poidsFoetal(\'#id_e32pcFB_id\', \'#id_e32paFB_id\', \'#id_e32femurB_id\', \'#id_e32poidsFB_id\');\r\n    poidsFoetal(\'#id_e32pcFC_id\', \'#id_e32paFC_id\', \'#id_e32femurC_id\', \'#id_e32poidsFC_id\');\r\n\r\n    //foetus A\r\n    displayPercentiles(\'#id_e32bipFA_id\', \'bip\');\r\n    displayPercentiles(\'#id_e32pcFA_id\', \'pc\');\r\n    displayPercentiles(\'#id_e32paFA_id\', \'pa\');\r\n    displayPercentiles(\'#id_e32femurA_id\', \'lf\');\r\n\r\n    //foetus B\r\n    if ($(\'.foetusB\').is(\':visible\')) {\r\n      displayPercentiles(\'#id_e32bipFB_id\', \'bip\');\r\n      displayPercentiles(\'#id_e32pcFB_id\', \'pc\');\r\n      displayPercentiles(\'#id_e32paFB_id\', \'pa\');\r\n      displayPercentiles(\'#id_e32femurB_id\', \'lf\');\r\n    }\r\n\r\n    //foetus C\r\n    if ($(\'.foetusC\').is(\':visible\')) {\r\n      displayPercentiles(\'#id_e32bipFC_id\', \'bip\');\r\n      displayPercentiles(\'#id_e32pcFC_id\', \'pc\');\r\n      displayPercentiles(\'#id_e32paFC_id\', \'pa\');\r\n      displayPercentiles(\'#id_e32femurC_id\', \'lf\');\r\n    }\r\n\r\n    // compléter la conclusion\r\n    conclusionComp();\r\n\r\n  });\r\n\r\n  // MoM\r\n  $(\'body\').on(\"change, keyup\", \"#id_e32dopACMVFA_id, #id_e32dopACMVFB_id, #id_e32dopACMVFC_id\", function() {\r\n      if($(this).val() > 0) {\r\n        mom = momCalc($(this).val(), $(\'#id_termeDuJour_id\').attr(\'data-tdj4math\'));\r\n      } else {\r\n        mom = \'\';\r\n      }\r\n      idsource = $(this).attr(\'id\');\r\n      if (idsource == \'id_e32dopACMVFA_id\') $(\'#id_e32dopACMMoMFA_id\').val(mom);\r\n      if (idsource == \'id_e32dopACMVFB_id\') $(\'#id_e32dopACMMoMFB_id\').val(mom);\r\n      if (idsource == \'id_e32dopACMVFC_id\') $(\'#id_e32dopACMMoMFC_id\').val(mom);\r\n\r\n  });\r\n\r\n  //changement de la présentation : adapter la conclusion automatique complémentaire\r\n  $(\'body\').on(\"change\", \"#id_e32presentationFA_id, #id_e32presentationFB_id, #id_e32presentationFC_id\", function() {\r\n    conclusionComp();\r\n  });\r\n\r\n  // Restauration édition \r\n  $(\"#id_e32bipFA_id, #id_e32bipFB_id, #id_e32bipFC_id\").trigger(\'keyup\');\r\n  $(\"#id_e32dopACMVFA_id, #id_e32dopACMVFB_id, #id_e32dopACMVFC_id\").trigger(\'keyup\');\r\n\r\n});' where internalName = 'gynObsEcho32';


UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'eGynConclusion,rows=5', 'eGynConclusion,rows=2') where internalName = 'gynObsEchoGyneco';
UPDATE `forms` SET `javascript` ='$(document).ready(function() {\r\n\r\n  //ajutement auto des textarea en hauteur\r\n  autosize($(\'#formName_gynObsEchoGyneco textarea\')); \r\n\r\n  //calculer nb jour du cycle\r\n  $(\'body\').on(\"focusout\", \'#id_eGynDDR_id\', function() {\r\n    ddr = $(\'#id_eGynDDR_id\').val();\r\n    var today = moment().startOf(\'day\');\r\n    var ddrm = moment(ddr, \"DD-MM-YYYY\");\r\n\r\n    if (ddrm.isValid()) {\r\n      jours = today.diff(ddrm, \'days\') + 1;\r\n      $(\'#id_eGynDDR_idAddOnG\').text(\'J\' + jours);\r\n    }\r\n  });\r\n\r\n});' where internalName = 'gynObsEchoGyneco';

UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, 'examenColpoDuJour,rows=10', 'examenColpoDuJour,rows=4') where internalName = 'gynObsColposcopie';
UPDATE `forms` SET `javascript` = '$(document).ready(function() {\r\n\r\n  //ajutement auto des textarea en hauteur\r\n  autosize($(\'#formName_gynObsColposcopie textarea\')); \r\n\r\n});' where internalName = 'gynObsColposcopie';
