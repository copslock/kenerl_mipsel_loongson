Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 20:02:58 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:60143 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904273Ab1KITCv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2011 20:02:51 +0100
Received: by faaq17 with SMTP id q17so2581758faa.36
        for <multiple recipients>; Wed, 09 Nov 2011 11:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ggCnr99nNeXI5fXEXmgbuqggkJdjp1H/dAR+yexiQhY=;
        b=qVTT2plUEqXQKYlAaRFAv+oyp6V4kTDhPTbOl5ftBSQlNJI7CL6di1f624m9ZibxnW
         a7I5VcQcUXvoWefp+GaUCCaPEGD2lL8OQ6L4kadbeJ/2gciUzqiCwUSGR2aC5RNOQOxP
         UrAtXspfPaDsh4PeOolZCFmtvFhW+uYwkfr5s=
Received: by 10.152.148.168 with SMTP id tt8mr2516021lab.7.1320865366409;
        Wed, 09 Nov 2011 11:02:46 -0800 (PST)
Received: from flagship.roarinelk.net (178-191-4-90.adsl.highway.telekom.at. [178.191.4.90])
        by mx.google.com with ESMTPS id po16sm4983568lab.2.2011.11.09.11.02.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 11:02:45 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH mips-next] MIPS: Alchemy: pci: fix build: missing module.h
Date:   Wed,  9 Nov 2011 20:02:42 +0100
Message-Id: <1320865362-16718-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.2
X-archive-position: 31480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8059

fixes:
pci-alchemy.c:487:12: error: 'THIS_MODULE' undeclared here [...]

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
This is a new one in 3.2-rc1.

 arch/mips/pci/pci-alchemy.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index 4ee5710..b7779a3 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/vmalloc.h>
 
 #include <asm/mach-au1x00/au1000.h>
-- 
1.7.7.2
