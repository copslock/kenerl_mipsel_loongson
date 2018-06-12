Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2018 07:42:52 +0200 (CEST)
Received: from mga05.intel.com ([192.55.52.43]:13876 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992618AbeFLFl3pr5Ra (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Jun 2018 07:41:29 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 22:41:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="236658441"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jun 2018 22:41:25 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com
Cc:     linux-mips@linux-mips.org, qi-ming.wu@intel.com,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 6/7] tty: serial: lantiq: Remove unneeded header includes and macros
Date:   Tue, 12 Jun 2018 13:40:33 +0800
Message-Id: <20180612054034.4969-7-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180612054034.4969-1-songjun.wu@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: songjun.wu@linux.intel.com
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

Update the author list with Intel Corporation.
Sort the header includes in alphabetical orders.
Remove unneeded header includes and macros.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 drivers/tty/serial/lantiq.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 72aab1b05265..cc33208c93ac 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -6,24 +6,23 @@
  * Copyright (C) 2007 Felix Fietkau <nbd@openwrt.org>
  * Copyright (C) 2007 John Crispin <john@phrozen.org>
  * Copyright (C) 2010 Thomas Langer, <thomas.langer@lantiq.com>
+ * Copyright (C) 2017 Intel Corporation.
  */
 
-#include <linux/slab.h>
-#include <linux/ioport.h>
-#include <linux/init.h>
+#include <linux/clk.h>
 #include <linux/console.h>
-#include <linux/sysrq.h>
 #include <linux/device.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/serial_core.h>
-#include <linux/serial.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/gpio.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <linux/sysrq.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 
 #include <lantiq_soc.h>
 
@@ -43,7 +42,6 @@
 #define LTQ_ASC_STATE		0x0014
 #define LTQ_ASC_IRNCR		0x00F8
 #define LTQ_ASC_CLC		0x0000
-#define LTQ_ASC_ID		0x0008
 #define LTQ_ASC_PISEL		0x0004
 #define LTQ_ASC_TXFCON		0x0044
 #define LTQ_ASC_RXFCON		0x0040
@@ -51,16 +49,12 @@
 #define LTQ_ASC_BG		0x0050
 #define LTQ_ASC_FDV		0x0058
 #define LTQ_ASC_IRNEN		0x00F4
-
 #define ASC_IRNREN_TX		0x1
 #define ASC_IRNREN_RX		0x2
 #define ASC_IRNREN_ERR		0x4
-#define ASC_IRNREN_TX_BUF	0x8
 #define ASC_IRNCR_TIR		0x1
 #define ASC_IRNCR_RIR		0x2
 #define ASC_IRNCR_EIR		0x4
-
-#define ASCOPT_CSIZE		0x3
 #define TXFIFO_FL		1
 #define RXFIFO_FL		1
 #define ASCCLC_DISR		0x1
@@ -71,7 +65,6 @@
 #define ASCCON_M_7ASYNC		0x2
 #define ASCCON_ODD		0x00000020
 #define ASCCON_STP		0x00000080
-#define ASCCON_BRS		0x00000100
 #define ASCCON_FDE		0x00000200
 #define ASCCON_R		0x00008000
 #define ASCCON_FEN		0x00020000
@@ -80,7 +73,7 @@
 #define ASCSTATE_PE		0x00010000
 #define ASCSTATE_FE		0x00020000
 #define ASCSTATE_ROE		0x00080000
-#define ASCSTATE_ANY		(ASCSTATE_ROE|ASCSTATE_PE|ASCSTATE_FE)
+#define ASCSTATE_ANY		(ASCSTATE_ROE | ASCSTATE_PE | ASCSTATE_FE)
 #define ASCWHBSTATE_CLRREN	0x00000001
 #define ASCWHBSTATE_SETREN	0x00000002
 #define ASCWHBSTATE_CLRPE	0x00000004
-- 
2.11.0
