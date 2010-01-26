Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 10:10:16 +0100 (CET)
Received: from mail-px0-f181.google.com ([209.85.216.181]:52776 "EHLO
        mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492685Ab0AZJKL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 10:10:11 +0100
Received: by pxi11 with SMTP id 11so3249950pxi.22
        for <multiple recipients>; Tue, 26 Jan 2010 01:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=lb5QwB9y0AEmKwc2k7t9gJSJag7lBgXvBHSlTP4/DeY=;
        b=Xl0Wdmj1AbDP7DW9vJrcMhfylatycjypXnMH68OgSlbb4d+f/Gws8B2uILCgh93EMo
         klMxmy9ayEMyVwiCjPsftYfRMPKE+Ayu8c5l1rpU3pJWAuUnkyzIch8MOoM262WieuGo
         CmvQK3apv9+XX/ZLhNF/x6PFKqwtJZGlNJ5N0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=otEM4Waj2EePntDp2PR6la+X9PKC0GHyhpdoB4yoyKxqI5oIlwOWdOxQogzc7aiGAU
         QStDBEHdEjO803eSxmRV2cwK0IRgXzpxiqAaUqn+WtSeYEHiWqwvHjNHTHqLecJ+72rJ
         kGEhWf2Bmfl9oZE69EUaPtz7KH2rETWg+ZU+o=
Received: by 10.114.187.17 with SMTP id k17mr3122103waf.1.1264497004156;
        Tue, 26 Jan 2010 01:10:04 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm5603365pzk.14.2010.01.26.01.10.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 01:10:03 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 1/2] MIPS: Cleanup the Makefile of compressed kernel support
Date:   Tue, 26 Jan 2010 17:04:02 +0800
Message-Id: <979633248ed16f2724296fd90f4b824f601809e1.1264496568.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
X-archive-position: 25659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16536

This patch removes a useless "\" (line break) and tunes the format of a
long line.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 46a4537..91a57a6 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -24,11 +24,11 @@ BOOT_HEAP_SIZE := 0x400000
 KBUILD_CFLAGS := $(shell echo $(KBUILD_CFLAGS) | sed -e "s/-pg//")
 
 KBUILD_CFLAGS := $(LINUXINCLUDE) $(KBUILD_CFLAGS) -D__KERNEL__ \
-	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) -D"VMLINUX_LOAD_ADDRESS_ULL=$(VMLINUX_LOAD_ADDRESS)ull" \
+	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) -D"VMLINUX_LOAD_ADDRESS_ULL=$(VMLINUX_LOAD_ADDRESS)ull"
 
 KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
-	-DKERNEL_ENTRY=0x$(shell $(NM) $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | grep " kernel_entry" | cut -f1 -d \ ) \
-	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE)
+	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
+	-DKERNEL_ENTRY=0x$(shell $(NM) $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | grep " kernel_entry" | cut -f1 -d \ )
 
 obj-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
 
-- 
1.6.6
