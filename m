Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2009 15:27:37 +0200 (CEST)
Received: from hera.kernel.org ([140.211.167.34]:51922 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492616AbZIVN1a (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Sep 2009 15:27:30 +0200
Received: from [192.168.1.220] (triband-del-59.180.23.123.bol.net.in [59.180.23.123] (may be forged))
	(authenticated bits=0)
	by hera.kernel.org (8.14.2/8.13.8) with ESMTP id n8MDRCIs016616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 22 Sep 2009 13:27:15 GMT
Subject: [PATCH] MIPS: includecheck fix: bcm63xx, board_bcm963xx.c
From:	Jaswinder Singh Rajput <jaswinder@kernel.org>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>,
	linux-mips <linux-mips@linux-mips.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date:	Tue, 22 Sep 2009 18:57:17 +0530
Message-Id: <1253626037.3784.13.camel@ht.satnam>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.5 (2.24.5-2.fc10) 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.93.3/9821/Mon Sep 21 23:48:15 2009 on hera.kernel.org
X-Virus-Status:	Clean
Return-Path: <jaswinder@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaswinder@kernel.org
Precedence: bulk
X-list: linux-mips


fix the following 'make includecheck' warning:

  arch/mips/bcm63xx/boards/board_bcm963xx.c: bcm63xx_board.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index fd77f54..12add0c 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -20,7 +20,6 @@
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_regs.h>
 #include <bcm63xx_io.h>
-#include <bcm63xx_board.h>
 #include <bcm63xx_dev_pci.h>
 #include <bcm63xx_dev_enet.h>
 #include <bcm63xx_dev_dsp.h>
-- 
1.6.0.6
