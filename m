Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7NASr621647
	for linux-mips-outgoing; Thu, 23 Aug 2001 03:28:53 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7NASnd21644
	for <linux-mips@oss.sgi.com>; Thu, 23 Aug 2001 03:28:49 -0700
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 15ZrjE-0003kA-00; Thu, 23 Aug 2001 12:28:48 +0200
Date: Thu, 23 Aug 2001 12:28:48 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: linux-mips@oss.sgi.com
Cc: Ralf Baechle <ralf@uni-koblenz.de>
Subject: Patch: linux_logo.h build_fix for 2.4.6
Message-ID: <20010823122848.A14308@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com,
	Ralf Baechle <ralf@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached patch adds the definition of __HAVE_ARCH_LINUX_LOGO to let
current cvs build again.
 -- Guido

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="arch_linux_logo-2001-08-23.diff"

Index: include/asm-mips/linux_logo_dec.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/linux_logo_dec.h,v
retrieving revision 1.1
diff -u -u -r1.1 linux_logo_dec.h
--- include/asm-mips/linux_logo_dec.h	2001/07/14 12:43:30	1.1
+++ include/asm-mips/linux_logo_dec.h	2001/08/23 10:26:54
@@ -16,6 +16,8 @@
 #define linux_logo_banner "Linux/MIPSel version " UTS_RELEASE
 #define LINUX_LOGO_COLORS 183
 
+#define __HAVE_ARCH_LINUX_LOGO
+
 #ifdef INCLUDE_LINUX_LOGO_DATA
 unsigned char linux_logo_red[] __initdata = {
     0x00, 0x06, 0x0a, 0x0e, 0x16, 0x1a, 0x1e, 0x22,
Index: include/asm-mips/linux_logo_sgi.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/linux_logo_sgi.h,v
retrieving revision 1.1
diff -u -u -r1.1 linux_logo_sgi.h
--- include/asm-mips/linux_logo_sgi.h	2001/07/14 12:43:30	1.1
+++ include/asm-mips/linux_logo_sgi.h	2001/08/23 10:26:54
@@ -16,6 +16,8 @@
 #define linux_logo_banner "Linux/MIPS version " UTS_RELEASE
 #define LINUX_LOGO_COLORS 212
 
+#define __HAVE_ARCH_LINUX_LOGO
+
 #ifdef INCLUDE_LINUX_LOGO_DATA
 unsigned char linux_logo_red[] __initdata = {
   0x03, 0x82, 0xE9, 0xBF, 0x42, 0xC9, 0x7E, 0xC0,

--7AUc2qLy4jB3hD7Z--
