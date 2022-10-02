default:
	rm -f MedShakeEHR-modGynObs.zip SHA256SUMS
	zip -r MedShakeEHR-modGynObs.zip . -x .git\* -x Makefile -x installer\*
	sha256sum -b MedShakeEHR-modGynObs.zip > preSHA256SUMS
	head -c 64 preSHA256SUMS > SHA256SUMS
	rm -f preSHA256SUMS

clean:
	rm -f MedShakeEHR-modGynObs.zip