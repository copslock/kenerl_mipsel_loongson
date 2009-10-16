Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 06:27:12 +0200 (CEST)
Received: from mail-px0-f189.google.com ([209.85.216.189]:61244 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492229AbZJPE1F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 06:27:05 +0200
Received: by pxi27 with SMTP id 27so1456674pxi.22
        for <multiple recipients>; Thu, 15 Oct 2009 21:26:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Suqc3SvZPuX8Db36dIlr2o++AieeBBCcqqialwHxtTo=;
        b=i+NhpHmwyPTBw3BNDKCkANLTXfzF6Ty1TJznWvcBesydYugc5Q18VTXNfTxkPGGKAj
         OESIp2apDcKbnN5JACDaG/mqRs/DKOLpHqfsjoNIRuVxkpuCXR82llS0jBdM8xbeZjQz
         UeN9ffbMg9fww5tUnEMmvsay0VfoVLOGIBRlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jnxFYW8HLsLB0aicXvZNHN2L9Tll2ecUIDvCk/CZM0iguDx5LMZCcuXxKam26aBeSM
         rN/eeZKk4iiwXW601EiDSyRDNJCb/85z8fK66ILhrYpjweKdF/NTxNwyfhJOc8gMVjcU
         wyW/NjdKK5IEjUmkOyTCbzD13eup+78r0KNvA=
Received: by 10.115.66.9 with SMTP id t9mr1055846wak.56.1255667216929;
        Thu, 15 Oct 2009 21:26:56 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm1180704pzk.13.2009.10.15.21.26.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 21:26:56 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Disable Function Tracer for Compressed kernel support part
Date:	Fri, 16 Oct 2009 12:26:45 +0800
Message-Id: <1255667205-22998-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

There is no need to trace the compressed support part, so, dislable it.
and also, if we not disable it, there will be compiling error about no
defined _mcount.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 9bc435d..e27f40b 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -20,6 +20,9 @@ VMLINUZ_LOAD_ADDRESS := 0x$(shell [ -n "$(VMLINUX_SIZE)" ] && printf %x $$(($(VM
 # set the default size of the mallocing area for decompressing
 BOOT_HEAP_SIZE := 0x400000
 
+# Disable Function Tracer
+KBUILD_CFLAGS := $(shell echo $(KBUILD_CFLAGS) | sed -e "s/-pg//")
+
 KBUILD_CFLAGS := $(LINUXINCLUDE) $(KBUILD_CFLAGS) -D__KERNEL__ \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) -D"VMLINUX_LOAD_ADDRESS_ULL=$(VMLINUX_LOAD_ADDRESS)ull" \
 
-- 
1.6.2.1
