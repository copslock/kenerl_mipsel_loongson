Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57HZpN29027
	for linux-mips-outgoing; Thu, 7 Jun 2001 10:35:51 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57HZnh29024
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 10:35:49 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id C47F4125BA; Thu,  7 Jun 2001 10:35:47 -0700 (PDT)
Date: Thu, 7 Jun 2001 10:35:46 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: binutils@sourceware.cygnus.com
Cc: GDB <gdb@sourceware.cygnus.com>, linux-mips@oss.sgi.com
Subject: Patch: Switch Linux/mips to stabs
Message-ID: <20010607103546.A14690@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Based on the recommendations from Ian and Daniel, I checked in the
following patches to switch Linux/mips to stabs.

Thanks.

---
2001-06-07  H.J. Lu  <hjl@gnu.org>

	* elf32-mips.c (_bfd_mips_elf_object_p): Set the bad symtab
	for SGI only.

	* config.bfd: Remove ecoff from Linux/mips.

Index: config.bfd
===================================================================
RCS file: /cvs/src/src/bfd/config.bfd,v
retrieving revision 1.58
diff -u -p -r1.58 config.bfd
--- config.bfd	2001/06/02 17:32:09	1.58
+++ config.bfd	2001/06/07 17:28:52
@@ -675,7 +675,7 @@ case "${targ}" in
     ;;
   mips*el*-*-linux-gnu*)
     targ_defvec=bfd_elf32_tradlittlemips_vec
-    targ_selvecs="bfd_elf32_tradbigmips_vec bfd_elf64_tradlittlemips_vec bfd_elf64_tradbigmips_vec ecoff_little_vec ecoff_big_vec"
+    targ_selvecs="bfd_elf32_tradbigmips_vec bfd_elf64_tradlittlemips_vec bfd_elf64_tradbigmips_vec"
     ;;
   mips*-*-openbsd*)
     targ_defvec=bfd_elf32_bigmips_vec
@@ -683,7 +683,7 @@ case "${targ}" in
     ;;
   mips*-*-linux-gnu*)
     targ_defvec=bfd_elf32_tradbigmips_vec
-    targ_selvecs="bfd_elf32_tradlittlemips_vec bfd_elf64_tradbigmips_vec bfd_elf64_tradlittlemips_vec ecoff_big_vec ecoff_little_vec"
+    targ_selvecs="bfd_elf32_tradlittlemips_vec bfd_elf64_tradbigmips_vec bfd_elf64_tradlittlemips_vec"
     ;;
   mn10200-*-*)
     targ_defvec=bfd_elf32_mn10200_vec
Index: elf32-mips.c
===================================================================
RCS file: /cvs/src/src/bfd/elf32-mips.c,v
retrieving revision 1.97
diff -u -p -r1.97 elf32-mips.c
--- elf32-mips.c	2001/05/23 17:26:35	1.97
+++ elf32-mips.c	2001/06/07 17:29:12
@@ -2331,7 +2331,8 @@ _bfd_mips_elf_object_p (abfd)
   /* Irix 5 and 6 is broken.  Object file symbol tables are not always
      sorted correctly such that local symbols precede global symbols,
      and the sh_info field in the symbol table is not always right.  */
-  elf_bad_symtab (abfd) = true;
+  if (SGI_COMPAT(abfd))
+    elf_bad_symtab (abfd) = true;
 
   bfd_default_set_arch_mach (abfd, bfd_arch_mips,
 			     elf_mips_mach (elf_elfheader (abfd)->e_flags));

2001-06-07  H.J. Lu  <hjl@gnu.org>

	* configure.in: Use MIPS_STABS_ELF for Linux/mips and remove
	ecoff emulation.
	* configure: Regenerate.

Index: configure.in
===================================================================
RCS file: /cvs/src/src/gas/configure.in,v
retrieving revision 1.69
diff -u -p -r1.69 configure.in
--- configure.in	2001/05/25 07:21:00	1.69
+++ configure.in	2001/06/07 17:20:54
@@ -346,8 +346,13 @@ changequote([,])dnl
       mips-*-irix*)         fmt=ecoff ;;
       mips-*-lnews*)        fmt=ecoff em=lnews ;;
       mips-*-riscos*)       fmt=ecoff ;;
-      mips-*-sysv4*MP* | mips-*-linux-gnu* | mips-*-gnu*)
+      mips-*-sysv4*MP* | mips-*-gnu*)
 			    fmt=elf em=tmips ;;
+      mips-*-linux-gnu*)
+			    fmt=elf em=tmips
+			    AC_DEFINE(MIPS_STABS_ELF, 1,
+				[Use ELF stabs for MIPS, not ECOFF stabs])
+			    ;;
       mips-*-sysv*)         fmt=ecoff ;;
       mips-*-elf* | mips-*-rtems* | mips-*-openbsd*)
 			    fmt=elf ;;
@@ -602,8 +607,8 @@ changequote([,])dnl
     case ${generic_target}-${fmt} in
       mips-*-irix5*-*)	emulation="mipsbelf mipslelf mipself mipsbecoff mipslecoff mipsecoff" ;;
       mips-*-linux-gnu*-*) case "$endian" in
-			big)	emulation="mipsbelf mipslelf mipself mipsbecoff mipslecoff mipsecoff" ;;
-			*)	emulation="mipslelf mipsbelf mipself mipslecoff mipsbecoff mipsecoff" ;;
+			big)	emulation="mipsbelf mipslelf mipself" ;;
+			*)	emulation="mipslelf mipsbelf mipself" ;;
 			esac ;;
       mips-*-lnews*-ecoff) ;;
       mips-*-*-ecoff)	case "$endian" in
