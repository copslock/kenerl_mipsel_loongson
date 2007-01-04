Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jan 2007 19:51:50 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:61456 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S28578857AbXADTvo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Jan 2007 19:51:44 +0000
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.0)); Thu, 04 Jan 2007 11:51:25 -0800
X-Server-Uuid: D7CB97D3-6392-476F-BE46-AB3D6F515C9A
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 837632AF; Thu, 4 Jan 2007 11:51:25 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 57A622AE for
 <linux-mips@linux-mips.org>; Thu, 4 Jan 2007 11:51:25 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id ESL85375; Thu, 4 Jan 2007 11:51:24 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 8010E20501 for <linux-mips@linux-mips.org>; Thu, 4 Jan 2007 11:51:24
 -0800 (PST)
Received: from debian.broadcom.com ([10.240.253.68]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 4 Jan 2007 11:51:23 -0800
Received: from mason by debian.broadcom.com with local (Exim 4.50) id
 1H2Ybo-0000iE-NW for linux-mips@linux-mips.org; Thu, 04 Jan 2007
 11:50:40 -0800
Date:	Thu, 4 Jan 2007 11:50:40 -0800
To:	linux-mips@linux-mips.org
Subject: [PATCH] Sync up sibyte headers with master versions
Message-ID: <20070104195040.GA2732@broadcom.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.9i
From:	"mason" <mason@broadcom.com>
X-OriginalArrivalTime: 04 Jan 2007 19:51:23.0556 (UTC)
 FILETIME=[B6724640:01C73039]
X-WSS-ID: 698385373EK15940771-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

Below is a patch to sync up the sibyte-specific header files with the
master versions maintained here at Broadcom.  The master files get
edited directly, and then the derivitative versions for CFE, Linux, etc,
all get generated automatically with the appropriate license, etc.

Because these haven't been synced in a while, some of these are just
whitespace adjustments - please forgive those, but including them now
will make future sync-ups much easier.

The real changes are updates for the 1480 register defintions to support
Z-Bus tracing, and some of the newer MAC features, correcting a few
typos, and providing names for a few additional 11xx based boards.

These were tested against the 2.6.18-rc4 kernel, as the tip doesn't seem
to be working at the moment (ie. yesterday).

Thanks,
Mark

Signed-off-by: Mark Mason <mason@broadcom.com>


diff --git a/include/asm-mips/sibyte/bcm1480_int.h b/include/asm-mips/sibyte/bcm1480_int.h
index 42d4cf0..d8c7460 100644
--- a/include/asm-mips/sibyte/bcm1480_int.h
+++ b/include/asm-mips/sibyte/bcm1480_int.h
@@ -1,22 +1,22 @@
 /*  *********************************************************************
     *  BCM1280/BCM1480 Board Support Package
-    *
+    *  
     *  Interrupt Mapper definitions		File: bcm1480_int.h
-    *
+    *  
     *  This module contains constants for manipulating the
     *  BCM1255/BCM1280/BCM1455/BCM1480's interrupt mapper and
     *  definitions for the interrupt sources.
-    *
+    *  
     *  BCM1480 specification level: 1X55_1X80-UM100-D4 (11/24/03)
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -26,7 +26,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
@@ -51,9 +51,9 @@ #include "sb1250_defs.h"
  * register.
  */
 
-/*
+/* 
  * This entire file uses _BCM1480_ in all the symbols because it is
- * entirely BCM1480 specific.
+ * entirely BCM1480 specific.  
  */
 
 /*
diff --git a/include/asm-mips/sibyte/bcm1480_l2c.h b/include/asm-mips/sibyte/bcm1480_l2c.h
index 886b099..35c6721 100644
--- a/include/asm-mips/sibyte/bcm1480_l2c.h
+++ b/include/asm-mips/sibyte/bcm1480_l2c.h
@@ -1,21 +1,21 @@
 /*  *********************************************************************
     *  BCM1280/BCM1480 Board Support Package
-    *
+    *  
     *  L2 Cache constants and macros		File: bcm1480_l2c.h
-    *
+    *  
     *  This module contains constants useful for manipulating the
     *  level 2 cache.
-    *
+    *  
     *  BCM1400 specification level:  1280-UM100-D2 (11/14/03)
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -25,7 +25,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
diff --git a/include/asm-mips/sibyte/bcm1480_mc.h b/include/asm-mips/sibyte/bcm1480_mc.h
index 6bdc941..4e50cd4 100644
--- a/include/asm-mips/sibyte/bcm1480_mc.h
+++ b/include/asm-mips/sibyte/bcm1480_mc.h
@@ -1,21 +1,21 @@
 /*  *********************************************************************
     *  BCM1280/BCM1480 Board Support Package
-    *
-    *  Memory Controller constants              File: bcm1480_mc.h
-    *
+    *  
+    *  Memory Controller constants              File: bcm1480_mc.h       
+    *  
     *  This module contains constants and macros useful for
     *  programming the memory controller.
-    *
+    *  
     *  BCM1400 specification level:  1280-UM100-D1 (11/14/03 Review Copy)
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -25,7 +25,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
@@ -74,7 +74,7 @@ #define K_BCM1480_MC_CS0123_MODE	    0x0
 #define K_BCM1480_MC_CS0246_MODE	    0x55
 #define K_BCM1480_MC_CS0145_MODE	    0x33
 #define K_BCM1480_MC_CS0167_MODE	    0xC3
-#define K_BCM1480_MC_CSFULL_MODE	    0xFF
+#define K_BCM1480_MC_CSFULL_MODE	    0xFF	
 
 /*
  * Chip Select Start Address Register (Table 82)
@@ -207,7 +207,7 @@ #define M_BCM1480_MC_ROW14              
 #define V_BCM1480_MC_ROW14(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW14)
 #define G_BCM1480_MC_ROW14(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW14,M_BCM1480_MC_ROW14)
 
-#define K_BCM1480_MC_ROWX_BIT_SPACING  	    8
+#define K_BCM1480_MC_ROWX_BIT_SPACING  	    8			
 
 /*
  * Column Address Bit Select Register 0 (Table 86)
@@ -289,7 +289,7 @@ #define M_BCM1480_MC_COL14              
 #define V_BCM1480_MC_COL14(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL14)
 #define G_BCM1480_MC_COL14(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL14,M_BCM1480_MC_COL14)
 
-#define K_BCM1480_MC_COLX_BIT_SPACING  	    8
+#define K_BCM1480_MC_COLX_BIT_SPACING  	    8			
 
 /*
  * CS0 and CS1 Bank Address Bit Select Register (Table 88)
@@ -410,14 +410,16 @@ #define K_BCM1480_MC_DRAM_TYPE_FCRAM    
 
 #if SIBYTE_HDR_FEATURE(1480, PASS2)
 #define K_BCM1480_MC_DRAM_TYPE_DDR2	    2
-#endif
+#endif			
+
+#define K_BCM1480_MC_DRAM_TYPE_DDR2_PASS1   0	
 
 #define V_BCM1480_MC_DRAM_TYPE_JEDEC        V_BCM1480_MC_DRAM_TYPE(K_BCM1480_MC_DRAM_TYPE_JEDEC)
 #define V_BCM1480_MC_DRAM_TYPE_FCRAM        V_BCM1480_MC_DRAM_TYPE(K_BCM1480_MC_DRAM_TYPE_FCRAM)
 
 #if SIBYTE_HDR_FEATURE(1480, PASS2)
 #define V_BCM1480_MC_DRAM_TYPE_DDR2	    V_BCM1480_MC_DRAM_TYPE(K_BCM1480_MC_DRAM_TYPE_DDR2)
-#endif
+#endif 
 
 #define M_BCM1480_MC_GANGED                 _SB_MAKEMASK1(36)
 #define M_BCM1480_MC_BY9_INTF               _SB_MAKEMASK1(37)
@@ -438,10 +440,10 @@ #define V_BCM1480_MC_PG_POLICY_CAS_TIME_
 #if SIBYTE_HDR_FEATURE(1480, PASS2)
 #define M_BCM1480_MC_2T_CMD		    _SB_MAKEMASK1(42)
 #define M_BCM1480_MC_ECC_COR_DIS	    _SB_MAKEMASK1(43)
-#endif
+#endif	
 
 #define V_BCM1480_MC_DRAMMODE_DEFAULT	V_BCM1480_MC_EMODE_DEFAULT | V_BCM1480_MC_MODE_DEFAULT | V_BCM1480_MC_DRAM_TYPE_JEDEC | \
-                                V_BCM1480_MC_PG_POLICY(K_BCM1480_MC_PG_POLICY_CAS_TIME_CHK)
+                                V_BCM1480_MC_PG_POLICY(K_BCM1480_MC_PG_POLICY_CAS_TIME_CHK) 
 
 /*
  * Memory Clock Configuration Register (Table 92)
@@ -460,7 +462,7 @@ #define V_BCM1480_MC_REF_RATE(x)        
 #define G_BCM1480_MC_REF_RATE(x)            _SB_GETVALUE(x,S_BCM1480_MC_REF_RATE,M_BCM1480_MC_REF_RATE)
 
 #define K_BCM1480_MC_REF_RATE_100MHz        0x31
-#define K_BCM1480_MC_REF_RATE_200MHz        0x62
+#define K_BCM1480_MC_REF_RATE_200MHz        0x62 
 #define K_BCM1480_MC_REF_RATE_400MHz        0xC4
 
 #define V_BCM1480_MC_REF_RATE_100MHz        V_BCM1480_MC_REF_RATE(K_BCM1480_MC_REF_RATE_100MHz)
@@ -511,6 +513,22 @@ #define M_BCM1480_MC_WR_ODT6_CS4	    _SB
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
@@ -588,11 +606,11 @@ #define	M_BCM1480_MC_DLL_REGBYPASS      
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
index c2dd2fe..4aff386 100644
--- a/include/asm-mips/sibyte/bcm1480_regs.h
+++ b/include/asm-mips/sibyte/bcm1480_regs.h
@@ -2,20 +2,20 @@
     *  BCM1255/BCM1280/BCM1455/BCM1480 Board Support Package
     *
     *  Register Definitions                     File: bcm1480_regs.h
-    *
+    *  
     *  This module contains the addresses of the on-chip peripherals
     *  on the BCM1280 and BCM1480.
-    *
+    *  
     *  BCM1480 specification level:  1X55_1X80-UM100-D4 (11/24/03)
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -25,7 +25,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
@@ -44,7 +44,7 @@ #include "sb1250_regs.h"
 
 /*  *********************************************************************
     *  Some general notes:
-    *
+    *  
     *  Register addresses are grouped by function and follow the order
     *  of the User Manual.
     *
@@ -53,7 +53,7 @@ #include "sb1250_regs.h"
     *  offsets from the base of each peripheral.  For example,
     *  the MAC registers are described as offsets from the first
     *  MAC register, and there will be a MAC_REGISTER() macro
-    *  to calculate the base address of a given MAC.
+    *  to calculate the base address of a given MAC.  
     *
     *  The information in this file is based on the BCM1X55/BCM1X80
     *  User Manual, Document 1X55_1X80-UM100-R, 22/12/03.
@@ -62,21 +62,21 @@ #include "sb1250_regs.h"
     *  BCM1250 and the new BCM1480 (and derivatives) share many common
     *  features, this file contains only what's new or changed from
     *  the 1250.  (above, you can see that we include the 1250 symbols
-    *  to get the base functionality).
+    *  to get the base functionality).  
     *
-    *  In software, be sure to use the correct symbols, particularly
+    *  In software, be sure to use the correct symbols, particularly 
     *  for blocks that are different between the two chip families.
     *  All BCM1480-specific symbols have _BCM1480_ in their names,
-    *  and all BCM1250-specific and "base" functions that are common in
+    *  and all BCM1250-specific and "base" functions that are common in 
     *  both chips have no special names (this is for compatibility with
     *  older include files).  Therefore, if you're working with the
     *  SCD, which is very different on each chip, A_SCD_xxx implies
     *  the BCM1250 version and A_BCM1480_SCD_xxx implies the BCM1480
-    *  version.
+    *  version.  
     ********************************************************************* */
 
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * Memory Controller Registers (Section 6)
     ********************************************************************* */
 
@@ -136,7 +136,7 @@ #define A_BCM1480_MC_GLB_ECC_ADDR       
 #define A_BCM1480_MC_GLB_ECC_CORRECT        0x0010054180
 #define A_BCM1480_MC_GLB_PERF_CNT_CONTROL   0x00100541A0
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * L2 Cache Control Registers (Section 5)
     ********************************************************************* */
 
@@ -168,7 +168,7 @@ #define A_BCM1480_L2_BANK_ADDRESS(b)    
 #define A_BCM1480_L2_MGMT_TAG_BASE          0x00D0000000
 
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * PCI-X Interface Registers (Section 7)
     ********************************************************************* */
 
@@ -179,7 +179,7 @@ #define A_BCM1480_PCI_DLL               
 
 #define A_BCM1480_PCI_TYPE00_HEADER         0x002E000000
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * Ethernet MAC Registers (Section 11) and DMA Registers (Section 10.6)
     ********************************************************************* */
 
@@ -201,7 +201,7 @@ #define R_MAC_DMA_OODPKTLOST        R_BC
 #endif
 
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * DUART Registers (Section 14)
     ********************************************************************* */
 
@@ -274,14 +274,14 @@ #define A_BCM1480_DUART_INPORT_CHNG_C   
 #define A_BCM1480_DUART_INPORT_CHNG_D       0x00100606E0
 
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * Generic Bus Registers (Section 15) and PCMCIA Registers (Section 16)
     ********************************************************************* */
 
 #define A_BCM1480_IO_PCMCIA_CFG_B	0x0010061A58
 #define A_BCM1480_IO_PCMCIA_STATUS_B	0x0010061A68
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * GPIO Registers (Section 17)
     ********************************************************************* */
 
@@ -293,13 +293,13 @@ #define R_BCM1480_GPIO_INT_ADD_TYPE     
 #define A_GPIO_INT_ADD_TYPE	A_BCM1480_GPIO_INT_ADD_TYPE
 #define R_GPIO_INT_ADD_TYPE	R_BCM1480_GPIO_INT_ADD_TYPE
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * SMBus Registers (Section 18)
     ********************************************************************* */
 
 /* No changes from BCM1250 */
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * Timer Registers (Sections 4.6)
     ********************************************************************* */
 
@@ -332,7 +332,7 @@ #define A_BCM1480_SCD_ZBBUS_CYCLE_CP1   
 #define A_BCM1480_SCD_ZBBUS_CYCLE_CP2           0x0010020C10
 #define A_BCM1480_SCD_ZBBUS_CYCLE_CP3           0x0010020C18
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Control Registers (Section 4.2)
     ********************************************************************* */
 
@@ -340,13 +340,13 @@ #define A_BCM1480_SCD_ZBBUS_CYCLE_CP3   
 
 #define A_BCM1480_SCD_SCRATCH	 	0x100200A0
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Address Trap Registers (Section 4.9)
     ********************************************************************* */
 
 /* No changes from BCM1250 */
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Interrupt Mapper Registers (Sections 4.3-4.5)
     ********************************************************************* */
 
@@ -404,7 +404,7 @@ #define A_BCM1480_IMR_ALIAS_MAILBOX_REGI
 #define R_BCM1480_IMR_ALIAS_MAILBOX_0           0x0000		/* 0x0x0 */
 #define R_BCM1480_IMR_ALIAS_MAILBOX_0_SET       0x0008		/* 0x0x8 */
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Performance Counter Registers (Section 4.7)
     ********************************************************************* */
 
@@ -428,7 +428,7 @@ #define A_BCM1480_SCD_PERF_CNT_5        
 #define A_BCM1480_SCD_PERF_CNT_6            0x0010020500
 #define A_BCM1480_SCD_PERF_CNT_7            0x0010020508
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Bus Watcher Registers (Section 4.8)
     ********************************************************************* */
 
@@ -437,26 +437,26 @@ #define A_BCM1480_SCD_PERF_CNT_7        
 
 #define A_BCM1480_BUS_ERR_STATUS_DEBUG      0x00100208D8
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Debug Controller Registers (Section 19)
     ********************************************************************* */
 
 /* Same as 1250 */
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Trace Unit Registers (Sections 4.10)
     ********************************************************************* */
 
 /* Same as 1250 */
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * Data Mover DMA Registers (Section 10.7)
     ********************************************************************* */
 
 /* Same as 1250 */
 
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * HyperTransport Interface Registers (Section 8)
     ********************************************************************* */
 
@@ -470,7 +470,7 @@ #define A_BCM1480_HT_PORT2_HEADER       
 #define A_BCM1480_HT_TYPE00_HEADER         0x00FE002000
 
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * Node Controller Registers (Section 9)
     ********************************************************************* */
 
@@ -507,7 +507,7 @@ #define A_BCM1480_NC_SR_TIMEOUT_COUNTER 
 #define A_BCM1480_NC_SR_TIMEOUT_COUNTER_SEL 0x00DFBE0080
 
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * H&R Block Configuration Registers (Section 12.4)
     ********************************************************************* */
 
@@ -551,7 +551,7 @@ #define R_BCM1480_HR_RT_WORD(idx)       
 
 
 /* checked to here - ehs */
-/*  *********************************************************************
+/*  ********************************************************************* 
     * Packet Manager DMA Registers (Section 12.5)
     ********************************************************************* */
 
@@ -678,7 +678,7 @@ #define A_BCM1480_SWTRC_MATCH_TAG_MASK(x
 
 
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     *  High-Speed Port Registers (Section 13)
     ********************************************************************* */
 
diff --git a/include/asm-mips/sibyte/bcm1480_scd.h b/include/asm-mips/sibyte/bcm1480_scd.h
index 648bed9..1edde6e 100644
--- a/include/asm-mips/sibyte/bcm1480_scd.h
+++ b/include/asm-mips/sibyte/bcm1480_scd.h
@@ -1,21 +1,21 @@
 /*  *********************************************************************
     *  BCM1280/BCM1400 Board Support Package
-    *
+    *  
     *  SCD Constants and Macros                     File: bcm1480_scd.h
-    *
+    *  
     *  This module contains constants and macros useful for
     *  manipulating the System Control and Debug module.
-    *
+    *  
     *  BCM1400 specification level: 1X55_1X80-UM100-R (12/18/03)
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -25,7 +25,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
@@ -42,22 +42,22 @@ #include "sb1250_scd.h"
 
 /*  *********************************************************************
     *  Some general notes:
-    *
+    *  
     *  This file is basically a "what's new" header file.  Since the
     *  BCM1250 and the new BCM1480 (and derivatives) share many common
     *  features, this file contains only what's new or changed from
     *  the 1250.  (above, you can see that we include the 1250 symbols
-    *  to get the base functionality).
+    *  to get the base functionality).  
     *
-    *  In software, be sure to use the correct symbols, particularly
+    *  In software, be sure to use the correct symbols, particularly 
     *  for blocks that are different between the two chip families.
     *  All BCM1480-specific symbols have _BCM1480_ in their names,
-    *  and all BCM1250-specific and "base" functions that are common in
+    *  and all BCM1250-specific and "base" functions that are common in 
     *  both chips have no special names (this is for compatibility with
     *  older include files).  Therefore, if you're working with the
     *  SCD, which is very different on each chip, A_SCD_xxx implies
     *  the BCM1250 version and A_BCM1480_SCD_xxx implies the BCM1480
-    *  version.
+    *  version.  
     ********************************************************************* */
 
 /*  *********************************************************************
@@ -71,13 +71,14 @@ #include "sb1250_scd.h"
  */
 
 /*
- * New part definitions
+ * New part definitions 
  */
 
 #define K_SYS_PART_BCM1480          0x1406
 #define K_SYS_PART_BCM1280          0x1206
 #define K_SYS_PART_BCM1455          0x1407
 #define K_SYS_PART_BCM1255          0x1257
+#define K_SYS_PART_BCM1158          0x1156
 
 /*
  * Manufacturing Information Register (Table 14)
@@ -87,7 +88,7 @@ #define K_SYS_PART_BCM1255          0x12
 /*
  * System Configuration Register (Table 15)
  * Register: SCD_SYSTEM_CFG
- * Entire register is different from 1250, all new constants below
+ * Entire register is different from 1250, all new constants below 
  */
 
 #define M_BCM1480_SYS_RESERVED0             _SB_MAKEMASK1(0)
@@ -180,7 +181,7 @@ #define M_BCM1480_SYS_SW_FLAG           
 /*
  * Watchdog Timer Initial Count Registers (Table 23)
  * Registers: SCD_WDOG_INIT_CNT_x
- *
+ * 
  * The watchdogs are almost the same as the 1250, except
  * the configuration register has more bits to control the
  * other CPUs.
@@ -221,7 +222,7 @@ #define M_BCM1480_SCD_WDOG_HAS_RESET    
 /*
  * ZBbus Count Register (Table 29)
  * Register: ZBBUS_CYCLE_COUNT
- *
+ * 
  * Same as BCM1250
  */
 
@@ -237,49 +238,30 @@ #define M_BCM1480_SCD_WDOG_HAS_RESET    
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
@@ -287,8 +269,8 @@ #define G_BCM1480_SPC_CFG_SRC7(x)       
  * BCM1480 specific
  */
 
-#define M_BCM1480_SPC_CFG_CLEAR             _SB_MAKEMASK1(0)
-#define M_BCM1480_SPC_CFG_ENABLE            _SB_MAKEMASK1(1)
+#define M_SPC_CFG_CLEAR             _SB_MAKEMASK1(0)
+#define M_SPC_CFG_ENABLE            _SB_MAKEMASK1(1)
 
 /*
  * System Performance Counters (Table 33)
@@ -333,7 +315,7 @@ #define M_BCM1480_SPC_CNT_OFLOW         
  * Address Trap Registers
  *
  * Register layout same as BCM1250, almost.  The bus agents
- * are different, and the address trap configuration bits are
+ * are different, and the address trap configuration bits are 
  * slightly different.
  */
 
@@ -405,20 +387,10 @@ #define G_BCM1480_SCD_TRSEQ_SWFUNC(x)   
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
@@ -428,9 +400,4 @@ #define K_BCM1480_SCD_TRACE_CFG_MODE_BLO
 #define K_BCM1480_SCD_TRACE_CFG_MODE_BYTEEN_INT	1
 #define K_BCM1480_SCD_TRACE_CFG_MODE_FLOW_ID	2
 
-#define S_BCM1480_SCD_TRACE_CFG_CUR_ADDR    24
-#define M_BCM1480_SCD_TRACE_CFG_CUR_ADDR    _SB_MAKEMASK(8,S_BCM1480_SCD_TRACE_CFG_CUR_ADDR)
-#define V_BCM1480_SCD_TRACE_CFG_CUR_ADDR(x) _SB_MAKEVALUE(x,S_BCM1480_SCD_TRACE_CFG_CUR_ADDR)
-#define G_BCM1480_SCD_TRACE_CFG_CUR_ADDR(x) _SB_GETVALUE(x,S_BCM1480_SCD_TRACE_CFG_CUR_ADDR,M_BCM1480_SCD_TRACE_CFG_CUR_ADDR)
-
 #endif /* _BCM1480_SCD_H */
diff --git a/include/asm-mips/sibyte/bigsur.h b/include/asm-mips/sibyte/bigsur.h
index ebefe79..02b9123 100644
--- a/include/asm-mips/sibyte/bigsur.h
+++ b/include/asm-mips/sibyte/bigsur.h
@@ -22,7 +22,7 @@ #include <asm/sibyte/sb1250.h>
 #include <asm/sibyte/bcm1480_int.h>
 
 #ifdef CONFIG_SIBYTE_BIGSUR
-#define SIBYTE_BOARD_NAME "BCM91x80A/B (BigSur)"
+#define SIBYTE_BOARD_NAME "BCM91280A (BIGSUR)"
 #define SIBYTE_HAVE_PCMCIA 1
 #define SIBYTE_HAVE_IDE    1
 #endif
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
diff --git a/include/asm-mips/sibyte/sb1250_defs.h b/include/asm-mips/sibyte/sb1250_defs.h
index 335dbaf..f2e28e9 100644
--- a/include/asm-mips/sibyte/sb1250_defs.h
+++ b/include/asm-mips/sibyte/sb1250_defs.h
@@ -1,21 +1,21 @@
 /*  *********************************************************************
     *  SB1250 Board Support Package
-    *
-    *  Global constants and macros		File: sb1250_defs.h
-    *
+    *  
+    *  Global constants and macros		File: sb1250_defs.h	
+    *  
     *  This file contains macros and definitions used by the other
     *  include files.
     *
     *  SB1250 specification level:  User's manual 1/02/02
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -25,7 +25,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
@@ -107,7 +107,7 @@ #define SIBYTE_HDR_FMASK_1480_ALL		0x000
 #define SIBYTE_HDR_FMASK_1480_PASS1		0x00001000
 #define SIBYTE_HDR_FMASK_1480_PASS2		0x00002000
 
-/* Bit mask for chip/revision.  (use _ALL for all revisions of a chip).  */
+/* Bit mask for chip/revision.  (use _ALL for all revisions of a chip).  */ 
 #define	SIBYTE_HDR_FMASK(chip, pass)					\
     (SIBYTE_HDR_FMASK_ ## chip ## _ ## pass)
 #define	SIBYTE_HDR_FMASK_ALLREVS(chip)					\
@@ -167,31 +167,31 @@ #define SIBYTE_HDR_FEATURE_UP_TO(chip, p
 
 /*  *********************************************************************
     *  Naming schemes for constants in these files:
-    *
-    *  M_xxx           MASK constant (identifies bits in a register).
+    *  
+    *  M_xxx           MASK constant (identifies bits in a register). 
     *                  For multi-bit fields, all bits in the field will
     *                  be set.
     *
     *  K_xxx           "Code" constant (value for data in a multi-bit
     *                  field).  The value is right justified.
     *
-    *  V_xxx           "Value" constant.  This is the same as the
+    *  V_xxx           "Value" constant.  This is the same as the 
     *                  corresponding "K_xxx" constant, except it is
     *                  shifted to the correct position in the register.
     *
     *  S_xxx           SHIFT constant.  This is the number of bits that
-    *                  a field value (code) needs to be shifted
+    *                  a field value (code) needs to be shifted 
     *                  (towards the left) to put the value in the right
     *                  position for the register.
     *
-    *  A_xxx           ADDRESS constant.  This will be a physical
+    *  A_xxx           ADDRESS constant.  This will be a physical 
     *                  address.  Use the PHYS_TO_K1 macro to generate
     *                  a K1SEG address.
     *
     *  R_xxx           RELATIVE offset constant.  This is an offset from
     *                  an A_xxx constant (usually the first register in
     *                  a group).
-    *
+    *  
     *  G_xxx(X)        GET value.  This macro obtains a multi-bit field
     *                  from a register, masks it, and shifts it to
     *                  the bottom of the register (retrieving a K_xxx
@@ -206,7 +206,7 @@ #define SIBYTE_HDR_FEATURE_UP_TO(chip, p
 
 
 /*
- * Cast to 64-bit number.  Presumably the syntax is different in
+ * Cast to 64-bit number.  Presumably the syntax is different in 
  * assembly language.
  *
  * Note: you'll need to define uint32_t and uint64_t in your headers.
@@ -257,3 +257,4 @@ #define SBREADCSR(csr) (*((volatile uint
 #endif /* __ASSEMBLER__ */
 
 #endif
+
diff --git a/include/asm-mips/sibyte/sb1250_dma.h b/include/asm-mips/sibyte/sb1250_dma.h
index e6145f5..8c8892c 100644
--- a/include/asm-mips/sibyte/sb1250_dma.h
+++ b/include/asm-mips/sibyte/sb1250_dma.h
@@ -1,23 +1,23 @@
 /*  *********************************************************************
     *  SB1250 Board Support Package
-    *
+    *  
     *  DMA definitions				File: sb1250_dma.h
-    *
+    *  
     *  This module contains constants and macros useful for
     *  programming the SB1250's DMA controllers, both the data mover
     *  and the Ethernet DMA.
-    *
+    *  
     *  SB1250 specification level:  User's manual 10/21/02
     *  BCM1280 specification level: User's manual 11/24/03
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -27,7 +27,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
@@ -42,9 +42,9 @@ #include "sb1250_defs.h"
     *  DMA Registers
     ********************************************************************* */
 
-/*
+/* 
  * Ethernet and Serial DMA Configuration Register 0  (Table 7-4)
- * Registers: DMA_CONFIG0_MAC_x_RX_CH_0
+ * Registers: DMA_CONFIG0_MAC_x_RX_CH_0 
  * Registers: DMA_CONFIG0_MAC_x_TX_CH_0
  * Registers: DMA_CONFIG0_SER_x_RX
  * Registers: DMA_CONFIG0_SER_x_TX
@@ -97,7 +97,7 @@ #define G_DMA_LOW_WATERMARK(x)      _SB_
 
 /*
  * Ethernet and Serial DMA Configuration Register 1 (Table 7-5)
- * Registers: DMA_CONFIG1_MAC_x_RX_CH_0
+ * Registers: DMA_CONFIG1_MAC_x_RX_CH_0 
  * Registers: DMA_CONFIG1_DMA_x_TX_CH_0
  * Registers: DMA_CONFIG1_SER_x_RX
  * Registers: DMA_CONFIG1_SER_x_TX
@@ -151,11 +151,11 @@ #define M_DMA_ASIC_BASE_MBZ         _SB_
 /*
  * DMA Descriptor Count Registers (Table 7-8)
  */
-
+ 
 /* No bitfields */
 
 
-/*
+/* 
  * Current Descriptor Address Register (Table 7-11)
  */
 
@@ -274,7 +274,7 @@ #define M_DMA_DSCRB_STATUS          _SB_
 #define V_DMA_DSCRB_STATUS(x)       _SB_MAKEVALUE(x,S_DMA_DSCRB_STATUS)
 #define G_DMA_DSCRB_STATUS(x)       _SB_GETVALUE(x,S_DMA_DSCRB_STATUS,M_DMA_DSCRB_STATUS)
 
-/*
+/* 
  * Ethernet Descriptor Status Bits (Table 7-15)
  */
 
@@ -324,7 +324,7 @@ #define M_DMA_ETHRX_SOP             _SB_
 
 #define M_DMA_ETHTX_SOP	    	    _SB_MAKEMASK1(63)
 
-/*
+/* 
  * Ethernet Transmit Options (Table 7-17)
  */
 
@@ -377,7 +377,7 @@ #define K_DMA_SERTX_ABORT           _SB_
     *  Data Mover Registers
     ********************************************************************* */
 
-/*
+/* 
  * Data Mover Descriptor Base Address Register (Table 7-22)
  * Register: DM_DSCR_BASE_0
  * Register: DM_DSCR_BASE_1
@@ -414,7 +414,7 @@ #define M_DM_DSCR_BASE_ERROR        _SB_
 #define M_DM_DSCR_BASE_ABORT        _SB_MAKEMASK1(62)
 #define M_DM_DSCR_BASE_ENABL        _SB_MAKEMASK1(63)
 
-/*
+/* 
  * Data Mover Descriptor Count Register (Table 7-25)
  */
 
diff --git a/include/asm-mips/sibyte/sb1250_genbus.h b/include/asm-mips/sibyte/sb1250_genbus.h
index 1b5cbc5..9a83b3f 100644
--- a/include/asm-mips/sibyte/sb1250_genbus.h
+++ b/include/asm-mips/sibyte/sb1250_genbus.h
@@ -1,22 +1,22 @@
 /*  *********************************************************************
     *  SB1250 Board Support Package
-    *
+    *  
     *  Generic Bus Constants                     File: sb1250_genbus.h
-    *
-    *  This module contains constants and macros useful for
+    *  
+    *  This module contains constants and macros useful for 
     *  manipulating the SB1250's Generic Bus interface
-    *
+    *  
     *  SB1250 specification level:  User's manual 10/21/02
     *  BCM1280 specification level: User's Manual 11/14/03
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -26,7 +26,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
@@ -416,7 +416,7 @@ #define G_GPIO_INTR_TYPE14(x)	_SB_GETVAL
 #if SIBYTE_HDR_FEATURE_CHIP(1480)
 
 /*
- * GPIO Interrupt Additional Type Register
+ * GPIO Interrupt Additional Type Register 
  */
 
 #define K_GPIO_INTR_BOTHEDGE	0
diff --git a/include/asm-mips/sibyte/sb1250_int.h b/include/asm-mips/sibyte/sb1250_int.h
index 05c7b39..14be0b1 100644
--- a/include/asm-mips/sibyte/sb1250_int.h
+++ b/include/asm-mips/sibyte/sb1250_int.h
@@ -1,21 +1,21 @@
 /*  *********************************************************************
     *  SB1250 Board Support Package
-    *
+    *  
     *  Interrupt Mapper definitions		File: sb1250_int.h
-    *
+    *  
     *  This module contains constants for manipulating the SB1250's
     *  interrupt mapper and definitions for the interrupt sources.
-    *
+    *  
     *  SB1250 specification level:  User's manual 1/02/02
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -25,7 +25,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
@@ -41,7 +41,7 @@ #include "sb1250_defs.h"
 
 /*
  * Interrupt sources (Table 4-8, UM 0.2)
- *
+ * 
  * First, the interrupt numbers.
  */
 
diff --git a/include/asm-mips/sibyte/sb1250_l2c.h b/include/asm-mips/sibyte/sb1250_l2c.h
index 842f205..5667d9e 100644
--- a/include/asm-mips/sibyte/sb1250_l2c.h
+++ b/include/asm-mips/sibyte/sb1250_l2c.h
@@ -1,21 +1,21 @@
 /*  *********************************************************************
     *  SB1250 Board Support Package
-    *
+    *  
     *  L2 Cache constants and macros		File: sb1250_l2c.h
-    *
+    *  
     *  This module contains constants useful for manipulating the
     *  level 2 cache.
-    *
+    *  
     *  SB1250 specification level:  User's manual 1/02/02
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -25,7 +25,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
diff --git a/include/asm-mips/sibyte/sb1250_ldt.h b/include/asm-mips/sibyte/sb1250_ldt.h
index 7092535..d0626d9 100644
--- a/include/asm-mips/sibyte/sb1250_ldt.h
+++ b/include/asm-mips/sibyte/sb1250_ldt.h
@@ -1,21 +1,21 @@
 /*  *********************************************************************
     *  SB1250 Board Support Package
-    *
+    *  
     *  LDT constants				File: sb1250_ldt.h
-    *
-    *  This module contains constants and macros to describe
-    *  the LDT interface on the SB1250.
-    *
+    *  
+    *  This module contains constants and macros to describe 
+    *  the LDT interface on the SB1250.  
+    *  
     *  SB1250 specification level:  User's manual 1/02/02
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -25,7 +25,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
@@ -153,7 +153,7 @@ #define G_LDT_DEVHDR_BIST(x)		_SB_GETVAL
 
 /*
  * LDT Status Register (Table 8-14).  Note that these constants
- * assume you've read the command and status register
+ * assume you've read the command and status register 
  * together (32-bit read at offset 0x04)
  *
  * These bits also apply to the secondary status
@@ -181,8 +181,8 @@ #define M_LDT_STATUS_SIGDSERR		_SB_MAKEM
 #define M_LDT_STATUS_DETPARERR		_SB_MAKEMASK1_32(31)
 
 /*
- * Bridge Control Register (Table 8-16).  Note that these
- * constants assume you've read the register as a 32-bit
+ * Bridge Control Register (Table 8-16).  Note that these 
+ * constants assume you've read the register as a 32-bit 
  * read (offset 0x3C)
  */
 
diff --git a/include/asm-mips/sibyte/sb1250_mac.h b/include/asm-mips/sibyte/sb1250_mac.h
index adfc688..acc118c 100644
--- a/include/asm-mips/sibyte/sb1250_mac.h
+++ b/include/asm-mips/sibyte/sb1250_mac.h
@@ -1,21 +1,21 @@
 /*  *********************************************************************
     *  SB1250 Board Support Package
-    *
+    *  
     *  MAC constants and macros			File: sb1250_mac.h
-    *
+    *  
     *  This module contains constants and macros for the SB1250's
     *  ethernet controllers.
-    *
+    *  
     *  SB1250 specification level:  User's manual 1/02/02
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -25,7 +25,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
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
@@ -324,7 +324,7 @@ #define G_MAC_MAX_FRAMESZ(x)        _SB_
 
 /*
  * These constants are used to configure the fields within the Frame
- * Configuration Register.
+ * Configuration Register.  
  */
 
 #define K_MAC_IFG_RX_10             _SB_MAKE64(0)	/* See table 176, not used */
@@ -406,7 +406,7 @@ #endif /* 1250 PASS3 || 112x PASS1 */
  * Register: MAC_INT_MASK_2
  */
 
-/*
+/* 
  * Use these constants to shift the appropriate channel
  * into the CH0 position so the same tests can be used
  * on each channel.
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
index 26e4214..20bfb31 100644
--- a/include/asm-mips/sibyte/sb1250_mc.h
+++ b/include/asm-mips/sibyte/sb1250_mc.h
@@ -1,21 +1,21 @@
 /*  *********************************************************************
     *  SB1250 Board Support Package
-    *
-    *  Memory Controller constants              File: sb1250_mc.h
-    *
+    *  
+    *  Memory Controller constants              File: sb1250_mc.h       
+    *  
     *  This module contains constants and macros useful for
     *  programming the memory controller.
-    *
+    *  
     *  SB1250 specification level:  User's manual 1/02/02
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -25,7 +25,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
@@ -164,7 +164,7 @@ #define G_MC_REF_RATE(x)             _SB
 
 #define K_MC_REF_RATE_100MHz         0x62
 #define K_MC_REF_RATE_133MHz         0x81
-#define K_MC_REF_RATE_200MHz         0xC4
+#define K_MC_REF_RATE_200MHz         0xC4 
 
 #define V_MC_REF_RATE_100MHz         V_MC_REF_RATE(K_MC_REF_RATE_100MHz)
 #define V_MC_REF_RATE_133MHz         V_MC_REF_RATE(K_MC_REF_RATE_133MHz)
@@ -226,7 +226,7 @@ #define V_MC_CLKCONFIG_DEFAULT       V_M
                                      V_MC_ADDR_DRIVE_DEFAULT | \
                                      V_MC_DATA_DRIVE_DEFAULT | \
                                      V_MC_CLOCK_DRIVE_DEFAULT | \
-                                     V_MC_REF_RATE_DEFAULT
+                                     V_MC_REF_RATE_DEFAULT 
 
 
 
@@ -295,7 +295,7 @@ #define M_MC_EXTERNALDECODE	    _SB_MAKE
 
 #if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
 #define M_MC_PRE_ON_A8              _SB_MAKEMASK1(36)
-#define M_MC_RAM_WITH_A13           _SB_MAKEMASK1(38)
+#define M_MC_RAM_WITH_A13           _SB_MAKEMASK1(37)
 #endif /* 1250 PASS3 || 112x PASS1 */
 
 
diff --git a/include/asm-mips/sibyte/sb1250_regs.h b/include/asm-mips/sibyte/sb1250_regs.h
index bab3a45..1f147db 100644
--- a/include/asm-mips/sibyte/sb1250_regs.h
+++ b/include/asm-mips/sibyte/sb1250_regs.h
@@ -1,21 +1,21 @@
 /*  *********************************************************************
     *  SB1250 Board Support Package
-    *
+    *  
     *  Register Definitions                     File: sb1250_regs.h
-    *
+    *  
     *  This module contains the addresses of the on-chip peripherals
     *  on the SB1250.
-    *
+    *  
     *  SB1250 specification level:  01/02/2002
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -25,7 +25,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
@@ -38,20 +38,20 @@ #include "sb1250_defs.h"
 
 /*  *********************************************************************
     *  Some general notes:
-    *
+    *  
     *  For the most part, when there is more than one peripheral
     *  of the same type on the SOC, the constants below will be
     *  offsets from the base of each peripheral.  For example,
     *  the MAC registers are described as offsets from the first
     *  MAC register, and there will be a MAC_REGISTER() macro
-    *  to calculate the base address of a given MAC.
-    *
+    *  to calculate the base address of a given MAC.  
+    *  
     *  The information in this file is based on the SB1250 SOC
     *  manual version 0.2, July 2000.
     ********************************************************************* */
 
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * Memory Controller Registers
     ********************************************************************* */
 
@@ -103,7 +103,7 @@ #define R_MC_MCLK_CFG               0x00
 
 #endif	/* 1250 & 112x */
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * L2 Cache Control Registers
     ********************************************************************* */
 
@@ -131,7 +131,8 @@ #define A_L2_EEC_ADDRESS            A_L2
 
 #endif
 
-/*  *********************************************************************
+
+/*  ********************************************************************* 
     * PCI Interface Registers
     ********************************************************************* */
 
@@ -141,7 +142,7 @@ #define A_PCI_TYPE01_HEADER         0x00
 #endif
 
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * Ethernet DMA and MACs
     ********************************************************************* */
 
@@ -191,7 +192,7 @@ #define R_MAC_DMA_REGISTER(txrx,chan,reg
             (R_MAC_DMA_CHANNEL_BASE(txrx,chan) +    \
             (reg))
 
-/*
+/* 
  * DMA channel registers, relative to A_MAC_DMA_CHANNEL_BASE
  */
 
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
@@ -266,7 +267,7 @@ #define MAC_ADDR_COUNT			8
 #define MAC_CHMAP_COUNT			4
 
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * DUART Registers
     ********************************************************************* */
 
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
@@ -372,7 +373,7 @@ #define A_DUART_INPORT_CHNG_DEBUG   0x00
 #endif /* 1250 PASS2 || 112x PASS1 */
 
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * Synchronous Serial Registers
     ********************************************************************* */
 
@@ -408,7 +409,7 @@ #define A_SER_DMA_REGISTER(sernum,txrx,r
             (reg))
 
 
-/*
+/* 
  * DMA channel registers, relative to A_SER_DMA_CHANNEL_BASE
  */
 
@@ -470,7 +471,7 @@ #define R_SER_RMON_RX_BADADDR       0x00
 
 #endif	/* 1250/112x */
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * Generic Bus Registers
     ********************************************************************* */
 
@@ -526,7 +527,7 @@ #define R_IO_INTERRUPT_PARITY       0x0A
 #define R_IO_PCMCIA_CFG             0x0A60
 #define R_IO_PCMCIA_STATUS          0x0A70
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * GPIO Registers
     ********************************************************************* */
 
@@ -550,7 +551,7 @@ #define R_GPIO_DIRECTION            0x28
 #define R_GPIO_PIN_CLR              0x30
 #define R_GPIO_PIN_SET              0x38
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * SMBus Registers
     ********************************************************************* */
 
@@ -586,7 +587,7 @@ #define R_SMB_DATA                  0x00
 #define R_SMB_CONTROL               0x0000000060
 #define R_SMB_PEC                   0x0000000070
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * Timer Registers
     ********************************************************************* */
 
@@ -655,7 +656,7 @@ #define A_SCD_ZBBUS_CYCLE_CP0	   0x00100
 #define A_SCD_ZBBUS_CYCLE_CP1	   0x0010020C08
 #endif
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Control Registers
     ********************************************************************* */
 
@@ -663,7 +664,7 @@ #define A_SCD_SYSTEM_REVISION       0x00
 #define A_SCD_SYSTEM_CFG            0x0010020008
 #define A_SCD_SYSTEM_MANUF          0x0010038000
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Address Trap Registers
     ********************************************************************* */
 
@@ -686,7 +687,7 @@ #define A_ADDR_TRAP_REG_DEBUG	    0x0010
 #endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Interrupt Mapper Registers
     ********************************************************************* */
 
@@ -717,7 +718,7 @@ #define R_IMR_INTERRUPT_MAP_BASE        
 #define R_IMR_INTERRUPT_MAP_COUNT       64
 #endif	/* 1250/112x */
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Performance Counter Registers
     ********************************************************************* */
 
@@ -727,7 +728,7 @@ #define A_SCD_PERF_CNT_1            0x00
 #define A_SCD_PERF_CNT_2            0x00100204E0
 #define A_SCD_PERF_CNT_3            0x00100204E8
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Bus Watcher Registers
     ********************************************************************* */
 
@@ -743,13 +744,13 @@ #define A_BUS_ERR_DATA_3            0x00
 #define A_BUS_L2_ERRORS             0x00100208C0
 #define A_BUS_MEM_IO_ERRORS         0x00100208C8
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Debug Controller Registers
     ********************************************************************* */
 
 #define A_SCD_JTAG_BASE             0x0010000000
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Trace Buffer Registers
     ********************************************************************* */
 
@@ -772,7 +773,7 @@ #define A_SCD_TRACE_SEQUENCE_5      0x00
 #define A_SCD_TRACE_SEQUENCE_6      0x0010020A90
 #define A_SCD_TRACE_SEQUENCE_7      0x0010020A98
 
-/*  *********************************************************************
+/*  ********************************************************************* 
     * System Generic DMA Registers
     ********************************************************************* */
 
diff --git a/include/asm-mips/sibyte/sb1250_scd.h b/include/asm-mips/sibyte/sb1250_scd.h
index f4178bd..0f262b1 100644
--- a/include/asm-mips/sibyte/sb1250_scd.h
+++ b/include/asm-mips/sibyte/sb1250_scd.h
@@ -1,21 +1,21 @@
 /*  *********************************************************************
     *  SB1250 Board Support Package
-    *
+    *  
     *  SCD Constants and Macros			File: sb1250_scd.h
-    *
+    *  
     *  This module contains constants and macros useful for
     *  manipulating the System Control and Debug module on the 1250.
-    *
+    *  
     *  SB1250 specification level:  User's manual 1/02/02
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -25,7 +25,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
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
@@ -173,46 +174,47 @@ #define M_SYS_WID                   _SB_
 #define V_SYS_WID(x)                _SB_MAKEVALUE(x,S_SYS_WID)
 #define G_SYS_WID(x)                _SB_GETVALUE(x,S_SYS_WID,M_SYS_WID)
 
-/*
+/* 
  * System Manufacturing Register
  * Register: SCD_SYSTEM_MANUF
  */
 
-#if SIBYTE_HDR_FEATURE_1250_112x
+#if SIBYTE_HDR_FEATURE_1250_112x 
 /* Wafer ID: bits 31:0 */
 #define S_SYS_WAFERID1_200        _SB_MAKE64(0)
 #define M_SYS_WAFERID1_200        _SB_MAKEMASK(32,S_SYS_WAFERID1_200)
 #define V_SYS_WAFERID1_200(x)     _SB_MAKEVALUE(x,S_SYS_WAFERID1_200)
 #define G_SYS_WAFERID1_200(x)     _SB_GETVALUE(x,S_SYS_WAFERID1_200,M_SYS_WAFERID1_200)
-
+ 
 #define S_SYS_BIN                 _SB_MAKE64(32)
 #define M_SYS_BIN                 _SB_MAKEMASK(4,S_SYS_BIN)
 #define V_SYS_BIN(x)              _SB_MAKEVALUE(x,S_SYS_BIN)
 #define G_SYS_BIN(x)              _SB_GETVALUE(x,S_SYS_BIN,M_SYS_BIN)
-
+ 
 /* Wafer ID: bits 39:36 */
 #define S_SYS_WAFERID2_200        _SB_MAKE64(36)
 #define M_SYS_WAFERID2_200        _SB_MAKEMASK(4,S_SYS_WAFERID2_200)
 #define V_SYS_WAFERID2_200(x)     _SB_MAKEVALUE(x,S_SYS_WAFERID2_200)
 #define G_SYS_WAFERID2_200(x)     _SB_GETVALUE(x,S_SYS_WAFERID2_200,M_SYS_WAFERID2_200)
-
+ 
 /* Wafer ID: bits 39:0 */
 #define S_SYS_WAFERID_300         _SB_MAKE64(0)
 #define M_SYS_WAFERID_300         _SB_MAKEMASK(40,S_SYS_WAFERID_300)
 #define V_SYS_WAFERID_300(x)      _SB_MAKEVALUE(x,S_SYS_WAFERID_300)
 #define G_SYS_WAFERID_300(x)      _SB_GETVALUE(x,S_SYS_WAFERID_300,M_SYS_WAFERID_300)
-
+ 
 #define S_SYS_XPOS                _SB_MAKE64(40)
 #define M_SYS_XPOS                _SB_MAKEMASK(6,S_SYS_XPOS)
 #define V_SYS_XPOS(x)             _SB_MAKEVALUE(x,S_SYS_XPOS)
 #define G_SYS_XPOS(x)             _SB_GETVALUE(x,S_SYS_XPOS,M_SYS_XPOS)
-
+ 
 #define S_SYS_YPOS                _SB_MAKE64(46)
 #define M_SYS_YPOS                _SB_MAKEMASK(6,S_SYS_YPOS)
 #define V_SYS_YPOS(x)             _SB_MAKEVALUE(x,S_SYS_YPOS)
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
@@ -400,6 +401,7 @@ #define M_SPC_CFG_SRC3            _SB_MA
 #define V_SPC_CFG_SRC3(x)         _SB_MAKEVALUE(x,S_SPC_CFG_SRC3)
 #define G_SPC_CFG_SRC3(x)         _SB_GETVALUE(x,S_SPC_CFG_SRC3,M_SPC_CFG_SRC3)
 
+#if SIBYTE_HDR_FEATURE_1250_112x
 #define M_SPC_CFG_CLEAR		_SB_MAKEMASK1(32)
 #define M_SPC_CFG_ENABLE	_SB_MAKEMASK1(33)
 #endif
@@ -515,8 +517,6 @@ #endif	/* 1250/112x */
  * Trace Buffer Config register
  */
 
-#if SIBYTE_HDR_FEATURE_1250_112x
-
 #define M_SCD_TRACE_CFG_RESET           _SB_MAKEMASK1(0)
 #define M_SCD_TRACE_CFG_START_READ      _SB_MAKEMASK1(1)
 #define M_SCD_TRACE_CFG_START           _SB_MAKEMASK1(2)
@@ -525,17 +525,25 @@ #define M_SCD_TRACE_CFG_FREEZE          
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
+#endif	/* 1250/112x */
+#if SIBYTE_HDR_FEATURE_CHIP(1480)
+#define S_SCD_TRACE_CFG_CUR_ADDR        24
+#endif	/* 1480 */
+
 #define M_SCD_TRACE_CFG_CUR_ADDR        _SB_MAKEMASK(8,S_SCD_TRACE_CFG_CUR_ADDR)
 #define V_SCD_TRACE_CFG_CUR_ADDR(x)     _SB_MAKEVALUE(x,S_SCD_TRACE_CFG_CUR_ADDR)
 #define G_SCD_TRACE_CFG_CUR_ADDR(x)     _SB_GETVALUE(x,S_SCD_TRACE_CFG_CUR_ADDR,M_SCD_TRACE_CFG_CUR_ADDR)
 
-#endif	/* 1250/112x */
-
 /*
  * Trace Event registers
  */
diff --git a/include/asm-mips/sibyte/sb1250_smbus.h b/include/asm-mips/sibyte/sb1250_smbus.h
index 279a912..e95636e 100644
--- a/include/asm-mips/sibyte/sb1250_smbus.h
+++ b/include/asm-mips/sibyte/sb1250_smbus.h
@@ -1,22 +1,22 @@
 /*  *********************************************************************
     *  SB1250 Board Support Package
-    *
+    *  
     *  SMBUS Constants                          File: sb1250_smbus.h
-    *
-    *  This module contains constants and macros useful for
+    *  
+    *  This module contains constants and macros useful for 
     *  manipulating the SB1250's SMbus devices.
-    *
+    *  
     *  SB1250 specification level:  10/21/02
     *  BCM1280 specification level:  11/24/03
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -26,7 +26,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
diff --git a/include/asm-mips/sibyte/sb1250_syncser.h b/include/asm-mips/sibyte/sb1250_syncser.h
index dd154ac..6a1d554 100644
--- a/include/asm-mips/sibyte/sb1250_syncser.h
+++ b/include/asm-mips/sibyte/sb1250_syncser.h
@@ -7,15 +7,15 @@
     *  manipulating the SB1250's Synchronous Serial
     *
     *  SB1250 specification level:  User's manual 1/02/02
-    *
+    *  
     *********************************************************************
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -25,7 +25,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
diff --git a/include/asm-mips/sibyte/sb1250_uart.h b/include/asm-mips/sibyte/sb1250_uart.h
index e87045e..a2cea2a 100644
--- a/include/asm-mips/sibyte/sb1250_uart.h
+++ b/include/asm-mips/sibyte/sb1250_uart.h
@@ -1,21 +1,21 @@
 /*  *********************************************************************
     *  SB1250 Board Support Package
-    *
+    *  
     *  UART Constants				File: sb1250_uart.h
-    *
-    *  This module contains constants and macros useful for
+    *  
+    *  This module contains constants and macros useful for 
     *  manipulating the SB1250's UARTs
     *
     *  SB1250 specification level:  User's manual 1/02/02
-    *
-    *********************************************************************
+    *  
+    *********************************************************************  
     *
     *  Copyright 2000,2001,2002,2003
     *  Broadcom Corporation. All rights reserved.
-    *
-    *  This program is free software; you can redistribute it and/or
-    *  modify it under the terms of the GNU General Public License as
-    *  published by the Free Software Foundation; either version 2 of
+    *  
+    *  This program is free software; you can redistribute it and/or 
+    *  modify it under the terms of the GNU General Public License as 
+    *  published by the Free Software Foundation; either version 2 of 
     *  the License, or (at your option) any later version.
     *
     *  This program is distributed in the hope that it will be useful,
@@ -25,7 +25,7 @@
     *
     *  You should have received a copy of the GNU General Public License
     *  along with this program; if not, write to the Free Software
-    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
     *  MA 02111-1307 USA
     ********************************************************************* */
 
@@ -35,7 +35,7 @@ #define _SB1250_UART_H
 
 #include "sb1250_defs.h"
 
-/* **********************************************************************
+/* ********************************************************************** 
    * DUART Registers
    ********************************************************************** */
 
@@ -143,7 +143,7 @@ #define V_DUART_MISC_CMD_RESET_BREAK_INT
 #define V_DUART_MISC_CMD_START_BREAK     V_DUART_MISC_CMD(K_DUART_MISC_CMD_START_BREAK)
 #define V_DUART_MISC_CMD_STOP_BREAK      V_DUART_MISC_CMD(K_DUART_MISC_CMD_STOP_BREAK)
 
-#define M_DUART_CMD_RESERVED             _SB_MAKEMASK1(7)
+#define M_DUART_CMD_RESERVED             _SB_MAKEMASK1(7) 
 
 /*
  * DUART Status Register (Table 10-6)
@@ -163,7 +163,7 @@ #define M_DUART_RCVD_BRK            _SB_
 
 /*
  * DUART Baud Rate Register (Table 10-7)
- * Register: DUART_CLK_SEL_A
+ * Register: DUART_CLK_SEL_A 
  * Register: DUART_CLK_SEL_B
  */
 
@@ -335,7 +335,7 @@ #define M_DUART_OUT_PIN_CLR(chan) \
     (chan == 0 ? M_DUART_OUT_PIN_CLR0 : M_DUART_OUT_PIN_CLR1)
 
 #if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
-/*
+/* 
  * Full Interrupt Control Register
  */
 
diff --git a/include/asm-mips/sibyte/sentosa.h b/include/asm-mips/sibyte/sentosa.h
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
