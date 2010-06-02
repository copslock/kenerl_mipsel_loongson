Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 10:53:20 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:48411 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492555Ab0FBIxP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 10:53:15 +0200
Received: by iwn34 with SMTP id 34so558377iwn.36
        for <multiple recipients>; Wed, 02 Jun 2010 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=FQu1EmorC2GETsVuhiPXev2uxHOs4Xpe/EEZN8TTE9Y=;
        b=nIUzr3myMjGAfV+/IDMmDQ7AODPJlSxkV5XqRAFLkK4Ne6phq1y6FEB79dnLsu1vHl
         qQGsZW44RyntYdDnXkjV8gY0+ZRIGA/Rae+DWXhRzLNkT5GOi5NIRYKUmAtf5Jf/1pqQ
         xpFVvwn77VjAGWe9IamxnqEZD3dVM9XNSTw44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BYuW5DUk+7UjQXdiyhvLRN4NM83mIrkCXkXDpvgp4ZfZXdpieVGf6sDmSfu6sKrZ3T
         gr3OwJ0UVNdqqu2Y8dtQBliJlt+YRyL8HK224BbZQEtK3TbvLHqHtGpuAAQsjOOlmXtZ
         hboPVp4Xq5OcPbFXvT9Q+j9axQwvyhyrp+svg=
Received: by 10.231.59.1 with SMTP id j1mr2838643ibh.55.1275468794093;
        Wed, 02 Jun 2010 01:53:14 -0700 (PDT)
Received: from yeeloong ([202.201.14.140])
        by mx.google.com with ESMTPS id f1sm35625153ibg.15.2010.06.02.01.53.11
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 01:53:13 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue] MIPS: Move Loongson Makefile parts to their own Platform file (cont.)
Date:   Wed,  2 Jun 2010 16:53:00 +0800
Message-Id: <95654e45e2f02133c6334fb147d3e28ef94f2bb0.1275439768.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 26995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1123

Hi, Ralf

I have fogotten to remove the -Werror in the Makefiles under loongson/
directory, this patch does it. could you please merge it into the commit "MIPS:
Move Loongson Makefile parts to their own Platform file".

Thanks & Regards,

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/cs5536/Makefile |    2 --
 arch/mips/loongson/fuloong-2e/Makefile    |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/mips/loongson/common/cs5536/Makefile b/arch/mips/loongson/common/cs5536/Makefile
index 510d4cd..f12e640 100644
--- a/arch/mips/loongson/common/cs5536/Makefile
+++ b/arch/mips/loongson/common/cs5536/Makefile
@@ -9,5 +9,3 @@ obj-$(CONFIG_CS5536) += cs5536_pci.o cs5536_ide.o cs5536_acc.o cs5536_ohci.o \
 # Enable cs5536 mfgpt Timer
 #
 obj-$(CONFIG_CS5536_MFGPT) += cs5536_mfgpt.o
-
-EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/loongson/fuloong-2e/Makefile b/arch/mips/loongson/fuloong-2e/Makefile
index 3aba5fc..b762272 100644
--- a/arch/mips/loongson/fuloong-2e/Makefile
+++ b/arch/mips/loongson/fuloong-2e/Makefile
@@ -3,5 +3,3 @@
 #
 
 obj-y += irq.o reset.o
-
-EXTRA_CFLAGS += -Werror
-- 
1.6.5
