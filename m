Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:58:59 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:18051 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225235AbTC0C4Z>;
	Thu, 27 Mar 2003 02:56:25 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id E66B746A59; Thu, 27 Mar 2003 03:54:58 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: everybody includes bcache.h
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:54:58 +0100
Message-ID: <m2wuilcyd9.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        on all that files, none of the things declared on bcache.h are
        used.

Later, Juan.


 build/arch/mips/ddb5xxx/ddb5074/setup.c   |    1 -
 build/arch/mips/ddb5xxx/ddb5476/setup.c   |    1 -
 build/arch/mips/ddb5xxx/ddb5477/setup.c   |    1 -
 build/arch/mips/jmr3927/rbhma3100/setup.c |    1 -
 build/arch/mips/sni/pcimt_scache.c        |    2 +-
 build/arch/mips/sni/setup.c               |    1 -
 6 files changed, 1 insertion(+), 6 deletions(-)

diff -puN build/arch/mips/ddb5xxx/ddb5074/setup.c~remove_unused_bcache.h_includes build/arch/mips/ddb5xxx/ddb5074/setup.c
--- 24/build/arch/mips/ddb5xxx/ddb5074/setup.c~remove_unused_bcache.h_includes	2003-03-27 01:32:57.000000000 +0100
+++ 24-quintela/build/arch/mips/ddb5xxx/ddb5074/setup.c	2003-03-27 01:33:30.000000000 +0100
@@ -20,7 +20,6 @@
 #include <linux/irq.h>
 
 #include <asm/addrspace.h>
-#include <asm/bcache.h>
 #include <asm/keyboard.h>
 #include <asm/irq.h>
 #include <asm/reboot.h>
diff -puN build/arch/mips/ddb5xxx/ddb5476/setup.c~remove_unused_bcache.h_includes build/arch/mips/ddb5xxx/ddb5476/setup.c
--- 24/build/arch/mips/ddb5xxx/ddb5476/setup.c~remove_unused_bcache.h_includes	2003-03-27 01:33:16.000000000 +0100
+++ 24-quintela/build/arch/mips/ddb5xxx/ddb5476/setup.c	2003-03-27 01:33:43.000000000 +0100
@@ -18,7 +18,6 @@
 #include <linux/ide.h>
 
 #include <asm/addrspace.h>
-#include <asm/bcache.h>
 #include <asm/keyboard.h>
 #include <asm/irq.h>
 #include <asm/reboot.h>
diff -puN build/arch/mips/ddb5xxx/ddb5477/setup.c~remove_unused_bcache.h_includes build/arch/mips/ddb5xxx/ddb5477/setup.c
--- 24/build/arch/mips/ddb5xxx/ddb5477/setup.c~remove_unused_bcache.h_includes	2003-03-27 01:33:24.000000000 +0100
+++ 24-quintela/build/arch/mips/ddb5xxx/ddb5477/setup.c	2003-03-27 01:33:51.000000000 +0100
@@ -28,7 +28,6 @@
 #include <asm/bootinfo.h>
 #include <asm/addrspace.h>
 #include <asm/time.h>
-#include <asm/bcache.h>
 #include <asm/irq.h>
 #include <asm/reboot.h>
 #include <asm/gdb-stub.h>
diff -puN build/arch/mips/jmr3927/rbhma3100/setup.c~remove_unused_bcache.h_includes build/arch/mips/jmr3927/rbhma3100/setup.c
--- 24/build/arch/mips/jmr3927/rbhma3100/setup.c~remove_unused_bcache.h_includes	2003-03-27 01:34:39.000000000 +0100
+++ 24-quintela/build/arch/mips/jmr3927/rbhma3100/setup.c	2003-03-27 01:34:43.000000000 +0100
@@ -49,7 +49,6 @@
 
 #include <asm/addrspace.h>
 #include <asm/time.h>
-#include <asm/bcache.h>
 #include <asm/irq.h>
 #include <asm/reboot.h>
 #include <asm/gdb-stub.h>
diff -puN build/arch/mips/sgi-ip22/ip22-setup.c~remove_unused_bcache.h_includes build/arch/mips/sgi-ip22/ip22-setup.c
diff -puN build/arch/mips/sni/setup.c~remove_unused_bcache.h_includes build/arch/mips/sni/setup.c
--- 24/build/arch/mips/sni/setup.c~remove_unused_bcache.h_includes	2003-03-27 01:36:36.000000000 +0100
+++ 24-quintela/build/arch/mips/sni/setup.c	2003-03-27 01:37:39.000000000 +0100
@@ -22,7 +22,6 @@
 #include <linux/pc_keyb.h>
 #include <linux/ide.h>
 
-#include <asm/bcache.h>
 #include <asm/bootinfo.h>
 #include <asm/keyboard.h>
 #include <asm/io.h>
diff -puN build/arch/mips/sni/pcimt_scache.c~remove_unused_bcache.h_includes build/arch/mips/sni/pcimt_scache.c
--- 24/build/arch/mips/sni/pcimt_scache.c~remove_unused_bcache.h_includes	2003-03-27 01:37:26.000000000 +0100
+++ 24-quintela/build/arch/mips/sni/pcimt_scache.c	2003-03-27 01:37:32.000000000 +0100
@@ -9,7 +9,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <asm/bcache.h>
+
 #include <asm/sni.h>
 
 #define cacheconf (*(volatile unsigned int *)PCIMT_CACHECONF)

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
