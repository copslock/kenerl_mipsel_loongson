Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Jan 2006 15:29:40 +0000 (GMT)
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55563 "HELO
	mailout.stusta.mhn.de") by ftp.linux-mips.org with SMTP
	id S8133634AbWAHP3W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Jan 2006 15:29:22 +0000
Received: (qmail 8984 invoked from network); 8 Jan 2006 15:32:09 -0000
Received: from r063144.stusta.swh.mhn.de (10.150.63.144)
  by mailout.stusta.mhn.de with SMTP; 8 Jan 2006 15:32:09 -0000
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id EF7981479CF; Sun,  8 Jan 2006 16:32:09 +0100 (CET)
Date:	Sun, 8 Jan 2006 16:32:09 +0100
From:	Adrian Bunk <bunk@stusta.de>
To:	ralf@linux-mips.org, schwidefsky@de.ibm.com, linux390@de.ibm.com
Cc:	linux-390@vm.marist.edu, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] mips/s390: remove -finline-limit=10000{,0}
Message-ID: <20060108153209.GM3774@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <bunk@stusta.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@stusta.de
Precedence: bulk
X-list: linux-mips

-finline-limit might have been required for older compilers, but 
nowadays it does no longer make sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/mips/Makefile |    1 -
 arch/s390/Makefile |    1 -
 2 files changed, 2 deletions(-)

--- linux-2.6.15-mm2-full/arch/mips/Makefile.old	2006-01-08 16:25:35.000000000 +0100
+++ linux-2.6.15-mm2-full/arch/mips/Makefile	2006-01-08 16:25:46.000000000 +0100
@@ -93,7 +93,6 @@
 #
 cflags-y			+= -I $(TOPDIR)/include/asm/gcc
 cflags-y			+= -G 0 -mno-abicalls -fno-pic -pipe
-cflags-y			+= $(call cc-option, -finline-limit=100000)
 LDFLAGS_vmlinux			+= -G 0 -static -n -nostdlib
 MODFLAGS			+= -mlong-calls
 
--- linux-2.6.15-mm2-full/arch/s390/Makefile.old	2006-01-08 16:25:53.000000000 +0100
+++ linux-2.6.15-mm2-full/arch/s390/Makefile	2006-01-08 16:25:59.000000000 +0100
@@ -67,7 +67,6 @@
 endif
 
 CFLAGS		+= -mbackchain -msoft-float $(cflags-y)
-CFLAGS		+= $(call cc-option,-finline-limit=10000)
 CFLAGS 		+= -pipe -fno-strength-reduce -Wno-sign-compare 
 AFLAGS		+= $(aflags-y)
 
