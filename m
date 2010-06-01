Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 15:12:35 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:52357 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492349Ab0FANMb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 15:12:31 +0200
Received: by pxi1 with SMTP id 1so2070074pxi.36
        for <multiple recipients>; Tue, 01 Jun 2010 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=GWvSWRV9Qk29VyHeoYIIOJjN0RhDnyHELyjnw8CGeQk=;
        b=buLO1Z74ulpQ/wdXe1L+ZOtbmywb+Q58rRu4sLabBRHT9tKoROBZCrVFHTMqLZ0I5D
         JIVq0e2k6ex1iYp/kFhUFXEdCClqOYZxmpeeVeTrJjzBXxQN8VGyYVhwlGazfO1RkZTf
         FZN1FoWEqEToS4WivhKoqwtn0UJwHZ9Igr5OU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kb2P4X5g0rCUR8uB04oTruJWM0q5PiZ4eJyXyuvlmORZaAPFf+A/kMR7v17bO1lQ0f
         wYHVWEdvdCEzeb4CdDIuwFmM5v3fDVmtlFNjAlgerTJsxo5MBG+2GCr2oSPwQqYYzXcj
         D3RUIYUT/TFXDplCHVzkOSGHU9BVKZrtQiF8M=
Received: by 10.141.106.21 with SMTP id i21mr4506764rvm.40.1275397940955;
        Tue, 01 Jun 2010 06:12:20 -0700 (PDT)
Received: from yeeloong ([202.201.14.140])
        by mx.google.com with ESMTPS id i19sm5220005rvn.23.2010.06.01.06.12.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 06:12:20 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Cc:     Alexander Clouter <alex@digriz.org.uk>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v2] MIPS: Clean up the calculation of VMLINUZ_LOAD_ADDRESS
Date:   Tue,  1 Jun 2010 21:11:56 +0800
Message-Id: <1275397916-6401-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 26962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 342

Changes:

v1 -> v2:
  o make it more portable (feedback from Alexander Clouter)
    use EXIT_SUCCESS and EXIT_FAILURE as the return value, and use uint64_t
    instead of "unsigned long long".
  o add a missing return value (feedback from Alexander Clouter)
    return EXIT_FAILURE if (n != 1).

We have calculated VMLINUZ_LOAD_ADDRESS in shell, which is awful. This patch
rewrites it in C.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/.gitignore                          |    1 +
 arch/mips/boot/compressed/Makefile                 |   22 ++++----
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |   55 ++++++++++++++++++++
 3 files changed, 66 insertions(+), 12 deletions(-)
 create mode 100644 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c

diff --git a/arch/mips/boot/.gitignore b/arch/mips/boot/.gitignore
index 4667a5f..f210b09 100644
--- a/arch/mips/boot/.gitignore
+++ b/arch/mips/boot/.gitignore
@@ -3,3 +3,4 @@ elf2ecoff
 vmlinux.*
 zImage
 zImage.tmp
+calc_vmlinuz_load_addr
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 7204dfc..cd9ee04 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -12,14 +12,6 @@
 # Author: Wu Zhangjin <wuzhangjin@gmail.com>
 #
 
-# compressed kernel load addr: VMLINUZ_LOAD_ADDRESS > VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE
-VMLINUX_SIZE := $(shell wc -c $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | cut -d' ' -f1)
-VMLINUX_SIZE := $(shell [ -n "$(VMLINUX_SIZE)" ] && echo -n $$(($(VMLINUX_SIZE) + (65536 - $(VMLINUX_SIZE) % 65536))))
-# VMLINUZ_LOAD_ADDRESS = concat "high32 of VMLINUX_LOAD_ADDRESS" and "(low32 of VMLINUX_LOAD_ADDRESS) + VMLINUX_SIZE"
-HIGH32 := $(shell A=$(VMLINUX_LOAD_ADDRESS); [ $${\#A} -gt 10 ] && expr substr "$(VMLINUX_LOAD_ADDRESS)" 3 $$(($${\#A} - 10)))
-LOW32 := $(shell [ -n "$(HIGH32)" ] && A=11 || A=3; expr substr "$(VMLINUX_LOAD_ADDRESS)" $${A} 8)
-VMLINUZ_LOAD_ADDRESS := 0x$(shell [ -n "$(VMLINUX_SIZE)" -a -n "$(LOW32)" ] && printf "$(HIGH32)%08x" $$(($(VMLINUX_SIZE) + 0x$(LOW32))))
-
 # set the default size of the mallocing area for decompressing
 BOOT_HEAP_SIZE := 0x400000
 
@@ -63,9 +55,15 @@ OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.z \
 $(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.z FORCE
 	$(call if_changed,objcopy)
 
-LDFLAGS_vmlinuz := $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T
-vmlinuz: $(src)/ld.script $(vmlinuzobjs-y) $(obj)/piggy.o
-	$(call cmd,ld)
+# Calculate the load address of the compressed kernel
+hostprogs-y := calc_vmlinuz_load_addr
+
+vmlinuzobjs-y += $(obj)/piggy.o
+
+quiet_cmd_zld = LD      $@
+      cmd_zld = $(LD) $(LDFLAGS) -Ttext $(shell $(obj)/calc_vmlinuz_load_addr $(objtree)/$(KBUILD_IMAGE) $(VMLINUX_LOAD_ADDRESS)) -T $< $(vmlinuzobjs-y) -o $@
+vmlinuz: $(src)/ld.script $(vmlinuzobjs-y) $(obj)/calc_vmlinuz_load_addr
+	$(call cmd,zld)
 	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) $@
 
 #
@@ -76,7 +74,7 @@ ifdef CONFIG_MACH_DECSTATION
 endif
 
 # elf2ecoff can only handle 32bit image
-hostprogs-y := ../elf2ecoff
+hostprogs-y += ../elf2ecoff
 
 ifdef CONFIG_32BIT
 	VMLINUZ = vmlinuz
diff --git a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
new file mode 100644
index 0000000..81176b1
--- /dev/null
+++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2010 "Wu Zhangjin" <wuzhangjin@gmail.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+int main(int argc, char *argv[])
+{
+	int n;
+	struct stat sb;
+	uint64_t vmlinux_size, vmlinux_load_addr, vmlinuz_load_addr;
+
+	if (argc != 3) {
+		fprintf(stderr, "Usage: %s <pathname> <vmlinux_load_addr>\n",
+				argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	if (stat(argv[1], &sb) == -1) {
+		perror("stat");
+		return EXIT_FAILURE;
+	}
+
+	/* Convert hex characters to dec number */
+	errno = 0;
+	n = sscanf(argv[2], "%llx", &vmlinux_load_addr);
+	if (n != 1) {
+		if (errno != 0)
+			perror("sscanf");
+		else
+			fprintf(stderr, "No matching characters\n");
+
+		return EXIT_FAILURE;
+	}
+
+	vmlinux_size = (unsigned long long)sb.st_size;
+	vmlinuz_load_addr = vmlinux_load_addr + vmlinux_size;
+
+	/* Align with 65536 */
+	vmlinuz_load_addr += (65536 - vmlinux_size % 65536);
+
+	printf("0x%llx\n", vmlinuz_load_addr);
+
+	return EXIT_SUCCESS;
+}
-- 
1.6.5
