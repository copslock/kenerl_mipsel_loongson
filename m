Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jan 2010 18:46:39 +0100 (CET)
Received: from mail-fx0-f211.google.com ([209.85.220.211]:34590 "EHLO
        mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493215Ab0AMRqe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jan 2010 18:46:34 +0100
Received: by fxm3 with SMTP id 3so13781407fxm.24
        for <linux-mips@linux-mips.org>; Wed, 13 Jan 2010 09:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=hcYUKKmEKOOMXkn9/a0sNk/1UcyVKjLiidR6Ie9gF/M=;
        b=QAvLEUF3Fof/GyW06EuaxSiZkdpBDJzpM7X3cjPMMSLRszfBBP99iSsqSOt7bbYDs+
         In44y7/TtUM7/2LR0qBSYrH5S0qo/1JdKG91aMEWaPlSp+5WnbrABM+lmKgl4KUtrWgZ
         ICCmstuEFSKy3OmWbY3Fkh4GNGz7IUkXD4Zqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=tNH6jIbQlPzMLk33gfIAHTMOoIG3bC+ufG2oVldroms0i8CLTn1Gs47izfx9caXLoh
         prJ6c+9ybaBzKj/F3hdodXJ200K5hD7S1IKh23bcY3ZilpHcGLKXbDlM/BeAMN1u4Q/E
         K4/TrQODC+K4zTCMV/bvcJl031WmjnPQkqssI=
Received: by 10.223.29.193 with SMTP id r1mr10606394fac.29.1263404789246;
        Wed, 13 Jan 2010 09:46:29 -0800 (PST)
Received: from localhost.localdomain (p5496EE2B.dip.t-dialin.net [84.150.238.43])
        by mx.google.com with ESMTPS id 14sm10943855fxm.11.2010.01.13.09.46.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Jan 2010 09:46:28 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [RFC PATCH] MIPS: Alchemy: debug output for compressed kernels
Date:   Wed, 13 Jan 2010 18:46:58 +0100
Message-Id: <1263404818-23038-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.6
X-archive-position: 25585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8746

Hook up the compressed debug output for all Alchemy systems supported
by current kernel codebase.

Cc: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
The code is built for all alchemy systems since I doubt anyone would
solder on an extra UART chip instead of using the built-in ones.

Should work on all in-kernel boards; my db1200 likes it:
 zimage at:     82E21350 82FA149D
 Uncompressing Linux at load address 80100000
 Now, booting the kernel...


 arch/mips/boot/compressed/Makefile       |    1 +
 arch/mips/boot/compressed/uart-alchemy.c |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/boot/compressed/uart-alchemy.c

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 671d344..5f09c18 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -33,6 +33,7 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 obj-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
 
 obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
+obj-$(CONFIG_MACH_ALCHEMY)		   += $(obj)/uart-alchemy.o
 
 OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary -R .comment -S
 $(obj)/vmlinux.bin: $(KBUILD_IMAGE)
diff --git a/arch/mips/boot/compressed/uart-alchemy.c b/arch/mips/boot/compressed/uart-alchemy.c
new file mode 100644
index 0000000..1bff22f
--- /dev/null
+++ b/arch/mips/boot/compressed/uart-alchemy.c
@@ -0,0 +1,7 @@
+#include <asm/mach-au1x00/au1000.h>
+
+void putc(char c)
+{
+	/* all current (Jan. 2010) in-kernel boards */
+	alchemy_uart_putchar(UART0_PHYS_ADDR, c);
+}
-- 
1.6.5.6
