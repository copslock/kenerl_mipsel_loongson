Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0BLChe31948
	for linux-mips-outgoing; Fri, 11 Jan 2002 13:12:43 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0BLCVg31943
	for <linux-mips@oss.sgi.com>; Fri, 11 Jan 2002 13:12:31 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA29999;
	Fri, 11 Jan 2002 21:12:32 +0100 (MET)
Date: Fri, 11 Jan 2002 21:12:32 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Adrian.Hulse@taec.toshiba.com
cc: linux-mips@oss.sgi.com
Subject: Re: libtool warning on redhat 7.1 native mipsel compile
In-Reply-To: <OFC2A7FD37.680D7B25-ON88256B3E.00695F38@taec.com>
Message-ID: <Pine.GSO.3.96.1020111205908.15977E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 11 Jan 2002 Adrian.Hulse@taec.toshiba.com wrote:

> To cut a long story short I traced the problem to a number of script files
> which define a string to be :
> 
>      ELF [0-9][0-9]*-bit [LM]SB (shared object | dynamic lib)
> 
> When this is used as a match against libc-2.2.4.so's output the "mips-1"
> part causes a mismatch and libtool complains the library is not a shared
> library file. Note, as far as I have checked most of the library files in
> the redhat 7.1 distribution include this "mips-1".

 Libtool is broken.  It doesn't use `file' for most ELF Linux platforms
but it does for MIPS. 

 Here is a patch for libtool.  After building and installing updated
libtool you need to run `libtoolize -f' to update an obsolete script for
every libtool-dependent program to be built.  Depending on a program's
configuration and the version of libtool used by it, there might be
additional steps needed, such as running `aclocal' or `autoconf'.
Sometimes a manual update of "aclocal.m4" is needed.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

libtool-1.4.1-mips-deplibs.patch
diff -up --recursive --new-file libtool-1.4.1.macro/acinclude.m4 libtool-1.4.1/acinclude.m4
--- libtool-1.4.1.macro/acinclude.m4	Sun Sep  2 23:32:02 2001
+++ libtool-1.4.1/acinclude.m4	Sat Sep  8 23:30:44 2001
@@ -3323,7 +3323,7 @@ irix5* | irix6*)
 # This must be Linux ELF.
 linux-gnu*)
   case $host_cpu in
-  alpha* | hppa* | i*86 | powerpc* | sparc* | ia64* )
+  alpha* | hppa* | i*86 | mips | mipsel | powerpc* | sparc* | ia64* )
     lt_cv_deplibs_check_method=pass_all ;;
   *)
     # glibc up to 2.1.1 does not perform some relocations on ARM
diff -up --recursive --new-file libtool-1.4.1.macro/cdemo/acinclude.m4 libtool-1.4.1/cdemo/acinclude.m4
--- libtool-1.4.1.macro/cdemo/acinclude.m4	Mon Sep  3 01:45:03 2001
+++ libtool-1.4.1/cdemo/acinclude.m4	Sat Sep  8 23:30:44 2001
@@ -3323,7 +3323,7 @@ irix5* | irix6*)
 # This must be Linux ELF.
 linux-gnu*)
   case $host_cpu in
-  alpha* | hppa* | i*86 | powerpc* | sparc* | ia64* )
+  alpha* | hppa* | i*86 | mips | mipsel | powerpc* | sparc* | ia64* )
     lt_cv_deplibs_check_method=pass_all ;;
   *)
     # glibc up to 2.1.1 does not perform some relocations on ARM
diff -up --recursive --new-file libtool-1.4.1.macro/demo/acinclude.m4 libtool-1.4.1/demo/acinclude.m4
--- libtool-1.4.1.macro/demo/acinclude.m4	Mon Sep  3 01:44:59 2001
+++ libtool-1.4.1/demo/acinclude.m4	Sat Sep  8 23:30:44 2001
@@ -3323,7 +3323,7 @@ irix5* | irix6*)
 # This must be Linux ELF.
 linux-gnu*)
   case $host_cpu in
-  alpha* | hppa* | i*86 | powerpc* | sparc* | ia64* )
+  alpha* | hppa* | i*86 | mips | mipsel | powerpc* | sparc* | ia64* )
     lt_cv_deplibs_check_method=pass_all ;;
   *)
     # glibc up to 2.1.1 does not perform some relocations on ARM
diff -up --recursive --new-file libtool-1.4.1.macro/depdemo/acinclude.m4 libtool-1.4.1/depdemo/acinclude.m4
--- libtool-1.4.1.macro/depdemo/acinclude.m4	Mon Sep  3 01:45:00 2001
+++ libtool-1.4.1/depdemo/acinclude.m4	Sat Sep  8 23:30:44 2001
@@ -3323,7 +3323,7 @@ irix5* | irix6*)
 # This must be Linux ELF.
 linux-gnu*)
   case $host_cpu in
-  alpha* | hppa* | i*86 | powerpc* | sparc* | ia64* )
+  alpha* | hppa* | i*86 | mips | mipsel | powerpc* | sparc* | ia64* )
     lt_cv_deplibs_check_method=pass_all ;;
   *)
     # glibc up to 2.1.1 does not perform some relocations on ARM
diff -up --recursive --new-file libtool-1.4.1.macro/libtool.m4 libtool-1.4.1/libtool.m4
--- libtool-1.4.1.macro/libtool.m4	Sun Sep  2 23:32:02 2001
+++ libtool-1.4.1/libtool.m4	Sat Sep  8 23:30:44 2001
@@ -3323,7 +3323,7 @@ irix5* | irix6*)
 # This must be Linux ELF.
 linux-gnu*)
   case $host_cpu in
-  alpha* | hppa* | i*86 | powerpc* | sparc* | ia64* )
+  alpha* | hppa* | i*86 | mips | mipsel | powerpc* | sparc* | ia64* )
     lt_cv_deplibs_check_method=pass_all ;;
   *)
     # glibc up to 2.1.1 does not perform some relocations on ARM
diff -up --recursive --new-file libtool-1.4.1.macro/mdemo/acinclude.m4 libtool-1.4.1/mdemo/acinclude.m4
--- libtool-1.4.1.macro/mdemo/acinclude.m4	Mon Sep  3 01:45:02 2001
+++ libtool-1.4.1/mdemo/acinclude.m4	Sat Sep  8 23:30:44 2001
@@ -3323,7 +3323,7 @@ irix5* | irix6*)
 # This must be Linux ELF.
 linux-gnu*)
   case $host_cpu in
-  alpha* | hppa* | i*86 | powerpc* | sparc* | ia64* )
+  alpha* | hppa* | i*86 | mips | mipsel | powerpc* | sparc* | ia64* )
     lt_cv_deplibs_check_method=pass_all ;;
   *)
     # glibc up to 2.1.1 does not perform some relocations on ARM
