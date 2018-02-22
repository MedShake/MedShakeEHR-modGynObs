default:
	zip -r MedShakeEHR-modGynObs.zip . -x .git\* -x Makefile

clean:
	rm -f MedShakeEHR-modGynObs.zip
