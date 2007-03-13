Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 16:03:47 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:18627 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022271AbXCMQDm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Mar 2007 16:03:42 +0000
Received: from localhost (p8240-ipad202funabasi.chiba.ocn.ne.jp [222.146.79.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BE29FB722; Wed, 14 Mar 2007 01:02:20 +0900 (JST)
Date:	Wed, 14 Mar 2007 01:02:20 +0900 (JST)
Message-Id: <20070314.010220.65192616.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, netdev@vger.kernel.org, jeff@garzik.org,
	sshtylyov@ru.mvista.com, akpm@linux-foundation.org
Subject: [PATCH] tc35815: Fix an usage of streaming DMA API.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070303.235459.25478204.anemo@mba.ocn.ne.jp>
References: <20070303.235459.25478204.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The tc35815 driver lacks a call to pci_dma_sync_single_for_device() on
receiving.  Recent fix of MIPS dma_sync_single_for_cpu() reveal this
bug.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch can be applied to netdev-2.6 tree or 2.6.21-rc3-mm2.

diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
index ec888db..eed78b5 100644
--- a/drivers/net/tc35815.c
+++ b/drivers/net/tc35815.c
@@ -58,12 +58,13 @@
  *	1.34	Fix netpoll locking.  "BH rule" for NAPI is not enough with
  *		netpoll, hard_start_xmit might be called from irq context.
  *		PM support.
+ *	1.35	Fix an usage of streaming DMA API.
  */
 
 #ifdef TC35815_NAPI
-#define DRV_VERSION	"1.34-NAPI"
+#define DRV_VERSION	"1.35-NAPI"
 #else
-#define DRV_VERSION	"1.34"
+#define DRV_VERSION	"1.35"
 #endif
 static const char *version = "tc35815.c:v" DRV_VERSION "\n";
 #define MODNAME			"tc35815"
@@ -1551,6 +1552,11 @@ tc35815_rx(struct net_device *dev)
 							    PCI_DMA_FROMDEVICE);
 #endif
 				memcpy(data + offset, rxbuf, len);
+#ifdef TC35815_DMA_SYNC_ONDEMAND
+				pci_dma_sync_single_for_device(lp->pci_dev,
+							       dma, len,
+							       PCI_DMA_FROMDEVICE);
+#endif
 				offset += len;
 				cur_bd++;
 			}
