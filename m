Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2010 17:27:03 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:64650 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492028Ab0KIQ0y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Nov 2010 17:26:54 +0100
Received: by pwj8 with SMTP id 8so476324pwj.36
        for <multiple recipients>; Tue, 09 Nov 2010 08:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mcMfl7EPLUxEcSTUwYi0XXAG2azpdI74kuft3weCIrA=;
        b=YHHHGb5nfcEJYq0Z5O8mY379g1dfCcJOHHjysk/6g/r1cBWf/J0mYVAP9pFreJHgz3
         yIV19AquQeOnC540jlLuwrxevfN6yZ4g2YQItSIqTBxnQ3tiifoYMCTVCXxco39/rPiZ
         m1ryReYOskJJ5p2Dmb71gUzJ0hoteQzB3bfsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CK3gIQ2xUS1a1JSr6vfm2y7qG34EQPt81QZjLe6OkqhKUqn/eH6k4s+5ZDAFTQWQ/H
         qTdz2+ni/vZ1/LPuLc2O4bPoSmOoytXr6Szcos6tWHF6IktvlgzBaq3FUVHWdsAGIDdb
         05/OL6zXvC0fOQOsGXqHwWwIWwjUTH/lx1T9w=
Received: by 10.142.163.6 with SMTP id l6mr1676522wfe.406.1289320007633;
        Tue, 09 Nov 2010 08:26:47 -0800 (PST)
Received: from localhost.localdomain ([221.220.250.231])
        by mx.google.com with ESMTPS id x4sm1872040wfd.21.2010.11.09.08.26.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 08:26:46 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Sam Ravnborg <sam@ravnborg.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 2/2] MIPS: Quiet the building output of vmlinux.32 and vmlinux.64
Date:   Wed, 10 Nov 2010 00:26:34 +0800
Message-Id: <6f2125c69f79f864518a20af44568f81ce309c77.1289319749.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <81fc5055a5980ee2877004944553387ed8bdb2b8.1289319749.git.wuzhangjin@gmail.com>
References: <81fc5055a5980ee2877004944553387ed8bdb2b8.1289319749.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Based on quiet_cmd_X and cmd_X, this patch quiets the building output of
vmlinux.32 and vmlinux.64.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Makefile |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 4a7bfa7..d1f132d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -256,15 +256,19 @@ endif
 # Other need ECOFF, so we build a 32-bit ELF binary for them which we then
 # convert to ECOFF using elf2ecoff.
 #
+quiet_cmd_32 = OBJCOPY $@
+      cmd_32 = $(OBJCOPY) -O $(32bit-bfd) $(OBJCOPYFLAGS) $< $@
 vmlinux.32: vmlinux
-	$(OBJCOPY) -O $(32bit-bfd) $(OBJCOPYFLAGS) $< $@
+	$(call cmd,32)
 
 #
 # The 64-bit ELF tools are pretty broken so at this time we generate 64-bit
 # ELF files from 32-bit files by conversion.
 #
+quiet_cmd_64 = OBJCOPY $@
+      cmd_64 = $(OBJCOPY) -O $(64bit-bfd) $(OBJCOPYFLAGS) $< $@
 vmlinux.64: vmlinux
-	$(OBJCOPY) -O $(64bit-bfd) $(OBJCOPYFLAGS) $< $@
+	$(call cmd,64)
 
 all:	$(all-y)
 
-- 
1.7.1
