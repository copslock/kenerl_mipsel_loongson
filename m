Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2007 07:59:52 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:8890 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20022126AbXIEG7m (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2007 07:59:42 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1ISorO-0004SM-5E
	for linux-mips@linux-mips.org; Wed, 05 Sep 2007 08:59:34 +0200
Date:	Wed, 5 Sep 2007 08:59:34 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH 2/2][MIPS] Move ARC code into arch/mips/fw/arc
Message-ID: <20070905065934.GC16802@hall.aurel32.net>
References: <20070905065704.GA16802@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20070905065704.GA16802@hall.aurel32.net>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Move the ARC code to arch/mips/fw/arc from arch/mips/arc.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/Makefile              |    2 +-
 arch/mips/arc/Makefile          |   10 --
 arch/mips/arc/arc_con.c         |   50 -----------
 arch/mips/arc/cmdline.c         |  108 ------------------------
 arch/mips/arc/env.c             |   27 ------
 arch/mips/arc/file.c            |   75 -----------------
 arch/mips/arc/identify.c        |  123 ---------------------------
 arch/mips/arc/init.c            |   51 -----------
 arch/mips/arc/memory.c          |  160 -----------------------------------
 arch/mips/arc/misc.c            |   89 --------------------
 arch/mips/arc/promlib.c         |   43 ----------
 arch/mips/arc/salone.c          |   24 ------
 arch/mips/arc/time.c            |   25 ------
 arch/mips/arc/tree.c            |  127 ----------------------------
 arch/mips/fw/arc/Makefile       |   10 ++
 arch/mips/fw/arc/arc_con.c      |   50 +++++++++++
 arch/mips/fw/arc/cmdline.c      |  108 ++++++++++++++++++++++++
 arch/mips/fw/arc/env.c          |   27 ++++++
 arch/mips/fw/arc/file.c         |   75 +++++++++++++++++
 arch/mips/fw/arc/identify.c     |  123 +++++++++++++++++++++++++++
 arch/mips/fw/arc/init.c         |   51 +++++++++++
 arch/mips/fw/arc/memory.c       |  160 +++++++++++++++++++++++++++++++++++
 arch/mips/fw/arc/misc.c         |   89 ++++++++++++++++++++
 arch/mips/fw/arc/promlib.c      |   43 ++++++++++
 arch/mips/fw/arc/salone.c       |   24 ++++++
 arch/mips/fw/arc/time.c         |   25 ++++++
 arch/mips/fw/arc/tree.c         |  127 ++++++++++++++++++++++++++++
 arch/mips/sni/setup.c           |    2 +-
 include/asm-mips/arc/hinv.h     |  175 ---------------------------------------
 include/asm-mips/arc/types.h    |   86 -------------------
 include/asm-mips/fw/arc/hinv.h  |  175 +++++++++++++++++++++++++++++++++++++++
 include/asm-mips/fw/arc/types.h |   86 +++++++++++++++++++
 include/asm-mips/sgiarcs.h      |    2 +-
 include/asm-mips/sn/klconfig.h  |    4 +-
 34 files changed, 1178 insertions(+), 1178 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 8163eb7..a4f8ba2 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -148,7 +148,7 @@ endif
 #
 # Firmware support
 #
-libs-$(CONFIG_ARC)		+= arch/mips/arc/
+libs-$(CONFIG_ARC)		+= arch/mips/fw/arc/
 libs-$(CONFIG_CFE)		+= arch/mips/fw/cfe/
 libs-$(CONFIG_SIBYTE_CFE)	+= arch/mips/sibyte/cfe/
 
diff --git a/arch/mips/arc/Makefile b/arch/mips/arc/Makefile
deleted file mode 100644
index 4f349ec..0000000
--- a/arch/mips/arc/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# Makefile for the ARC prom monitor library routines under Linux.
-#
-
-lib-y				+= cmdline.o env.o file.o identify.o init.o \
-				   misc.o salone.o time.o tree.o
-
-lib-$(CONFIG_ARC_MEMORY)	+= memory.o
-lib-$(CONFIG_ARC_CONSOLE)	+= arc_con.o
-lib-$(CONFIG_ARC_PROMLIB)	+= promlib.o
diff --git a/arch/mips/arc/arc_con.c b/arch/mips/arc/arc_con.c
deleted file mode 100644
index bc32fe6..0000000
--- a/arch/mips/arc/arc_con.c
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- * Wrap-around code for a console using the
- * ARC io-routines.
- *
- * Copyright (c) 1998 Harald Koerfgen
- * Copyright (c) 2001 Ralf Baechle
- * Copyright (c) 2002 Thiemo Seufer
- */
-#include <linux/tty.h>
-#include <linux/major.h>
-#include <linux/init.h>
-#include <linux/console.h>
-#include <linux/fs.h>
-#include <asm/sgialib.h>
-
-static void prom_console_write(struct console *co, const char *s,
-			       unsigned count)
-{
-	/* Do each character */
-	while (count--) {
-		if (*s == '\n')
-			prom_putchar('\r');
-		prom_putchar(*s++);
-	}
-}
-
-static int prom_console_setup(struct console *co, char *options)
-{
-	return !(prom_flags & PROM_FLAG_USE_AS_CONSOLE);
-}
-
-static struct console arc_cons = {
-	.name		= "arc",
-	.write		= prom_console_write,
-	.setup		= prom_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-};
-
-/*
- *    Register console.
- */
-
-static int __init arc_console_init(void)
-{
-	register_console(&arc_cons);
-
-	return 0;
-}
-console_initcall(arc_console_init);
diff --git a/arch/mips/arc/cmdline.c b/arch/mips/arc/cmdline.c
deleted file mode 100644
index fd604ef..0000000
--- a/arch/mips/arc/cmdline.c
+++ /dev/null
@@ -1,108 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * cmdline.c: Kernel command line creation using ARCS argc/argv.
- *
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-#include <asm/sgialib.h>
-#include <asm/bootinfo.h>
-
-#undef DEBUG_CMDLINE
-
-char * __init prom_getcmdline(void)
-{
-	return arcs_cmdline;
-}
-
-static char *ignored[] = {
-	"ConsoleIn=",
-	"ConsoleOut=",
-	"SystemPartition=",
-	"OSLoader=",
-	"OSLoadPartition=",
-	"OSLoadFilename=",
-	"OSLoadOptions="
-};
-
-static char *used_arc[][2] = {
-	{ "OSLoadPartition=", "root=" },
-	{ "OSLoadOptions=", "" }
-};
-
-static char * __init move_firmware_args(char* cp)
-{
-	char *s;
-	int actr, i;
-
-	actr = 1; /* Always ignore argv[0] */
-
-	while (actr < prom_argc) {
-		for(i = 0; i < ARRAY_SIZE(used_arc); i++) {
-			int len = strlen(used_arc[i][0]);
-
-			if (!strncmp(prom_argv(actr), used_arc[i][0], len)) {
-			/* Ok, we want it. First append the replacement... */
-				strcat(cp, used_arc[i][1]);
-				cp += strlen(used_arc[i][1]);
-				/* ... and now the argument */
-				s = strstr(prom_argv(actr), "=");
-				if (s) {
-					s++;
-					strcpy(cp, s);
-					cp += strlen(s);
-				}
-				*cp++ = ' ';
-				break;
-			}
-		}
-		actr++;
-	}
-
-	return cp;
-}
-
-void __init prom_init_cmdline(void)
-{
-	char *cp;
-	int actr, i;
-
-	actr = 1; /* Always ignore argv[0] */
-
-	cp = arcs_cmdline;
-	/*
-	 * Move ARC variables to the beginning to make sure they can be
-	 * overridden by later arguments.
-	 */
-	cp = move_firmware_args(cp);
-
-	while (actr < prom_argc) {
-		for (i = 0; i < ARRAY_SIZE(ignored); i++) {
-			int len = strlen(ignored[i]);
-
-			if (!strncmp(prom_argv(actr), ignored[i], len))
-				goto pic_cont;
-		}
-		/* Ok, we want it. */
-		strcpy(cp, prom_argv(actr));
-		cp += strlen(prom_argv(actr));
-		*cp++ = ' ';
-
-	pic_cont:
-		actr++;
-	}
-
-	if (cp != arcs_cmdline)		/* get rid of trailing space */
-		--cp;
-	*cp = '\0';
-
-#ifdef DEBUG_CMDLINE
-	printk(KERN_DEBUG "prom cmdline: %s\n", arcs_cmdline);
-#endif
-}
diff --git a/arch/mips/arc/env.c b/arch/mips/arc/env.c
deleted file mode 100644
index e521a6e..0000000
--- a/arch/mips/arc/env.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * env.c: ARCS environment variable routines.
- *
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-#include <asm/arc/types.h>
-#include <asm/sgialib.h>
-
-PCHAR __init
-ArcGetEnvironmentVariable(CHAR *name)
-{
-	return (CHAR *) ARC_CALL1(get_evar, name);
-}
-
-LONG __init
-ArcSetEnvironmentVariable(PCHAR name, PCHAR value)
-{
-	return ARC_CALL2(set_evar, name, value);
-}
diff --git a/arch/mips/arc/file.c b/arch/mips/arc/file.c
deleted file mode 100644
index cb0127c..0000000
--- a/arch/mips/arc/file.c
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * ARC firmware interface.
- *
- * Copyright (C) 1994, 1995, 1996, 1999 Ralf Baechle
- * Copyright (C) 1999 Silicon Graphics, Inc.
- */
-#include <linux/init.h>
-
-#include <asm/arc/types.h>
-#include <asm/sgialib.h>
-
-LONG
-ArcGetDirectoryEntry(ULONG FileID, struct linux_vdirent *Buffer,
-                     ULONG N, ULONG *Count)
-{
-	return ARC_CALL4(get_vdirent, FileID, Buffer, N, Count);
-}
-
-LONG
-ArcOpen(CHAR *Path, enum linux_omode OpenMode, ULONG *FileID)
-{
-	return ARC_CALL3(open, Path, OpenMode, FileID);
-}
-
-LONG
-ArcClose(ULONG FileID)
-{
-	return ARC_CALL1(close, FileID);
-}
-
-LONG
-ArcRead(ULONG FileID, VOID *Buffer, ULONG N, ULONG *Count)
-{
-	return ARC_CALL4(read, FileID, Buffer, N, Count);
-}
-
-LONG
-ArcGetReadStatus(ULONG FileID)
-{
-	return ARC_CALL1(get_rstatus, FileID);
-}
-
-LONG
-ArcWrite(ULONG FileID, PVOID Buffer, ULONG N, PULONG Count)
-{
-	return ARC_CALL4(write, FileID, Buffer, N, Count);
-}
-
-LONG
-ArcSeek(ULONG FileID, struct linux_bigint *Position, enum linux_seekmode SeekMode)
-{
-	return ARC_CALL3(seek, FileID, Position, SeekMode);
-}
-
-LONG
-ArcMount(char *name, enum linux_mountops op)
-{
-	return ARC_CALL2(mount, name, op);
-}
-
-LONG
-ArcGetFileInformation(ULONG FileID, struct linux_finfo *Information)
-{
-	return ARC_CALL2(get_finfo, FileID, Information);
-}
-
-LONG ArcSetFileInformation(ULONG FileID, ULONG AttributeFlags,
-                           ULONG AttributeMask)
-{
-	return ARC_CALL3(set_finfo, FileID, AttributeFlags, AttributeMask);
-}
diff --git a/arch/mips/arc/identify.c b/arch/mips/arc/identify.c
deleted file mode 100644
index 4b90736..0000000
--- a/arch/mips/arc/identify.c
+++ /dev/null
@@ -1,123 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * identify.c: identify machine by looking up system identifier
- *
- * Copyright (C) 1998 Thomas Bogendoerfer
- *
- * This code is based on arch/mips/sgi/kernel/system.c, which is
- *
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/string.h>
-
-#include <asm/sgialib.h>
-#include <asm/bootinfo.h>
-
-struct smatch {
-	char *arcname;
-	char *liname;
-	int group;
-	int type;
-	int flags;
-};
-
-static struct smatch mach_table[] = {
-	{	"SGI-IP22",
-		"SGI Indy",
-		MACH_GROUP_SGI,
-		MACH_SGI_IP22,
-		PROM_FLAG_ARCS
-	}, {	"SGI-IP27",
-		"SGI Origin",
-		MACH_GROUP_SGI,
-		MACH_SGI_IP27,
-		PROM_FLAG_ARCS
-	}, {	"SGI-IP28",
-		"SGI IP28",
-		MACH_GROUP_SGI,
-		MACH_SGI_IP28,
-		PROM_FLAG_ARCS
-	}, {	"SGI-IP30",
-		"SGI Octane",
-		MACH_GROUP_SGI,
-		MACH_SGI_IP30,
-		PROM_FLAG_ARCS
-	}, {	"SGI-IP32",
-		"SGI O2",
-		MACH_GROUP_SGI,
-		MACH_SGI_IP32,
-		PROM_FLAG_ARCS
-	}, {	"Microsoft-Jazz",
-		"Jazz MIPS_Magnum_4000",
-		MACH_GROUP_JAZZ,
-		MACH_MIPS_MAGNUM_4000,
-		0
-	}, {	"PICA-61",
-		"Jazz Acer_PICA_61",
-		MACH_GROUP_JAZZ,
-		MACH_ACER_PICA_61,
-		0
-	}, {	"RM200PCI",
-		"SNI RM200_PCI",
-		MACH_GROUP_SNI_RM,
-		MACH_SNI_RM200_PCI,
-		PROM_FLAG_DONT_FREE_TEMP
-	}
-};
-
-int prom_flags;
-
-static struct smatch * __init string_to_mach(const char *s)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(mach_table); i++) {
-		if (!strcmp(s, mach_table[i].arcname))
-			return &mach_table[i];
-	}
-
-	panic("Yeee, could not determine architecture type <%s>", s);
-}
-
-char *system_type;
-
-const char *get_system_type(void)
-{
-	return system_type;
-}
-
-void __init prom_identify_arch(void)
-{
-	pcomponent *p;
-	struct smatch *mach;
-	const char *iname;
-
-	/*
-	 * The root component tells us what machine architecture we have here.
-	 */
-	p = ArcGetChild(PROM_NULL_COMPONENT);
-	if (p == NULL) {
-#ifdef CONFIG_SGI_IP27
-		/* IP27 PROM misbehaves, seems to not implement ARC
-		   GetChild().  So we just assume it's an IP27.  */
-		iname = "SGI-IP27";
-#else
-		iname = "Unknown";
-#endif
-	} else
-		iname = (char *) (long) p->iname;
-
-	printk("ARCH: %s\n", iname);
-	mach = string_to_mach(iname);
-	system_type = mach->liname;
-
-	mips_machgroup = mach->group;
-	mips_machtype = mach->type;
-	prom_flags = mach->flags;
-}
diff --git a/arch/mips/arc/init.c b/arch/mips/arc/init.c
deleted file mode 100644
index e2f75b1..0000000
--- a/arch/mips/arc/init.c
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * PROM library initialisation code.
- *
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-#include <asm/bootinfo.h>
-#include <asm/sgialib.h>
-
-#undef DEBUG_PROM_INIT
-
-/* Master romvec interface. */
-struct linux_romvec *romvec;
-int prom_argc;
-LONG *_prom_argv, *_prom_envp;
-
-void __init prom_init(void)
-{
-	PSYSTEM_PARAMETER_BLOCK pb = PROMBLOCK;
-
-	romvec = ROMVECTOR;
-
-	prom_argc = fw_arg0;
-	_prom_argv = (LONG *) fw_arg1;
-	_prom_envp = (LONG *) fw_arg2;
-
-	if (pb->magic != 0x53435241) {
-		printk(KERN_CRIT "Aieee, bad prom vector magic %08lx\n",
-		       (unsigned long) pb->magic);
-		while(1)
-			;
-	}
-
-	prom_init_cmdline();
-	prom_identify_arch();
-	printk(KERN_INFO "PROMLIB: ARC firmware Version %d Revision %d\n",
-	       pb->ver, pb->rev);
-	prom_meminit();
-
-#ifdef DEBUG_PROM_INIT
-	pr_info("Press a key to reboot\n");
-	ArcRead(0, &c, 1, &cnt);
-	ArcEnterInteractiveMode();
-#endif
-}
diff --git a/arch/mips/arc/memory.c b/arch/mips/arc/memory.c
deleted file mode 100644
index 83d1579..0000000
--- a/arch/mips/arc/memory.c
+++ /dev/null
@@ -1,160 +0,0 @@
-/*
- * memory.c: PROM library functions for acquiring/using memory descriptors
- *           given to us from the ARCS firmware.
- *
- * Copyright (C) 1996 by David S. Miller
- * Copyright (C) 1999, 2000, 2001 by Ralf Baechle
- * Copyright (C) 1999, 2000 by Silicon Graphics, Inc.
- *
- * PROM library functions for acquiring/using memory descriptors given to us
- * from the ARCS firmware.  This is only used when CONFIG_ARC_MEMORY is set
- * because on some machines like SGI IP27 the ARC memory configuration data
- * completly bogus and alternate easier to use mechanisms are available.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/bootmem.h>
-#include <linux/swap.h>
-
-#include <asm/sgialib.h>
-#include <asm/page.h>
-#include <asm/pgtable.h>
-#include <asm/bootinfo.h>
-
-#undef DEBUG
-
-/*
- * For ARC firmware memory functions the unit of meassuring memory is always
- * a 4k page of memory
- */
-#define ARC_PAGE_SHIFT	12
-
-struct linux_mdesc * __init ArcGetMemoryDescriptor(struct linux_mdesc *Current)
-{
-	return (struct linux_mdesc *) ARC_CALL1(get_mdesc, Current);
-}
-
-#ifdef DEBUG /* convenient for debugging */
-static char *arcs_mtypes[8] = {
-	"Exception Block",
-	"ARCS Romvec Page",
-	"Free/Contig RAM",
-	"Generic Free RAM",
-	"Bad Memory",
-	"Standalone Program Pages",
-	"ARCS Temp Storage Area",
-	"ARCS Permanent Storage Area"
-};
-
-static char *arc_mtypes[8] = {
-	"Exception Block",
-	"SystemParameterBlock",
-	"FreeMemory",
-	"Bad Memory",
-	"LoadedProgram",
-	"FirmwareTemporary",
-	"FirmwarePermanent",
-	"FreeContiguous"
-};
-#define mtypes(a) (prom_flags & PROM_FLAG_ARCS) ? arcs_mtypes[a.arcs] \
-						: arc_mtypes[a.arc]
-#endif
-
-static inline int memtype_classify_arcs (union linux_memtypes type)
-{
-	switch (type.arcs) {
-	case arcs_fcontig:
-	case arcs_free:
-		return BOOT_MEM_RAM;
-	case arcs_atmp:
-		return BOOT_MEM_ROM_DATA;
-	case arcs_eblock:
-	case arcs_rvpage:
-	case arcs_bmem:
-	case arcs_prog:
-	case arcs_aperm:
-		return BOOT_MEM_RESERVED;
-	default:
-		BUG();
-	}
-	while(1);				/* Nuke warning.  */
-}
-
-static inline int memtype_classify_arc (union linux_memtypes type)
-{
-	switch (type.arc) {
-	case arc_free:
-	case arc_fcontig:
-		return BOOT_MEM_RAM;
-	case arc_atmp:
-		return BOOT_MEM_ROM_DATA;
-	case arc_eblock:
-	case arc_rvpage:
-	case arc_bmem:
-	case arc_prog:
-	case arc_aperm:
-		return BOOT_MEM_RESERVED;
-	default:
-		BUG();
-	}
-	while(1);				/* Nuke warning.  */
-}
-
-static int __init prom_memtype_classify (union linux_memtypes type)
-{
-	if (prom_flags & PROM_FLAG_ARCS)	/* SGI is ``different'' ... */
-		return memtype_classify_arcs(type);
-
-	return memtype_classify_arc(type);
-}
-
-void __init prom_meminit(void)
-{
-	struct linux_mdesc *p;
-
-#ifdef DEBUG
-	int i = 0;
-
-	printk("ARCS MEMORY DESCRIPTOR dump:\n");
-	p = ArcGetMemoryDescriptor(PROM_NULL_MDESC);
-	while(p) {
-		printk("[%d,%p]: base<%08lx> pages<%08lx> type<%s>\n",
-		       i, p, p->base, p->pages, mtypes(p->type));
-		p = ArcGetMemoryDescriptor(p);
-		i++;
-	}
-#endif
-
-	p = PROM_NULL_MDESC;
-	while ((p = ArcGetMemoryDescriptor(p))) {
-		unsigned long base, size;
-		long type;
-
-		base = p->base << ARC_PAGE_SHIFT;
-		size = p->pages << ARC_PAGE_SHIFT;
-		type = prom_memtype_classify(p->type);
-
-		add_memory_region(base, size, type);
-	}
-}
-
-void __init prom_free_prom_memory(void)
-{
-	unsigned long addr;
-	int i;
-
-	if (prom_flags & PROM_FLAG_DONT_FREE_TEMP)
-		return;
-
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
-			continue;
-
-		addr = boot_mem_map.map[i].addr;
-		free_init_pages("prom memory",
-				addr, addr + boot_mem_map.map[i].size);
-	}
-}
diff --git a/arch/mips/arc/misc.c b/arch/mips/arc/misc.c
deleted file mode 100644
index b2e10b9..0000000
--- a/arch/mips/arc/misc.c
+++ /dev/null
@@ -1,89 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Miscellaneous ARCS PROM routines.
- *
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- * Copyright (C) 1999 Ralf Baechle (ralf@gnu.org)
- * Copyright (C) 1999 Silicon Graphics, Inc.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-#include <asm/bcache.h>
-
-#include <asm/arc/types.h>
-#include <asm/sgialib.h>
-#include <asm/bootinfo.h>
-#include <asm/system.h>
-
-VOID
-ArcHalt(VOID)
-{
-	bc_disable();
-	local_irq_disable();
-	ARC_CALL0(halt);
-never:	goto never;
-}
-
-VOID
-ArcPowerDown(VOID)
-{
-	bc_disable();
-	local_irq_disable();
-	ARC_CALL0(pdown);
-never:	goto never;
-}
-
-/* XXX is this a soft reset basically? XXX */
-VOID
-ArcRestart(VOID)
-{
-	bc_disable();
-	local_irq_disable();
-	ARC_CALL0(restart);
-never:	goto never;
-}
-
-VOID
-ArcReboot(VOID)
-{
-	bc_disable();
-	local_irq_disable();
-	ARC_CALL0(reboot);
-never:	goto never;
-}
-
-VOID
-ArcEnterInteractiveMode(VOID)
-{
-	bc_disable();
-	local_irq_disable();
-	ARC_CALL0(imode);
-never:	goto never;
-}
-
-LONG
-ArcSaveConfiguration(VOID)
-{
-	return ARC_CALL0(cfg_save);
-}
-
-struct linux_sysid *
-ArcGetSystemId(VOID)
-{
-	return (struct linux_sysid *) ARC_CALL0(get_sysid);
-}
-
-VOID __init
-ArcFlushAllCaches(VOID)
-{
-	ARC_CALL0(cache_flush);
-}
-
-DISPLAY_STATUS * __init ArcGetDisplayStatus(ULONG FileID)
-{
-	return (DISPLAY_STATUS *) ARC_CALL1(GetDisplayStatus, FileID);
-}
diff --git a/arch/mips/arc/promlib.c b/arch/mips/arc/promlib.c
deleted file mode 100644
index c508c00..0000000
--- a/arch/mips/arc/promlib.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1996 David S. Miller (dm@sgi.com)
- * Compability with board caches, Ulf Carlsson
- */
-#include <linux/kernel.h>
-#include <asm/sgialib.h>
-#include <asm/bcache.h>
-
-/*
- * IP22 boardcache is not compatible with board caches.  Thus we disable it
- * during romvec action.  Since r4xx0.c is always compiled and linked with your
- * kernel, this shouldn't cause any harm regardless what MIPS processor you
- * have.
- *
- * The ARC write and read functions seem to interfere with the serial lines
- * in some way. You should be careful with them.
- */
-
-void prom_putchar(char c)
-{
-	ULONG cnt;
-	CHAR it = c;
-
-	bc_disable();
-	ArcWrite(1, &it, 1, &cnt);
-	bc_enable();
-}
-
-char prom_getchar(void)
-{
-	ULONG cnt;
-	CHAR c;
-
-	bc_disable();
-	ArcRead(0, &c, 1, &cnt);
-	bc_enable();
-
-	return c;
-}
diff --git a/arch/mips/arc/salone.c b/arch/mips/arc/salone.c
deleted file mode 100644
index e6afb64..0000000
--- a/arch/mips/arc/salone.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Routines to load into memory and execute stand-along program images using
- * ARCS PROM firmware.
- *
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- */
-#include <linux/init.h>
-#include <asm/sgialib.h>
-
-LONG __init ArcLoad(CHAR *Path, ULONG TopAddr, ULONG *ExecAddr, ULONG *LowAddr)
-{
-	return ARC_CALL4(load, Path, TopAddr, ExecAddr, LowAddr);
-}
-
-LONG __init ArcInvoke(ULONG ExecAddr, ULONG StackAddr, ULONG Argc, CHAR *Argv[],
-	CHAR *Envp[])
-{
-	return ARC_CALL5(invoke, ExecAddr, StackAddr, Argc, Argv, Envp);
-}
-
-LONG __init ArcExecute(CHAR *Path, LONG Argc, CHAR *Argv[], CHAR *Envp[])
-{
-	return ARC_CALL4(exec, Path, Argc, Argv, Envp);
-}
diff --git a/arch/mips/arc/time.c b/arch/mips/arc/time.c
deleted file mode 100644
index 299ff2c..0000000
--- a/arch/mips/arc/time.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Extracting time information from ARCS prom.
- *
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- */
-#include <linux/init.h>
-
-#include <asm/arc/types.h>
-#include <asm/sgialib.h>
-
-struct linux_tinfo * __init
-ArcGetTime(VOID)
-{
-	return (struct linux_tinfo *) ARC_CALL0(get_tinfo);
-}
-
-ULONG __init
-ArcGetRelativeTime(VOID)
-{
-	return ARC_CALL0(get_rtime);
-}
diff --git a/arch/mips/arc/tree.c b/arch/mips/arc/tree.c
deleted file mode 100644
index abd1786..0000000
--- a/arch/mips/arc/tree.c
+++ /dev/null
@@ -1,127 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * PROM component device tree code.
- *
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- * Copyright (C) 1999 Ralf Baechle (ralf@gnu.org)
- * Copyright (C) 1999 Silicon Graphics, Inc.
- */
-#include <linux/init.h>
-#include <asm/arc/types.h>
-#include <asm/sgialib.h>
-
-#undef DEBUG_PROM_TREE
-
-pcomponent * __init
-ArcGetPeer(pcomponent *Current)
-{
-	if (Current == PROM_NULL_COMPONENT)
-		return PROM_NULL_COMPONENT;
-
-	return (pcomponent *) ARC_CALL1(next_component, Current);
-}
-
-pcomponent * __init
-ArcGetChild(pcomponent *Current)
-{
-	return (pcomponent *) ARC_CALL1(child_component, Current);
-}
-
-pcomponent * __init
-ArcGetParent(pcomponent *Current)
-{
-	if (Current == PROM_NULL_COMPONENT)
-		return PROM_NULL_COMPONENT;
-
-	return (pcomponent *) ARC_CALL1(parent_component, Current);
-}
-
-LONG __init
-ArcGetConfigurationData(VOID *Buffer, pcomponent *Current)
-{
-	return ARC_CALL2(component_data, Buffer, Current);
-}
-
-pcomponent * __init
-ArcAddChild(pcomponent *Current, pcomponent *Template, VOID *ConfigurationData)
-{
-	return (pcomponent *)
-	       ARC_CALL3(child_add, Current, Template, ConfigurationData);
-}
-
-LONG __init
-ArcDeleteComponent(pcomponent *ComponentToDelete)
-{
-	return ARC_CALL1(comp_del, ComponentToDelete);
-}
-
-pcomponent * __init
-ArcGetComponent(CHAR *Path)
-{
-	return (pcomponent *)ARC_CALL1(component_by_path, Path);
-}
-
-#ifdef DEBUG_PROM_TREE
-
-static char *classes[] = {
-	"system", "processor", "cache", "adapter", "controller", "peripheral",
-	"memory"
-};
-
-static char *types[] = {
-	"arc", "cpu", "fpu", "picache", "pdcache", "sicache", "sdcache",
-	"sccache", "memdev", "eisa adapter", "tc adapter", "scsi adapter",
-	"dti adapter", "multi-func adapter", "disk controller",
-	"tp controller", "cdrom controller", "worm controller",
-	"serial controller", "net controller", "display controller",
-	"parallel controller", "pointer controller", "keyboard controller",
-	"audio controller", "misc controller", "disk peripheral",
-	"floppy peripheral", "tp peripheral", "modem peripheral",
-	"monitor peripheral", "printer peripheral", "pointer peripheral",
-	"keyboard peripheral", "terminal peripheral", "line peripheral",
-	"net peripheral", "misc peripheral", "anonymous"
-};
-
-static char *iflags[] = {
-	"bogus", "read only", "removable", "console in", "console out",
-	"input", "output"
-};
-
-static void __init
-dump_component(pcomponent *p)
-{
-	printk("[%p]:class<%s>type<%s>flags<%s>ver<%d>rev<%d>",
-	       p, classes[p->class], types[p->type],
-	       iflags[p->iflags], p->vers, p->rev);
-	printk("key<%08lx>\n\tamask<%08lx>cdsize<%d>ilen<%d>iname<%s>\n",
-	       p->key, p->amask, (int)p->cdsize, (int)p->ilen, p->iname);
-}
-
-static void __init
-traverse(pcomponent *p, int op)
-{
-	dump_component(p);
-	if(ArcGetChild(p))
-		traverse(ArcGetChild(p), 1);
-	if(ArcGetPeer(p) && op)
-		traverse(ArcGetPeer(p), 1);
-}
-
-void __init
-prom_testtree(void)
-{
-	pcomponent *p;
-
-	p = ArcGetChild(PROM_NULL_COMPONENT);
-	dump_component(p);
-	p = ArcGetChild(p);
-	while(p) {
-		dump_component(p);
-		p = ArcGetPeer(p);
-	}
-}
-
-#endif /* DEBUG_PROM_TREE  */
diff --git a/arch/mips/fw/arc/Makefile b/arch/mips/fw/arc/Makefile
new file mode 100644
index 0000000..4f349ec
--- /dev/null
+++ b/arch/mips/fw/arc/Makefile
@@ -0,0 +1,10 @@
+#
+# Makefile for the ARC prom monitor library routines under Linux.
+#
+
+lib-y				+= cmdline.o env.o file.o identify.o init.o \
+				   misc.o salone.o time.o tree.o
+
+lib-$(CONFIG_ARC_MEMORY)	+= memory.o
+lib-$(CONFIG_ARC_CONSOLE)	+= arc_con.o
+lib-$(CONFIG_ARC_PROMLIB)	+= promlib.o
diff --git a/arch/mips/fw/arc/arc_con.c b/arch/mips/fw/arc/arc_con.c
new file mode 100644
index 0000000..bc32fe6
--- /dev/null
+++ b/arch/mips/fw/arc/arc_con.c
@@ -0,0 +1,50 @@
+/*
+ * Wrap-around code for a console using the
+ * ARC io-routines.
+ *
+ * Copyright (c) 1998 Harald Koerfgen
+ * Copyright (c) 2001 Ralf Baechle
+ * Copyright (c) 2002 Thiemo Seufer
+ */
+#include <linux/tty.h>
+#include <linux/major.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/fs.h>
+#include <asm/sgialib.h>
+
+static void prom_console_write(struct console *co, const char *s,
+			       unsigned count)
+{
+	/* Do each character */
+	while (count--) {
+		if (*s == '\n')
+			prom_putchar('\r');
+		prom_putchar(*s++);
+	}
+}
+
+static int prom_console_setup(struct console *co, char *options)
+{
+	return !(prom_flags & PROM_FLAG_USE_AS_CONSOLE);
+}
+
+static struct console arc_cons = {
+	.name		= "arc",
+	.write		= prom_console_write,
+	.setup		= prom_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+};
+
+/*
+ *    Register console.
+ */
+
+static int __init arc_console_init(void)
+{
+	register_console(&arc_cons);
+
+	return 0;
+}
+console_initcall(arc_console_init);
diff --git a/arch/mips/fw/arc/cmdline.c b/arch/mips/fw/arc/cmdline.c
new file mode 100644
index 0000000..fd604ef
--- /dev/null
+++ b/arch/mips/fw/arc/cmdline.c
@@ -0,0 +1,108 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * cmdline.c: Kernel command line creation using ARCS argc/argv.
+ *
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include <asm/sgialib.h>
+#include <asm/bootinfo.h>
+
+#undef DEBUG_CMDLINE
+
+char * __init prom_getcmdline(void)
+{
+	return arcs_cmdline;
+}
+
+static char *ignored[] = {
+	"ConsoleIn=",
+	"ConsoleOut=",
+	"SystemPartition=",
+	"OSLoader=",
+	"OSLoadPartition=",
+	"OSLoadFilename=",
+	"OSLoadOptions="
+};
+
+static char *used_arc[][2] = {
+	{ "OSLoadPartition=", "root=" },
+	{ "OSLoadOptions=", "" }
+};
+
+static char * __init move_firmware_args(char* cp)
+{
+	char *s;
+	int actr, i;
+
+	actr = 1; /* Always ignore argv[0] */
+
+	while (actr < prom_argc) {
+		for(i = 0; i < ARRAY_SIZE(used_arc); i++) {
+			int len = strlen(used_arc[i][0]);
+
+			if (!strncmp(prom_argv(actr), used_arc[i][0], len)) {
+			/* Ok, we want it. First append the replacement... */
+				strcat(cp, used_arc[i][1]);
+				cp += strlen(used_arc[i][1]);
+				/* ... and now the argument */
+				s = strstr(prom_argv(actr), "=");
+				if (s) {
+					s++;
+					strcpy(cp, s);
+					cp += strlen(s);
+				}
+				*cp++ = ' ';
+				break;
+			}
+		}
+		actr++;
+	}
+
+	return cp;
+}
+
+void __init prom_init_cmdline(void)
+{
+	char *cp;
+	int actr, i;
+
+	actr = 1; /* Always ignore argv[0] */
+
+	cp = arcs_cmdline;
+	/*
+	 * Move ARC variables to the beginning to make sure they can be
+	 * overridden by later arguments.
+	 */
+	cp = move_firmware_args(cp);
+
+	while (actr < prom_argc) {
+		for (i = 0; i < ARRAY_SIZE(ignored); i++) {
+			int len = strlen(ignored[i]);
+
+			if (!strncmp(prom_argv(actr), ignored[i], len))
+				goto pic_cont;
+		}
+		/* Ok, we want it. */
+		strcpy(cp, prom_argv(actr));
+		cp += strlen(prom_argv(actr));
+		*cp++ = ' ';
+
+	pic_cont:
+		actr++;
+	}
+
+	if (cp != arcs_cmdline)		/* get rid of trailing space */
+		--cp;
+	*cp = '\0';
+
+#ifdef DEBUG_CMDLINE
+	printk(KERN_DEBUG "prom cmdline: %s\n", arcs_cmdline);
+#endif
+}
diff --git a/arch/mips/fw/arc/env.c b/arch/mips/fw/arc/env.c
new file mode 100644
index 0000000..6f5dd42
--- /dev/null
+++ b/arch/mips/fw/arc/env.c
@@ -0,0 +1,27 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * env.c: ARCS environment variable routines.
+ *
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include <asm/fw/arc/types.h>
+#include <asm/sgialib.h>
+
+PCHAR __init
+ArcGetEnvironmentVariable(CHAR *name)
+{
+	return (CHAR *) ARC_CALL1(get_evar, name);
+}
+
+LONG __init
+ArcSetEnvironmentVariable(PCHAR name, PCHAR value)
+{
+	return ARC_CALL2(set_evar, name, value);
+}
diff --git a/arch/mips/fw/arc/file.c b/arch/mips/fw/arc/file.c
new file mode 100644
index 0000000..3033534
--- /dev/null
+++ b/arch/mips/fw/arc/file.c
@@ -0,0 +1,75 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * ARC firmware interface.
+ *
+ * Copyright (C) 1994, 1995, 1996, 1999 Ralf Baechle
+ * Copyright (C) 1999 Silicon Graphics, Inc.
+ */
+#include <linux/init.h>
+
+#include <asm/fw/arc/types.h>
+#include <asm/sgialib.h>
+
+LONG
+ArcGetDirectoryEntry(ULONG FileID, struct linux_vdirent *Buffer,
+                     ULONG N, ULONG *Count)
+{
+	return ARC_CALL4(get_vdirent, FileID, Buffer, N, Count);
+}
+
+LONG
+ArcOpen(CHAR *Path, enum linux_omode OpenMode, ULONG *FileID)
+{
+	return ARC_CALL3(open, Path, OpenMode, FileID);
+}
+
+LONG
+ArcClose(ULONG FileID)
+{
+	return ARC_CALL1(close, FileID);
+}
+
+LONG
+ArcRead(ULONG FileID, VOID *Buffer, ULONG N, ULONG *Count)
+{
+	return ARC_CALL4(read, FileID, Buffer, N, Count);
+}
+
+LONG
+ArcGetReadStatus(ULONG FileID)
+{
+	return ARC_CALL1(get_rstatus, FileID);
+}
+
+LONG
+ArcWrite(ULONG FileID, PVOID Buffer, ULONG N, PULONG Count)
+{
+	return ARC_CALL4(write, FileID, Buffer, N, Count);
+}
+
+LONG
+ArcSeek(ULONG FileID, struct linux_bigint *Position, enum linux_seekmode SeekMode)
+{
+	return ARC_CALL3(seek, FileID, Position, SeekMode);
+}
+
+LONG
+ArcMount(char *name, enum linux_mountops op)
+{
+	return ARC_CALL2(mount, name, op);
+}
+
+LONG
+ArcGetFileInformation(ULONG FileID, struct linux_finfo *Information)
+{
+	return ARC_CALL2(get_finfo, FileID, Information);
+}
+
+LONG ArcSetFileInformation(ULONG FileID, ULONG AttributeFlags,
+                           ULONG AttributeMask)
+{
+	return ARC_CALL3(set_finfo, FileID, AttributeFlags, AttributeMask);
+}
diff --git a/arch/mips/fw/arc/identify.c b/arch/mips/fw/arc/identify.c
new file mode 100644
index 0000000..4b90736
--- /dev/null
+++ b/arch/mips/fw/arc/identify.c
@@ -0,0 +1,123 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * identify.c: identify machine by looking up system identifier
+ *
+ * Copyright (C) 1998 Thomas Bogendoerfer
+ *
+ * This code is based on arch/mips/sgi/kernel/system.c, which is
+ *
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/string.h>
+
+#include <asm/sgialib.h>
+#include <asm/bootinfo.h>
+
+struct smatch {
+	char *arcname;
+	char *liname;
+	int group;
+	int type;
+	int flags;
+};
+
+static struct smatch mach_table[] = {
+	{	"SGI-IP22",
+		"SGI Indy",
+		MACH_GROUP_SGI,
+		MACH_SGI_IP22,
+		PROM_FLAG_ARCS
+	}, {	"SGI-IP27",
+		"SGI Origin",
+		MACH_GROUP_SGI,
+		MACH_SGI_IP27,
+		PROM_FLAG_ARCS
+	}, {	"SGI-IP28",
+		"SGI IP28",
+		MACH_GROUP_SGI,
+		MACH_SGI_IP28,
+		PROM_FLAG_ARCS
+	}, {	"SGI-IP30",
+		"SGI Octane",
+		MACH_GROUP_SGI,
+		MACH_SGI_IP30,
+		PROM_FLAG_ARCS
+	}, {	"SGI-IP32",
+		"SGI O2",
+		MACH_GROUP_SGI,
+		MACH_SGI_IP32,
+		PROM_FLAG_ARCS
+	}, {	"Microsoft-Jazz",
+		"Jazz MIPS_Magnum_4000",
+		MACH_GROUP_JAZZ,
+		MACH_MIPS_MAGNUM_4000,
+		0
+	}, {	"PICA-61",
+		"Jazz Acer_PICA_61",
+		MACH_GROUP_JAZZ,
+		MACH_ACER_PICA_61,
+		0
+	}, {	"RM200PCI",
+		"SNI RM200_PCI",
+		MACH_GROUP_SNI_RM,
+		MACH_SNI_RM200_PCI,
+		PROM_FLAG_DONT_FREE_TEMP
+	}
+};
+
+int prom_flags;
+
+static struct smatch * __init string_to_mach(const char *s)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mach_table); i++) {
+		if (!strcmp(s, mach_table[i].arcname))
+			return &mach_table[i];
+	}
+
+	panic("Yeee, could not determine architecture type <%s>", s);
+}
+
+char *system_type;
+
+const char *get_system_type(void)
+{
+	return system_type;
+}
+
+void __init prom_identify_arch(void)
+{
+	pcomponent *p;
+	struct smatch *mach;
+	const char *iname;
+
+	/*
+	 * The root component tells us what machine architecture we have here.
+	 */
+	p = ArcGetChild(PROM_NULL_COMPONENT);
+	if (p == NULL) {
+#ifdef CONFIG_SGI_IP27
+		/* IP27 PROM misbehaves, seems to not implement ARC
+		   GetChild().  So we just assume it's an IP27.  */
+		iname = "SGI-IP27";
+#else
+		iname = "Unknown";
+#endif
+	} else
+		iname = (char *) (long) p->iname;
+
+	printk("ARCH: %s\n", iname);
+	mach = string_to_mach(iname);
+	system_type = mach->liname;
+
+	mips_machgroup = mach->group;
+	mips_machtype = mach->type;
+	prom_flags = mach->flags;
+}
diff --git a/arch/mips/fw/arc/init.c b/arch/mips/fw/arc/init.c
new file mode 100644
index 0000000..e2f75b1
--- /dev/null
+++ b/arch/mips/fw/arc/init.c
@@ -0,0 +1,51 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * PROM library initialisation code.
+ *
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <asm/bootinfo.h>
+#include <asm/sgialib.h>
+
+#undef DEBUG_PROM_INIT
+
+/* Master romvec interface. */
+struct linux_romvec *romvec;
+int prom_argc;
+LONG *_prom_argv, *_prom_envp;
+
+void __init prom_init(void)
+{
+	PSYSTEM_PARAMETER_BLOCK pb = PROMBLOCK;
+
+	romvec = ROMVECTOR;
+
+	prom_argc = fw_arg0;
+	_prom_argv = (LONG *) fw_arg1;
+	_prom_envp = (LONG *) fw_arg2;
+
+	if (pb->magic != 0x53435241) {
+		printk(KERN_CRIT "Aieee, bad prom vector magic %08lx\n",
+		       (unsigned long) pb->magic);
+		while(1)
+			;
+	}
+
+	prom_init_cmdline();
+	prom_identify_arch();
+	printk(KERN_INFO "PROMLIB: ARC firmware Version %d Revision %d\n",
+	       pb->ver, pb->rev);
+	prom_meminit();
+
+#ifdef DEBUG_PROM_INIT
+	pr_info("Press a key to reboot\n");
+	ArcRead(0, &c, 1, &cnt);
+	ArcEnterInteractiveMode();
+#endif
+}
diff --git a/arch/mips/fw/arc/memory.c b/arch/mips/fw/arc/memory.c
new file mode 100644
index 0000000..83d1579
--- /dev/null
+++ b/arch/mips/fw/arc/memory.c
@@ -0,0 +1,160 @@
+/*
+ * memory.c: PROM library functions for acquiring/using memory descriptors
+ *           given to us from the ARCS firmware.
+ *
+ * Copyright (C) 1996 by David S. Miller
+ * Copyright (C) 1999, 2000, 2001 by Ralf Baechle
+ * Copyright (C) 1999, 2000 by Silicon Graphics, Inc.
+ *
+ * PROM library functions for acquiring/using memory descriptors given to us
+ * from the ARCS firmware.  This is only used when CONFIG_ARC_MEMORY is set
+ * because on some machines like SGI IP27 the ARC memory configuration data
+ * completly bogus and alternate easier to use mechanisms are available.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/swap.h>
+
+#include <asm/sgialib.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/bootinfo.h>
+
+#undef DEBUG
+
+/*
+ * For ARC firmware memory functions the unit of meassuring memory is always
+ * a 4k page of memory
+ */
+#define ARC_PAGE_SHIFT	12
+
+struct linux_mdesc * __init ArcGetMemoryDescriptor(struct linux_mdesc *Current)
+{
+	return (struct linux_mdesc *) ARC_CALL1(get_mdesc, Current);
+}
+
+#ifdef DEBUG /* convenient for debugging */
+static char *arcs_mtypes[8] = {
+	"Exception Block",
+	"ARCS Romvec Page",
+	"Free/Contig RAM",
+	"Generic Free RAM",
+	"Bad Memory",
+	"Standalone Program Pages",
+	"ARCS Temp Storage Area",
+	"ARCS Permanent Storage Area"
+};
+
+static char *arc_mtypes[8] = {
+	"Exception Block",
+	"SystemParameterBlock",
+	"FreeMemory",
+	"Bad Memory",
+	"LoadedProgram",
+	"FirmwareTemporary",
+	"FirmwarePermanent",
+	"FreeContiguous"
+};
+#define mtypes(a) (prom_flags & PROM_FLAG_ARCS) ? arcs_mtypes[a.arcs] \
+						: arc_mtypes[a.arc]
+#endif
+
+static inline int memtype_classify_arcs (union linux_memtypes type)
+{
+	switch (type.arcs) {
+	case arcs_fcontig:
+	case arcs_free:
+		return BOOT_MEM_RAM;
+	case arcs_atmp:
+		return BOOT_MEM_ROM_DATA;
+	case arcs_eblock:
+	case arcs_rvpage:
+	case arcs_bmem:
+	case arcs_prog:
+	case arcs_aperm:
+		return BOOT_MEM_RESERVED;
+	default:
+		BUG();
+	}
+	while(1);				/* Nuke warning.  */
+}
+
+static inline int memtype_classify_arc (union linux_memtypes type)
+{
+	switch (type.arc) {
+	case arc_free:
+	case arc_fcontig:
+		return BOOT_MEM_RAM;
+	case arc_atmp:
+		return BOOT_MEM_ROM_DATA;
+	case arc_eblock:
+	case arc_rvpage:
+	case arc_bmem:
+	case arc_prog:
+	case arc_aperm:
+		return BOOT_MEM_RESERVED;
+	default:
+		BUG();
+	}
+	while(1);				/* Nuke warning.  */
+}
+
+static int __init prom_memtype_classify (union linux_memtypes type)
+{
+	if (prom_flags & PROM_FLAG_ARCS)	/* SGI is ``different'' ... */
+		return memtype_classify_arcs(type);
+
+	return memtype_classify_arc(type);
+}
+
+void __init prom_meminit(void)
+{
+	struct linux_mdesc *p;
+
+#ifdef DEBUG
+	int i = 0;
+
+	printk("ARCS MEMORY DESCRIPTOR dump:\n");
+	p = ArcGetMemoryDescriptor(PROM_NULL_MDESC);
+	while(p) {
+		printk("[%d,%p]: base<%08lx> pages<%08lx> type<%s>\n",
+		       i, p, p->base, p->pages, mtypes(p->type));
+		p = ArcGetMemoryDescriptor(p);
+		i++;
+	}
+#endif
+
+	p = PROM_NULL_MDESC;
+	while ((p = ArcGetMemoryDescriptor(p))) {
+		unsigned long base, size;
+		long type;
+
+		base = p->base << ARC_PAGE_SHIFT;
+		size = p->pages << ARC_PAGE_SHIFT;
+		type = prom_memtype_classify(p->type);
+
+		add_memory_region(base, size, type);
+	}
+}
+
+void __init prom_free_prom_memory(void)
+{
+	unsigned long addr;
+	int i;
+
+	if (prom_flags & PROM_FLAG_DONT_FREE_TEMP)
+		return;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
+			continue;
+
+		addr = boot_mem_map.map[i].addr;
+		free_init_pages("prom memory",
+				addr, addr + boot_mem_map.map[i].size);
+	}
+}
diff --git a/arch/mips/fw/arc/misc.c b/arch/mips/fw/arc/misc.c
new file mode 100644
index 0000000..e527c5f
--- /dev/null
+++ b/arch/mips/fw/arc/misc.c
@@ -0,0 +1,89 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Miscellaneous ARCS PROM routines.
+ *
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ * Copyright (C) 1999 Ralf Baechle (ralf@gnu.org)
+ * Copyright (C) 1999 Silicon Graphics, Inc.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <asm/bcache.h>
+
+#include <asm/fw/arc/types.h>
+#include <asm/sgialib.h>
+#include <asm/bootinfo.h>
+#include <asm/system.h>
+
+VOID
+ArcHalt(VOID)
+{
+	bc_disable();
+	local_irq_disable();
+	ARC_CALL0(halt);
+never:	goto never;
+}
+
+VOID
+ArcPowerDown(VOID)
+{
+	bc_disable();
+	local_irq_disable();
+	ARC_CALL0(pdown);
+never:	goto never;
+}
+
+/* XXX is this a soft reset basically? XXX */
+VOID
+ArcRestart(VOID)
+{
+	bc_disable();
+	local_irq_disable();
+	ARC_CALL0(restart);
+never:	goto never;
+}
+
+VOID
+ArcReboot(VOID)
+{
+	bc_disable();
+	local_irq_disable();
+	ARC_CALL0(reboot);
+never:	goto never;
+}
+
+VOID
+ArcEnterInteractiveMode(VOID)
+{
+	bc_disable();
+	local_irq_disable();
+	ARC_CALL0(imode);
+never:	goto never;
+}
+
+LONG
+ArcSaveConfiguration(VOID)
+{
+	return ARC_CALL0(cfg_save);
+}
+
+struct linux_sysid *
+ArcGetSystemId(VOID)
+{
+	return (struct linux_sysid *) ARC_CALL0(get_sysid);
+}
+
+VOID __init
+ArcFlushAllCaches(VOID)
+{
+	ARC_CALL0(cache_flush);
+}
+
+DISPLAY_STATUS * __init ArcGetDisplayStatus(ULONG FileID)
+{
+	return (DISPLAY_STATUS *) ARC_CALL1(GetDisplayStatus, FileID);
+}
diff --git a/arch/mips/fw/arc/promlib.c b/arch/mips/fw/arc/promlib.c
new file mode 100644
index 0000000..c508c00
--- /dev/null
+++ b/arch/mips/fw/arc/promlib.c
@@ -0,0 +1,43 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1996 David S. Miller (dm@sgi.com)
+ * Compability with board caches, Ulf Carlsson
+ */
+#include <linux/kernel.h>
+#include <asm/sgialib.h>
+#include <asm/bcache.h>
+
+/*
+ * IP22 boardcache is not compatible with board caches.  Thus we disable it
+ * during romvec action.  Since r4xx0.c is always compiled and linked with your
+ * kernel, this shouldn't cause any harm regardless what MIPS processor you
+ * have.
+ *
+ * The ARC write and read functions seem to interfere with the serial lines
+ * in some way. You should be careful with them.
+ */
+
+void prom_putchar(char c)
+{
+	ULONG cnt;
+	CHAR it = c;
+
+	bc_disable();
+	ArcWrite(1, &it, 1, &cnt);
+	bc_enable();
+}
+
+char prom_getchar(void)
+{
+	ULONG cnt;
+	CHAR c;
+
+	bc_disable();
+	ArcRead(0, &c, 1, &cnt);
+	bc_enable();
+
+	return c;
+}
diff --git a/arch/mips/fw/arc/salone.c b/arch/mips/fw/arc/salone.c
new file mode 100644
index 0000000..e6afb64
--- /dev/null
+++ b/arch/mips/fw/arc/salone.c
@@ -0,0 +1,24 @@
+/*
+ * Routines to load into memory and execute stand-along program images using
+ * ARCS PROM firmware.
+ *
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ */
+#include <linux/init.h>
+#include <asm/sgialib.h>
+
+LONG __init ArcLoad(CHAR *Path, ULONG TopAddr, ULONG *ExecAddr, ULONG *LowAddr)
+{
+	return ARC_CALL4(load, Path, TopAddr, ExecAddr, LowAddr);
+}
+
+LONG __init ArcInvoke(ULONG ExecAddr, ULONG StackAddr, ULONG Argc, CHAR *Argv[],
+	CHAR *Envp[])
+{
+	return ARC_CALL5(invoke, ExecAddr, StackAddr, Argc, Argv, Envp);
+}
+
+LONG __init ArcExecute(CHAR *Path, LONG Argc, CHAR *Argv[], CHAR *Envp[])
+{
+	return ARC_CALL4(exec, Path, Argc, Argv, Envp);
+}
diff --git a/arch/mips/fw/arc/time.c b/arch/mips/fw/arc/time.c
new file mode 100644
index 0000000..42138c8
--- /dev/null
+++ b/arch/mips/fw/arc/time.c
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Extracting time information from ARCS prom.
+ *
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ */
+#include <linux/init.h>
+
+#include <asm/fw/arc/types.h>
+#include <asm/sgialib.h>
+
+struct linux_tinfo * __init
+ArcGetTime(VOID)
+{
+	return (struct linux_tinfo *) ARC_CALL0(get_tinfo);
+}
+
+ULONG __init
+ArcGetRelativeTime(VOID)
+{
+	return ARC_CALL0(get_rtime);
+}
diff --git a/arch/mips/fw/arc/tree.c b/arch/mips/fw/arc/tree.c
new file mode 100644
index 0000000..d68e5a5
--- /dev/null
+++ b/arch/mips/fw/arc/tree.c
@@ -0,0 +1,127 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * PROM component device tree code.
+ *
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ * Copyright (C) 1999 Ralf Baechle (ralf@gnu.org)
+ * Copyright (C) 1999 Silicon Graphics, Inc.
+ */
+#include <linux/init.h>
+#include <asm/fw/arc/types.h>
+#include <asm/sgialib.h>
+
+#undef DEBUG_PROM_TREE
+
+pcomponent * __init
+ArcGetPeer(pcomponent *Current)
+{
+	if (Current == PROM_NULL_COMPONENT)
+		return PROM_NULL_COMPONENT;
+
+	return (pcomponent *) ARC_CALL1(next_component, Current);
+}
+
+pcomponent * __init
+ArcGetChild(pcomponent *Current)
+{
+	return (pcomponent *) ARC_CALL1(child_component, Current);
+}
+
+pcomponent * __init
+ArcGetParent(pcomponent *Current)
+{
+	if (Current == PROM_NULL_COMPONENT)
+		return PROM_NULL_COMPONENT;
+
+	return (pcomponent *) ARC_CALL1(parent_component, Current);
+}
+
+LONG __init
+ArcGetConfigurationData(VOID *Buffer, pcomponent *Current)
+{
+	return ARC_CALL2(component_data, Buffer, Current);
+}
+
+pcomponent * __init
+ArcAddChild(pcomponent *Current, pcomponent *Template, VOID *ConfigurationData)
+{
+	return (pcomponent *)
+	       ARC_CALL3(child_add, Current, Template, ConfigurationData);
+}
+
+LONG __init
+ArcDeleteComponent(pcomponent *ComponentToDelete)
+{
+	return ARC_CALL1(comp_del, ComponentToDelete);
+}
+
+pcomponent * __init
+ArcGetComponent(CHAR *Path)
+{
+	return (pcomponent *)ARC_CALL1(component_by_path, Path);
+}
+
+#ifdef DEBUG_PROM_TREE
+
+static char *classes[] = {
+	"system", "processor", "cache", "adapter", "controller", "peripheral",
+	"memory"
+};
+
+static char *types[] = {
+	"arc", "cpu", "fpu", "picache", "pdcache", "sicache", "sdcache",
+	"sccache", "memdev", "eisa adapter", "tc adapter", "scsi adapter",
+	"dti adapter", "multi-func adapter", "disk controller",
+	"tp controller", "cdrom controller", "worm controller",
+	"serial controller", "net controller", "display controller",
+	"parallel controller", "pointer controller", "keyboard controller",
+	"audio controller", "misc controller", "disk peripheral",
+	"floppy peripheral", "tp peripheral", "modem peripheral",
+	"monitor peripheral", "printer peripheral", "pointer peripheral",
+	"keyboard peripheral", "terminal peripheral", "line peripheral",
+	"net peripheral", "misc peripheral", "anonymous"
+};
+
+static char *iflags[] = {
+	"bogus", "read only", "removable", "console in", "console out",
+	"input", "output"
+};
+
+static void __init
+dump_component(pcomponent *p)
+{
+	printk("[%p]:class<%s>type<%s>flags<%s>ver<%d>rev<%d>",
+	       p, classes[p->class], types[p->type],
+	       iflags[p->iflags], p->vers, p->rev);
+	printk("key<%08lx>\n\tamask<%08lx>cdsize<%d>ilen<%d>iname<%s>\n",
+	       p->key, p->amask, (int)p->cdsize, (int)p->ilen, p->iname);
+}
+
+static void __init
+traverse(pcomponent *p, int op)
+{
+	dump_component(p);
+	if(ArcGetChild(p))
+		traverse(ArcGetChild(p), 1);
+	if(ArcGetPeer(p) && op)
+		traverse(ArcGetPeer(p), 1);
+}
+
+void __init
+prom_testtree(void)
+{
+	pcomponent *p;
+
+	p = ArcGetChild(PROM_NULL_COMPONENT);
+	dump_component(p);
+	p = ArcGetChild(p);
+	while(p) {
+		dump_component(p);
+		p = ArcGetPeer(p);
+	}
+}
+
+#endif /* DEBUG_PROM_TREE  */
diff --git a/arch/mips/sni/setup.c b/arch/mips/sni/setup.c
index 6edbb30..883e35e 100644
--- a/arch/mips/sni/setup.c
+++ b/arch/mips/sni/setup.c
@@ -15,7 +15,7 @@
 #include <linux/screen_info.h>
 
 #ifdef CONFIG_ARC
-#include <asm/arc/types.h>
+#include <asm/fw/arc/types.h>
 #include <asm/sgialib.h>
 #endif
 
diff --git a/include/asm-mips/arc/hinv.h b/include/asm-mips/arc/hinv.h
deleted file mode 100644
index 1862912..0000000
--- a/include/asm-mips/arc/hinv.h
+++ /dev/null
@@ -1,175 +0,0 @@
-/*
- * ARCS hardware/memory inventory/configuration and system ID definitions.
- */
-#ifndef _ASM_ARC_HINV_H
-#define _ASM_ARC_HINV_H
-
-#include <asm/sgidefs.h>
-#include <asm/arc/types.h>
-
-/* configuration query defines */
-typedef enum configclass {
-	SystemClass,
-	ProcessorClass,
-	CacheClass,
-#ifndef	_NT_PROM
-	MemoryClass,
-	AdapterClass,
-	ControllerClass,
-	PeripheralClass
-#else	/* _NT_PROM */
-	AdapterClass,
-	ControllerClass,
-	PeripheralClass,
-	MemoryClass
-#endif	/* _NT_PROM */
-} CONFIGCLASS;
-
-typedef enum configtype {
-	ARC,
-	CPU,
-	FPU,
-	PrimaryICache,
-	PrimaryDCache,
-	SecondaryICache,
-	SecondaryDCache,
-	SecondaryCache,
-#ifndef	_NT_PROM
-	Memory,
-#endif
-	EISAAdapter,
-	TCAdapter,
-	SCSIAdapter,
-	DTIAdapter,
-	MultiFunctionAdapter,
-	DiskController,
-	TapeController,
-	CDROMController,
-	WORMController,
-	SerialController,
-	NetworkController,
-	DisplayController,
-	ParallelController,
-	PointerController,
-	KeyboardController,
-	AudioController,
-	OtherController,
-	DiskPeripheral,
-	FloppyDiskPeripheral,
-	TapePeripheral,
-	ModemPeripheral,
-	MonitorPeripheral,
-	PrinterPeripheral,
-	PointerPeripheral,
-	KeyboardPeripheral,
-	TerminalPeripheral,
-	LinePeripheral,
-	NetworkPeripheral,
-#ifdef	_NT_PROM
-	Memory,
-#endif
-	OtherPeripheral,
-
-	/* new stuff for IP30 */
-	/* added without moving anything */
-	/* except ANONYMOUS. */
-
-	XTalkAdapter,
-	PCIAdapter,
-	GIOAdapter,
-	TPUAdapter,
-
-	Anonymous
-} CONFIGTYPE;
-
-typedef enum {
-	Failed = 1,
-	ReadOnly = 2,
-	Removable = 4,
-	ConsoleIn = 8,
-	ConsoleOut = 16,
-	Input = 32,
-	Output = 64
-} IDENTIFIERFLAG;
-
-#ifndef NULL			/* for GetChild(NULL); */
-#define	NULL	0
-#endif
-
-union key_u {
-	struct {
-#ifdef	_MIPSEB
-		unsigned char  c_bsize;		/* block size in lines */
-		unsigned char  c_lsize;		/* line size in bytes/tag */
-		unsigned short c_size;		/* cache size in 4K pages */
-#else	/* _MIPSEL */
-		unsigned short c_size;		/* cache size in 4K pages */
-		unsigned char  c_lsize;		/* line size in bytes/tag */
-		unsigned char  c_bsize;		/* block size in lines */
-#endif	/* _MIPSEL */
-	} cache;
-	ULONG FullKey;
-};
-
-#if _MIPS_SIM == _MIPS_SIM_ABI64
-#define SGI_ARCS_VERS	64			/* sgi 64-bit version */
-#define SGI_ARCS_REV	0			/* rev .00 */
-#else
-#define SGI_ARCS_VERS	1			/* first version */
-#define SGI_ARCS_REV	10			/* rev .10, 3/04/92 */
-#endif
-
-typedef struct component {
-	CONFIGCLASS	Class;
-	CONFIGTYPE	Type;
-	IDENTIFIERFLAG	Flags;
-	USHORT		Version;
-	USHORT		Revision;
-	ULONG 		Key;
-	ULONG		AffinityMask;
-	ULONG		ConfigurationDataSize;
-	ULONG		IdentifierLength;
-	char		*Identifier;
-} COMPONENT;
-
-/* internal structure that holds pathname parsing data */
-struct cfgdata {
-	char *name;			/* full name */
-	int minlen;			/* minimum length to match */
-	CONFIGTYPE type;		/* type of token */
-};
-
-/* System ID */
-typedef struct systemid {
-	CHAR VendorId[8];
-	CHAR ProductId[8];
-} SYSTEMID;
-
-/* memory query functions */
-typedef enum memorytype {
-	ExceptionBlock,
-	SPBPage,			/* ARCS == SystemParameterBlock */
-#ifndef	_NT_PROM
-	FreeContiguous,
-	FreeMemory,
-	BadMemory,
-	LoadedProgram,
-	FirmwareTemporary,
-	FirmwarePermanent
-#else	/* _NT_PROM */
-	FreeMemory,
-	BadMemory,
-	LoadedProgram,
-	FirmwareTemporary,
-	FirmwarePermanent,
-	FreeContiguous
-#endif	/* _NT_PROM */
-} MEMORYTYPE;
-
-typedef struct memorydescriptor {
-	MEMORYTYPE	Type;
-	LONG		BasePage;
-	LONG		PageCount;
-} MEMORYDESCRIPTOR;
-
-#endif /* _ASM_ARC_HINV_H */
diff --git a/include/asm-mips/arc/types.h b/include/asm-mips/arc/types.h
deleted file mode 100644
index b9adcd6..0000000
--- a/include/asm-mips/arc/types.h
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright 1999 Ralf Baechle (ralf@gnu.org)
- * Copyright 1999 Silicon Graphics, Inc.
- */
-#ifndef _ASM_ARC_TYPES_H
-#define _ASM_ARC_TYPES_H
-
-
-#ifdef CONFIG_ARC32
-
-typedef char		CHAR;
-typedef short		SHORT;
-typedef long		LARGE_INTEGER __attribute__ ((__mode__ (__DI__)));
-typedef	long		LONG __attribute__ ((__mode__ (__SI__)));
-typedef unsigned char	UCHAR;
-typedef unsigned short	USHORT;
-typedef unsigned long	ULONG __attribute__ ((__mode__ (__SI__)));
-typedef void		VOID;
-
-/* The pointer types.  Note that we're using a 64-bit compiler but all
-   pointer in the ARC structures are only 32-bit, so we need some disgusting
-   workarounds.  Keep your vomit bag handy.  */
-typedef LONG		_PCHAR;
-typedef LONG		_PSHORT;
-typedef LONG		_PLARGE_INTEGER;
-typedef	LONG		_PLONG;
-typedef LONG		_PUCHAR;
-typedef LONG		_PUSHORT;
-typedef LONG		_PULONG;
-typedef LONG		_PVOID;
-
-#endif /* CONFIG_ARC32 */
-
-#ifdef CONFIG_ARC64
-
-typedef char		CHAR;
-typedef short		SHORT;
-typedef long		LARGE_INTEGER __attribute__ ((__mode__ (__DI__)));
-typedef	long		LONG __attribute__ ((__mode__ (__DI__)));
-typedef unsigned char	UCHAR;
-typedef unsigned short	USHORT;
-typedef unsigned long	ULONG __attribute__ ((__mode__ (__DI__)));
-typedef void		VOID;
-
-/* The pointer types.  We're 64-bit and the firmware is also 64-bit, so
-   live is sane ...  */
-typedef CHAR		*_PCHAR;
-typedef SHORT		*_PSHORT;
-typedef LARGE_INTEGER	*_PLARGE_INTEGER;
-typedef	LONG		*_PLONG;
-typedef UCHAR		*_PUCHAR;
-typedef USHORT		*_PUSHORT;
-typedef ULONG		*_PULONG;
-typedef VOID		*_PVOID;
-
-#endif /* CONFIG_ARC64  */
-
-typedef CHAR		*PCHAR;
-typedef SHORT		*PSHORT;
-typedef LARGE_INTEGER	*PLARGE_INTEGER;
-typedef	LONG		*PLONG;
-typedef UCHAR		*PUCHAR;
-typedef USHORT		*PUSHORT;
-typedef ULONG		*PULONG;
-typedef VOID		*PVOID;
-
-/*
- * Return type of ArcGetDisplayStatus()
- */
-typedef struct {
-	USHORT	CursorXPosition;
-	USHORT	CursorYPosition;
-	USHORT	CursorMaxXPosition;
-	USHORT	CursorMaxYPosition;
-	USHORT	ForegroundColor;
-	USHORT	BackgroundColor;
-	UCHAR	HighIntensity;
-	UCHAR	Underscored;
-	UCHAR	ReverseVideo;
-} DISPLAY_STATUS;
-
-#endif /* _ASM_ARC_TYPES_H */
diff --git a/include/asm-mips/fw/arc/hinv.h b/include/asm-mips/fw/arc/hinv.h
new file mode 100644
index 0000000..e6ff4ad
--- /dev/null
+++ b/include/asm-mips/fw/arc/hinv.h
@@ -0,0 +1,175 @@
+/*
+ * ARCS hardware/memory inventory/configuration and system ID definitions.
+ */
+#ifndef _ASM_ARC_HINV_H
+#define _ASM_ARC_HINV_H
+
+#include <asm/sgidefs.h>
+#include <asm/fw/arc/types.h>
+
+/* configuration query defines */
+typedef enum configclass {
+	SystemClass,
+	ProcessorClass,
+	CacheClass,
+#ifndef	_NT_PROM
+	MemoryClass,
+	AdapterClass,
+	ControllerClass,
+	PeripheralClass
+#else	/* _NT_PROM */
+	AdapterClass,
+	ControllerClass,
+	PeripheralClass,
+	MemoryClass
+#endif	/* _NT_PROM */
+} CONFIGCLASS;
+
+typedef enum configtype {
+	ARC,
+	CPU,
+	FPU,
+	PrimaryICache,
+	PrimaryDCache,
+	SecondaryICache,
+	SecondaryDCache,
+	SecondaryCache,
+#ifndef	_NT_PROM
+	Memory,
+#endif
+	EISAAdapter,
+	TCAdapter,
+	SCSIAdapter,
+	DTIAdapter,
+	MultiFunctionAdapter,
+	DiskController,
+	TapeController,
+	CDROMController,
+	WORMController,
+	SerialController,
+	NetworkController,
+	DisplayController,
+	ParallelController,
+	PointerController,
+	KeyboardController,
+	AudioController,
+	OtherController,
+	DiskPeripheral,
+	FloppyDiskPeripheral,
+	TapePeripheral,
+	ModemPeripheral,
+	MonitorPeripheral,
+	PrinterPeripheral,
+	PointerPeripheral,
+	KeyboardPeripheral,
+	TerminalPeripheral,
+	LinePeripheral,
+	NetworkPeripheral,
+#ifdef	_NT_PROM
+	Memory,
+#endif
+	OtherPeripheral,
+
+	/* new stuff for IP30 */
+	/* added without moving anything */
+	/* except ANONYMOUS. */
+
+	XTalkAdapter,
+	PCIAdapter,
+	GIOAdapter,
+	TPUAdapter,
+
+	Anonymous
+} CONFIGTYPE;
+
+typedef enum {
+	Failed = 1,
+	ReadOnly = 2,
+	Removable = 4,
+	ConsoleIn = 8,
+	ConsoleOut = 16,
+	Input = 32,
+	Output = 64
+} IDENTIFIERFLAG;
+
+#ifndef NULL			/* for GetChild(NULL); */
+#define	NULL	0
+#endif
+
+union key_u {
+	struct {
+#ifdef	_MIPSEB
+		unsigned char  c_bsize;		/* block size in lines */
+		unsigned char  c_lsize;		/* line size in bytes/tag */
+		unsigned short c_size;		/* cache size in 4K pages */
+#else	/* _MIPSEL */
+		unsigned short c_size;		/* cache size in 4K pages */
+		unsigned char  c_lsize;		/* line size in bytes/tag */
+		unsigned char  c_bsize;		/* block size in lines */
+#endif	/* _MIPSEL */
+	} cache;
+	ULONG FullKey;
+};
+
+#if _MIPS_SIM == _MIPS_SIM_ABI64
+#define SGI_ARCS_VERS	64			/* sgi 64-bit version */
+#define SGI_ARCS_REV	0			/* rev .00 */
+#else
+#define SGI_ARCS_VERS	1			/* first version */
+#define SGI_ARCS_REV	10			/* rev .10, 3/04/92 */
+#endif
+
+typedef struct component {
+	CONFIGCLASS	Class;
+	CONFIGTYPE	Type;
+	IDENTIFIERFLAG	Flags;
+	USHORT		Version;
+	USHORT		Revision;
+	ULONG 		Key;
+	ULONG		AffinityMask;
+	ULONG		ConfigurationDataSize;
+	ULONG		IdentifierLength;
+	char		*Identifier;
+} COMPONENT;
+
+/* internal structure that holds pathname parsing data */
+struct cfgdata {
+	char *name;			/* full name */
+	int minlen;			/* minimum length to match */
+	CONFIGTYPE type;		/* type of token */
+};
+
+/* System ID */
+typedef struct systemid {
+	CHAR VendorId[8];
+	CHAR ProductId[8];
+} SYSTEMID;
+
+/* memory query functions */
+typedef enum memorytype {
+	ExceptionBlock,
+	SPBPage,			/* ARCS == SystemParameterBlock */
+#ifndef	_NT_PROM
+	FreeContiguous,
+	FreeMemory,
+	BadMemory,
+	LoadedProgram,
+	FirmwareTemporary,
+	FirmwarePermanent
+#else	/* _NT_PROM */
+	FreeMemory,
+	BadMemory,
+	LoadedProgram,
+	FirmwareTemporary,
+	FirmwarePermanent,
+	FreeContiguous
+#endif	/* _NT_PROM */
+} MEMORYTYPE;
+
+typedef struct memorydescriptor {
+	MEMORYTYPE	Type;
+	LONG		BasePage;
+	LONG		PageCount;
+} MEMORYDESCRIPTOR;
+
+#endif /* _ASM_ARC_HINV_H */
diff --git a/include/asm-mips/fw/arc/types.h b/include/asm-mips/fw/arc/types.h
new file mode 100644
index 0000000..b9adcd6
--- /dev/null
+++ b/include/asm-mips/fw/arc/types.h
@@ -0,0 +1,86 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright 1999 Ralf Baechle (ralf@gnu.org)
+ * Copyright 1999 Silicon Graphics, Inc.
+ */
+#ifndef _ASM_ARC_TYPES_H
+#define _ASM_ARC_TYPES_H
+
+
+#ifdef CONFIG_ARC32
+
+typedef char		CHAR;
+typedef short		SHORT;
+typedef long		LARGE_INTEGER __attribute__ ((__mode__ (__DI__)));
+typedef	long		LONG __attribute__ ((__mode__ (__SI__)));
+typedef unsigned char	UCHAR;
+typedef unsigned short	USHORT;
+typedef unsigned long	ULONG __attribute__ ((__mode__ (__SI__)));
+typedef void		VOID;
+
+/* The pointer types.  Note that we're using a 64-bit compiler but all
+   pointer in the ARC structures are only 32-bit, so we need some disgusting
+   workarounds.  Keep your vomit bag handy.  */
+typedef LONG		_PCHAR;
+typedef LONG		_PSHORT;
+typedef LONG		_PLARGE_INTEGER;
+typedef	LONG		_PLONG;
+typedef LONG		_PUCHAR;
+typedef LONG		_PUSHORT;
+typedef LONG		_PULONG;
+typedef LONG		_PVOID;
+
+#endif /* CONFIG_ARC32 */
+
+#ifdef CONFIG_ARC64
+
+typedef char		CHAR;
+typedef short		SHORT;
+typedef long		LARGE_INTEGER __attribute__ ((__mode__ (__DI__)));
+typedef	long		LONG __attribute__ ((__mode__ (__DI__)));
+typedef unsigned char	UCHAR;
+typedef unsigned short	USHORT;
+typedef unsigned long	ULONG __attribute__ ((__mode__ (__DI__)));
+typedef void		VOID;
+
+/* The pointer types.  We're 64-bit and the firmware is also 64-bit, so
+   live is sane ...  */
+typedef CHAR		*_PCHAR;
+typedef SHORT		*_PSHORT;
+typedef LARGE_INTEGER	*_PLARGE_INTEGER;
+typedef	LONG		*_PLONG;
+typedef UCHAR		*_PUCHAR;
+typedef USHORT		*_PUSHORT;
+typedef ULONG		*_PULONG;
+typedef VOID		*_PVOID;
+
+#endif /* CONFIG_ARC64  */
+
+typedef CHAR		*PCHAR;
+typedef SHORT		*PSHORT;
+typedef LARGE_INTEGER	*PLARGE_INTEGER;
+typedef	LONG		*PLONG;
+typedef UCHAR		*PUCHAR;
+typedef USHORT		*PUSHORT;
+typedef ULONG		*PULONG;
+typedef VOID		*PVOID;
+
+/*
+ * Return type of ArcGetDisplayStatus()
+ */
+typedef struct {
+	USHORT	CursorXPosition;
+	USHORT	CursorYPosition;
+	USHORT	CursorMaxXPosition;
+	USHORT	CursorMaxYPosition;
+	USHORT	ForegroundColor;
+	USHORT	BackgroundColor;
+	UCHAR	HighIntensity;
+	UCHAR	Underscored;
+	UCHAR	ReverseVideo;
+} DISPLAY_STATUS;
+
+#endif /* _ASM_ARC_TYPES_H */
diff --git a/include/asm-mips/sgiarcs.h b/include/asm-mips/sgiarcs.h
index 439bce7..6d1eda6 100644
--- a/include/asm-mips/sgiarcs.h
+++ b/include/asm-mips/sgiarcs.h
@@ -13,7 +13,7 @@
 #define _ASM_SGIARCS_H
 
 #include <asm/types.h>
-#include <asm/arc/types.h>
+#include <asm/fw/arc/types.h>
 
 /* Various ARCS error codes. */
 #define PROM_ESUCCESS                   0x00
diff --git a/include/asm-mips/sn/klconfig.h b/include/asm-mips/sn/klconfig.h
index 82aeb9e..852213d 100644
--- a/include/asm-mips/sn/klconfig.h
+++ b/include/asm-mips/sn/klconfig.h
@@ -51,8 +51,8 @@
 
 #if defined(CONFIG_SGI_IP27) || defined(CONFIG_SGI_IP35)
 #include <asm/sn/agent.h>
-#include <asm/arc/types.h>
-#include <asm/arc/hinv.h>
+#include <asm/fw/arc/types.h>
+#include <asm/fw/arc/hinv.h>
 #if defined(CONFIG_SGI_IP35)
 // The hack file has to be before vector and after sn0_fru....
 #include <asm/hack.h>
---


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
