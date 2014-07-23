Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:39:11 +0200 (CEST)
Received: from mail-we0-f182.google.com ([74.125.82.182]:58211 "EHLO
        mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6837945AbaGWOg5BDNGW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:36:57 +0200
Received: by mail-we0-f182.google.com with SMTP id k48so1284625wev.13
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DKE/1ARJe/vTXvRN84i2lvBcfHuQvfj1x0VqhCxUEaA=;
        b=XmFGL0PRrRegNMdDnLXd5I8lkDJb4p74+D6k1m7l9eHjr195Of39LS2lTJ7Lkwa0AT
         MX/Ppw5lbMR86EVhjOpbjhuW3B+OQqrmncJiUd1T0s+uvHblSo8KyTZMjthSaKubcU2G
         Z7wmlRj7MeQCRXluMIohzg5t5WeHP5ij4/OIQ/IPbIN/PbFpK+8l79kVLhCiTnfVRZhq
         TD6CUlysYl67Pc7GZnnuR+YlgHLDo1pK4Wl6DStiXo9LZUSycvNtHoA71N0v8sciPfT1
         2PaoAhrGnVwJdSzZyclQQPvGOYXRu/+zopky8dEk/diexSp8FnXVPkxE4vFV4SDoLiqG
         pHRA==
X-Received: by 10.181.11.232 with SMTP id el8mr3676695wid.57.1406126202804;
        Wed, 23 Jul 2014 07:36:42 -0700 (PDT)
Received: from localhost.localdomain (p57A349C7.dip0.t-ipconnect.de. [87.163.73.199])
        by mx.google.com with ESMTPSA id h3sm6717751wjz.48.2014.07.23.07.36.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 07:36:42 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/6] MIPS: Alchemy: au1000.h: remove unused register definitions
Date:   Wed, 23 Jul 2014 16:36:21 +0200
Message-Id: <1406126186-471228-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1406126186-471228-1-git-send-email-manuel.lauss@gmail.com>
References: <1406126186-471228-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41532
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

remove the unused SSI I2S and AC97C register definitions.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/include/asm/mach-au1x00/au1000.h | 157 -----------------------------
 1 file changed, 157 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index b4c3ecb..60754fc 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -1003,38 +1003,6 @@ enum soc_au1200_ints {
 #define SYS_RTCMATCH2		(SYS_BASE + 0x54)
 #define SYS_RTCREAD		(SYS_BASE + 0x58)
 
-/* I2S Controller */
-#define I2S_DATA		0xB1000000
-#  define I2S_DATA_MASK		0xffffff
-#define I2S_CONFIG		0xB1000004
-#  define I2S_CONFIG_XU		(1 << 25)
-#  define I2S_CONFIG_XO		(1 << 24)
-#  define I2S_CONFIG_RU		(1 << 23)
-#  define I2S_CONFIG_RO		(1 << 22)
-#  define I2S_CONFIG_TR		(1 << 21)
-#  define I2S_CONFIG_TE		(1 << 20)
-#  define I2S_CONFIG_TF		(1 << 19)
-#  define I2S_CONFIG_RR		(1 << 18)
-#  define I2S_CONFIG_RE		(1 << 17)
-#  define I2S_CONFIG_RF		(1 << 16)
-#  define I2S_CONFIG_PD		(1 << 11)
-#  define I2S_CONFIG_LB		(1 << 10)
-#  define I2S_CONFIG_IC		(1 << 9)
-#  define I2S_CONFIG_FM_BIT	7
-#  define I2S_CONFIG_FM_MASK	(0x3 << I2S_CONFIG_FM_BIT)
-#    define I2S_CONFIG_FM_I2S	(0x0 << I2S_CONFIG_FM_BIT)
-#    define I2S_CONFIG_FM_LJ	(0x1 << I2S_CONFIG_FM_BIT)
-#    define I2S_CONFIG_FM_RJ	(0x2 << I2S_CONFIG_FM_BIT)
-#  define I2S_CONFIG_TN		(1 << 6)
-#  define I2S_CONFIG_RN		(1 << 5)
-#  define I2S_CONFIG_SZ_BIT	0
-#  define I2S_CONFIG_SZ_MASK	(0x1F << I2S_CONFIG_SZ_BIT)
-
-#define I2S_CONTROL		0xB1000008
-#  define I2S_CONTROL_D		(1 << 1)
-#  define I2S_CONTROL_CE	(1 << 0)
-
-
 /* Ethernet Controllers  */
 
 /* 4 byte offsets from AU1000_ETH_BASE */
@@ -1161,100 +1129,6 @@ enum soc_au1200_ints {
 #define MAC_RX_BUFF3_STATUS	0x30
 #define MAC_RX_BUFF3_ADDR	0x34
 
-/* SSIO */
-#define SSI0_STATUS		0xB1600000
-#  define SSI_STATUS_BF		(1 << 4)
-#  define SSI_STATUS_OF		(1 << 3)
-#  define SSI_STATUS_UF		(1 << 2)
-#  define SSI_STATUS_D		(1 << 1)
-#  define SSI_STATUS_B		(1 << 0)
-#define SSI0_INT		0xB1600004
-#  define SSI_INT_OI		(1 << 3)
-#  define SSI_INT_UI		(1 << 2)
-#  define SSI_INT_DI		(1 << 1)
-#define SSI0_INT_ENABLE		0xB1600008
-#  define SSI_INTE_OIE		(1 << 3)
-#  define SSI_INTE_UIE		(1 << 2)
-#  define SSI_INTE_DIE		(1 << 1)
-#define SSI0_CONFIG		0xB1600020
-#  define SSI_CONFIG_AO		(1 << 24)
-#  define SSI_CONFIG_DO		(1 << 23)
-#  define SSI_CONFIG_ALEN_BIT	20
-#  define SSI_CONFIG_ALEN_MASK	(0x7 << 20)
-#  define SSI_CONFIG_DLEN_BIT	16
-#  define SSI_CONFIG_DLEN_MASK	(0x7 << 16)
-#  define SSI_CONFIG_DD		(1 << 11)
-#  define SSI_CONFIG_AD		(1 << 10)
-#  define SSI_CONFIG_BM_BIT	8
-#  define SSI_CONFIG_BM_MASK	(0x3 << 8)
-#  define SSI_CONFIG_CE		(1 << 7)
-#  define SSI_CONFIG_DP		(1 << 6)
-#  define SSI_CONFIG_DL		(1 << 5)
-#  define SSI_CONFIG_EP		(1 << 4)
-#define SSI0_ADATA		0xB1600024
-#  define SSI_AD_D		(1 << 24)
-#  define SSI_AD_ADDR_BIT	16
-#  define SSI_AD_ADDR_MASK	(0xff << 16)
-#  define SSI_AD_DATA_BIT	0
-#  define SSI_AD_DATA_MASK	(0xfff << 0)
-#define SSI0_CLKDIV		0xB1600028
-#define SSI0_CONTROL		0xB1600100
-#  define SSI_CONTROL_CD	(1 << 1)
-#  define SSI_CONTROL_E		(1 << 0)
-
-/* SSI1 */
-#define SSI1_STATUS		0xB1680000
-#define SSI1_INT		0xB1680004
-#define SSI1_INT_ENABLE		0xB1680008
-#define SSI1_CONFIG		0xB1680020
-#define SSI1_ADATA		0xB1680024
-#define SSI1_CLKDIV		0xB1680028
-#define SSI1_ENABLE		0xB1680100
-
-/*
- * Register content definitions
- */
-#define SSI_STATUS_BF		(1 << 4)
-#define SSI_STATUS_OF		(1 << 3)
-#define SSI_STATUS_UF		(1 << 2)
-#define SSI_STATUS_D		(1 << 1)
-#define SSI_STATUS_B		(1 << 0)
-
-/* SSI_INT */
-#define SSI_INT_OI		(1 << 3)
-#define SSI_INT_UI		(1 << 2)
-#define SSI_INT_DI		(1 << 1)
-
-/* SSI_INTEN */
-#define SSI_INTEN_OIE		(1 << 3)
-#define SSI_INTEN_UIE		(1 << 2)
-#define SSI_INTEN_DIE		(1 << 1)
-
-#define SSI_CONFIG_AO		(1 << 24)
-#define SSI_CONFIG_DO		(1 << 23)
-#define SSI_CONFIG_ALEN		(7 << 20)
-#define SSI_CONFIG_DLEN		(15 << 16)
-#define SSI_CONFIG_DD		(1 << 11)
-#define SSI_CONFIG_AD		(1 << 10)
-#define SSI_CONFIG_BM		(3 << 8)
-#define SSI_CONFIG_CE		(1 << 7)
-#define SSI_CONFIG_DP		(1 << 6)
-#define SSI_CONFIG_DL		(1 << 5)
-#define SSI_CONFIG_EP		(1 << 4)
-#define SSI_CONFIG_ALEN_N(N)	((N-1) << 20)
-#define SSI_CONFIG_DLEN_N(N)	((N-1) << 16)
-#define SSI_CONFIG_BM_HI	(0 << 8)
-#define SSI_CONFIG_BM_LO	(1 << 8)
-#define SSI_CONFIG_BM_CY	(2 << 8)
-
-#define SSI_ADATA_D		(1 << 24)
-#define SSI_ADATA_ADDR		(0xFF << 16)
-#define SSI_ADATA_DATA		0x0FFF
-#define SSI_ADATA_ADDR_N(N)	(N << 16)
-
-#define SSI_ENABLE_CD		(1 << 1)
-#define SSI_ENABLE_E		(1 << 0)
-
 
 /*
  * The IrDA peripheral has an IRFIRSEL pin, but on the DB/PB boards it's not
@@ -1424,37 +1298,6 @@ struct au1k_irda_platform_data {
 #define SYS_CPUPLL		0xB1900060
 #define SYS_AUXPLL		0xB1900064
 
-/* AC97 Controller */
-#define AC97C_CONFIG		0xB0000000
-#  define AC97C_RECV_SLOTS_BIT	13
-#  define AC97C_RECV_SLOTS_MASK (0x3ff << AC97C_RECV_SLOTS_BIT)
-#  define AC97C_XMIT_SLOTS_BIT	3
-#  define AC97C_XMIT_SLOTS_MASK (0x3ff << AC97C_XMIT_SLOTS_BIT)
-#  define AC97C_SG		(1 << 2)
-#  define AC97C_SYNC		(1 << 1)
-#  define AC97C_RESET		(1 << 0)
-#define AC97C_STATUS		0xB0000004
-#  define AC97C_XU		(1 << 11)
-#  define AC97C_XO		(1 << 10)
-#  define AC97C_RU		(1 << 9)
-#  define AC97C_RO		(1 << 8)
-#  define AC97C_READY		(1 << 7)
-#  define AC97C_CP		(1 << 6)
-#  define AC97C_TR		(1 << 5)
-#  define AC97C_TE		(1 << 4)
-#  define AC97C_TF		(1 << 3)
-#  define AC97C_RR		(1 << 2)
-#  define AC97C_RE		(1 << 1)
-#  define AC97C_RF		(1 << 0)
-#define AC97C_DATA		0xB0000008
-#define AC97C_CMD		0xB000000C
-#  define AC97C_WD_BIT		16
-#  define AC97C_READ		(1 << 7)
-#  define AC97C_INDEX_MASK	0x7f
-#define AC97C_CNTRL		0xB0000010
-#  define AC97C_RS		(1 << 1)
-#  define AC97C_CE		(1 << 0)
-
 
 /* The PCI chip selects are outside the 32bit space, and since we can't
  * just program the 36bit addresses into BARs, we have to take a chunk
-- 
2.0.1
