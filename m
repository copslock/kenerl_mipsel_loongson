Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Mar 2010 08:05:40 +0100 (CET)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38654 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490950Ab0CLHFg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Mar 2010 08:05:36 +0100
Received: from themisto.ext.pengutronix.de ([92.198.50.58] helo=pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.71)
        (envelope-from <w.sang@pengutronix.de>)
        id 1Npyvy-00009C-G7; Fri, 12 Mar 2010 08:05:25 +0100
From:   Wolfram Sang <w.sang@pengutronix.de>
To:     kernel-janitors@vger.kernel.org
Cc:     Wolfram Sang <w.sang@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Mar 2010 08:03:49 +0100
Message-Id: <1268377431-11671-2-git-send-email-w.sang@pengutronix.de>
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1268377431-11671-1-git-send-email-w.sang@pengutronix.de>
References: <1268377431-11671-1-git-send-email-w.sang@pengutronix.de>
X-SA-Exim-Connect-IP: 92.198.50.58
X-SA-Exim-Mail-From: w.sang@pengutronix.de
Subject: [PATCH 1/3] arch/mips/txx9/generic: init dynamic bin_attribute structures
X-SA-Exim-Version: 4.2.1 (built Wed, 25 Jun 2008 17:14:11 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <w.sang@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips

Commit 6992f5334995af474c2b58d010d08bc597f0f2fe introduced this requirement.
Found with coccinelle, but fixed manually. Compile tested on X86 where
possible.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/mips/txx9/generic/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 7174d83..95184a0 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -956,6 +956,7 @@ void __init txx9_sramc_init(struct resource *r)
 	if (!dev->base)
 		goto exit;
 	dev->dev.cls = &txx9_sramc_sysdev_class;
+	sysfs_bin_attr_init(&dev->bindata_attr);
 	dev->bindata_attr.attr.name = "bindata";
 	dev->bindata_attr.attr.mode = S_IRUSR | S_IWUSR;
 	dev->bindata_attr.read = txx9_sram_read;
-- 
1.7.0
