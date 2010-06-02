Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 10:36:19 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:48357 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490962Ab0FBIfr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 10:35:47 +0200
Received: by mail-iw0-f177.google.com with SMTP id 34so552102iwn.36
        for <multiple recipients>; Wed, 02 Jun 2010 01:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=s6bXI8dFczbIKVHlS/hHi1Cbq+nZCkxV58jG5LsO2zg=;
        b=VDl9fRtSU4890Kdk5vNo3IwocrafoSkj55YfzQFFNKggSCIvnruTp7kWWYc/zftj5q
         Ml7sQ5xIWAE6aRM7FKDBuhT+6BHOXUZxv+sWOOMPpOJ3ufYgK9eNj81cMl/KQTFtpv/u
         M5mJUIo19Hsqk5zzd6widfZaGrQCRVX1yFnwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=laqtQZeRslicxWGk3hdIkTSPYpl6gyc2pf81L9Wgbhz307/nQVJdWIEZa4CEOWE2P4
         Uk/O9AEaj9Xj2oAFHSLICEvcSy2Adhw48GRUp5ZYEoQWyfxhLfE9KQVv8+r4sjd/8dA+
         JnFRFvy+Nbpt5JJrSFbYpFe+UlzFXvxYsNQ/A=
Received: by 10.231.120.69 with SMTP id c5mr9432021ibr.79.1275467746666;
        Wed, 02 Jun 2010 01:35:46 -0700 (PDT)
Received: from yeeloong ([202.201.14.140])
        by mx.google.com with ESMTPS id d9sm35557897ibl.10.2010.06.02.01.35.42
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 01:35:46 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Cc:     Alexander Clouter <alex@digriz.org.uk>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v4] MIPS: Clean up the calculation of VMLINUZ_LOAD_ADDRESS
Date:   Wed,  2 Jun 2010 16:35:25 +0800
Message-Id: <96f3b48ba7f749c4357760008cdae644aa55b92d.1275438520.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <9890d1383c75ce6df44d357687a9c4e2d6ba4050.1275438553.git.wuzhangjin@gmail.com>
References: <9890d1383c75ce6df44d357687a9c4e2d6ba4050.1275438553.git.wuzhangjin@gmail.com>
X-archive-position: 26993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1109

We have calculated VMLINUZ_LOAD_ADDRESS in shell, which is indecipherable. This
patch rewrites it in C.

Changes:

v3 -> v4: (feedback from Sam Ravnborg)
  o Makefile: Follow the 80 characters' limit and Remove an un-needed objcopy.
  o calc_vmlinuz_load_addr.c: Use a smaller alignment and Add more comments

v2 -> v3: (feedback from Alexander Clouter)
  o Drop the unneeded variable n
  o Replace the last "unsigned long long" by uint64_t

v1 -> v2: (feedback from Alexander Clouter)
  o make it more portable
    use EXIT_SUCCESS and EXIT_FAILURE as the return value, and use uint64_t
    instead of "unsigned long long".
  o add a missing return value
    return EXIT_FAILURE if sscanf() not return 1

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/.gitignore                          |    1 +
 arch/mips/boot/compressed/Makefile                 |   26 +++++-----
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |   57 ++++++++++++++++++++
 3 files changed, 71 insertions(+), 13 deletions(-)
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
index a517f58..9ef6e2f 100644
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
 
@@ -63,10 +55,18 @@ OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.bin.z \
 $(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.bin.z FORCE
 	$(call if_changed,objcopy)
 
-LDFLAGS_vmlinuz := $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T
-vmlinuz: $(src)/ld.script $(vmlinuzobjs-y) $(obj)/piggy.o
-	$(call cmd,ld)
-	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) $@
+# Calculate the load address of the compressed kernel image
+hostprogs-y := calc_vmlinuz_load_addr
+
+VMLINUZ_LOAD_ADDRESS = $(shell $(obj)/calc_vmlinuz_load_addr \
+		$(objtree)/$(KBUILD_IMAGE) $(VMLINUX_LOAD_ADDRESS))
+
+vmlinuzobjs-y += $(obj)/piggy.o
+
+quiet_cmd_zld = LD      $@
+      cmd_zld = $(LD) $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T $< $(vmlinuzobjs-y) -o $@
+vmlinuz: $(src)/ld.script $(vmlinuzobjs-y) $(obj)/calc_vmlinuz_load_addr
+	$(call cmd,zld)
 
 #
 # Some DECstations need all possible sections of an ECOFF executable
@@ -76,7 +76,7 @@ ifdef CONFIG_MACH_DECSTATION
 endif
 
 # elf2ecoff can only handle 32bit image
-hostprogs-y := ../elf2ecoff
+hostprogs-y += ../elf2ecoff
 
 ifdef CONFIG_32BIT
 	VMLINUZ = vmlinuz
diff --git a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
new file mode 100644
index 0000000..88c9d96
--- /dev/null
+++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
@@ -0,0 +1,57 @@
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
+	if (sscanf(argv[2], "%llx", &vmlinux_load_addr) != 1) {
+		if (errno != 0)
+			perror("sscanf");
+		else
+			fprintf(stderr, "No matching characters\n");
+
+		return EXIT_FAILURE;
+	}
+
+	vmlinux_size = (uint64_t)sb.st_size;
+	vmlinuz_load_addr = vmlinux_load_addr + vmlinux_size;
+
+	/*
+	 * Align with 16 bytes: "greater than that used for any standard data
+	 * types by a MIPS compiler." -- See MIPS Run Linux (Second Edition).
+	 */
+
+	vmlinuz_load_addr += (16 - vmlinux_size % 16);
+
+	printf("0x%llx\n", vmlinuz_load_addr);
+
+	return EXIT_SUCCESS;
+}
-- 
1.6.5
