Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Dec 2010 16:12:20 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:47179 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491136Ab0LYPMR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Dec 2010 16:12:17 +0100
Received: by pzk30 with SMTP id 30so1926006pzk.36
        for <multiple recipients>; Sat, 25 Dec 2010 07:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=mlzF2yGiJe7Ex74hpMfzqWU7t8RFy8FOL+eraui2WCs=;
        b=AuUqXlrrIcrO1DenJhp1iX+IP0izrwWdsnxBcebn460aMy4VPHYp2jLfgq4e20OxPW
         0kBy4cvFhvJrJbxs412RJrzw31QWi8Cv46i4JV27Pb5kBlK9gLm0WDOl2kAOpoOoOhm8
         YP6s3G5vj1LmV9xpPwO5+NNhOn1Y/vPEjMUU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=HkGMB33rWjA0OZziyygQtvM0lQqQEt6HcmR3qm47QIDLoGyVnO02tXiAaYatG8+LP5
         Xnf/hoEw9IlFLZuxCfRIW+2DZBjmAYyA0DOZ7cX16vrmY8DzBr9rQvrYhX9f1bHZhT+s
         lpu6zd12MwD1qtMWAW3l+//nuROo9YhEcpqw4=
Received: by 10.142.128.18 with SMTP id a18mr8339323wfd.267.1293289929947;
        Sat, 25 Dec 2010 07:12:09 -0800 (PST)
Received: from localhost.localdomain ([61.48.57.245])
        by mx.google.com with ESMTPS id x35sm14223266wfd.1.2010.12.25.07.12.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Dec 2010 07:12:08 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Reduce kernel image size for !CONFIG_DEBUG_ZBOOT
Date:   Sat, 25 Dec 2010 23:11:49 +0800
Message-Id: <1293289909-7635-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

!CONFIG_DEBUG_ZBOOT doesn't need puts() and puthex(), remove them and
the according strings for !CONFIG_DEBUG_ZBOOT, as a result, it saves
about 1280 bytes.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/Makefile     |    3 ++-
 arch/mips/boot/compressed/decompress.c |    5 +++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 5042d51..aab6d7f 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -28,9 +28,10 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 targets := head.o decompress.o dbg.o uart-16550.o uart-alchemy.o
 
 # decompressor objects (linked with vmlinuz)
-vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
+vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o
 
 ifdef CONFIG_DEBUG_ZBOOT
+vmlinuzobjs-y += $(obj)/dbg.o
 vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
 vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
 endif
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 5cad0fa..c9cbff5 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -27,8 +27,13 @@ unsigned long free_mem_end_ptr;
 extern unsigned char __image_begin, __image_end;
 
 /* debug interfaces  */
+#ifdef CONFIG_DEBUG_ZBOOT
 extern void puts(const char *s);
 extern void puthex(unsigned long long val);
+#else
+#define puts(s) do {} while (0)
+#define puthex(val) do {} while (0)
+#endif
 
 void error(char *x)
 {
-- 
1.7.1
