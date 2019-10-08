# read from xlsx
START_ELEM0 = "FE_ISRC1:ACC_D0700"
END_ELEM0 = "FE_RFQ:CAV_D1005"

CONFIG = "phantasy.cfg"
OUT_LAYOUT = 'layout.csv'
OUT_CHANNELS = 'channels.csv'
LATTICE_TEMPLATE = 'template.lat'
SETTING_TEMPLATE = 'settings.json'

# read from layout.csv
START_ELEM = "FE_ISRC1:ACC_DFT_D0700_1"
END_ELEM = "FE_LEBT:GV_DFT_D0999_3"

PHYTOOL := python2 /usr/local/bin/phytool

layout:
	$(PHYTOOL) frib-layout --cfg $(CONFIG) \
		--start $(START_ELEM0) \
		--end $(END_ELEM0) layout0.csv && \
	head -1 layout0.csv > $(OUT_LAYOUT) && \
	sed -n /$(START_ELEM)/,/$(END_ELEM)/p layout0.csv >> $(OUT_LAYOUT)
	rm layout0.csv

# mag
channels:
	$(PHYTOOL) frib-channels $(OUT_LAYOUT) $(OUT_CHANNELS) \
		--start $(START_ELEM) --end $(END_ELEM) \
		--pspvfile pspvconfig.csv \
		--tag 'LEBT' #--machine 'VA'

pv:
	awk -F',' '{print $$1}' $(OUT_CHANNELS) | sed 1d > test-pvs.dat

clean:
	rm $(OUT_LAYOUT) $(OUT_CHANNELS) layout0.csv

# 2 (after filling out SETTING_TEMPLATE)
flame_lattice:
	$(PHYTOOL) flame-lattice --config phantasy.cfg \
		--settings settings.json baseline.lat --mach .

# 0 (if no settings file available)
lattice-template:
	$(PHYTOOL) flame-lattice $(LATTICE_TEMPLATE) \
		--layout $(OUT_LAYOUT) \
		--config $(CONFIG) \
		--mach $(shell basename `pwd`) \
		--start $(START_ELEM) \
		--end $(END_ELEM) \
		--template
# 1
settings-template:
	$(PHYTOOL) flame-settings $(LATTICE_TEMPLATE) $(SETTING_TEMPLATE)


.PHONY: layout channels clean
