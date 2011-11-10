Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 19:54:46 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:42009 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903567Ab1KJSyk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2011 19:54:40 +0100
Received: by faar25 with SMTP id r25so92570faa.36
        for <multiple recipients>; Thu, 10 Nov 2011 10:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8jOpczxJtxDv7dHCSYhp47Xj8VL7Hyj042vKWZuueLU=;
        b=feXj4oBMJMTFDg4IvCHCea9GMhwJ2HPGqMIcx4vNipEBVaBGiXXdnjvhtjphPYClVA
         5yTdPvqsHGCltYSEm/ngCT/+5DWL34bII7e1SRhWps9PgTlPliYbTzUu2zefXVvaVdHH
         1NLSBJwzQd8f2Ks5igKebSeOG9/2wjkCc46Js=
Received: by 10.152.162.10 with SMTP id xw10mr5190273lab.12.1320951265243;
        Thu, 10 Nov 2011 10:54:25 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-13-175.adsl.highway.telekom.at. [188.22.13.175])
        by mx.google.com with ESMTPS id pw12sm8172130lab.13.2011.11.10.10.54.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 10:54:23 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V2] MIPS: Alchemy: pci: fix build: missing export.h
Date:   Thu, 10 Nov 2011 19:52:59 +0100
Message-Id: <1320951179-25780-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.2
In-Reply-To: <20111110180624.GA30108@linux-mips.org>
References: <20111110180624.GA30108@linux-mips.org>
X-archive-position: 31505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9652

fixes:
pci-alchemy.c:487:12: error: 'THIS_MODULE' undeclared here [...]

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
V2: export.h instead of module.h

 arch/mips/pci/pci-alchemy.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index 4ee5710..b5ce041 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -7,6 +7,7 @@
  * Support for all devices (greater than 16) added by David Gathright.
  */
 
+#include <linux/export.h>
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
-- 
1.7.7.2
