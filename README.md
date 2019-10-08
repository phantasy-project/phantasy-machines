# machines
Configuration files for FRIB virtual accelerators, similar configuration
files should be created for real accelerator.

### Run with FLAME model engine:

```
phytool flame-vastart --mach <machine-name> -subm <segment-name> -v
```
`machine-name`: `FRIB_VA`, `segment-name': `LEBT', `MEBT', `LS1'.

### Model Machine with `phantasy`:

```
>>> import phantasy
>>>
>>> # e.g. machine-name: 'FRIB_LEBT', segment: 'LEBT' (or skipped)
>>> mp = phantasy.MachinePortal(machine='<machine-name>', segment='<segment-name>')
>>>
>>> # get all device types
>>> mp.get_all_types()
>>>
>>> # get elements by name/type/location
>>> mp.get_elements()
>>>
>>> # get elements regarding to reference elements
>>> mp.next_elements()
>>> lat = mp.work_lattice_conf
>>>
>>> # sync settings from accelerator (VA or REAL)
>>> lat.sync_settings(data_source='control')
>>>
>>> # sync settings from model to accelerator
>>> lat.sync_settings(data_source='model')
>>>
>>> # get the FLAME lattice file
>>> latfile, fm = lat.run()
>>> # ...
```
