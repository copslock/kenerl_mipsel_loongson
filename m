From: Kevin D. Kissell <kevink@mips.com>
Date: Thu, 22 May 2008 16:32:15 +0200
Subject: [PATCH] Fixes to some corner cases in the VPE ELF loader, migration
 of some functions from rtlx.c to vpe.c in order to support
 multiple Linux services for AP support, e.g. M3P network driver.
 Signed-off-by: Kevin D. Kissell <kevink@mips.com>
Message-ID: <20080522143215.Xw5RbuX-5kgCYAekXnQQux59pX80-D759grmT-_lq48@z>

---
 arch/mips/kernel/rtlx.c |   25 ++---
 arch/mips/kernel/vpe.c  |  272 +++++++++++++++++++++++++++++++++++++++++++----
 include/asm-mips/vpe.h  |   27 +++++
 3 files changed, 287 insertions(+), 37 deletions(-)

diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index c0bb347..431d4e7 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -61,11 +61,6 @@ static int sp_stopping = 0;
 
 extern void *vpe_get_shared(int index);
 
-static void rtlx_dispatch(void)
-{
-	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ);
-}
-
 
 /* Interrupt handler may be called before rtlx_init has otherwise had
    a chance to run.
@@ -474,13 +469,6 @@ static const struct file_operations rtlx_fops = {
 	.poll =    file_poll
 };
 
-static struct irqaction rtlx_irq = {
-	.handler	= rtlx_interrupt,
-	.flags		= IRQF_DISABLED,
-	.name		= "RTLX",
-};
-
-static int rtlx_irq_num = MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ;
 
 static char register_chrdev_failed[] __initdata =
 	KERN_ERR "rtlx_module_init: unable to register device\n";
@@ -488,7 +476,7 @@ static char register_chrdev_failed[] __initdata =
 static int __init rtlx_module_init(void)
 {
 	struct device *dev;
-	int i, err;
+	int i, err, irq;
 
 	if (!cpu_has_mipsmt) {
 		printk("VPE loader: not a MIPS MT capable processor\n");
@@ -529,16 +517,17 @@ static int __init rtlx_module_init(void)
 	notify.stop = stopping;
 	vpe_notify(tclimit, &notify);
 
-	if (cpu_has_vint)
-		set_vi_handler(MIPS_CPU_RTLX_IRQ, rtlx_dispatch);
-	else {
+	irq = arch_get_xcpu_irq();
+	if (irq < 0) {
 		printk("APRP RTLX init on non-vectored-interrupt processor\n");
 		err = -ENODEV;
 		goto out_chrdev;
 	}
 
-	rtlx_irq.dev_id = rtlx;
-	setup_irq(rtlx_irq_num, &rtlx_irq);
+	err = request_irq(irq, &rtlx_interrupt, IRQF_SHARED,
+		module_name, (void *)dev);
+	if (err)
+		goto out_chrdev;
 
 	return 0;
 
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 49471f2..1074a8e 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -147,9 +147,12 @@ struct vpe {
 	/* The list of vpe's */
 	struct list_head list;
 
-	/* shared symbol address */
+	/* legacy shared symbol address */
 	void *shared_ptr;
 
+	/* shared area descriptor array address */
+	struct vpe_shared_area *shared_areas;
+
 	/* the list of who wants to know when something major happens */
 	struct list_head notify;
 
@@ -180,6 +183,18 @@ struct {
 static void release_progmem(void *ptr);
 extern void save_gp_address(unsigned int secbase, unsigned int rel);
 
+/*
+ * Values and state associated with publishing shared memory areas
+ */
+
+#define N_PUB_AREAS 4
+
+static struct vpe_shared_area published_vpe_area[N_PUB_AREAS] =
+	{{VPE_SHARED_RESERVED, 0},
+	{VPE_SHARED_RESERVED, 0},
+	{VPE_SHARED_RESERVED, 0},
+	{VPE_SHARED_RESERVED, 0} };
+
 /* get the vpe associated with this minor */
 struct vpe *get_vpe(int minor)
 {
@@ -196,7 +211,7 @@ struct vpe *get_vpe(int minor)
 	return NULL;
 }
 
-/* get the vpe associated with this minor */
+/* get the tc associated with this minor */
 struct tc *get_tc(int index)
 {
 	struct tc *t;
@@ -260,6 +275,7 @@ void release_vpe(struct vpe *v)
 	list_del(&v->list);
 	if (v->load_addr)
 		release_progmem(v);
+	kfree(v->l_phsort);
 	kfree(v);
 }
 
@@ -283,6 +299,87 @@ void dump_mtregs(void)
 	       val & MVPCONF0_PTC, (val & MVPCONF0_M) >> MVPCONF0_M_SHIFT);
 }
 
+/*
+ * The original APRP prototype assumed a single, unshared IRQ for
+ * cross-VPE interrupts, used by the RTLX code.  But M3P networking
+ * and other future functions may need to share an IRQ, particularly
+ * in 34K/Malta configurations without an external interrupt controller.
+ * All cross-VPE insterrupt users need to coordinate through shared
+ * functions here.
+ */
+
+/*
+ * It would be nice if I could just have this initialized to zero,
+ * but the patchcheck police won't hear of it...
+ */
+
+static int xvpe_vector_set;
+
+#define XVPE_INTR_OFFSET 0
+
+static int xvpe_irq = MIPS_CPU_IRQ_BASE + XVPE_INTR_OFFSET;
+
+static void xvpe_dispatch(void)
+{
+	do_IRQ(xvpe_irq);
+}
+
+/* Name here is generic, as m3pnet.c could in principle be used by non-MIPS */
+int arch_get_xcpu_irq()
+{
+	/*
+	 * Some of this will ultimately become platform code,
+	 * but for now, we're only targeting 34K/FPGA/Malta,
+	 * and there's only one generic mechanism.
+	 */
+	if (!xvpe_vector_set) {
+		/*
+		 * A more elaborate shared variable shouldn't be needed.
+		 * Two initializations back-to-back should be harmless.
+		 */
+		if (cpu_has_vint) {
+			set_vi_handler(XVPE_INTR_OFFSET, xvpe_dispatch);
+			xvpe_vector_set = 1;
+		} else {
+			printk(KERN_ERR "APRP requires vectored interrupts\n");
+			return(-1);
+		}
+	}
+
+	return(xvpe_irq);
+}
+EXPORT_SYMBOL(arch_get_xcpu_irq);
+
+int vpe_send_interrupt(int vpe, int inter)
+{
+	unsigned long flags;
+	unsigned int vpeflags;
+
+	local_irq_save(flags);
+	vpeflags = dvpe();
+
+	/*
+	 * Initial version makes same simple-minded assumption
+	 * as is implicit elsewhere in this module, that the
+	 * only RP of interest is using the first non-Linux TC.
+	 * We ignore the parameters provided by the caller!
+	 */
+	settc(tclimit);
+	/*
+	 * In 34K/Malta, the only cross-VPE interrupts possible
+	 * are done by setting SWINT bits in Cause, of which there
+	 * are two.  SMTC uses SW1 for a multiplexed class of IPIs,
+	 * and this mechanism should be generalized to APRP and use
+	 * the same protocol.  Until that's implemented, send only
+	 * SW0 here, regardless of requested type.
+	 */
+	write_vpe_c0_cause(read_vpe_c0_cause() | C_SW0);
+	evpe(vpeflags);
+	local_irq_restore(flags);
+	return(1);
+}
+EXPORT_SYMBOL(vpe_send_interrupt);
+
 /* Find some VPE program space  */
 static void *alloc_progmem(void *requested, unsigned long len)
 {
@@ -844,16 +941,40 @@ static int find_vpe_symbols(struct vpe * v, Elf_Shdr * sechdrs,
 				      struct module *mod)
 {
 	Elf_Sym *sym = (void *)sechdrs[symindex].sh_addr;
-	unsigned int i, n = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
+	unsigned int i, j, n = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
 
 	for (i = 1; i < n; i++) {
-		if (strcmp(strtab + sym[i].st_name, "__start") == 0) {
-			v->__start = sym[i].st_value;
-		}
-
-		if (strcmp(strtab + sym[i].st_name, "vpe_shared") == 0) {
-			v->shared_ptr = (void *)sym[i].st_value;
+	    if (strcmp(strtab + sym[i].st_name, "__start") == 0)
+		v->__start = sym[i].st_value;
+
+	    if (strcmp(strtab + sym[i].st_name, "vpe_shared") == 0)
+		v->shared_ptr = (void *)sym[i].st_value;
+
+	    if (strcmp(strtab + sym[i].st_name, "_vpe_shared_areas") == 0) {
+		struct vpe_shared_area *psa
+		    = (struct vpe_shared_area *)sym[i].st_value;
+		struct vpe_shared_area *tpsa;
+		v->shared_areas = psa;
+		printk(KERN_INFO"_vpe_shared_areas found, 0x%x\n",
+		    (unsigned int)v->shared_areas);
+		/*
+		 * Copy any "published" areas to the descriptor
+		 */
+		for (j = 0; j < N_PUB_AREAS; j++) {
+		    if (published_vpe_area[j].type != VPE_SHARED_RESERVED) {
+			tpsa = psa;
+			while (tpsa->type != VPE_SHARED_NULL) {
+			    if ((tpsa->type == VPE_SHARED_RESERVED)
+			    || (tpsa->type == published_vpe_area[j].type)) {
+				tpsa->type = published_vpe_area[j].type;
+				tpsa->addr = published_vpe_area[j].addr;
+				break;
+			    }
+			    tpsa++;
+			}
+		    }
 		}
+	    }
 	}
 
 	if ( (v->__start == 0) || (v->shared_ptr == NULL))
@@ -1139,6 +1260,7 @@ static int vpe_open(struct inode *inode, struct file *filp)
 		printk(KERN_WARNING "VPE loader: open, getcwd returned %d\n", ret);
 
 	v->shared_ptr = NULL;
+	v->shared_areas = NULL;
 	v->__start = 0;
 
 	return 0;
@@ -1250,12 +1372,6 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 		return -ENOMEM;
 	}
 
-	if ((count + v->copied) > v->pbsize) {
-		printk(KERN_WARNING
-		       "VPE loader: elf size too big. Perhaps strip uneeded symbols\n");
-		return -ENOMEM;
-	}
-
 	while (count) {
 		switch (v->l_state) {
 		case LOAD_STATE_EHDR:
@@ -1282,6 +1398,12 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 					(v->pbuffer + v->l_ehdr->e_phoff);
 				v->l_phlen = v->l_ehdr->e_phentsize
 					* v->l_ehdr->e_phnum;
+				/* Check against buffer overflow */
+				if ((v->copied + v->l_phlen) > v->pbsize) {
+				    printk(KERN_WARNING "VPE loader: elf program header table size too big \n");
+				    v->l_state = LOAD_STATE_ERROR;
+				    return -ENOMEM;
+				}
 				v->l_state = LOAD_STATE_PHDR;
 				/*
 				 * Program headers generally indicate
@@ -1302,6 +1424,12 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 				 */
 				v->l_shlen = v->l_ehdr->e_shentsize
 					* v->l_ehdr->e_shnum;
+				if ((v->l_ehdr->e_shoff + v->l_shlen
+				    - v->offset) > v->pbsize) {
+				    printk(KERN_WARNING "VPE loader: elf sections/section table too big. \n");
+				    v->l_state = LOAD_STATE_ERROR;
+				    return -ENOMEM;
+				}
 				v->l_state = LOAD_STATE_SHDR;
 			    } else {
 				/*
@@ -1467,6 +1595,12 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 				/* Copy to where we left off in temp buffer */
 				    v->l_shlen = v->l_ehdr->e_shentsize
 					* v->l_ehdr->e_shnum;
+				    if ((v->l_ehdr->e_shoff + v->l_shlen
+					- v->offset) > v->pbsize) {
+					printk(KERN_WARNING "VPE loader: elf sections/section table too big. \n");
+					v->l_state = LOAD_STATE_ERROR;
+					return -ENOMEM;
+				    }
 				    v->l_state = LOAD_STATE_SHDR;
 				    break;
 				}
@@ -1530,11 +1664,16 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 				    }
 				    /* Adjust section offset if necessary */
 				    v->l_shdr[i].sh_offset -= offset_delta;
-				}
+			    }
+			    if ((v->copied + v->l_trailer) > v->pbsize) {
+				printk(KERN_WARNING "VPE loader: elf size too big. Perhaps strip uneeded symbols\n");
+				v->l_state = LOAD_STATE_ERROR;
+				return -ENOMEM;
+			    }
 
-				/* Fix up offsets in ELF header */
-				v->l_ehdr->e_shoff = (unsigned int)v->l_shdr
-				    - (unsigned int)v->pbuffer;
+			    /* Fix up offsets in ELF header */
+			    v->l_ehdr->e_shoff = (unsigned int)v->l_shdr
+				- (unsigned int)v->pbuffer;
 			}
 			break;
 		case LOAD_STATE_TRAILER:
@@ -1725,6 +1864,99 @@ char *vpe_getcwd(int index)
 
 EXPORT_SYMBOL(vpe_getcwd);
 
+/*
+ * RP applications may contain a _vpe_shared_area descriptor
+ * array to allow for data sharing with Linux kernel functions
+ * that's slightly more abstracted and extensible than the
+ * fixed binding used by the rtlx support.  Indeed, the rtlx
+ * support should ideally be converted to use the generic
+ * shared area descriptor scheme at some point.
+ *
+ * mips_get_vpe_shared_area() can be used by AP kernel
+ * modules to get an area pointer of a given type, if
+ * it exists.
+ *
+ * mips_publish_vpe_area() is used by AP kernel modules
+ * to share kseg0 kernel memory with the RP.  It maintains
+ * a private table, so that publishing can be done before
+ * the RP program is launched.  Making this table dynamically
+ * allocated and extensible would be good scalable OS design.
+ * however, until there's more than one user of the mechanism,
+ * it should be an acceptable simplification to allow a static
+ * maximum of 4 published areas.
+ */
+
+void *mips_get_vpe_shared_area(int index, int type)
+{
+	struct vpe *v;
+	struct vpe_shared_area *vsa;
+
+	v = get_vpe(index);
+	if (v == NULL)
+		return NULL;
+
+	if (v->shared_areas == NULL)
+		return NULL;
+
+	vsa = v->shared_areas;
+
+	while (vsa->type != VPE_SHARED_NULL) {
+		if (vsa->type == type)
+			return(vsa->addr);
+		else
+			vsa++;
+	}
+	/* Fell through without finding type */
+
+	return NULL;
+}
+EXPORT_SYMBOL(mips_get_vpe_shared_area);
+
+int  mips_publish_vpe_area(int type, void *ptr)
+{
+	int i;
+	int retval = 0;
+	struct vpe *v;
+	unsigned long flags;
+	unsigned int vpflags;
+
+	printk(KERN_INFO "mips_publish_vpe_area(0x%x, 0x%x)\n", type, (int)ptr);
+	if ((unsigned int)ptr >= KSEG2) {
+	    printk(KERN_ERR "VPE area pubish of invalid address 0x%x\n",
+		(int)ptr);
+	    return(0);
+	}
+	for (i = 0; i < N_PUB_AREAS; i++) {
+	    if (published_vpe_area[i].type == VPE_SHARED_RESERVED) {
+		published_vpe_area[i].type = type;
+		published_vpe_area[i].addr = ptr;
+		retval = type;
+		break;
+	    }
+	}
+	/*
+	 * If we've already got a VPE up and running, try to
+	 * update the shared descriptor with the new data.
+	 */
+	list_for_each_entry(v, &vpecontrol.vpe_list, list) {
+	    if (v->shared_areas != NULL) {
+		local_irq_save(flags);
+		vpflags = dvpe();
+		for (i = 0; v->shared_areas[i].type != VPE_SHARED_NULL; i++) {
+		    if ((v->shared_areas[i].type == type)
+		    || (v->shared_areas[i].type == VPE_SHARED_RESERVED)) {
+			v->shared_areas[i].type = type;
+			v->shared_areas[i].addr = ptr;
+		    }
+		}
+		evpe(vpflags);
+		local_irq_restore(flags);
+	    }
+	}
+	return(retval);
+}
+EXPORT_SYMBOL(mips_publish_vpe_area);
+
 #ifdef CONFIG_MIPS_APSP_KSPD
 static void kspd_sp_exit( int sp_id)
 {
@@ -1841,6 +2073,7 @@ static int __init vpe_module_init(void)
 		goto out_chrdev;
 	}
 
+	xvpe_vector_set = 0;
 	device_initialize(&vpe_device);
 	vpe_device.class	= &vpe_class,
 	vpe_device.parent	= NULL,
@@ -1852,6 +2085,7 @@ static int __init vpe_module_init(void)
 		goto out_class;
 	}
 
+
 	local_irq_save(flags);
 	mtflags = dmt();
 	vpflags = dvpe();
diff --git a/include/asm-mips/vpe.h b/include/asm-mips/vpe.h
index c6e1b96..ae9c891 100644
--- a/include/asm-mips/vpe.h
+++ b/include/asm-mips/vpe.h
@@ -29,9 +29,36 @@ struct vpe_notifications {
 
 extern int vpe_notify(int index, struct vpe_notifications *notify);
 
+/*
+ * libc style I/O support hooks
+ */
+
 extern void *vpe_get_shared(int index);
 extern int vpe_getuid(int index);
 extern int vpe_getgid(int index);
 extern char *vpe_getcwd(int index);
 
+/*
+ * Kernel/Kernel message passing support hooks
+ */
+
+extern void *vpe_get_shared_area(int index, int type);
+
+/* "Well-Known" Area Types */
+
+#define VPE_SHARED_NULL 0
+#define VPE_SHARED_RESERVED -1
+
+struct vpe_shared_area {
+	int type;
+	void *addr;
+};
+
+/*
+ * IRQ assignment and initialization hook for RP services.
+ */
+
+int arch_get_xcpu_irq(void);
+
+int vpe_send_interrupt(int v, int i);
 #endif /* _ASM_VPE_H */
-- 
1.5.3.3


--------------090905060800010704090105--
