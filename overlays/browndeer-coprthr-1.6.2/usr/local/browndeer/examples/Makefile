
EXAMPLES = hello_stdcl image2d_example mpi_lock_example clopen_example \
	clvector_example clmulti_array_example \
	clete_clmulti_array_example clete_clvector_example \
	bdt_em3d bdt_nbody bdt_nbody_e32 bdt_nbody_tutorial bdt_nbody_tutorial_2 \
	parallella

#	bdt_em3d_e32 bdt_nbody_e32 

##### DO NOT EDIT BELOW THIS LINE #####

SUBDIRS = 
SUBDIRS += $(EXAMPLES)

#export TOPDIR = $(CURDIR)

all: $(SUBDIRS) 

.PHONY: subdirs $(SUBDIRS) clean 

subdirs: $(SUBDIRS)

$(SUBDIRS):
	echo $(MAKECMDGOALS)
	make -C $@ $(MAKECMDGOALS)

clean: subdirs

distclean: subdirs
	@dirs="$(EXAMPLES)"; for dir in $$dirs; do \
	rm -f $$dir/Makefile; \
	done

