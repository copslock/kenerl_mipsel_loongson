Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2006 20:38:48 +0100 (BST)
Received: from gateway.codesourcery.com ([65.74.133.9]:40639 "EHLO
	gateway.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S20027647AbWIQTiq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 17 Sep 2006 20:38:46 +0100
Received: (qmail 26699 invoked by uid 1010); 17 Sep 2006 19:38:39 -0000
From:	Richard Sandiford <richard@codesourcery.com>
To:	linux-mips@linux-mips.org
Mail-Followup-To: linux-mips@linux-mips.org, richard@codesourcery.com
Subject: [PATCH] fstatat syscall names
Date:	Sun, 17 Sep 2006 20:38:39 +0100
Message-ID: <877j02xozk.fsf@talisman.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <richard@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@codesourcery.com
Precedence: bulk
X-list: linux-mips

MIPS is the only port to call its fstatat()-related syscalls
"__NR_fstatat".  Now I can see why that might be seen as every
other port being wrong, but I think for o32, it is at best confusing.
__NR_fstat provides a plain (32-bit) stat while __NR_fstatat provides a
64-bit stat.  Changing the name to __NR_fstatat64 would make things more
explicit, match x86, and make the glibc port slightly easier.

The current name is more appropriate for n32 and n64, but it would be
appropriate for other 64-bit targets too, and those targets have chosen
to call it __NR_newfstatat instead.  Using the same name for MIPS would
again be more consistent and make the glibc port slightly easier.

I'm not wedded to this idea if the current names are preferred,
but FWIW...

Richard

Signed-off-by: Richard Sandiford <richard@codesourcery.com>

diff --git a/include/asm-mips/unistd.h b/include/asm-mips/unistd.h
index 558e3cb..c391429 100644
--- a/include/asm-mips/unistd.h
+++ b/include/asm-mips/unistd.h
@@ -313,7 +313,7 @@
 #define __NR_mknodat			(__NR_Linux + 290)
 #define __NR_fchownat			(__NR_Linux + 291)
 #define __NR_futimesat			(__NR_Linux + 292)
-#define __NR_fstatat			(__NR_Linux + 293)
+#define __NR_fstatat64			(__NR_Linux + 293)
 #define __NR_unlinkat			(__NR_Linux + 294)
 #define __NR_renameat			(__NR_Linux + 295)
 #define __NR_linkat			(__NR_Linux + 296)
@@ -600,7 +600,7 @@
 #define __NR_mknodat			(__NR_Linux + 249)
 #define __NR_fchownat			(__NR_Linux + 250)
 #define __NR_futimesat			(__NR_Linux + 251)
-#define __NR_fstatat			(__NR_Linux + 252)
+#define __NR_newfstatat			(__NR_Linux + 252)
 #define __NR_unlinkat			(__NR_Linux + 253)
 #define __NR_renameat			(__NR_Linux + 254)
 #define __NR_linkat			(__NR_Linux + 255)
@@ -891,7 +891,7 @@
 #define __NR_mknodat			(__NR_Linux + 253)
 #define __NR_fchownat			(__NR_Linux + 254)
 #define __NR_futimesat			(__NR_Linux + 255)
-#define __NR_fstatat			(__NR_Linux + 256)
+#define __NR_newfstatat			(__NR_Linux + 256)
 #define __NR_unlinkat			(__NR_Linux + 257)
 #define __NR_renameat			(__NR_Linux + 258)
 #define __NR_linkat			(__NR_Linux + 259)
