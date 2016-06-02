Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 07:22:27 +0200 (CEST)
Received: from smtpout.microchip.com ([198.175.253.82]:17846 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27033582AbcFBFWZrT6vY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 07:22:25 +0200
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.181.6; Wed, 1 Jun 2016
 22:22:17 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Thu, 02 Jun 2016
 10:50:22 +0530
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        Joshua Henderson <digitalpeer@digitalpeer.com>,
        Joshua Henderson <joshua.henderson@microchip.com>
Subject: [PATCH] MIPS: pic32mzda: fix linker error for pic32_get_pbclk().
Date:   Thu, 2 Jun 2016 10:50:21 +0530
Message-ID: <1464844821-1581-1-git-send-email-purna.mandal@microchip.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: purna.mandal@microchip.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Early clock API pic32_get_pbclk() is defined in early_clk.c and
used by time.c and early_console.c. When CONFIG_EARLY_PRINTK isn't
set, early_clk.c isn't compiled and so a linker error is reported
while referring the API from time.c.

Fix it by compiling early_clk.c always. Also sort files in
alphabetical order.

Cc: Harvey Hunt <harvey.hunt@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Joshua Henderson <digitalpeer@digitalpeer.com>

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>

---

 arch/mips/pic32/pic32mzda/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/pic32/pic32mzda/Makefile b/arch/mips/pic32/pic32mzda/Makefile
index 4a4c272..c286496 100644
--- a/arch/mips/pic32/pic32mzda/Makefile
+++ b/arch/mips/pic32/pic32mzda/Makefile
@@ -2,8 +2,7 @@
 # Joshua Henderson, <joshua.henderson@microchip.com>
 # Copyright (C) 2015 Microchip Technology, Inc.  All rights reserved.
 #
-obj-y			:= init.o time.o config.o
+obj-y			:= config.o early_clk.o init.o time.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= early_console.o      \
-				   early_pin.o		\
-				   early_clk.o
+				   early_pin.o
-- 
1.8.3.1
