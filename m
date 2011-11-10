Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 20:33:41 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:39367 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903568Ab1KJTdg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2011 20:33:36 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: lantiq: fixes etop compile error due to missing includes
Date:   Thu, 10 Nov 2011 21:33:06 +0100
Message-Id: <1320957187-26693-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
X-archive-position: 31510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9721

The ethernet driver fails to build in 3.1-RC1 due to 2 missing header files.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
---
 drivers/net/ethernet/lantiq_etop.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 6bb2b95..0b3567a 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -34,6 +34,8 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
 
 #include <asm/checksum.h>
 
-- 
1.7.7.1
