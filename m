Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2008 16:00:23 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:43518 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21921593AbYJTPAV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2008 16:00:21 +0100
Received: from localhost.localdomain (p5246-ipad210funabasi.chiba.ocn.ne.jp [58.88.124.246])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 237FAA823; Tue, 21 Oct 2008 00:00:16 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, jeff@garzik.org
Subject: [PATCH] net: Make SMC91X selectable on other MIPS boards
Date:	Tue, 21 Oct 2008 00:00:29 +0900
Message-Id: <1224514829-16163-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

RBTX4939 board has SMC91X chip and there can be other MIPS boards with
that chip.  Make SMC91X selectable on all MIPS board would be better than
enumerating each boards in Kconfig.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: jeff@garzik.org
---
 drivers/net/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 096735f..be3c4b2 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -888,7 +888,7 @@ config SMC91X
 	select CRC32
 	select MII
 	depends on ARM || REDWOOD_5 || REDWOOD_6 || M32R || SUPERH || \
-		SOC_AU1X00 || BLACKFIN || MN10300
+		MIPS || BLACKFIN || MN10300
 	help
 	  This is a driver for SMC's 91x series of Ethernet chipsets,
 	  including the SMC91C94 and the SMC91C111. Say Y if you want it
-- 
1.5.6.3
