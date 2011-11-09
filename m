Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 19:39:05 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:40352 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904270Ab1KISi7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2011 19:38:59 +0100
Received: by faaq17 with SMTP id q17so2552054faa.36
        for <multiple recipients>; Wed, 09 Nov 2011 10:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=412eoE73D3ZjyFUTWIFPzVuiEjakyPho8h079qPOwkg=;
        b=qP+8EoPNsErtnKrzc17fSOuvVE1V5m23PuP5XHK3+yugypvHQoouGzHe4pyjA1uMoq
         CLzJcf2I69U/Me1o7MpmbJbqzYTh0N5k62Xs4DHFezfowDx5K0cjEK5dXzkG2wnIMn/m
         ceoH9N1CyL3WNXCVeKEuBV7QpJszTlI0PO7m0=
Received: by 10.152.105.195 with SMTP id go3mr2338641lab.25.1320863933610;
        Wed, 09 Nov 2011 10:38:53 -0800 (PST)
Received: from flagship.roarinelk.net (178-191-4-90.adsl.highway.telekom.at. [178.191.4.90])
        by mx.google.com with ESMTPS id nw10sm4925036lab.4.2011.11.09.10.38.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 10:38:51 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] MIPS: Alchemy: db1300: fix build: missing module.h
Date:   Wed,  9 Nov 2011 19:38:46 +0100
Message-Id: <1320863926-6168-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.2
In-Reply-To: <20111109145015.GE19187@linux-mips.org>
References: <20111109145015.GE19187@linux-mips.org>
X-archive-position: 31476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8037

add module.h to fix build (symbol_get/symbol_put) against 3.2-rc1

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Please fold into "[PATCH 05/18] Basic support for the DB1300 board."

 arch/mips/alchemy/devboards/db1300.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index 23fd4ff..0893f2a 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -14,6 +14,7 @@
 #include <linux/leds.h>
 #include <linux/ata_platform.h>
 #include <linux/mmc/host.h>
+#include <linux/module.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
-- 
1.7.7.2
