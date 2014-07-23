Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:37:17 +0200 (CEST)
Received: from mail-wg0-f47.google.com ([74.125.82.47]:38271 "EHLO
        mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826470AbaGWOgwlKUd- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:36:52 +0200
Received: by mail-wg0-f47.google.com with SMTP id b13so1269996wgh.6
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cm6nfnvRWP0F7IT/wHGQKMxSJO680S+YOJYZOcRDur0=;
        b=A3nTlxpujZoA+2tqHXHo5wSX/SkLQvoUY9PVuNU4x9koLtuYagnPpFaHfr2hvliwl1
         maIDFjaO6iNp9wq9lSooxCMBXId6f+lWppNd3QCLbEIk9FTI1W0OlwcvSV0Qbqjbuv3M
         Z5DARfzohvSGMt/C47dLyFP/9KN5CUD/dIrozbB4z7fCfnROxarCrZPhUcKOsldwvrkL
         4S/+qGSOL/sMJVDBvwU3ISPMmhvLANB2T6QNuRnEiyc8/TSlHsx1EfzQ8zW9zFLUz7WZ
         YzWKnmo263CMdI4Bv8E5wAWOQVCHNVkjN7yx6U8DjDtn8hQEcrUt77ruFkotI2JOmcFN
         KTaw==
X-Received: by 10.194.109.71 with SMTP id hq7mr2564446wjb.114.1406126204071;
        Wed, 23 Jul 2014 07:36:44 -0700 (PDT)
Received: from localhost.localdomain (p57A349C7.dip0.t-ipconnect.de. [87.163.73.199])
        by mx.google.com with ESMTPSA id h3sm6717751wjz.48.2014.07.23.07.36.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 07:36:43 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 2/6] MIPS: Alchemy: move ethernet registers to ethernet driver
Date:   Wed, 23 Jul 2014 16:36:22 +0200
Message-Id: <1406126186-471228-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1406126186-471228-1-git-send-email-manuel.lauss@gmail.com>
References: <1406126186-471228-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Move the register offsets and bit descriptions from the au1000.h header
to their only user, the au1000_eth.c driver.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
Cc: netdev@vger.kernel.org
---
 arch/mips/include/asm/mach-au1x00/au1000.h | 126 -----------------------------
 drivers/net/ethernet/amd/au1000_eth.c      | 118 +++++++++++++++++++++++++++
 2 files changed, 118 insertions(+), 126 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 60754fc..e506710 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -1003,132 +1003,6 @@ enum soc_au1200_ints {
 #define SYS_RTCMATCH2		(SYS_BASE + 0x54)
 #define SYS_RTCREAD		(SYS_BASE + 0x58)
 
-/* Ethernet Controllers  */
-
-/* 4 byte offsets from AU1000_ETH_BASE */
-#define MAC_CONTROL		0x0
-#  define MAC_RX_ENABLE		(1 << 2)
-#  define MAC_TX_ENABLE		(1 << 3)
-#  define MAC_DEF_CHECK		(1 << 5)
-#  define MAC_SET_BL(X)		(((X) & 0x3) << 6)
-#  define MAC_AUTO_PAD		(1 << 8)
-#  define MAC_DISABLE_RETRY	(1 << 10)
-#  define MAC_DISABLE_BCAST	(1 << 11)
-#  define MAC_LATE_COL		(1 << 12)
-#  define MAC_HASH_MODE		(1 << 13)
-#  define MAC_HASH_ONLY		(1 << 15)
-#  define MAC_PASS_ALL		(1 << 16)
-#  define MAC_INVERSE_FILTER	(1 << 17)
-#  define MAC_PROMISCUOUS	(1 << 18)
-#  define MAC_PASS_ALL_MULTI	(1 << 19)
-#  define MAC_FULL_DUPLEX	(1 << 20)
-#  define MAC_NORMAL_MODE	0
-#  define MAC_INT_LOOPBACK	(1 << 21)
-#  define MAC_EXT_LOOPBACK	(1 << 22)
-#  define MAC_DISABLE_RX_OWN	(1 << 23)
-#  define MAC_BIG_ENDIAN	(1 << 30)
-#  define MAC_RX_ALL		(1 << 31)
-#define MAC_ADDRESS_HIGH	0x4
-#define MAC_ADDRESS_LOW		0x8
-#define MAC_MCAST_HIGH		0xC
-#define MAC_MCAST_LOW		0x10
-#define MAC_MII_CNTRL		0x14
-#  define MAC_MII_BUSY		(1 << 0)
-#  define MAC_MII_READ		0
-#  define MAC_MII_WRITE		(1 << 1)
-#  define MAC_SET_MII_SELECT_REG(X) (((X) & 0x1f) << 6)
-#  define MAC_SET_MII_SELECT_PHY(X) (((X) & 0x1f) << 11)
-#define MAC_MII_DATA		0x18
-#define MAC_FLOW_CNTRL		0x1C
-#  define MAC_FLOW_CNTRL_BUSY	(1 << 0)
-#  define MAC_FLOW_CNTRL_ENABLE (1 << 1)
-#  define MAC_PASS_CONTROL	(1 << 2)
-#  define MAC_SET_PAUSE(X)	(((X) & 0xffff) << 16)
-#define MAC_VLAN1_TAG		0x20
-#define MAC_VLAN2_TAG		0x24
-
-/* Ethernet Controller Enable */
-
-#  define MAC_EN_CLOCK_ENABLE	(1 << 0)
-#  define MAC_EN_RESET0		(1 << 1)
-#  define MAC_EN_TOSS		(0 << 2)
-#  define MAC_EN_CACHEABLE	(1 << 3)
-#  define MAC_EN_RESET1		(1 << 4)
-#  define MAC_EN_RESET2		(1 << 5)
-#  define MAC_DMA_RESET		(1 << 6)
-
-/* Ethernet Controller DMA Channels */
-
-#define MAC0_TX_DMA_ADDR	0xB4004000
-#define MAC1_TX_DMA_ADDR	0xB4004200
-/* offsets from MAC_TX_RING_ADDR address */
-#define MAC_TX_BUFF0_STATUS	0x0
-#  define TX_FRAME_ABORTED	(1 << 0)
-#  define TX_JAB_TIMEOUT	(1 << 1)
-#  define TX_NO_CARRIER		(1 << 2)
-#  define TX_LOSS_CARRIER	(1 << 3)
-#  define TX_EXC_DEF		(1 << 4)
-#  define TX_LATE_COLL_ABORT	(1 << 5)
-#  define TX_EXC_COLL		(1 << 6)
-#  define TX_UNDERRUN		(1 << 7)
-#  define TX_DEFERRED		(1 << 8)
-#  define TX_LATE_COLL		(1 << 9)
-#  define TX_COLL_CNT_MASK	(0xF << 10)
-#  define TX_PKT_RETRY		(1 << 31)
-#define MAC_TX_BUFF0_ADDR	0x4
-#  define TX_DMA_ENABLE		(1 << 0)
-#  define TX_T_DONE		(1 << 1)
-#  define TX_GET_DMA_BUFFER(X)	(((X) >> 2) & 0x3)
-#define MAC_TX_BUFF0_LEN	0x8
-#define MAC_TX_BUFF1_STATUS	0x10
-#define MAC_TX_BUFF1_ADDR	0x14
-#define MAC_TX_BUFF1_LEN	0x18
-#define MAC_TX_BUFF2_STATUS	0x20
-#define MAC_TX_BUFF2_ADDR	0x24
-#define MAC_TX_BUFF2_LEN	0x28
-#define MAC_TX_BUFF3_STATUS	0x30
-#define MAC_TX_BUFF3_ADDR	0x34
-#define MAC_TX_BUFF3_LEN	0x38
-
-#define MAC0_RX_DMA_ADDR	0xB4004100
-#define MAC1_RX_DMA_ADDR	0xB4004300
-/* offsets from MAC_RX_RING_ADDR */
-#define MAC_RX_BUFF0_STATUS	0x0
-#  define RX_FRAME_LEN_MASK	0x3fff
-#  define RX_WDOG_TIMER		(1 << 14)
-#  define RX_RUNT		(1 << 15)
-#  define RX_OVERLEN		(1 << 16)
-#  define RX_COLL		(1 << 17)
-#  define RX_ETHER		(1 << 18)
-#  define RX_MII_ERROR		(1 << 19)
-#  define RX_DRIBBLING		(1 << 20)
-#  define RX_CRC_ERROR		(1 << 21)
-#  define RX_VLAN1		(1 << 22)
-#  define RX_VLAN2		(1 << 23)
-#  define RX_LEN_ERROR		(1 << 24)
-#  define RX_CNTRL_FRAME	(1 << 25)
-#  define RX_U_CNTRL_FRAME	(1 << 26)
-#  define RX_MCAST_FRAME	(1 << 27)
-#  define RX_BCAST_FRAME	(1 << 28)
-#  define RX_FILTER_FAIL	(1 << 29)
-#  define RX_PACKET_FILTER	(1 << 30)
-#  define RX_MISSED_FRAME	(1 << 31)
-
-#  define RX_ERROR (RX_WDOG_TIMER | RX_RUNT | RX_OVERLEN |  \
-		    RX_COLL | RX_MII_ERROR | RX_CRC_ERROR | \
-		    RX_LEN_ERROR | RX_U_CNTRL_FRAME | RX_MISSED_FRAME)
-#define MAC_RX_BUFF0_ADDR	0x4
-#  define RX_DMA_ENABLE		(1 << 0)
-#  define RX_T_DONE		(1 << 1)
-#  define RX_GET_DMA_BUFFER(X)	(((X) >> 2) & 0x3)
-#  define RX_SET_BUFF_ADDR(X)	((X) & 0xffffffc0)
-#define MAC_RX_BUFF1_STATUS	0x10
-#define MAC_RX_BUFF1_ADDR	0x14
-#define MAC_RX_BUFF2_STATUS	0x20
-#define MAC_RX_BUFF2_ADDR	0x24
-#define MAC_RX_BUFF3_STATUS	0x30
-#define MAC_RX_BUFF3_ADDR	0x34
-
 
 /*
  * The IrDA peripheral has an IRFIRSEL pin, but on the DB/PB boards it's not
diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index a78e4c1..ad8b058 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -89,6 +89,124 @@ MODULE_DESCRIPTION(DRV_DESC);
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
+/* AU1000 MAC registers and bits */
+#define MAC_CONTROL		0x0
+#  define MAC_RX_ENABLE		(1 << 2)
+#  define MAC_TX_ENABLE		(1 << 3)
+#  define MAC_DEF_CHECK		(1 << 5)
+#  define MAC_SET_BL(X)		(((X) & 0x3) << 6)
+#  define MAC_AUTO_PAD		(1 << 8)
+#  define MAC_DISABLE_RETRY	(1 << 10)
+#  define MAC_DISABLE_BCAST	(1 << 11)
+#  define MAC_LATE_COL		(1 << 12)
+#  define MAC_HASH_MODE		(1 << 13)
+#  define MAC_HASH_ONLY		(1 << 15)
+#  define MAC_PASS_ALL		(1 << 16)
+#  define MAC_INVERSE_FILTER	(1 << 17)
+#  define MAC_PROMISCUOUS	(1 << 18)
+#  define MAC_PASS_ALL_MULTI	(1 << 19)
+#  define MAC_FULL_DUPLEX	(1 << 20)
+#  define MAC_NORMAL_MODE	0
+#  define MAC_INT_LOOPBACK	(1 << 21)
+#  define MAC_EXT_LOOPBACK	(1 << 22)
+#  define MAC_DISABLE_RX_OWN	(1 << 23)
+#  define MAC_BIG_ENDIAN	(1 << 30)
+#  define MAC_RX_ALL		(1 << 31)
+#define MAC_ADDRESS_HIGH	0x4
+#define MAC_ADDRESS_LOW		0x8
+#define MAC_MCAST_HIGH		0xC
+#define MAC_MCAST_LOW		0x10
+#define MAC_MII_CNTRL		0x14
+#  define MAC_MII_BUSY		(1 << 0)
+#  define MAC_MII_READ		0
+#  define MAC_MII_WRITE		(1 << 1)
+#  define MAC_SET_MII_SELECT_REG(X) (((X) & 0x1f) << 6)
+#  define MAC_SET_MII_SELECT_PHY(X) (((X) & 0x1f) << 11)
+#define MAC_MII_DATA		0x18
+#define MAC_FLOW_CNTRL		0x1C
+#  define MAC_FLOW_CNTRL_BUSY	(1 << 0)
+#  define MAC_FLOW_CNTRL_ENABLE (1 << 1)
+#  define MAC_PASS_CONTROL	(1 << 2)
+#  define MAC_SET_PAUSE(X)	(((X) & 0xffff) << 16)
+#define MAC_VLAN1_TAG		0x20
+#define MAC_VLAN2_TAG		0x24
+
+/* Ethernet Controller Enable */
+#  define MAC_EN_CLOCK_ENABLE	(1 << 0)
+#  define MAC_EN_RESET0		(1 << 1)
+#  define MAC_EN_TOSS		(0 << 2)
+#  define MAC_EN_CACHEABLE	(1 << 3)
+#  define MAC_EN_RESET1		(1 << 4)
+#  define MAC_EN_RESET2		(1 << 5)
+#  define MAC_DMA_RESET		(1 << 6)
+
+/* Ethernet Controller DMA Channels */
+/* offsets from MAC_TX_RING_ADDR address */
+#define MAC_TX_BUFF0_STATUS	0x0
+#  define TX_FRAME_ABORTED	(1 << 0)
+#  define TX_JAB_TIMEOUT	(1 << 1)
+#  define TX_NO_CARRIER		(1 << 2)
+#  define TX_LOSS_CARRIER	(1 << 3)
+#  define TX_EXC_DEF		(1 << 4)
+#  define TX_LATE_COLL_ABORT	(1 << 5)
+#  define TX_EXC_COLL		(1 << 6)
+#  define TX_UNDERRUN		(1 << 7)
+#  define TX_DEFERRED		(1 << 8)
+#  define TX_LATE_COLL		(1 << 9)
+#  define TX_COLL_CNT_MASK	(0xF << 10)
+#  define TX_PKT_RETRY		(1 << 31)
+#define MAC_TX_BUFF0_ADDR	0x4
+#  define TX_DMA_ENABLE		(1 << 0)
+#  define TX_T_DONE		(1 << 1)
+#  define TX_GET_DMA_BUFFER(X)	(((X) >> 2) & 0x3)
+#define MAC_TX_BUFF0_LEN	0x8
+#define MAC_TX_BUFF1_STATUS	0x10
+#define MAC_TX_BUFF1_ADDR	0x14
+#define MAC_TX_BUFF1_LEN	0x18
+#define MAC_TX_BUFF2_STATUS	0x20
+#define MAC_TX_BUFF2_ADDR	0x24
+#define MAC_TX_BUFF2_LEN	0x28
+#define MAC_TX_BUFF3_STATUS	0x30
+#define MAC_TX_BUFF3_ADDR	0x34
+#define MAC_TX_BUFF3_LEN	0x38
+
+/* offsets from MAC_RX_RING_ADDR */
+#define MAC_RX_BUFF0_STATUS	0x0
+#  define RX_FRAME_LEN_MASK	0x3fff
+#  define RX_WDOG_TIMER		(1 << 14)
+#  define RX_RUNT		(1 << 15)
+#  define RX_OVERLEN		(1 << 16)
+#  define RX_COLL		(1 << 17)
+#  define RX_ETHER		(1 << 18)
+#  define RX_MII_ERROR		(1 << 19)
+#  define RX_DRIBBLING		(1 << 20)
+#  define RX_CRC_ERROR		(1 << 21)
+#  define RX_VLAN1		(1 << 22)
+#  define RX_VLAN2		(1 << 23)
+#  define RX_LEN_ERROR		(1 << 24)
+#  define RX_CNTRL_FRAME	(1 << 25)
+#  define RX_U_CNTRL_FRAME	(1 << 26)
+#  define RX_MCAST_FRAME	(1 << 27)
+#  define RX_BCAST_FRAME	(1 << 28)
+#  define RX_FILTER_FAIL	(1 << 29)
+#  define RX_PACKET_FILTER	(1 << 30)
+#  define RX_MISSED_FRAME	(1 << 31)
+
+#  define RX_ERROR (RX_WDOG_TIMER | RX_RUNT | RX_OVERLEN |  \
+		    RX_COLL | RX_MII_ERROR | RX_CRC_ERROR | \
+		    RX_LEN_ERROR | RX_U_CNTRL_FRAME | RX_MISSED_FRAME)
+#define MAC_RX_BUFF0_ADDR	0x4
+#  define RX_DMA_ENABLE		(1 << 0)
+#  define RX_T_DONE		(1 << 1)
+#  define RX_GET_DMA_BUFFER(X)	(((X) >> 2) & 0x3)
+#  define RX_SET_BUFF_ADDR(X)	((X) & 0xffffffc0)
+#define MAC_RX_BUFF1_STATUS	0x10
+#define MAC_RX_BUFF1_ADDR	0x14
+#define MAC_RX_BUFF2_STATUS	0x20
+#define MAC_RX_BUFF2_ADDR	0x24
+#define MAC_RX_BUFF3_STATUS	0x30
+#define MAC_RX_BUFF3_ADDR	0x34
+
 /*
  * Theory of operation
  *
-- 
2.0.1
