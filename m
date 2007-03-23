Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 20:25:08 +0000 (GMT)
Received: from mms3.broadcom.com ([216.31.210.19]:28933 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20021649AbXCWUZF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 20:25:05 +0000
Received: from [10.10.64.154] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.1)); Fri, 23 Mar 2007 13:24:25 -0700
X-Server-Uuid: 20144BB6-FB76-4F11-80B6-E6B2900CA0D7
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 1D8E02B1; Fri, 23 Mar 2007 13:24:25 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 0799A2B0 for
 <linux-mips@linux-mips.org>; Fri, 23 Mar 2007 13:24:25 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id FCI58463; Fri, 23 Mar 2007 13:24:24 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 A851320501 for <linux-mips@linux-mips.org>; Fri, 23 Mar 2007 13:24:24
 -0700 (PDT)
Received: from localhost.localdomain ([10.240.253.47]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Fri, 23 Mar 2007 13:24:24 -0700
Received: from mason by localhost.localdomain with local (Exim 4.50) id
 1HUqIp-0000XI-Fr; Fri, 23 Mar 2007 13:23:59 -0700
Date:	Fri, 23 Mar 2007 13:23:55 -0700
From:	"Mark Mason" <mason@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Update sibyte header files
Message-ID: <20070323202355.GA2058@broadcom.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 23 Mar 2007 20:24:24.0230 (UTC)
 FILETIME=[3F3DA460:01C76D89]
X-WSS-ID: 6A1AE8F338G7769361-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips


Patch to update sibyte header files to match master versions maintained
at Broadcom.  This patch also corrects some whitespace problems, and
(hopefully) shouldn't introduce any new ones.

Signed-off-by: Mark Mason <mason@broadcom.com>

diff --git a/include/asm-mips/sibyte/bcm1480_int.h b/include/asm-mips/sibyte/bcm1480_int.h
index 42d4cf0..c0d5206 100644
--- a/include/asm-mips/sibyte/bcm1480_int.h
+++ b/include/asm-mips/sibyte/bcm1480_int.h
@@ -157,6 +157,7 @@ #define K_BCM1480_INT_GPIO_15           
  * Mask values for each interrupt
  */
 
+#define _BCM1480_INT_MASK(w,n)              _SB_MAKEMASK(w,((n) & 0x3F))
 #define _BCM1480_INT_MASK1(n)               _SB_MAKEMASK1(((n) & 0x3F))
 #define _BCM1480_INT_OFFSET(n)              (((n) & 0x40) << 6)
 
@@ -195,6 +196,7 @@ #define M_BCM1480_INT_PMI_LOW           
 #define M_BCM1480_INT_PMI_HIGH              _BCM1480_INT_MASK1(K_BCM1480_INT_PMI_HIGH)
 #define M_BCM1480_INT_PMO_LOW               _BCM1480_INT_MASK1(K_BCM1480_INT_PMO_LOW)
 #define M_BCM1480_INT_PMO_HIGH              _BCM1480_INT_MASK1(K_BCM1480_INT_PMO_HIGH)
+#define M_BCM1480_INT_MBOX_ALL              _BCM1480_INT_MASK(8,K_BCM1480_INT_MBOX_0_0)
 #define M_BCM1480_INT_MBOX_0_0              _BCM1480_INT_MASK1(K_BCM1480_INT_MBOX_0_0)
 #define M_BCM1480_INT_MBOX_0_1              _BCM1480_INT_MASK1(K_BCM1480_INT_MBOX_0_1)
 #define M_BCM1480_INT_MBOX_0_2              _BCM1480_INT_MASK1(K_BCM1480_INT_MBOX_0_2)
diff --git a/include/asm-mips/sibyte/bcm1480_mc.h b/include/asm-mips/sibyte/bcm1480_mc.h
index 6bdc941..a6a4374 100644
--- a/include/asm-mips/sibyte/bcm1480_mc.h
+++ b/include/asm-mips/sibyte/bcm1480_mc.h
@@ -382,6 +382,10 @@ #define M_BCM1480_MC_CS5                
 #define M_BCM1480_MC_CS6                    _SB_MAKEMASK1(10)
 #define M_BCM1480_MC_CS7                    _SB_MAKEMASK1(11)
 
+#define M_BCM1480_MC_CS                  _SB_MAKEMASK(8,S_BCM1480_MC_CS0)
+#define V_BCM1480_MC_CS(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_CS0)
+#define G_BCM1480_MC_CS(x)               _SB_GETVALUE(x,S_BCM1480_MC_CS0,M_BCM1480_MC_CS0)
+
 #define M_BCM1480_MC_CMD_ACTIVE             _SB_MAKEMASK1(16)
 
 /*
@@ -412,6 +416,8 @@ #if SIBYTE_HDR_FEATURE(1480, PASS2)
 #define K_BCM1480_MC_DRAM_TYPE_DDR2	    2
 #endif
 
+#define K_BCM1480_MC_DRAM_TYPE_DDR2_PASS1   0
+
 #define V_BCM1480_MC_DRAM_TYPE_JEDEC        V_BCM1480_MC_DRAM_TYPE(K_BCM1480_MC_DRAM_TYPE_JEDEC)
 #define V_BCM1480_MC_DRAM_TYPE_FCRAM        V_BCM1480_MC_DRAM_TYPE(K_BCM1480_MC_DRAM_TYPE_FCRAM)
 
@@ -511,6 +517,22 @@ #define M_BCM1480_MC_WR_ODT6_CS4	    _SB
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
@@ -588,11 +610,11 @@ #define	M_BCM1480_MC_DLL_REGBYPASS      
 #define	M_BCM1480_MC_DQO_SHIFT            _SB_MAKEMASK1(47)
 #endif
 
-#define S_BCM1480_MC_DLL_DEFAULT            48
-#define M_BCM1480_MC_DLL_DEFAULT            _SB_MAKEMASK(6,S_BCM1480_MC_DLL_DEFAULT)
-#define V_BCM1480_MC_DLL_DEFAULT(x)         _SB_MAKEVALUE(x,S_BCM1480_MC_DLL_DEFAULT)
-#define G_BCM1480_MC_DLL_DEFAULT(x)         _SB_GETVALUE(x,S_BCM1480_MC_DLL_DEFAULT,M_BCM1480_MC_DLL_DEFAULT)
-#define V_BCM1480_MC_DLL_DEFAULT_DEFAULT    V_BCM1480_MC_DLL_DEFAULT(0x10)
+#define S_BCM1480_MC_DLL_DEFAULT           48
+#define M_BCM1480_MC_DLL_DEFAULT           _SB_MAKEMASK(6,S_BCM1480_MC_DLL_DEFAULT)
+#define V_BCM1480_MC_DLL_DEFAULT(x)        _SB_MAKEVALUE(x,S_BCM1480_MC_DLL_DEFAULT)
+#define G_BCM1480_MC_DLL_DEFAULT(x)        _SB_GETVALUE(x,S_BCM1480_MC_DLL_DEFAULT,M_BCM1480_MC_DLL_DEFAULT)
+#define V_BCM1480_MC_DLL_DEFAULT_DEFAULT   V_BCM1480_MC_DLL_DEFAULT(0x10)
 
 #if SIBYTE_HDR_FEATURE(1480, PASS2)
 #define S_BCM1480_MC_DLL_REGCTRL	  54
diff --git a/include/asm-mips/sibyte/bcm1480_regs.h b/include/asm-mips/sibyte/bcm1480_regs.h
index c2dd2fe..bda391d 100644
--- a/include/asm-mips/sibyte/bcm1480_regs.h
+++ b/include/asm-mips/sibyte/bcm1480_regs.h
@@ -230,6 +230,7 @@ #define R_BCM1480_DUART_ISRREG(chan)	   
 
 #define A_BCM1480_DUART_IMRREG(chan)	    (A_BCM1480_DUART(chan) + R_BCM1480_DUART_IMRREG(chan))
 #define A_BCM1480_DUART_ISRREG(chan)	    (A_BCM1480_DUART(chan) + R_BCM1480_DUART_ISRREG(chan))
+#define A_BCM1480_DUART_IN_PORT(chan)       (A_BCM1480_DUART(chan) + R_DUART_INP_ORT)
 
 /*
  * These constants are the absolute addresses.
@@ -404,6 +405,21 @@ #define A_BCM1480_IMR_ALIAS_MAILBOX_REGI
 #define R_BCM1480_IMR_ALIAS_MAILBOX_0           0x0000		/* 0x0x0 */
 #define R_BCM1480_IMR_ALIAS_MAILBOX_0_SET       0x0008		/* 0x0x8 */
 
+/*
+ * these macros work together to build the address of a mailbox
+ * register, e.g., A_BCM1480_MAILBOX_REGISTER(0,R_BCM1480_IMR_MAILBOX_SET,2)
+ * for mbox_0_set_cpu2 returns 0x00100240C8
+ */
+#define R_BCM1480_IMR_MAILBOX_CPU         0x00
+#define R_BCM1480_IMR_MAILBOX_SET         0x08
+#define R_BCM1480_IMR_MAILBOX_CLR         0x10
+#define R_BCM1480_IMR_MAILBOX_NUM_SPACING 0x20
+#define A_BCM1480_MAILBOX_REGISTER(num,reg,cpu) \
+    (A_BCM1480_IMR_CPU0_BASE + \
+     (num * R_BCM1480_IMR_MAILBOX_NUM_SPACING) + \
+     (cpu * BCM1480_IMR_REGISTER_SPACING) + \
+     (R_BCM1480_IMR_MAILBOX_0_CPU + reg))
+
 /*  *********************************************************************
     * System Performance Counter Registers (Section 4.7)
     ********************************************************************* */
@@ -428,6 +444,10 @@ #define A_BCM1480_SCD_PERF_CNT_5        
 #define A_BCM1480_SCD_PERF_CNT_6            0x0010020500
 #define A_BCM1480_SCD_PERF_CNT_7            0x0010020508
 
+#define BCM1480_SCD_NUM_PERF_CNT 8
+#define BCM1480_SCD_PERF_CNT_SPACING 8
+#define A_BCM1480_SCD_PERF_CNT(n) (A_SCD_PERF_CNT_0+(n*BCM1480_SCD_PERF_CNT_SPACING))
+
 /*  *********************************************************************
     * System Bus Watcher Registers (Section 4.8)
     ********************************************************************* */
diff --git a/include/asm-mips/sibyte/bcm1480_scd.h b/include/asm-mips/sibyte/bcm1480_scd.h
index 648bed9..4141673 100644
--- a/include/asm-mips/sibyte/bcm1480_scd.h
+++ b/include/asm-mips/sibyte/bcm1480_scd.h
@@ -78,6 +78,7 @@ #define K_SYS_PART_BCM1480          0x14
 #define K_SYS_PART_BCM1280          0x1206
 #define K_SYS_PART_BCM1455          0x1407
 #define K_SYS_PART_BCM1255          0x1257
+#define K_SYS_PART_BCM1158          0x1156
 
 /*
  * Manufacturing Information Register (Table 14)
@@ -237,58 +238,38 @@ #define M_BCM1480_SCD_WDOG_HAS_RESET    
  * System Performance Counter Configuration Register (Table 31)
  * Register: PERF_CNT_CFG_0
  *
- * Since the clear/enable bits are moved compared to the
- * 1250 and there are more fields, this register will be BCM1480 specific.
+ * SPC_CFG_SRC[0-3] is the same as the 1250.
+ * SPC_CFG_SRC[4-7] only exist on the 1480
+ * The clear/enable bits are in different locations on the 1250 and 1480.
  */
 
-#define S_BCM1480_SPC_CFG_SRC0              0
-#define M_BCM1480_SPC_CFG_SRC0              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC0)
-#define V_BCM1480_SPC_CFG_SRC0(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC0)
-#define G_BCM1480_SPC_CFG_SRC0(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC0,M_BCM1480_SPC_CFG_SRC0)
-
-#define S_BCM1480_SPC_CFG_SRC1              8
-#define M_BCM1480_SPC_CFG_SRC1              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC1)
-#define V_BCM1480_SPC_CFG_SRC1(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC1)
-#define G_BCM1480_SPC_CFG_SRC1(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC1,M_BCM1480_SPC_CFG_SRC1)
-
-#define S_BCM1480_SPC_CFG_SRC2              16
-#define M_BCM1480_SPC_CFG_SRC2              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC2)
-#define V_BCM1480_SPC_CFG_SRC2(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC2)
-#define G_BCM1480_SPC_CFG_SRC2(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC2,M_BCM1480_SPC_CFG_SRC2)
-
-#define S_BCM1480_SPC_CFG_SRC3              24
-#define M_BCM1480_SPC_CFG_SRC3              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC3)
-#define V_BCM1480_SPC_CFG_SRC3(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC3)
-#define G_BCM1480_SPC_CFG_SRC3(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC3,M_BCM1480_SPC_CFG_SRC3)
-
-#define S_BCM1480_SPC_CFG_SRC4              32
-#define M_BCM1480_SPC_CFG_SRC4              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC4)
-#define V_BCM1480_SPC_CFG_SRC4(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC4)
-#define G_BCM1480_SPC_CFG_SRC4(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC4,M_BCM1480_SPC_CFG_SRC4)
-
-#define S_BCM1480_SPC_CFG_SRC5              40
-#define M_BCM1480_SPC_CFG_SRC5              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC5)
-#define V_BCM1480_SPC_CFG_SRC5(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC5)
-#define G_BCM1480_SPC_CFG_SRC5(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC5,M_BCM1480_SPC_CFG_SRC5)
-
-#define S_BCM1480_SPC_CFG_SRC6              48
-#define M_BCM1480_SPC_CFG_SRC6              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC6)
-#define V_BCM1480_SPC_CFG_SRC6(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC6)
-#define G_BCM1480_SPC_CFG_SRC6(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC6,M_BCM1480_SPC_CFG_SRC6)
-
-#define S_BCM1480_SPC_CFG_SRC7              56
-#define M_BCM1480_SPC_CFG_SRC7              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC7)
-#define V_BCM1480_SPC_CFG_SRC7(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC7)
-#define G_BCM1480_SPC_CFG_SRC7(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC7,M_BCM1480_SPC_CFG_SRC7)
+#define S_SPC_CFG_SRC4              32
+#define M_SPC_CFG_SRC4              _SB_MAKEMASK(8,S_SPC_CFG_SRC4)
+#define V_SPC_CFG_SRC4(x)           _SB_MAKEVALUE(x,S_SPC_CFG_SRC4)
+#define G_SPC_CFG_SRC4(x)           _SB_GETVALUE(x,S_SPC_CFG_SRC4,M_SPC_CFG_SRC4)
+
+#define S_SPC_CFG_SRC5              40
+#define M_SPC_CFG_SRC5              _SB_MAKEMASK(8,S_SPC_CFG_SRC5)
+#define V_SPC_CFG_SRC5(x)           _SB_MAKEVALUE(x,S_SPC_CFG_SRC5)
+#define G_SPC_CFG_SRC5(x)           _SB_GETVALUE(x,S_SPC_CFG_SRC5,M_SPC_CFG_SRC5)
+
+#define S_SPC_CFG_SRC6              48
+#define M_SPC_CFG_SRC6              _SB_MAKEMASK(8,S_SPC_CFG_SRC6)
+#define V_SPC_CFG_SRC6(x)           _SB_MAKEVALUE(x,S_SPC_CFG_SRC6)
+#define G_SPC_CFG_SRC6(x)           _SB_GETVALUE(x,S_SPC_CFG_SRC6,M_SPC_CFG_SRC6)
+
+#define S_SPC_CFG_SRC7              56
+#define M_SPC_CFG_SRC7              _SB_MAKEMASK(8,S_SPC_CFG_SRC7)
+#define V_SPC_CFG_SRC7(x)           _SB_MAKEVALUE(x,S_SPC_CFG_SRC7)
+#define G_SPC_CFG_SRC7(x)           _SB_GETVALUE(x,S_SPC_CFG_SRC7,M_SPC_CFG_SRC7)
 
 /*
  * System Performance Counter Control Register (Table 32)
  * Register: PERF_CNT_CFG_1
  * BCM1480 specific
  */
-
-#define M_BCM1480_SPC_CFG_CLEAR             _SB_MAKEMASK1(0)
-#define M_BCM1480_SPC_CFG_ENABLE            _SB_MAKEMASK1(1)
+#define M_BCM1480_SPC_CFG_CLEAR     _SB_MAKEMASK1(0)
+#define M_BCM1480_SPC_CFG_ENABLE    _SB_MAKEMASK1(1)
 
 /*
  * System Performance Counters (Table 33)
@@ -405,20 +386,10 @@ #define G_BCM1480_SCD_TRSEQ_SWFUNC(x)   
  * Trace Control Register (Table 49)
  * Register: TRACE_CFG
  *
- * Bits 0..8 are the same as the BCM1250, rest are different.
- * Entire register is redefined below.
+ * BCM1480 changes to this register (other than location of the CUR_ADDR field)
+ * are defined below.
  */
 
-#define M_BCM1480_SCD_TRACE_CFG_RESET       _SB_MAKEMASK1(0)
-#define M_BCM1480_SCD_TRACE_CFG_START_READ  _SB_MAKEMASK1(1)
-#define M_BCM1480_SCD_TRACE_CFG_START       _SB_MAKEMASK1(2)
-#define M_BCM1480_SCD_TRACE_CFG_STOP        _SB_MAKEMASK1(3)
-#define M_BCM1480_SCD_TRACE_CFG_FREEZE      _SB_MAKEMASK1(4)
-#define M_BCM1480_SCD_TRACE_CFG_FREEZE_FULL _SB_MAKEMASK1(5)
-#define M_BCM1480_SCD_TRACE_CFG_DEBUG_FULL  _SB_MAKEMASK1(6)
-#define M_BCM1480_SCD_TRACE_CFG_FULL        _SB_MAKEMASK1(7)
-#define M_BCM1480_SCD_TRACE_CFG_FORCE_CNT   _SB_MAKEMASK1(8)
-
 #define S_BCM1480_SCD_TRACE_CFG_MODE        16
 #define M_BCM1480_SCD_TRACE_CFG_MODE        _SB_MAKEMASK(2,S_BCM1480_SCD_TRACE_CFG_MODE)
 #define V_BCM1480_SCD_TRACE_CFG_MODE(x)     _SB_MAKEVALUE(x,S_BCM1480_SCD_TRACE_CFG_MODE)
@@ -428,9 +399,4 @@ #define K_BCM1480_SCD_TRACE_CFG_MODE_BLO
 #define K_BCM1480_SCD_TRACE_CFG_MODE_BYTEEN_INT	1
 #define K_BCM1480_SCD_TRACE_CFG_MODE_FLOW_ID	2
 
-#define S_BCM1480_SCD_TRACE_CFG_CUR_ADDR    24
-#define M_BCM1480_SCD_TRACE_CFG_CUR_ADDR    _SB_MAKEMASK(8,S_BCM1480_SCD_TRACE_CFG_CUR_ADDR)
-#define V_BCM1480_SCD_TRACE_CFG_CUR_ADDR(x) _SB_MAKEVALUE(x,S_BCM1480_SCD_TRACE_CFG_CUR_ADDR)
-#define G_BCM1480_SCD_TRACE_CFG_CUR_ADDR(x) _SB_GETVALUE(x,S_BCM1480_SCD_TRACE_CFG_CUR_ADDR,M_BCM1480_SCD_TRACE_CFG_CUR_ADDR)
-
 #endif /* _BCM1480_SCD_H */
diff --git a/include/asm-mips/sibyte/board.h b/include/asm-mips/sibyte/board.h
index 3dfe29e..73bce90 100644
--- a/include/asm-mips/sibyte/board.h
+++ b/include/asm-mips/sibyte/board.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2000, 2001, 2002, 2003 Broadcom Corporation
+ * Copyright (C) 2000,2001,2002,2003,2004 Broadcom Corporation
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -19,8 +19,8 @@
 #ifndef _SIBYTE_BOARD_H
 #define _SIBYTE_BOARD_H
 
-
 #if defined(CONFIG_SIBYTE_SWARM) || defined(CONFIG_SIBYTE_PTSWARM) || \
+    defined(CONFIG_SIBYTE_PT1120) || defined(CONFIG_SIBYTE_PT1125) || \
     defined(CONFIG_SIBYTE_CRHONE) || defined(CONFIG_SIBYTE_CRHINE) || \
     defined(CONFIG_SIBYTE_LITTLESUR)
 #include <asm/sibyte/swarm.h>
@@ -55,6 +55,16 @@ #else
 #define setleds(t0,t1,c0,c1,c2,c3)
 #endif /* LEDS_PHYS */
 
+#else
+
+void swarm_setup(void);
+
+#ifdef LEDS_PHYS
+extern void setleds(char *str);
+#else
+#define setleds(s) do { } while (0)
+#endif /* LEDS_PHYS */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _SIBYTE_BOARD_H */
diff --git a/include/asm-mips/sibyte/carmel.h b/include/asm-mips/sibyte/carmel.h
index 57c53e6..e691b6d 100644
--- a/include/asm-mips/sibyte/carmel.h
+++ b/include/asm-mips/sibyte/carmel.h
@@ -18,18 +18,17 @@
 #ifndef __ASM_SIBYTE_CARMEL_H
 #define __ASM_SIBYTE_CARMEL_H
 
-
 #include <asm/sibyte/sb1250.h>
 #include <asm/sibyte/sb1250_int.h>
 
 #define SIBYTE_BOARD_NAME "Carmel"
 
-#define GPIO_PHY_INTERRUPT      2
-#define GPIO_NONMASKABLE_INT    3
-#define GPIO_CF_INSERTED        6
-#define GPIO_MONTEREY_RESET     7
-#define GPIO_QUADUART_INT       8
-#define GPIO_CF_INT             9
+#define GPIO_PHY_INTERRUPT      2 
+#define GPIO_NONMASKABLE_INT    3 
+#define GPIO_CF_INSERTED        6 
+#define GPIO_MONTEREY_RESET     7 
+#define GPIO_QUADUART_INT       8 
+#define GPIO_CF_INT             9 
 #define GPIO_FPGA_CCLK          10
 #define GPIO_FPGA_DOUT          11
 #define GPIO_FPGA_DIN           12
diff --git a/include/asm-mips/sibyte/sb1250_int.h b/include/asm-mips/sibyte/sb1250_int.h
index 05c7b39..94e8299 100644
--- a/include/asm-mips/sibyte/sb1250_int.h
+++ b/include/asm-mips/sibyte/sb1250_int.h
@@ -45,8 +45,6 @@ #include "sb1250_defs.h"
  * First, the interrupt numbers.
  */
 
-#if SIBYTE_HDR_FEATURE_1250_112x
-
 #define K_INT_SOURCES               64
 
 #define K_INT_WATCHDOG_TIMER_0      0
@@ -152,6 +150,7 @@ #define M_INT_MBOX_0                _SB_
 #define M_INT_MBOX_1                _SB_MAKEMASK1(K_INT_MBOX_1)
 #define M_INT_MBOX_2                _SB_MAKEMASK1(K_INT_MBOX_2)
 #define M_INT_MBOX_3                _SB_MAKEMASK1(K_INT_MBOX_3)
+#define M_INT_MBOX_ALL              _SB_MAKEMASK(4,K_INT_MBOX_0)
 #if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
 #define M_INT_CYCLE_CP0_INT	    _SB_MAKEMASK1(K_INT_CYCLE_CP0_INT)
 #define M_INT_CYCLE_CP1_INT	    _SB_MAKEMASK1(K_INT_CYCLE_CP1_INT)
@@ -247,5 +246,3 @@ #define M_LDTVECT_RAISEMBOX             
 
 
 #endif	/* 1250/112x */
-
-#endif
diff --git a/include/asm-mips/sibyte/sb1250_mac.h b/include/asm-mips/sibyte/sb1250_mac.h
index adfc688..833c8b5 100644
--- a/include/asm-mips/sibyte/sb1250_mac.h
+++ b/include/asm-mips/sibyte/sb1250_mac.h
@@ -129,9 +129,9 @@ #define K_MAC_BYPASS_EOP            3
 #define M_MAC_BYPASS_16             _SB_MAKEMASK1(42)
 #define M_MAC_BYPASS_FCS_CHK	    _SB_MAKEMASK1(43)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_MAC_RX_CH_SEL_MSB	    _SB_MAKEMASK1(44)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480*/
 
 #if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_MAC_SPLIT_CH_SEL	    _SB_MAKEMASK1(45)
@@ -223,9 +223,9 @@ #if SIBYTE_HDR_FEATURE_UP_TO(1250, PASS1
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
 
@@ -234,9 +234,9 @@ #if SIBYTE_HDR_FEATURE_UP_TO(1250, PASS1
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
 
@@ -260,12 +260,12 @@ #define M_MAC_RX_RL_THRSH           _SB_
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
@@ -462,9 +462,9 @@ #define M_MAC_TX_OVRFL              _SB_
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
@@ -598,9 +598,9 @@ #define M_MAC_MCAST_EN          _SB_MAKE
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
diff --git a/include/asm-mips/sibyte/sb1250_mc.h b/include/asm-mips/sibyte/sb1250_mc.h
index 26e4214..4fe848f 100644
--- a/include/asm-mips/sibyte/sb1250_mc.h
+++ b/include/asm-mips/sibyte/sb1250_mc.h
@@ -295,7 +295,7 @@ #define M_MC_EXTERNALDECODE	    _SB_MAKE
 
 #if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
 #define M_MC_PRE_ON_A8              _SB_MAKEMASK1(36)
-#define M_MC_RAM_WITH_A13           _SB_MAKEMASK1(38)
+#define M_MC_RAM_WITH_A13           _SB_MAKEMASK1(37)
 #endif /* 1250 PASS3 || 112x PASS1 */
 
 
diff --git a/include/asm-mips/sibyte/sb1250_regs.h b/include/asm-mips/sibyte/sb1250_regs.h
index bab3a45..da7c188 100644
--- a/include/asm-mips/sibyte/sb1250_regs.h
+++ b/include/asm-mips/sibyte/sb1250_regs.h
@@ -131,6 +131,7 @@ #define A_L2_EEC_ADDRESS            A_L2
 
 #endif
 
+
 /*  *********************************************************************
     * PCI Interface Registers
     ********************************************************************* */
@@ -239,14 +240,14 @@ #define R_MAC_THRSH_CFG                 
 #define R_MAC_VLANTAG                   0x00000110
 #define R_MAC_FRAMECFG                  0x00000118
 #define R_MAC_EOPCNT                    0x00000120
-#define R_MAC_FIFO_PTRS                 0x00000130
+#define R_MAC_FIFO_PTRS                 0x00000128
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
@@ -256,9 +257,9 @@ #define R_MAC_STATUS                    
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
@@ -289,11 +290,11 @@ #define R_DUART_CMD                 0x15
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
@@ -308,6 +309,7 @@ #define R_DUART_ISR_B               0x34
 #define R_DUART_IMR_B               0x350
 #define R_DUART_OUT_PORT            0x360
 #define R_DUART_OPCR                0x370
+#define R_DUART_IN_PORT             0x380
 
 #define R_DUART_SET_OPR		    0x3B0
 #define R_DUART_CLEAR_OPR	    0x3C0
@@ -685,12 +687,17 @@ #if SIBYTE_HDR_FEATURE(1250, PASS2) || S
 #define A_ADDR_TRAP_REG_DEBUG	    0x0010020460
 #endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
+#define ADDR_TRAP_SPACING 8
+#define NUM_ADDR_TRAP 4
+#define A_ADDR_TRAP_UP(n) (A_ADDR_TRAP_UP_0 + ((n) * ADDR_TRAP_SPACING))
+#define A_ADDR_TRAP_DOWN(n) (A_ADDR_TRAP_DOWN_0 + ((n) * ADDR_TRAP_SPACING))
+#define A_ADDR_TRAP_CFG(n) (A_ADDR_TRAP_CFG_0 + ((n) * ADDR_TRAP_SPACING))
+
 
 /*  *********************************************************************
     * System Interrupt Mapper Registers
     ********************************************************************* */
 
-#if SIBYTE_HDR_FEATURE_1250_112x
 #define A_IMR_CPU0_BASE                 0x0010020000
 #define A_IMR_CPU1_BASE                 0x0010022000
 #define IMR_REGISTER_SPACING            0x2000
@@ -700,6 +707,7 @@ #define A_IMR_MAPPER(cpu) (A_IMR_CPU0_BA
 #define A_IMR_REGISTER(cpu,reg) (A_IMR_MAPPER(cpu)+(reg))
 
 #define R_IMR_INTERRUPT_DIAG            0x0010
+#define R_IMR_INTERRUPT_LDT             0x0018
 #define R_IMR_INTERRUPT_MASK            0x0028
 #define R_IMR_INTERRUPT_TRACE           0x0038
 #define R_IMR_INTERRUPT_SOURCE_STATUS   0x0040
@@ -715,7 +723,14 @@ #define R_IMR_INTERRUPT_STATUS_BASE     
 #define R_IMR_INTERRUPT_STATUS_COUNT    7
 #define R_IMR_INTERRUPT_MAP_BASE        0x0200
 #define R_IMR_INTERRUPT_MAP_COUNT       64
-#endif	/* 1250/112x */
+
+/*
+ * these macros work together to build the address of a mailbox
+ * register, e.g., A_MAILBOX_REGISTER(R_IMR_MAILBOX_SET_CPU,1)
+ * for mbox_0_set_cpu2 returns 0x00100240C8
+ */
+#define A_MAILBOX_REGISTER(reg,cpu) \
+    (A_IMR_CPU0_BASE + (cpu * IMR_REGISTER_SPACING) + reg)
 
 /*  *********************************************************************
     * System Performance Counter Registers
@@ -727,6 +742,10 @@ #define A_SCD_PERF_CNT_1            0x00
 #define A_SCD_PERF_CNT_2            0x00100204E0
 #define A_SCD_PERF_CNT_3            0x00100204E8
 
+#define SCD_NUM_PERF_CNT 4
+#define SCD_PERF_CNT_SPACING 8
+#define A_SCD_PERF_CNT(n) (A_SCD_PERF_CNT_0+(n*SCD_PERF_CNT_SPACING))
+
 /*  *********************************************************************
     * System Bus Watcher Registers
     ********************************************************************* */
@@ -772,6 +791,15 @@ #define A_SCD_TRACE_SEQUENCE_5      0x00
 #define A_SCD_TRACE_SEQUENCE_6      0x0010020A90
 #define A_SCD_TRACE_SEQUENCE_7      0x0010020A98
 
+#define TRACE_REGISTER_SPACING 8
+#define TRACE_NUM_REGISTERS    8
+#define A_SCD_TRACE_EVENT(n) (((n) & 4) ? \
+   (A_SCD_TRACE_EVENT_4 + (((n) & 3) * TRACE_REGISTER_SPACING)) : \
+   (A_SCD_TRACE_EVENT_0 + ((n) * TRACE_REGISTER_SPACING)))
+#define A_SCD_TRACE_SEQUENCE(n) (((n) & 4) ? \
+   (A_SCD_TRACE_SEQUENCE_4 + (((n) & 3) * TRACE_REGISTER_SPACING)) : \
+   (A_SCD_TRACE_SEQUENCE_0 + ((n) * TRACE_REGISTER_SPACING)))
+
 /*  *********************************************************************
     * System Generic DMA Registers
     ********************************************************************* */
diff --git a/include/asm-mips/sibyte/sb1250_scd.h b/include/asm-mips/sibyte/sb1250_scd.h
index 7ed0bb6..ba765a7 100644
--- a/include/asm-mips/sibyte/sb1250_scd.h
+++ b/include/asm-mips/sibyte/sb1250_scd.h
@@ -84,12 +84,13 @@ #define K_SYS_REVISION_BCM112x_A1	0x20
 #define K_SYS_REVISION_BCM112x_A2	0x21
 #define K_SYS_REVISION_BCM112x_A3	0x22
 #define K_SYS_REVISION_BCM112x_A4	0x23
+#define K_SYS_REVISION_BCM112x_B0	0x30
 
 #define K_SYS_REVISION_BCM1480_S0	0x01
 #define K_SYS_REVISION_BCM1480_A1	0x02
 #define K_SYS_REVISION_BCM1480_A2	0x03
 #define K_SYS_REVISION_BCM1480_A3	0x04
-#define K_SYS_REVISION_BCM1480_B0	0x11
+#define K_SYS_REVISION_BCM1480_B0       0x11
 
 /*Cache size - 23:20  of revision register*/
 #define S_SYS_L2C_SIZE            _SB_MAKE64(20)
@@ -149,7 +150,7 @@ #define K_SYS_SOC_TYPE_BCM1x55      0x7
  * (For the assembler version, sysrev and dest may be the same register.
  * Also, it clobbers AT.)
  */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define SYS_SOC_TYPE(dest, sysrev)					\
 	.set push ;							\
 	.set reorder ;							\
@@ -213,6 +214,7 @@ #define V_SYS_YPOS(x)             _SB_MA
 #define G_SYS_YPOS(x)             _SB_GETVALUE(x,S_SYS_YPOS,M_SYS_YPOS)
 #endif
 
+
 /*
  * System Config Register (Table 4-2)
  * Register: SCD_SYSTEM_CFG
@@ -359,13 +361,13 @@ #endif
  */
 
 #define V_SCD_TIMER_FREQ            1000000
-#define V_SCD_TIMER_WIDTH           23
 
 #define S_SCD_TIMER_INIT            0
-#define M_SCD_TIMER_INIT            _SB_MAKEMASK(V_SCD_TIMER_WIDTH,S_SCD_TIMER_INIT)
+#define M_SCD_TIMER_INIT            _SB_MAKEMASK(23,S_SCD_TIMER_INIT)
 #define V_SCD_TIMER_INIT(x)         _SB_MAKEVALUE(x,S_SCD_TIMER_INIT)
 #define G_SCD_TIMER_INIT(x)         _SB_GETVALUE(x,S_SCD_TIMER_INIT,M_SCD_TIMER_INIT)
 
+#define V_SCD_TIMER_WIDTH	    23
 #define S_SCD_TIMER_CNT             0
 #define M_SCD_TIMER_CNT             _SB_MAKEMASK(V_SCD_TIMER_WIDTH,S_SCD_TIMER_CNT)
 #define V_SCD_TIMER_CNT(x)         _SB_MAKEVALUE(x,S_SCD_TIMER_CNT)
@@ -379,7 +381,6 @@ #define M_SCD_TIMER_MODE_CONTINUOUS M_SC
  * System Performance Counters
  */
 
-#if SIBYTE_HDR_FEATURE_1250_112x
 #define S_SPC_CFG_SRC0            0
 #define M_SPC_CFG_SRC0            _SB_MAKEMASK(8,S_SPC_CFG_SRC0)
 #define V_SPC_CFG_SRC0(x)         _SB_MAKEVALUE(x,S_SPC_CFG_SRC0)
@@ -402,7 +403,6 @@ #define G_SPC_CFG_SRC3(x)         _SB_GE
 
 #define M_SPC_CFG_CLEAR		_SB_MAKEMASK1(32)
 #define M_SPC_CFG_ENABLE	_SB_MAKEMASK1(33)
-#endif
 
 
 /*
@@ -515,8 +515,6 @@ #endif	/* 1250/112x */
  * Trace Buffer Config register
  */
 
-#if SIBYTE_HDR_FEATURE_1250_112x
-
 #define M_SCD_TRACE_CFG_RESET           _SB_MAKEMASK1(0)
 #define M_SCD_TRACE_CFG_START_READ      _SB_MAKEMASK1(1)
 #define M_SCD_TRACE_CFG_START           _SB_MAKEMASK1(2)
@@ -525,17 +523,26 @@ #define M_SCD_TRACE_CFG_FREEZE          
 #define M_SCD_TRACE_CFG_FREEZE_FULL     _SB_MAKEMASK1(5)
 #define M_SCD_TRACE_CFG_DEBUG_FULL      _SB_MAKEMASK1(6)
 #define M_SCD_TRACE_CFG_FULL            _SB_MAKEMASK1(7)
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_SCD_TRACE_CFG_FORCECNT        _SB_MAKEMASK1(8)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
+/*
+ * This field is the same on the 1250/112x and 1480, just located in
+ * a slightly different place in the register.
+ */
+#if SIBYTE_HDR_FEATURE_1250_112x
 #define S_SCD_TRACE_CFG_CUR_ADDR        10
+#else
+#if SIBYTE_HDR_FEATURE_CHIP(1480)
+#define S_SCD_TRACE_CFG_CUR_ADDR        24
+#endif	/* 1480 */
+#endif  /* 1250/112x */
+
 #define M_SCD_TRACE_CFG_CUR_ADDR        _SB_MAKEMASK(8,S_SCD_TRACE_CFG_CUR_ADDR)
 #define V_SCD_TRACE_CFG_CUR_ADDR(x)     _SB_MAKEVALUE(x,S_SCD_TRACE_CFG_CUR_ADDR)
 #define G_SCD_TRACE_CFG_CUR_ADDR(x)     _SB_GETVALUE(x,S_SCD_TRACE_CFG_CUR_ADDR,M_SCD_TRACE_CFG_CUR_ADDR)
 
-#endif	/* 1250/112x */
-
 /*
  * Trace Event registers
  */
diff --git a/include/asm-mips/sibyte/swarm.h b/include/asm-mips/sibyte/swarm.h
index 86db37e..540865f 100644
--- a/include/asm-mips/sibyte/swarm.h
+++ b/include/asm-mips/sibyte/swarm.h
@@ -32,6 +32,18 @@ #define SIBYTE_HAVE_PCMCIA 1
 #define SIBYTE_HAVE_IDE    1
 #define SIBYTE_DEFAULT_CONSOLE "ttyS0,115200"
 #endif
+#ifdef CONFIG_SIBYTE_PT1120
+#define SIBYTE_BOARD_NAME "PT1120"
+#define SIBYTE_HAVE_PCMCIA 1
+#define SIBYTE_HAVE_IDE    1
+#define SIBYTE_DEFAULT_CONSOLE "ttyS0,115200"
+#endif
+#ifdef CONFIG_SIBYTE_PT1125
+#define SIBYTE_BOARD_NAME "PT1125"
+#define SIBYTE_HAVE_PCMCIA 1
+#define SIBYTE_HAVE_IDE    1
+#define SIBYTE_DEFAULT_CONSOLE "ttyS0,115200"
+#endif
 #ifdef CONFIG_SIBYTE_LITTLESUR
 #define SIBYTE_BOARD_NAME "BCM91250C2 (LittleSur)"
 #define SIBYTE_HAVE_PCMCIA 0
