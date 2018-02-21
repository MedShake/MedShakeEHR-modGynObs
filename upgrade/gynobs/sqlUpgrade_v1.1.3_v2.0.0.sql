-- Modifications de structure de la bdd d'une version à la suivante
-- 1.1.3 to 2.0.0
UPDATE data_types set formType='checkbox' where id in ('436','492','493','496');

update forms set internalName='baseNewPatient' where id='1';
update forms set internalName='baseListingPatients' where id='2';
update forms set internalName='baseLogin' where id='3';
update forms set internalName='gynObsATCD' where id='4';
update forms set internalName='gynObsSyntheseGyn' where id='5';
update forms set internalName='gynObsSyntheseObs' where id='6';
update forms set internalName='baseNewPro' where id='7';
update forms set internalName='baseListingPro' where id='8';
update forms set internalName='gynObsEcho12' where id='9';
update forms set internalName='gynObsConsultGyn' where id='10';
update forms set internalName='baseSendMail' where id='11';
update forms set internalName='gynObsEchoAvt11' where id='12';
update forms set internalName='gynObsColposcopie' where id='20';
update forms set internalName='gynObsFinGrossesse' where id='21';
update forms set internalName='baseSendMailApicrypt' where id='14';
update forms set internalName='baseImportDocExterne' where id='15';
update forms set internalName='baseOrdonnance' where id='16';
update forms set internalName='baseReglement' where id='17';
update forms set internalName='baseReglementSimple' where id='18';
update forms set internalName='baseReglementSearch' where id='19';
update forms set internalName='baseImportExternal' where id='22';
update forms set internalName='gynObsEcho22' where id='23';
update forms set internalName='gynObsEcho32' where id='24';
update forms set internalName='basePasswordChange' where id='25';
update forms set internalName='gynObsConsultObs' where id='26';
update forms set internalName='gynObsEchoGyneco' where id='27';
update forms set internalName='gynObsMarqueursSeriques' where id='28';
update forms set internalName='baseFax' where id='29';
update forms set internalName='baseAgendaPriseRDV' where id='30';

update data_types set formValues='gynObsConsultGyn' where groupe='typecs' and formValues='10';
update data_types set formValues='gynObsEchoAvt11' where groupe='typecs' and formValues='12';
update data_types set formValues='gynObsColposcopie' where groupe='typecs' and formValues='20';
update data_types set formValues='gynObsFinGrossesse' where groupe='typecs' and formValues='21';
update data_types set formValues='baseImportExternal' where groupe='typecs' and formValues='22';
update data_types set formValues='gynObsEcho22' where groupe='typecs' and formValues='23';
update data_types set formValues='gynObsEcho32' where groupe='typecs' and formValues='24';
update data_types set formValues='gynObsConsultObs' where groupe='typecs' and formValues='26';
update data_types set formValues='gynObsEchoGyneco' where groupe='typecs' and formValues='27';
update data_types set formValues='gynObsMarqueursSeriques' where groupe='typecs' and formValues='28';
update data_types set formValues='gynObsSyntheseObs' where groupe='typecs' and formValues='6';
update data_types set formValues='gynObsEcho12' where groupe='typecs' and formValues='9';

