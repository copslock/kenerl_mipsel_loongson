Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4BBriI02822
	for linux-mips-outgoing; Fri, 11 May 2001 04:53:44 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4BBrhF02819
	for <linux-mips@oss.sgi.com>; Fri, 11 May 2001 04:53:43 -0700
Received: from cotw.com (dhcp-050.inter.net [192.168.10.50])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id GAA03395;
	Fri, 11 May 2001 06:53:41 -0500
Message-ID: <3AFBD5DE.A0457C6F@cotw.com>
Date: Fri, 11 May 2001 07:06:54 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre17-idepci i686)
X-Accept-Language: en
MIME-Version: 1.0
To: libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: glibc MIPS patch to check for binutils version...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Greetings.

Please find attached a patch to GLIBC that is compatible with
the new version of binutils (HJLu's and CVS at least). I have
also added some cruft in 'configure.in' that will produce
warning messages if a user attempt to use old binutils. Comments
are welcome. I have gone out on a limb and also included a
Changelog entry in case this patch actually gets accepted :).
This patch will apply against the CVS version of GLIBC. Please
regenerate 'configure'. Thanks.

-Steve


***** Changelog entry *****
        * sysdeps/mips/rtld-ldscript.in: removed unneeded binary
        output format directive
        * configure.in: added in checking for obsolete binutils
        for MIPS targets which produces a warning message if
        user attempts to use older tools.
***************************


******* START PATCH *******
diff -urN glibc-2.2.3/configure.in glibc-2.2.3-patched/configure.in
--- glibc-2.2.3/configure.in    Wed Apr 25 16:50:58 2001
+++ glibc-2.2.3-patched/configure.in    Thu May 10 23:09:24 2001
@@ -590,6 +590,29 @@
 AC_SUBST(cross_compiling)
 AC_PROG_CPP
 LIBC_PROG_BINUTILS
+
+# For MIPS targets, we need to check that the proper version of
+# binutils is being used and warn that old binary compatability
+# may be broken.  --sjhill
+case "$host_alias" in
+mips*-linux)
+  echo $ac_n "checking versions of GNU assembler and linker... $ac_c" 1>&6
+  ac_prog_version=`$AS -o conftest -v </dev/null 2>&1 | sed -n 's/^.*version \(
[0-9.]*\).*$/\1/p'`
+  case $ac_prog_version in
+    '') ac_prog_version="v. ?.??, bad"; ac_verc_fail=yes;;
+    2.11.90.0.[5-9]*|2.11.[2-9]|2.1[2-9]*)
+       ac_prog_version="$ac_prog_version, ok"; ac_verc_fail=no;;
+    *) ac_prog_version="$ac_prog_version, bad"; ac_verc_fail=yes;;
+  esac
+  echo "$ac_t""$ac_prog_version" 1>&6
+  if test $ac_verc_fail = yes; then
+    echo "configure: warning:
+*** These are older versions of the GNU linker and assembler
+*** for MIPS targets. You should seriously consider upgrading
+*** your tools or risk producing incompatible binaries." 1>&2
+  fi
+esac
+
 AC_CHECK_TOOL(MIG, mig)

 # Accept binutils 2.10.1 or newer (and also any ia64 2.9 version)
diff -urN glibc-2.2.3/sysdeps/mips/rtld-ldscript.in glibc-2.2.3-patched/sysdeps/
mips/rtld-ldscript.in
--- glibc-2.2.3/sysdeps/mips/rtld-ldscript.in   Sat Jul 12 18:23:14 1997
+++ glibc-2.2.3-patched/sysdeps/mips/rtld-ldscript.in   Fri May 11 06:34:52 2001
@@ -1,4 +1,3 @@
-OUTPUT_FORMAT("@@rtld-oformat@@")
 OUTPUT_ARCH(@@rtld-arch@@)
 ENTRY(@@rtld-entry@@)
 SECTIONS
******* END PATCH *******

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
