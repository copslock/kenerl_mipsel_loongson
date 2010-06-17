Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 13:36:57 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:40086 "EHLO
        tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492191Ab0FQLgk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 13:36:40 +0200
Received: from mailgate3.nec.co.jp ([10.7.69.197])
        by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o5HBacmb022728
        for <linux-mips@linux-mips.org>; Thu, 17 Jun 2010 20:36:38 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
        id o5HBacr11516 for linux-mips@linux-mips.org; Thu, 17 Jun 2010 20:36:38 +0900 (JST)
Received: from relay61.aps.necel.com ([10.29.19.64]) by vgate02.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
        id o5HBab916872 for <linux-mips@linux-mips.org>; Thu, 17 Jun 2010 20:36:37 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.36] [10.29.19.36]) by relay61.aps.necel.com with ESMTP; Thu, 17 Jun 2010 20:36:37 +0900
Received: from [10.114.180.181] ([10.114.180.181] [10.114.180.181]) by mbox02.aps.necel.com with ESMTP; Thu, 17 Jun 2010 20:36:37 +0900
Message-ID: <4C1A08C0.9070400@renesas.com>
Date:   Thu, 17 Jun 2010 20:36:32 +0900
From:   Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.9) Gecko/20100317 Lightning/1.0b1 Thunderbird/3.0.4
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: [PATCH 3/4] MIPS: EMMA2RH: Replace EMMA2RH_IRQ_INTxx with EMMA2RH_IRQ_INT(n)
References: <4C1A0801.60405@renesas.com>
In-Reply-To: <4C1A0801.60405@renesas.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi.px@renesas.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11957

Don't duplicate worthless lines.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 arch/mips/include/asm/emma/emma2rh.h  |   79 +++-----------------------------
 arch/mips/include/asm/emma/markeins.h |    4 +-
 2 files changed, 10 insertions(+), 73 deletions(-)

diff --git a/arch/mips/include/asm/emma/emma2rh.h b/arch/mips/include/asm/emma/emma2rh.h
index 95d0b7e..c1449d2 100644
--- a/arch/mips/include/asm/emma/emma2rh.h
+++ b/arch/mips/include/asm/emma/emma2rh.h
@@ -107,77 +107,14 @@
  * emma2rh irq defs
  */
 
-#define EMMA2RH_IRQ_INT0	(0 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT1	(1 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT2	(2 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT3	(3 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT4	(4 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT5	(5 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT6	(6 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT7	(7 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT8	(8 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT9	(9 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT10	(10 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT11	(11 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT12	(12 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT13	(13 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT14	(14 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT15	(15 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT16	(16 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT17	(17 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT18	(18 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT19	(19 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT20	(20 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT21	(21 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT22	(22 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT23	(23 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT24	(24 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT25	(25 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT26	(26 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT27	(27 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT28	(28 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT29	(29 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT30	(30 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT31	(31 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT32	(32 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT33	(33 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT34	(34 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT35	(35 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT36	(36 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT37	(37 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT38	(38 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT39	(39 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT40	(40 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT41	(41 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT42	(42 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT43	(43 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT44	(44 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT45	(45 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT46	(46 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT47	(47 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT48	(48 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT49	(49 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT50	(50 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT51	(51 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT52	(52 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT53	(53 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT54	(54 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT55	(55 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT56	(56 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT57	(57 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT58	(58 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT59	(59 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT60	(60 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT61	(61 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT62	(62 + EMMA2RH_IRQ_BASE)
-#define EMMA2RH_IRQ_INT63	(63 + EMMA2RH_IRQ_BASE)
-
-#define EMMA2RH_IRQ_PFUR0	EMMA2RH_IRQ_INT49
-#define EMMA2RH_IRQ_PFUR1	EMMA2RH_IRQ_INT50
-#define EMMA2RH_IRQ_PFUR2	EMMA2RH_IRQ_INT51
-#define EMMA2RH_IRQ_PIIC0	EMMA2RH_IRQ_INT56
-#define EMMA2RH_IRQ_PIIC1	EMMA2RH_IRQ_INT57
-#define EMMA2RH_IRQ_PIIC2	EMMA2RH_IRQ_INT58
+#define EMMA2RH_IRQ_INT(n)	(EMMA2RH_IRQ_BASE + (n))
+
+#define EMMA2RH_IRQ_PFUR0	EMMA2RH_IRQ_INT(49)
+#define EMMA2RH_IRQ_PFUR1	EMMA2RH_IRQ_INT(50)
+#define EMMA2RH_IRQ_PFUR2	EMMA2RH_IRQ_INT(51)
+#define EMMA2RH_IRQ_PIIC0	EMMA2RH_IRQ_INT(56)
+#define EMMA2RH_IRQ_PIIC1	EMMA2RH_IRQ_INT(57)
+#define EMMA2RH_IRQ_PIIC2	EMMA2RH_IRQ_INT(58)
 
 /*
  *  EMMA2RH Register Access
diff --git a/arch/mips/include/asm/emma/markeins.h b/arch/mips/include/asm/emma/markeins.h
index 2618bf2..507f125 100644
--- a/arch/mips/include/asm/emma/markeins.h
+++ b/arch/mips/include/asm/emma/markeins.h
@@ -25,8 +25,8 @@
 #define NUM_EMMA2RH_IRQ_SW	32
 #define NUM_EMMA2RH_IRQ_GPIO	32
 
-#define EMMA2RH_SW_CASCADE	(EMMA2RH_IRQ_INT7 - EMMA2RH_IRQ_INT0)
-#define EMMA2RH_GPIO_CASCADE	(EMMA2RH_IRQ_INT46 - EMMA2RH_IRQ_INT0)
+#define EMMA2RH_SW_CASCADE	(EMMA2RH_IRQ_INT(7) - EMMA2RH_IRQ_INT(0))
+#define EMMA2RH_GPIO_CASCADE	(EMMA2RH_IRQ_INT(46) - EMMA2RH_IRQ_INT(0))
 
 #define EMMA2RH_SW_IRQ_BASE	(EMMA2RH_IRQ_BASE + NUM_EMMA2RH_IRQ)
 #define EMMA2RH_GPIO_IRQ_BASE	(EMMA2RH_SW_IRQ_BASE + NUM_EMMA2RH_IRQ_SW)
-- 
1.7.1
