Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2005 22:44:31 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:32533
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133596AbVJQVoL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Oct 2005 22:44:11 +0100
Received: from dl2.hq2.avtrex.com (dl2.hq2.avtrex.com [127.0.0.1])
	by avtrex.com (8.13.1/8.13.1) with ESMTP id j9HLi8TW018746;
	Mon, 17 Oct 2005 14:44:08 -0700
Received: (from daney@localhost)
	by dl2.hq2.avtrex.com (8.13.1/8.13.1/Submit) id j9HLi8Ga018743;
	Mon, 17 Oct 2005 14:44:08 -0700
From:	David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17236.6951.865559.479107@dl2.hq2.avtrex.com>
Date:	Mon, 17 Oct 2005 14:44:07 -0700
To:	oprofile-list@lists.sourceforge.net
CC:	linux-mips@linux-mips.org
Subject: [Patch] Fix lookup_dcookie for MIPS o32
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: ddaney@avtrex.com
Return-Path: <daney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips


This patch fixes the lookup_dcookie for the MIPS o32 ABI.  Although I
only tested with little-endian, the big-endian case needed fixing as
well but is untested (but what are the chances that this is not the
correct fix?).

This is the only patch I needed to get the user space oprofile
programs to work for mipsel-linux.

I am CCing the linux-mips list as this may be of interest there as well.

David Daney.


2005-10-17  David Daney  <ddaney@avtrex.com>

	* daemon/opd_cookie.c (lookup_dcookie): Handle MIPS o32 for both big
	and little endian.

Index: oprofile/daemon/opd_cookie.c
===================================================================
RCS file: /cvsroot/oprofile/oprofile/daemon/opd_cookie.c,v
retrieving revision 1.19
diff -p -a -u -r1.19 opd_cookie.c
--- oprofile/daemon/opd_cookie.c	26 May 2005 00:00:02 -0000	1.19
+++ oprofile/daemon/opd_cookie.c	17 Oct 2005 21:29:13 -0000
@@ -60,12 +60,21 @@
 #endif /* __NR_lookup_dcookie */
 
 #if (defined(__powerpc__) && !defined(__powerpc64__)) || defined(__hppa__)\
-	|| (defined(__s390__) && !defined(__s390x__))
+	|| (defined(__s390__) && !defined(__s390x__)) \
+	|| (defined(__mips__) && (_MIPS_SIM == _MIPS_SIM_ABI32) \
+	    && defined(_MIPSEB))
 static inline int lookup_dcookie(cookie_t cookie, char * buf, size_t size)
 {
 	return syscall(__NR_lookup_dcookie, (unsigned long)(cookie >> 32),
 		       (unsigned long)(cookie & 0xffffffff), buf, size);
 }
+#elif (defined(__mips__) && (_MIPS_SIM == _MIPS_SIM_ABI32)) /*_MIPSEL */
+static inline int lookup_dcookie(cookie_t cookie, char * buf, size_t size)
+{
+	return syscall(__NR_lookup_dcookie,
+		       (unsigned long)(cookie & 0xffffffff),
+		       (unsigned long)(cookie >> 32), buf, size);
+}
 #else
 static inline int lookup_dcookie(cookie_t cookie, char * buf, size_t size)
 {
