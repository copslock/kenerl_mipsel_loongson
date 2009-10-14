Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 13:12:16 +0200 (CEST)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:46680 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492800AbZJNLMK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 13:12:10 +0200
Received: by pzk32 with SMTP id 32so11249916pzk.21
        for <multiple recipients>; Wed, 14 Oct 2009 04:12:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=VhHIX6ADd3NnUmjIX9SrU2Wm6m+O58Qdp5eROtFZvbo=;
        b=gO79mFCCtKyqyzYGAGfJ7lSh35trhBOGNjUwGFXx07k8Uqbba4dFzrMc+jUpYWkXRs
         VXwwkR0scWfKAhhgaRNbX21RYhiBkQ5uhQ1ameCt2Zdd06Sawi+velVjPLkQKaN5NNzP
         AeKZVu3BBl6Qs6xd4FdE3HLImwehiknpWLO/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JzQ+DY0jmTtTjlEsaVhQpOMF8YvV/cwweCYzATb1IwcKDED/k/CRq70IG9ULVxrOz0
         +N20wqPqCORPNx96S/x/4L/jdaUWWvcmKu73r3zaw4QL/v94rhyQJPH35WcAru4uG7RT
         HIM10rJ4+dJTJex8OOqaAnvJef4BztwSjeqRI=
Received: by 10.115.101.27 with SMTP id d27mr14950849wam.126.1255518723175;
        Wed, 14 Oct 2009 04:12:03 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm827510pxi.10.2009.10.14.04.11.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Oct 2009 04:12:02 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Manuel Lauss <manuel.lauss@googlemail.com>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: zboot: make the vmlinuz be fresh all the time
Date:	Wed, 14 Oct 2009 19:11:52 +0800
Message-Id: <1255518712-14666-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Manuel Lauss have reported:

"when I change the compression type in a built tree, the compressed/ directoryy
doesn't get rebuilt and a stale vmlinuz remains"

This patch fixes it.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Makefile                 |    2 +-
 arch/mips/boot/compressed/Makefile |    3 ---
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 05bcf99..c240f7d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -712,7 +712,7 @@ makezboot =$(Q)$(MAKE) $(build)=arch/mips/boot/compressed \
 
 all:	$(all-y)
 
-vmlinuz: vmlinux
+vmlinuz: vmlinux FORCE
 	+@$(call makezboot,$@)
 
 vmlinuz.bin: vmlinux
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 5cf9b46..90e5879 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -49,20 +49,17 @@ tool_$(CONFIG_KERNEL_LZMA)    = lzma
 tool_$(CONFIG_KERNEL_LZO)    = lzo
 $(obj)/vmlinux.$(suffix_y): $(obj)/vmlinux.bin
 	$(call if_changed,$(tool_y))
-	$(Q)rm -f $<
 
 $(obj)/piggy.o: $(obj)/vmlinux.$(suffix_y) $(obj)/dummy.o
 	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) \
 		--add-section=.image=$< \
 		--set-section-flags=.image=contents,alloc,load,readonly,data \
 		$(obj)/dummy.o $@
-	$(Q)rm -f $<
 
 LDFLAGS_vmlinuz := $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T
 vmlinuz: $(src)/ld.script $(obj-y) $(obj)/piggy.o
 	$(call if_changed,ld)
 	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) -R .comment -R .stab -R .stabstr -R .initrd -R .sysmap $@
-	$(Q)rm -f $(obj)/piggy.o
 
 #
 # Some DECstations need all possible sections of an ECOFF executable
-- 
1.6.2.1
