Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 20:40:16 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:42989 "EHLO
        mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493426Ab0AZTkN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 20:40:13 +0100
Received: by bwz21 with SMTP id 21so3921890bwz.24
        for <linux-mips@linux-mips.org>; Tue, 26 Jan 2010 11:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=SV2OGCObQ6Sf9WJbXgVQJLcZhyTIIYRcrvHqWjpJM6s=;
        b=sbqjlgQXelbLBTkB9Q6YwB9sPebKdEAqU9L76e1ZUrdEACPlqWyGNUbgaRAT1UnlNo
         pbB+DHse+kescfPsCMImofQ94sL0HICPoYCbdB8yR5VNd/xCOZjO2SyOQLArgAA1XZMj
         6wKTvmlYEoQMRYyOmeCW3pdBMtreHBim5A0vU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DjC96mfkY4crha0Y3otqGfBUjRT0t0MtQXkkvC/M+bIiloYCY3RjfocV1L8raNpmXz
         WCYlf/P01mGIPKNmINspd8kfKUc90Z4+Z4HUHoVsmtjpkwFMvg6i4znRr1w84T686Oc3
         ilv9NPcHKOHxjsk8GGu6gGj+2OrJd5Rwc7yvs=
Received: by 10.204.5.216 with SMTP id 24mr264876bkw.141.1264534807786;
        Tue, 26 Jan 2010 11:40:07 -0800 (PST)
Received: from localhost.localdomain (p5496CA8F.dip.t-dialin.net [84.150.202.143])
        by mx.google.com with ESMTPS id 13sm2828863bwz.6.2010.01.26.11.40.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 11:40:07 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v2] MIPS: Alchemy: debug output for compressed kernels
Date:   Tue, 26 Jan 2010 20:40:09 +0100
Message-Id: <1264534809-24938-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.6
X-archive-position: 25690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16903

Hook up the compressed debug output for all Alchemy systems supported
by current kernel codebase.

Cc: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v2: Applies on top of Wu Zhangjin's "MIPS: Cleanup the debugging of compressed
kernel support" fixed v3 patch, and -queue.

 arch/mips/boot/compressed/Makefile       |    1 +
 arch/mips/boot/compressed/uart-alchemy.c |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/boot/compressed/uart-alchemy.c

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 388b58c..fff73d4 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -34,6 +34,7 @@ obj-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
 
 ifdef CONFIG_DEBUG_ZBOOT
 obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
+obj-$(CONFIG_MACH_ALCHEMY)		   += $(obj)/uart-alchemy.o
 endif
 
 OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary -R .comment -S
diff --git a/arch/mips/boot/compressed/uart-alchemy.c b/arch/mips/boot/compressed/uart-alchemy.c
new file mode 100644
index 0000000..4c957df
--- /dev/null
+++ b/arch/mips/boot/compressed/uart-alchemy.c
@@ -0,0 +1,11 @@
+/*
+ * Alchemy on-chip uart based serial debug support for zboot
+ */
+
+#include <asm/mach-au1x00/au1000.h>
+
+void putc(char c)
+{
+	/* all current (Jan. 2010) in-kernel boards */
+	alchemy_uart_putchar(UART0_PHYS_ADDR, c);
+}
-- 
1.6.6
