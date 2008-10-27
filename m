Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 01:30:20 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:57473 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S22453082AbYJ0BaM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Oct 2008 01:30:12 +0000
Received: from base (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id 6B98938C1B79;
	Mon, 27 Oct 2008 02:30:01 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-Mips List <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] disable the right device
Date:	Mon, 27 Oct 2008 02:29:57 +0100
Message-Id: <1225070997-31819-1-git-send-email-n0-1@freewrt.org>
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <20081026103635.GA10490@linux-mips.org>
References: <20081026103635.GA10490@linux-mips.org>
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/rb532/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 31619c6..2f22d71 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -280,7 +280,7 @@ static int __init plat_setup_devices(void)
 {
 	/* Look for the CF card reader */
 	if (!readl(IDT434_REG_BASE + DEV1MASK))
-		rb532_devs[1] = NULL;
+		rb532_devs[2] = NULL;	/* disable cf_slot0 at index 2 */
 	else {
 		cf_slot0_res[0].start =
 		    readl(IDT434_REG_BASE + DEV1BASE);
-- 
1.5.6.4
