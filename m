From: Kevin D. Kissell <kevink@mips.com>
Date: Sat, 3 May 2008 16:03:51 +0200
Subject: [PATCH] Rewrite of APRP VPE ELF Loader
Message-ID: <20080503140351.WD9sabLmQ8CB2dTMU2NOgt7vNPVhw7XzpbrFX4AQ3NU@z>

Re-implemented as state machine driven by writes to vpe pseudo-device.
Load-time linking of relocatable binaries has same functionality and
restrictions as before, but for pre-linked ELF binaries:
- Program size restrictions due to intermediate copy in vmalloc buffer
  are eliminated.  Program segments are copied directly from input
  stream to target memory.
- Programs no longer need to be linked to exactly the top of memory
  known to the kernel. They need only be linked to an address that
  is no less than the kernel's memory size limit (max_low_pfn).
- Programs may be stripped of the __start symbol, as the ELF header
  entry point is used if __start is unavailable.  "vpe_shared" symbol
  must be retained if the rtlx I/O services are to be used.
- Protection added against binaries linked to addresses that overlay
  kernel or user addresses.
---
 arch/mips/kernel/vpe.c |  510 ++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 453 insertions(+), 57 deletions(-)

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 4515f1e..49471f2 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -77,13 +77,10 @@ static const int minor = 1;	/* fixed for now  */
 static int kspd_events_reqd = 0;
 #endif
 
-/* grab the likely amount of memory we will need. */
-#ifdef CONFIG_MIPS_VPE_LOADER_TOM
-#define P_SIZE (2 * 1024 * 1024)
-#else
-/* add an overhead to the max kmalloc size for non-striped symbols/etc */
+/*
+ * Size of private kernel buffer for ELF headers and sections
+ */
 #define P_SIZE (256 * 1024)
-#endif
 
 extern unsigned long physical_memsize;
 
@@ -103,6 +100,16 @@ enum tc_state {
 	TC_STATE_DYNAMIC
 };
 
+enum load_state {
+	LOAD_STATE_EHDR,
+	LOAD_STATE_PHDR,
+	LOAD_STATE_SHDR,
+	LOAD_STATE_PIMAGE,
+	LOAD_STATE_TRAILER,
+	LOAD_STATE_DONE,
+	LOAD_STATE_ERROR
+};
+
 struct vpe {
 	enum vpe_state state;
 
@@ -110,10 +117,25 @@ struct vpe {
 	int minor;
 
 	/* elfloader stuff */
+	unsigned long offset; /* File offset into input stream */
 	void *load_addr;
-	unsigned long len;
+	unsigned long copied;
 	char *pbuffer;
-	unsigned long plen;
+	unsigned long pbsize;
+	/* Program loading state */
+	enum load_state l_state;
+	Elf_Ehdr *l_ehdr;
+	struct elf_phdr *l_phdr;
+	unsigned int l_phlen;
+	Elf_Shdr *l_shdr;
+	unsigned int l_shlen;
+	int *l_phsort;	/* Sorted index list of program headers */
+	int l_segoff;	/* Offset into current program segment */
+	int l_cur_seg;	/* Indirect index of segment currently being loaded */
+	unsigned int l_progminad;
+	unsigned int l_progmaxad;
+	unsigned int l_trailer;
+
 	unsigned int uid, gid;
 	char cwd[VPE_PATH_MAX];
 
@@ -132,6 +154,7 @@ struct vpe {
 	struct list_head notify;
 
 	unsigned int ntcs;
+
 };
 
 struct tc {
@@ -261,22 +284,37 @@ void dump_mtregs(void)
 }
 
 /* Find some VPE program space  */
-static void *alloc_progmem(unsigned long len)
+static void *alloc_progmem(void *requested, unsigned long len)
 {
 	void *addr;
 
 #ifdef CONFIG_MIPS_VPE_LOADER_TOM
 	/*
 	 * This means you must tell Linux to use less memory than you
-	 * physically have, for example by passing a mem= boot argument.
+	 * physically have, for example by passing a memsize= boot argument.
 	 */
-	addr = pfn_to_kaddr(max_pfn);
-	memset(addr, 0, len);
+	addr = pfn_to_kaddr(max_low_pfn);
+	if (requested != 0) {
+		if (requested >= addr)
+			addr = requested;
+		else
+			addr = 0;
+	}
+	if (addr != 0)
+		memset(addr, 0, len);
 #else
-	/* simple grab some mem for now */
-	addr = kzalloc(len, GFP_KERNEL);
+	if (requested != 0) {
+		/* If we have a target in mind, grab a 2x slice and hope... */
+		addr = kzalloc(len*2, GFP_KERNEL);
+		if ((requested >= addr) && (requested < (addr + len)))
+			addr = requested;
+		else
+			addr = 0;
+	} else {
+		/* simply grab some mem for now */
+		addr = kzalloc(len, GFP_KERNEL);
+	}
 #endif
-
 	return addr;
 }
 
@@ -841,13 +879,12 @@ static int vpe_elfload(struct vpe * v)
 	memset(&mod, 0, sizeof(struct module));
 	strcpy(mod.name, "VPE loader");
 
-	hdr = (Elf_Ehdr *) v->pbuffer;
-	len = v->plen;
+	hdr = v->l_ehdr;
+	len = v->pbsize;
 
 	/* Sanity checks against insmoding binaries or wrong arch,
 	   weird elf version */
-	if (memcmp(hdr->e_ident, ELFMAG, 4) != 0
-	    || (hdr->e_type != ET_REL && hdr->e_type != ET_EXEC)
+	if ((hdr->e_type != ET_REL && hdr->e_type != ET_EXEC)
 	    || !elf_check_arch(hdr)
 	    || hdr->e_shentsize != sizeof(*sechdrs)) {
 		printk(KERN_WARNING
@@ -859,9 +896,8 @@ static int vpe_elfload(struct vpe * v)
 	if (hdr->e_type == ET_REL)
 		relocate = 1;
 
-	if (len < hdr->e_shoff + hdr->e_shnum * sizeof(Elf_Shdr)) {
-		printk(KERN_ERR "VPE loader: program length %u truncated\n",
-		       len);
+	if (len < v->l_phlen + v->l_shlen) {
+		printk(KERN_ERR "VPE loader: Headers exceed %u bytes\n", len);
 
 		return -ENOEXEC;
 	}
@@ -895,13 +931,17 @@ static int vpe_elfload(struct vpe * v)
 			}
 		}
 		layout_sections(&mod, hdr, sechdrs, secstrings);
+		/*
+		 * Non-relocatable loads should have already done their
+		 * allocates, based on program header table.
+		 */
+		v->load_addr = alloc_progmem(NULL, mod.core_size);
 	}
 
-	v->load_addr = alloc_progmem(mod.core_size);
 	if (!v->load_addr)
 		return -ENOMEM;
 
-	pr_info("VPE loader: loading to %p\n", v->load_addr);
+	printk(KERN_INFO "VPE loader: loaded/loading to %p\n", v->load_addr);
 
 	if (relocate) {
 		for (i = 0; i < hdr->e_shnum; i++) {
@@ -949,18 +989,10 @@ static int vpe_elfload(struct vpe * v)
  				return err;
 
   		}
-  	} else {
-		struct elf_phdr *phdr = (struct elf_phdr *) ((char *)hdr + hdr->e_phoff);
-
-		for (i = 0; i < hdr->e_phnum; i++) {
-		    if (phdr->p_type == PT_LOAD) {
-			memcpy((void *)phdr->p_paddr, 
-				(char *)hdr + phdr->p_offset, phdr->p_filesz);
-			memset((void *)phdr->p_paddr + phdr->p_filesz, 
-				0, phdr->p_memsz - phdr->p_filesz);
-		    }
-		    phdr++;
-		}
+	} else {
+		/*
+		 * Program image is already in memory.
+		 */
 
 		for (i = 0; i < hdr->e_shnum; i++) {
  			/* Internal symbols and strings. */
@@ -978,7 +1010,7 @@ static int vpe_elfload(struct vpe * v)
 
 	/* make sure it's physically written out */
 	flush_icache_range((unsigned long)v->load_addr,
-			   (unsigned long)v->load_addr + v->len);
+			   (unsigned long)v->load_addr + v->copied);
 
 	if ((find_vpe_symbols(v, sechdrs, symindex, strtab, &mod)) < 0) {
 		if (v->__start == 0) {
@@ -993,7 +1025,7 @@ static int vpe_elfload(struct vpe * v)
 			       " Unable to use AMVP (AP/SP) facilities.\n");
 	}
 
-	printk(" elf loaded\n");
+	printk(KERN_INFO "APRP VPE loader: elf loaded\n");
 	return 0;
 }
 
@@ -1058,6 +1090,10 @@ static int vpe_open(struct inode *inode, struct file *filp)
 		return -ENODEV;
 	}
 
+	/*
+	 * This treats the tclimit command line configuration input
+	 * as a minor device indication, which is probably unwholesome.
+	 */
 	if ((v = get_vpe(tclimit)) == NULL) {
 		printk(KERN_WARNING "VPE loader: unable to get vpe\n");
 		return -ENODEV;
@@ -1077,9 +1113,14 @@ static int vpe_open(struct inode *inode, struct file *filp)
 
 	/* this of-course trashes what was there before... */
 	v->pbuffer = vmalloc(P_SIZE);
-	v->plen = P_SIZE;
+	v->pbsize = P_SIZE;
 	v->load_addr = NULL;
-	v->len = 0;
+	v->copied = 0;
+	v->offset = 0;
+	v->l_state = LOAD_STATE_EHDR;
+	v->l_ehdr = NULL;
+	v->l_phdr = NULL;
+	v->l_shdr = NULL;
 
 	v->uid = filp->f_uid;
 	v->gid = filp->f_gid;
@@ -1106,23 +1147,26 @@ static int vpe_open(struct inode *inode, struct file *filp)
 static int vpe_release(struct inode *inode, struct file *filp)
 {
 	struct vpe *v;
-	Elf_Ehdr *hdr;
 	int ret = 0;
 
 	v = get_vpe(tclimit);
 	if (v == NULL)
 		return -ENODEV;
 
-	hdr = (Elf_Ehdr *) v->pbuffer;
-	if (memcmp(hdr->e_ident, ELFMAG, 4) == 0) {
-		if (vpe_elfload(v) >= 0) {
-			vpe_run(v);
-		} else {
- 			printk(KERN_WARNING "VPE loader: ELF load failed.\n");
-			ret = -ENOEXEC;
-		}
+	/*
+	 * If image load had no errors, massage program/section tables
+	 * to reflect movement of program/section data into VPE program
+	 * memory.
+	 */
+	if (v->l_state != LOAD_STATE_DONE) {
+		printk(KERN_WARNING "VPE Release after incomplete load\n");
+		return(-ENOEXEC);
+	}
+
+	if (vpe_elfload(v) >= 0) {
+		vpe_run(v);
 	} else {
- 		printk(KERN_WARNING "VPE loader: only elf files are supported\n");
+		printk(KERN_WARNING "VPE loader: ELF load failed.\n");
 		ret = -ENOEXEC;
 	}
 
@@ -1137,15 +1181,62 @@ static int vpe_release(struct inode *inode, struct file *filp)
 	// cleanup any temp buffers
 	if (v->pbuffer)
 		vfree(v->pbuffer);
-	v->plen = 0;
+	v->pbsize = 0;
 	return ret;
 }
 
+/*
+ * A sort of insertion sort to generate list of program header indices
+ * in order of their file offsets.
+ */
+
+static void indexort(struct elf_phdr *phdr, int nph, int *index)
+{
+	int i, j, t;
+	unsigned int toff;
+
+	/* Create initial mapping */
+	for (i = 0; i < nph; i++) index[i] = i;
+	/* Do the indexed insert sort */
+	for (i = 1; i < nph; i++) {
+		j = i;
+		t = index[j];
+		toff = phdr[t].p_offset;
+		while ((j > 0) && (phdr[index[j-1]].p_offset > toff)) {
+			index[j] = index[j-1];
+			j--;
+		}
+		index[j] = t;
+	}
+}
+
+
+/*
+ * This function has to convert the ELF file image being sequentially
+ * streamed to the pseudo-device into the binary image, symbol, and
+ * string information, which the ELF format allows to be in some degree
+ * of disorder.
+ *
+ * The ELF header and, if present, program header table, are copied into
+ * a temporary buffer.  Loadable program segments, if present, are copied
+ * into the RP program memory at the addresses specified by the program
+ * header table.
+ *
+ * Sections not specified by the program header table are loaded into
+ * memory following the program segments if they are "allocated", or
+ * into the temporary buffer if they are not. The section header
+ * table is loaded into the temporary buffer.???
+ */
+#define CURPHDR v->l_phdr[v->l_phsort[v->l_cur_seg]]
+
 static ssize_t vpe_write(struct file *file, const char __user * buffer,
 			 size_t count, loff_t * ppos)
 {
 	size_t ret = count;
 	struct vpe *v;
+	int tocopy, uncopied;
+	int i;
+	unsigned int progmemlen;
 
 	if (iminor(file->f_path.dentry->d_inode) != minor)
 		return -ENODEV;
@@ -1159,17 +1250,320 @@ static ssize_t vpe_write(struct file *file, const char __user * buffer,
 		return -ENOMEM;
 	}
 
-	if ((count + v->len) > v->plen) {
+	if ((count + v->copied) > v->pbsize) {
 		printk(KERN_WARNING
 		       "VPE loader: elf size too big. Perhaps strip uneeded symbols\n");
 		return -ENOMEM;
 	}
 
-	count -= copy_from_user(v->pbuffer + v->len, buffer, count);
-	if (!count)
-		return -EFAULT;
+	while (count) {
+		switch (v->l_state) {
+		case LOAD_STATE_EHDR:
+			/* Loading ELF Header into scratch buffer */
+			tocopy = min((unsigned long)count,
+			    sizeof(Elf_Ehdr) - v->offset);
+			uncopied = copy_from_user(v->pbuffer + v->copied,
+			    buffer, tocopy);
+			count -= tocopy - uncopied;
+			v->copied += tocopy - uncopied;
+			v->offset += tocopy - uncopied;
+			buffer += tocopy - uncopied;
+			if (v->copied == sizeof(Elf_Ehdr)) {
+			    v->l_ehdr = (Elf_Ehdr *)v->pbuffer;
+			    if (memcmp(v->l_ehdr->e_ident, ELFMAG, 4) != 0) {
+				printk(KERN_WARNING "VPE loader: %s\n",
+					"non-ELF file image");
+				ret = -ENOEXEC;
+				v->l_state = LOAD_STATE_ERROR;
+				break;
+			    }
+			    if (v->l_ehdr->e_phoff != 0) {
+				v->l_phdr = (struct elf_phdr *)
+					(v->pbuffer + v->l_ehdr->e_phoff);
+				v->l_phlen = v->l_ehdr->e_phentsize
+					* v->l_ehdr->e_phnum;
+				v->l_state = LOAD_STATE_PHDR;
+				/*
+				 * Program headers generally indicate
+				 * linked executable with possibly
+				 * valid entry point.
+				 */
+				v->__start = v->l_ehdr->e_entry;
+			    } else  if (v->l_ehdr->e_shoff != 0) {
+				/*
+				 * No program headers, but a section
+				 * header table.  A relocatable binary.
+				 * We need to load the works into the
+				 * kernel temp buffer to compute the
+				 * RP program image.  That limits our
+				 * binary size, but at least we're no
+				 * worse off than the original APRP
+				 * prototype.
+				 */
+				v->l_shlen = v->l_ehdr->e_shentsize
+					* v->l_ehdr->e_shnum;
+				v->l_state = LOAD_STATE_SHDR;
+			    } else {
+				/*
+				 * If neither program nor section tables,
+				 * we don't know what to do.
+				 */
+				v->l_state = LOAD_STATE_ERROR;
+				return(-ENOEXEC);
+			    }
+			}
+			break;
+		case LOAD_STATE_PHDR:
+			/* Loading Program Headers into scratch */
+			tocopy = min((unsigned long)count,
+			    v->l_ehdr->e_phoff + v->l_phlen - v->copied);
+			uncopied = copy_from_user(v->pbuffer + v->copied,
+			    buffer, tocopy);
+			count -= tocopy - uncopied;
+			v->copied += tocopy - uncopied;
+			v->offset += tocopy - uncopied;
+			buffer += tocopy - uncopied;
+
+			if (v->copied == v->l_ehdr->e_phoff + v->l_phlen) {
+			    /*
+			     * It's legal for the program headers to be
+			     * out of order with respect to the file layout.
+			     * Generate a list of indices, sorted by file
+			     * offset.
+			     */
+			    v->l_phsort = kmalloc(v->l_ehdr->e_phnum
+				* sizeof(int), GFP_KERNEL);
+			    if (!v->l_phsort) {
+				/* Preposterous, but... */
+				return(-ENOMEM);
+			    }
+			    indexort(v->l_phdr, v->l_ehdr->e_phnum,
+				v->l_phsort);
+
+			    v->l_progminad = (unsigned int)-1;
+			    v->l_progmaxad = 0;
+			    progmemlen = 0;
+			    for (i = 0; i < v->l_ehdr->e_phnum; i++) {
+				if (v->l_phdr[v->l_phsort[i]].p_type
+				    == PT_LOAD) {
+				    /* Unstripped .reginfo sections are bad */
+				    if (v->l_phdr[v->l_phsort[i]].p_vaddr
+					< __UA_LIMIT) {
+					printk(KERN_WARNING "%s%s%s\n",
+					    "VPE loader: ",
+					    "User-mode p_vaddr, ",
+					    "skipping program segment,");
+					printk(KERN_WARNING "%s%s%s\n",
+					    "VPE loader: ",
+					    "strip .reginfo from binary ",
+					    "if necessary.");
+					continue;
+				    }
+				    if (v->l_phdr[v->l_phsort[i]].p_vaddr
+					< v->l_progminad) {
+					    v->l_progminad =
+					      v->l_phdr[v->l_phsort[i]].p_vaddr;
+				    }
+				    if ((v->l_phdr[v->l_phsort[i]].p_vaddr
+					+ v->l_phdr[v->l_phsort[i]].p_memsz)
+					> v->l_progmaxad) {
+					    v->l_progmaxad =
+					     v->l_phdr[v->l_phsort[i]].p_vaddr +
+					     v->l_phdr[v->l_phsort[i]].p_memsz;
+				    }
+				}
+			    }
+			    printk(KERN_INFO "APRP RP program 0x%x to 0x%x\n",
+				v->l_progminad, v->l_progmaxad);
+			    v->load_addr = alloc_progmem((void *)v->l_progminad,
+				v->l_progmaxad - v->l_progminad);
+			    if (!v->load_addr)
+				return -ENOMEM;
+			    if ((unsigned int)v->load_addr
+				> v->l_progminad) {
+				release_progmem(v->load_addr);
+				return(-ENOMEM);
+			    }
+			    /* Find first segment with loadable content */
+			    for (i = 0; i < v->l_ehdr->e_phnum; i++) {
+				if (v->l_phdr[v->l_phsort[i]].p_type
+				    == PT_LOAD) {
+				    if (v->l_phdr[v->l_phsort[i]].p_vaddr
+					< __UA_LIMIT) {
+					/* Skip userspace segments */
+					continue;
+				    }
+				    v->l_cur_seg = i;
+				    break;
+				}
+			    }
+			    if (i == v->l_ehdr->e_phnum) {
+				/* No loadable program segment?  Bogus file. */
+				printk(KERN_WARNING "Bad ELF file for APRP\n");
+				return(-ENOEXEC);
+			    }
+			    v->l_segoff = 0;
+			    v->l_state = LOAD_STATE_PIMAGE;
+			}
+			break;
+		case LOAD_STATE_PIMAGE:
+			/*
+			 * Skip through input stream until
+			 * first program segment. Would be
+			 * better to have loaded up to here
+			 * into the temp buffer, but for now
+			 * we simply rule out "interesting"
+			 * sections prior to the last program
+			 * segment in an executable file.
+			 */
+			if (v->offset < CURPHDR.p_offset) {
+			    uncopied = CURPHDR.p_offset - v->offset;
+			    if (uncopied > count)
+				uncopied = count;
+			    count -= uncopied;
+			    buffer += uncopied;
+			    v->offset += uncopied;
+			    /* Go back through the "while" */
+			    break;
+			}
+			/*
+			 * Having dispensed with any unlikely fluff,
+			 * copy from user I/O buffer to program segment.
+			 */
+			tocopy = min(count, CURPHDR.p_filesz - v->l_segoff);
+
+			/* Loading image into RP memory */
+			uncopied = copy_from_user((char *)CURPHDR.p_vaddr
+			    + v->l_segoff, buffer, tocopy);
+			count -= tocopy - uncopied;
+			v->offset += tocopy - uncopied;
+			v->l_segoff += tocopy - uncopied;
+			buffer += tocopy - uncopied;
+			if (v->l_segoff >= CURPHDR.p_filesz) {
+			    /* Finished current segment load */
+			    /* Zero out non-file-sourced image */
+			    uncopied = CURPHDR.p_memsz - CURPHDR.p_filesz;
+			    if (uncopied > 0) {
+				memset((char *)CURPHDR.p_vaddr + v->l_segoff,
+				    0, uncopied);
+			    }
+			    /* Advance to next segment */
+			    for (i = v->l_cur_seg + 1;
+				i < v->l_ehdr->e_phnum; i++) {
+				if (v->l_phdr[v->l_phsort[i]].p_type
+				    == PT_LOAD) {
+				    if (v->l_phdr[v->l_phsort[i]].p_vaddr
+					< __UA_LIMIT) {
+					/* Skip userspace segments */
+					continue;
+				    }
+				    v->l_cur_seg = i;
+				    break;
+				}
+			    }
+			    /* If none left, prepare to load section headers */
+			    if (i == v->l_ehdr->e_phnum) {
+				if (v->l_ehdr->e_shoff != 0) {
+				/* Copy to where we left off in temp buffer */
+				    v->l_shlen = v->l_ehdr->e_shentsize
+					* v->l_ehdr->e_shnum;
+				    v->l_state = LOAD_STATE_SHDR;
+				    break;
+				}
+			    } else {
+				/* reset offset for new program segment */
+				v->l_segoff = 0;
+			    }
+			}
+			break;
+		case LOAD_STATE_SHDR:
+			/*
+			 * Read stream into private buffer up
+			 * through and including the section header
+			 * table.
+			 */
 
-	v->len += count;
+			tocopy = min((unsigned long)count,
+			    v->l_ehdr->e_shoff + v->l_shlen - v->offset);
+			if (tocopy) {
+			    uncopied = copy_from_user(v->pbuffer + v->copied,
+			    buffer, tocopy);
+			    count -= tocopy - uncopied;
+			    v->copied += tocopy - uncopied;
+			    v->offset += tocopy - uncopied;
+			    buffer += tocopy - uncopied;
+			}
+			/* Finished? */
+			if (v->offset == v->l_ehdr->e_shoff + v->l_shlen) {
+			    unsigned int offset_delta = v->offset - v->copied;
+
+			    v->l_shdr = (Elf_Shdr *)(v->pbuffer
+				+ v->l_ehdr->e_shoff - offset_delta);
+			    /*
+			     * Check for sections after the section table,
+			     * which for gcc MIPS binaries includes
+			     * the symbol table. Do any other processing
+			     * that requires value within stream, and
+			     * normalize offsets to be relative to
+			     * the header-only layout of temp buffer.
+			     */
+
+			    /* Assume no trailer until we detect one */
+			    v->l_trailer = 0;
+			    v->l_state = LOAD_STATE_DONE;
+			    for (i = 0; i < v->l_ehdr->e_shnum; i++) {
+				   if (v->l_shdr[i].sh_offset
+					> v->l_ehdr->e_shoff) {
+					v->l_state = LOAD_STATE_TRAILER;
+					/* Track trailing data length */
+					if (v->l_trailer
+					    < (v->l_shdr[i].sh_offset
+					    + v->l_shdr[i].sh_size)
+					    - (v->l_ehdr->e_shoff
+					    + v->l_shlen)) {
+						v->l_trailer =
+						    (v->l_shdr[i].sh_offset
+						    + v->l_shdr[i].sh_size)
+						    - (v->l_ehdr->e_shoff
+						    + v->l_shlen);
+					}
+				    }
+				    /* Adjust section offset if necessary */
+				    v->l_shdr[i].sh_offset -= offset_delta;
+				}
+
+				/* Fix up offsets in ELF header */
+				v->l_ehdr->e_shoff = (unsigned int)v->l_shdr
+				    - (unsigned int)v->pbuffer;
+			}
+			break;
+		case LOAD_STATE_TRAILER:
+			/*
+			 * Symbol and string tables follow section headers
+			 * in gcc binaries for MIPS. Copy into temp buffer.
+			 */
+			if (v->l_trailer) {
+			    tocopy = min(count, v->l_trailer);
+			    uncopied = copy_from_user(v->pbuffer + v->copied,
+			    buffer, tocopy);
+			    count -= tocopy - uncopied;
+			    v->l_trailer -= tocopy - uncopied;
+			    v->copied += tocopy - uncopied;
+			    v->offset += tocopy - uncopied;
+			    buffer += tocopy - uncopied;
+			}
+			if (!v->l_trailer)
+			    v->l_state = LOAD_STATE_DONE;
+			break;
+		case LOAD_STATE_DONE:
+			if (count)
+				count = 0;
+			break;
+		case LOAD_STATE_ERROR:
+		default:
+			return(-EINVAL);
+		}
+	}
 	return ret;
 }
 
@@ -1204,7 +1598,9 @@ int vpe_start(vpe_handle vpe, unsigned long start)
 {
 	struct vpe *v = vpe;
 
-	v->__start = start;
+	/* Null start address means use value from ELF file */
+	if (start)
+		v->__start = start;
 	return vpe_run(v);
 }
 
-- 
1.5.3.3


--------------000005000500030307010207--
