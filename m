Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 10:35:52 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:48357 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491203Ab0FBIfp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 10:35:45 +0200
Received: by iwn34 with SMTP id 34so552102iwn.36
        for <multiple recipients>; Wed, 02 Jun 2010 01:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=acpPPS335cajF56yrAW22OruOn6uR2fZBOlmpCpvkEw=;
        b=fJWM6rGpkSlIBa+oLRygW7Q5t2W9oUmMbA/ib/BuHE6KgRSJ9D3o/3/GACMNvVCMWL
         4Mu1tv9Rzo4tO3v+Ld6dqPPqtfCh0LoKc66Q+WKyRDahMTsVptmTVoWngfYROCF3aNjb
         3EmpnMx0GZWPI6exHQ3/mhG7TAGtkQSc2Hmww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=edeM31buDstO6XPiNagJIbOIbLPockLz77uQg6kpww87zXe5Q5MO1peARvic8fhw7K
         Yia4LeDf0vKjy4mGU3zloWVlbLZ+LcZ7diW27+iC/aMwUXUJKWMLUWWJoh4Nrwg7RiEh
         njCPUYbTIO1r3hhJX9dGJtWy9bCM8HVSzJXHk=
Received: by 10.231.195.16 with SMTP id ea16mr9333299ibb.64.1275467742139;
        Wed, 02 Jun 2010 01:35:42 -0700 (PDT)
Received: from yeeloong ([202.201.14.140])
        by mx.google.com with ESMTPS id d9sm35557897ibl.10.2010.06.02.01.35.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 01:35:41 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Cc:     Alexander Clouter <alex@digriz.org.uk>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v2] MIPS: Unify the suffix of compressed vmlinux.bin
Date:   Wed,  2 Jun 2010 16:35:24 +0800
Message-Id: <9890d1383c75ce6df44d357687a9c4e2d6ba4050.1275438553.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 26992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1107

The compressed vmlinux.bin is only a temp file, we can use the same suffix(.z)
for them(.gz,.lzo,.lzma...) to remove several lines and simpify the
maintaining(no need to add the "suffix_$(xxx) := suffix" line).

Changes:

  v1 -> v2:
    o Rename vmlinux.z to vmlinux.bin.z for vmlinux.z here is the compressed
    vmlinux.bin, not compressed vmlinux.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/Makefile |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 74a52d7..a517f58 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -48,23 +48,19 @@ OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary -R .comment -S
 $(obj)/vmlinux.bin: $(KBUILD_IMAGE) FORCE
 	$(call if_changed,objcopy)
 
-suffix_$(CONFIG_KERNEL_GZIP)  = gz
-suffix_$(CONFIG_KERNEL_BZIP2) = bz2
-suffix_$(CONFIG_KERNEL_LZMA)  = lzma
-suffix_$(CONFIG_KERNEL_LZO)   = lzo
 tool_$(CONFIG_KERNEL_GZIP)    = gzip
 tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
 tool_$(CONFIG_KERNEL_LZMA)    = lzma
 tool_$(CONFIG_KERNEL_LZO)     = lzo
 
-targets += vmlinux.gz vmlinux.bz2 vmlinux.lzma vmlinux.lzo
-$(obj)/vmlinux.$(suffix_y): $(obj)/vmlinux.bin FORCE
+targets += vmlinux.bin.z
+$(obj)/vmlinux.bin.z: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,$(tool_y))
 
 targets += piggy.o
-OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.$(suffix_y) \
+OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.bin.z \
                         --set-section-flags=.image=contents,alloc,load,readonly,data
-$(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.$(suffix_y) FORCE
+$(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.bin.z FORCE
 	$(call if_changed,objcopy)
 
 LDFLAGS_vmlinuz := $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T
-- 
1.6.5
