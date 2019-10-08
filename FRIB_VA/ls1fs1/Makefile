# read from xlsx
START_ELEM0 = "LS1_CA01:GV_D1124"
END_ELEM0 = "FS1_BMS:IP_D2703"

CONFIG = "phantasy.cfg"
OUT_LAYOUT = 'layout.csv'
OUT_CHANNELS = 'channels.csv'
LATTICE_TEMPLATE = 'template.lat'
SETTING_TEMPLATE = 'settings.json'

# read from layout.csv
START_ELEM = "LS1_CA01:GV_D1124"
END_ELEM = "FS1_BMS:IP_DFT_D2703_1"

PHYTOOL := python /usr/local/bin/phytool

layout:
	$(PHYTOOL) frib-layout -v --cfg $(CONFIG) \
		--start $(START_ELEM0) \
		--end $(END_ELEM0) layout0.csv && \
	head -1 layout0.csv > $(OUT_LAYOUT) && \
	sed -n /$(START_ELEM)/,/$(END_ELEM)/p layout0.csv >> $(OUT_LAYOUT)
	rm layout0.csv

# mag
channels:
	$(PHYTOOL) frib-channels $(OUT_LAYOUT) $(OUT_CHANNELS) \
		--start $(START_ELEM) --end $(END_ELEM) \
		--tag 'LINAC'

pv:
	awk -F',' '{print $$1}' $(OUT_CHANNELS) | sed 1d > test-pvs.dat

clean:
	rm $(OUT_LAYOUT) $(OUT_CHANNELS)

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
