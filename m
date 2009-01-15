Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 14:41:59 +0000 (GMT)
Received: from orbit.nwl.cc ([91.121.169.95]:27086 "EHLO mail.nwl.cc")
	by ftp.linux-mips.org with ESMTP id S21365931AbZAOOl5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2009 14:41:57 +0000
Received: from base (localhost [127.0.0.1])
	by mail.nwl.cc (Postfix) with ESMTP id 98F404043831;
	Thu, 15 Jan 2009 15:41:51 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Linux-Mips List <linux-mips@linux-mips.org>
Cc:	florian@openwrt.org, ralf@linux-mips.org, jeff@garzik.org
Subject: [PATCH] MIPS: rb532: use driver_data instead of platform_data
Date:	Thu, 15 Jan 2009 15:41:44 +0100
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <20090112.215202.194850308.davem@davemloft.net>
References: <20090112.215202.194850308.davem@davemloft.net>
Message-Id: <20090115144151.98F404043831@mail.nwl.cc>
Return-Path: <n0-1@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

As the korina ethernet driver uses platform_get_drvdata() to extract the
driver specific data from the platform device, driver_data has to be
used here.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/rb532/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 9b6b744..3c74561 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -89,7 +89,7 @@ static struct korina_device korina_dev0_data = {
 static struct platform_device korina_dev0 = {
 	.id = -1,
 	.name = "korina",
-	.dev.platform_data = &korina_dev0_data,
+	.dev.driver_data = &korina_dev0_data,
 	.resource = korina_dev0_res,
 	.num_resources = ARRAY_SIZE(korina_dev0_res),
 };
-- 
1.5.6.4
