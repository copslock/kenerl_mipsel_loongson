Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 12:29:31 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:39762 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492446Ab0FAK30 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 12:29:26 +0200
Received: by pvb32 with SMTP id 32so272261pvb.36
        for <multiple recipients>; Tue, 01 Jun 2010 03:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=7RkLAXuKIo4YJyC8BZN6L4kqn1Uxz5zp+LzdXdzUumE=;
        b=J20+H5TYzFcECGNKjl2jIlWvy4U9arjQ39ivNpEpCfOaAFrOcERkpRCRPDesqTCU0+
         OeKe1e9L9QE43zeyspvG/g3rNsv59PXgzncMmybfh9qQqeni0ckpk9KkKfS7Z3JeQomp
         Dv4rV81QlatsXfnayZEJDvskRgDpVauGj5lhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=P5x9qKr3AK/ahtevLaOZ7WCoce8EkJv8JQFBiRm8ydY517UD0ys52y73WatjW0WsMa
         BqlDA3F6UFkppvu6YcffIqCXn/9ywcztID0LQXX1HBUSE/iQrxLqST1dKXQvzghILIsK
         m/axuON4ZB2X6kUg6PlqJCW9O5Z4+jMifC/wE=
Received: by 10.142.152.18 with SMTP id z18mr3904649wfd.230.1275388159243;
        Tue, 01 Jun 2010 03:29:19 -0700 (PDT)
Received: from yeeloong ([202.201.14.140])
        by mx.google.com with ESMTPS id s21sm1917785wff.0.2010.06.01.03.29.16
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 03:29:18 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Cc:     Alexander Clouter <alex@digriz.org.uk>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: arch/mips/boot/compressed/Makefile: Unify the suffix of compressed vmlinux.bin
Date:   Tue,  1 Jun 2010 18:29:02 +0800
Message-Id: <1275388144-5998-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 26956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 247

The compressed vmlinux.{gz,bz2,lzo,lzma} are only temp files, we can use the
same suffix for them to remove several lines and simpify the maintaining.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/Makefile |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 74a52d7..7204dfc 100644
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
+targets += vmlinux.z
+$(obj)/vmlinux.z: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,$(tool_y))
 
 targets += piggy.o
-OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.$(suffix_y) \
+OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.z \
                         --set-section-flags=.image=contents,alloc,load,readonly,data
-$(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.$(suffix_y) FORCE
+$(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.z FORCE
 	$(call if_changed,objcopy)
 
 LDFLAGS_vmlinuz := $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T
-- 
1.6.5
