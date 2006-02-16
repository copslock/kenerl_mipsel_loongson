Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2006 22:57:42 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:26634 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133520AbWBPW5c (ORCPT <rfc822;linux-mips@www.linux-mips.org>);
	Thu, 16 Feb 2006 22:57:32 +0000
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Thu, 16 Feb 2006 15:03:57 -0800
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 595B52B0; Thu, 16 Feb 2006 15:03:47 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 2352E2AE for
 <linux-mips@www.linux-mips.org>; Thu, 16 Feb 2006 15:03:47 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id CYD21449; Thu, 16 Feb 2006 15:03:46 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 C278120501 for <linux-mips@www.linux-mips.org>; Thu, 16 Feb 2006
 15:03:46 -0800 (PST)
Received: from localhost.localdomain ([10.136.253.1]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 16 Feb 2006 15:03:46 -0800
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by localhost.localdomain (8.13.4/8.13.4) with ESMTP id k1GN3Kun011998
 for <linux-mips@www.linux-mips.org>; Thu, 16 Feb 2006 15:03:24 -0800
Received: (from mason@localhost) by localhost.localdomain (
 8.13.4/8.13.4/Submit) id k1GN34KT011995 for
 linux-mips@www.linux-mips.org; Thu, 16 Feb 2006 15:03:04 -0800
Date:	Thu, 16 Feb 2006 15:03:04 -0800
From:	"Mark Mason" <mason@broadcom.com>
To:	linux-mips@www.linux-mips.org
Subject: Patches for BCM1250/BCM1480 header files.
Message-ID: <20060216230304.GA11952@localhost.localdomain>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 16 Feb 2006 23:03:46.0583 (UTC)
 FILETIME=[3D9CEA70:01C6334D]
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006021609; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230372E34334635303243332E303035312D412D;
 ENG=IBF; TS=20060216230400; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006021609_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FEBDB5710G11239986-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@www.linux-mips.org
Original-Recipient: rfc822;linux-mips@www.linux-mips.org
X-archive-position: 10479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello all,

The following patch makes some minor feature updates to the BCM1250/BCM1480
header files.

Please apply.

Thanks,
Mark

Signed-off-by: Mark Mason <mason@broadcom.com>

diff --git a/include/asm-mips/sibyte/bcm1480_mc.h b/include/asm-mips/sibyte/bcm1480_mc.h
index 6bdc941..262690b 100644
--- a/include/asm-mips/sibyte/bcm1480_mc.h
+++ b/include/asm-mips/sibyte/bcm1480_mc.h
@@ -410,7 +410,9 @@
 
 #if SIBYTE_HDR_FEATURE(1480, PASS2)
 #define K_BCM1480_MC_DRAM_TYPE_DDR2	    2
-#endif
+#endif			
+
+#define K_BCM1480_MC_DRAM_TYPE_DDR2_PASS1   4	
 
 #define V_BCM1480_MC_DRAM_TYPE_JEDEC        V_BCM1480_MC_DRAM_TYPE(K_BCM1480_MC_DRAM_TYPE_JEDEC)
 #define V_BCM1480_MC_DRAM_TYPE_FCRAM        V_BCM1480_MC_DRAM_TYPE(K_BCM1480_MC_DRAM_TYPE_FCRAM)
@@ -511,6 +513,22 @@
 #define M_BCM1480_MC_WR_ODT6_CS6	    _SB_MAKEMASK1(31)
 
 #define M_BCM1480_MC_CS_ODD_ODT_EN	    _SB_MAKEMASK1(32)
+
+#define S_BCM1480_MC_ODT0	            0
+#define M_BCM1480_MC_ODT0		    _SB_MAKEMASK(8,S_BCM1480_MC_ODT0)
+#define V_BCM1480_MC_ODT0(x)		    _SB_MAKEVALUE(x,S_BCM1480_MC_ODT0)
+		    
+#define S_BCM1480_MC_ODT2	            8
+#define M_BCM1480_MC_ODT2		    _SB_MAKEMASK(8,S_BCM1480_MC_ODT2)
+#define V_BCM1480_MC_ODT2(x)		    _SB_MAKEVALUE(x,S_BCM1480_MC_ODT2)
+
+#define S_BCM1480_MC_ODT4	            16
+#define M_BCM1480_MC_ODT4		    _SB_MAKEMASK(8,S_BCM1480_MC_ODT4)
+#define V_BCM1480_MC_ODT4(x)		    _SB_MAKEVALUE(x,S_BCM1480_MC_ODT4)
+
+#define S_BCM1480_MC_ODT6	            24
+#define M_BCM1480_MC_ODT6		    _SB_MAKEMASK(8,S_BCM1480_MC_ODT6)
+#define V_BCM1480_MC_ODT6(x)		    _SB_MAKEVALUE(x,S_BCM1480_MC_ODT6)
 #endif
 
 /*
diff --git a/include/asm-mips/sibyte/sb1250_mac.h b/include/asm-mips/sibyte/sb1250_mac.h
index adfc688..833c8b5 100644
--- a/include/asm-mips/sibyte/sb1250_mac.h
+++ b/include/asm-mips/sibyte/sb1250_mac.h
@@ -129,9 +129,9 @@
 #define M_MAC_BYPASS_16             _SB_MAKEMASK1(42)
 #define M_MAC_BYPASS_FCS_CHK	    _SB_MAKEMASK1(43)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_MAC_RX_CH_SEL_MSB	    _SB_MAKEMASK1(44)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480*/
 
 #if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_MAC_SPLIT_CH_SEL	    _SB_MAKEMASK1(45)
@@ -223,9 +223,9 @@
 /* XXX: Can't enable, as it has the same name as a pass2+ define below.  */
 /* #define M_MAC_TX_WR_THRSH           _SB_MAKEMASK(6,S_MAC_TX_WR_THRSH) */
 #endif /* up to 1250 PASS1 */
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_MAC_TX_WR_THRSH           _SB_MAKEMASK(7,S_MAC_TX_WR_THRSH)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 #define V_MAC_TX_WR_THRSH(x)        _SB_MAKEVALUE(x,S_MAC_TX_WR_THRSH)
 #define G_MAC_TX_WR_THRSH(x)        _SB_GETVALUE(x,S_MAC_TX_WR_THRSH,M_MAC_TX_WR_THRSH)
 
@@ -234,9 +234,9 @@
 /* XXX: Can't enable, as it has the same name as a pass2+ define below.  */
 /* #define M_MAC_TX_RD_THRSH           _SB_MAKEMASK(6,S_MAC_TX_RD_THRSH) */
 #endif /* up to 1250 PASS1 */
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_MAC_TX_RD_THRSH           _SB_MAKEMASK(7,S_MAC_TX_RD_THRSH)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 #define V_MAC_TX_RD_THRSH(x)        _SB_MAKEVALUE(x,S_MAC_TX_RD_THRSH)
 #define G_MAC_TX_RD_THRSH(x)        _SB_GETVALUE(x,S_MAC_TX_RD_THRSH,M_MAC_TX_RD_THRSH)
 
@@ -260,12 +260,12 @@
 #define V_MAC_RX_RL_THRSH(x)        _SB_MAKEVALUE(x,S_MAC_RX_RL_THRSH)
 #define G_MAC_RX_RL_THRSH(x)        _SB_GETVALUE(x,S_MAC_RX_RL_THRSH,M_MAC_RX_RL_THRSH)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define S_MAC_ENC_FC_THRSH           _SB_MAKE64(56)
 #define M_MAC_ENC_FC_THRSH           _SB_MAKEMASK(6,S_MAC_ENC_FC_THRSH)
 #define V_MAC_ENC_FC_THRSH(x)        _SB_MAKEVALUE(x,S_MAC_ENC_FC_THRSH)
 #define G_MAC_ENC_FC_THRSH(x)        _SB_GETVALUE(x,S_MAC_ENC_FC_THRSH,M_MAC_ENC_FC_THRSH)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
 /*
  * MAC Frame Configuration Registers (Table 9-15)
@@ -462,9 +462,9 @@
 #define M_MAC_LTCOL_ERR             _SB_MAKEMASK1(44)
 #define M_MAC_EXCOL_ERR             _SB_MAKEMASK1(45)
 #define M_MAC_CNTR_OVRFL_ERR        _SB_MAKEMASK1(46)
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_MAC_SPLIT_EN		    _SB_MAKEMASK1(47) 	/* interrupt mask only */
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
 #define S_MAC_COUNTER_ADDR          _SB_MAKE64(47)
 #define M_MAC_COUNTER_ADDR          _SB_MAKEMASK(5,S_MAC_COUNTER_ADDR)
@@ -598,9 +598,9 @@
 #define M_MAC_MCAST_INV         _SB_MAKEMASK1(4)
 #define M_MAC_BCAST_EN          _SB_MAKEMASK1(5)
 #define M_MAC_DIRECT_INV        _SB_MAKEMASK1(6)
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_MAC_ALLMCAST_EN	_SB_MAKEMASK1(7)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
 #define S_MAC_IPHDR_OFFSET      _SB_MAKE64(8)
 #define M_MAC_IPHDR_OFFSET      _SB_MAKEMASK(8,S_MAC_IPHDR_OFFSET)
diff --git a/include/asm-mips/sibyte/sb1250_regs.h b/include/asm-mips/sibyte/sb1250_regs.h
index bab3a45..ace20d0 100644
--- a/include/asm-mips/sibyte/sb1250_regs.h
+++ b/include/asm-mips/sibyte/sb1250_regs.h
@@ -243,10 +243,10 @@
 #define R_MAC_ADFILTER_CFG              0x00000200
 #define R_MAC_ETHERNET_ADDR             0x00000208
 #define R_MAC_PKT_TYPE                  0x00000210
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define R_MAC_ADMASK0			0x00000218
 #define R_MAC_ADMASK1			0x00000220
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 #define R_MAC_HASH_BASE                 0x00000240
 #define R_MAC_ADDR_BASE                 0x00000280
 #define R_MAC_CHLO0_BASE                0x00000300
@@ -256,9 +256,9 @@
 #define R_MAC_INT_MASK                  0x00000410
 #define R_MAC_TXD_CTL                   0x00000420
 #define R_MAC_MDIO                      0x00000428
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define R_MAC_STATUS1		        0x00000430
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 #define R_MAC_DEBUG_STATUS              0x00000448
 
 #define MAC_HASH_COUNT			8
@@ -289,11 +289,11 @@
 #define R_DUART_RX_HOLD             0x160
 #define R_DUART_TX_HOLD             0x170
 
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define R_DUART_FULL_CTL	    0x140
 #define R_DUART_OPCR_X		    0x180
 #define R_DUART_AUXCTL_X	    0x190
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480*/
 
 
 /*
