Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 04:08:01 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:5726
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224936AbUAVEIA>; Thu, 22 Jan 2004 04:08:00 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1AjW8N-0000KE-00; Thu, 22 Jan 2004 05:07:59 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1AjW8N-0006ou-00; Thu, 22 Jan 2004 05:07:59 +0100
Date: Thu, 22 Jan 2004 05:07:59 +0100
To: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH, 2.4] Fix bad check_gcc order for mips64, make offset.h creation more robust
Message-ID: <20040122040759.GB23173@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hallo All,

current 2.4 64bit kernels fail to build for newer toolchains because
the -finline-limit=100000 option is ignored. The symptom is some bogus
offset.h content which stops the build in arch/mips64/mm/tlbex-r4k.S.

This patch fixes it by moving check_gcc in front of its first use,
it also removes some stale files if offset.h needs to be regenerated.


Thiemo


Index: arch/mips/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/Makefile,v
retrieving revision 1.78.2.50
diff -a -d -u -p -r1.78.2.50 Makefile
--- arch/mips/Makefile	11 Jan 2004 00:11:35 -0000	1.78.2.50
+++ arch/mips/Makefile	22 Jan 2004 03:18:57 -0000
@@ -746,5 +746,6 @@ archmrproper:
 archdep:
 	if [ ! -f $(TOPDIR)/include/asm-$(ARCH)/offset.h ]; then \
 		touch $(TOPDIR)/include/asm-$(ARCH)/offset.h; \
+		$(MAKE) -C arch/mips/tools clean; \
 	fi;
 	@$(MAKEBOOT) dep
Index: arch/mips64/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips64/Attic/Makefile,v
retrieving revision 1.22.2.43
diff -a -d -u -p -r1.22.2.43 Makefile
--- arch/mips64/Makefile	3 Jan 2004 02:07:52 -0000	1.22.2.43
+++ arch/mips64/Makefile	22 Jan 2004 03:19:23 -0000
@@ -26,6 +26,9 @@ ifdef CONFIG_CROSSCOMPILE
 CROSS_COMPILE	= $(tool-prefix)
 endif
 
+check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+check_gas = $(shell if $(CC) $(1) -Wa,-Z -c -o /dev/null -xassembler /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+
 #
 # The ELF GCC uses -G 0 -mabicalls -fpic as default.  We don't need PIC
 # code in the kernel since it only slows down the whole thing.  For the
@@ -49,9 +52,6 @@ GCCFLAGS	+= -mno-sched-prolog -fno-omit-
 endif
 endif
 
-check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
-check_gas = $(shell if $(CC) $(1) -Wa,-Z -c -o /dev/null -xassembler /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
-
 #
 # Use: $(call set_gccflags,<cpu0>,<isa0>,<cpu1>,<isa1>)
 #
@@ -402,5 +406,6 @@ archmrproper:
 archdep:
 	if [ ! -f $(TOPDIR)/include/asm-$(ARCH)/offset.h ]; then \
 		touch $(TOPDIR)/include/asm-$(ARCH)/offset.h; \
+		$(MAKE) -C arch/mips/tools clean; \
 	fi;
 	@$(MAKEBOOT) dep
