Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 01:46:02 +0200 (CEST)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:43004 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492164Ab1HRXp5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2011 01:45:57 +0200
Received: by vxj2 with SMTP id 2so2641385vxj.36
        for <multiple recipients>; Thu, 18 Aug 2011 16:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aZu46VvRSSEyzT29iFZWZTYexXx3uKhWPREInBqUOG8=;
        b=t6cm0AtsLOtL01CyOIm8OwF3yvwLm2x32k6bvfc2UXYe6rrhYKu40uUioNskKkv4E/
         DpKVp+carzGUdN1/MSxvQXFyAuF3QcGsDoDl+isFriZGd8now9M6/mkQvRnOmkw/5PgO
         rYa8+0Nn4X3/kq6kO6DUVFNCRC5M24QxPknNw=
Received: by 10.52.180.193 with SMTP id dq1mr1352612vdc.393.1313711151544;
        Thu, 18 Aug 2011 16:45:51 -0700 (PDT)
Received: from localhost (cpe-174-109-057-197.nc.res.rr.com [174.109.57.197])
        by mx.google.com with ESMTPS id dg6sm1520795vcb.41.2011.08.18.16.45.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 16:45:50 -0700 (PDT)
From:   mattst88@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org,
        Guenter Roeck <guenter.roeck@ericsson.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 1/3] RTC: SWARM class device persistent clock support
Date:   Thu, 18 Aug 2011 19:45:46 -0400
Message-Id: <4e4da42e.06bedc0a.5ff5.4d10@mx.google.com>
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <y>
References: <y>
X-archive-position: 30906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Maciej W. Rozycki <macro@linux-mips.org>

This is a set of changes removing the SWARM platform driver for the
M41T81 and "wiring" the class RTC driver.

The Xicor clock is unaffected as we have no class driver for this device.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 arch/mips/sibyte/swarm/Makefile     |    3 +-
 arch/mips/sibyte/swarm/rtc_m41t81.c |  233 -----------------------------------
 arch/mips/sibyte/swarm/setup.c      |   14 --
 3 files changed, 1 insertions(+), 249 deletions(-)
 delete mode 100644 arch/mips/sibyte/swarm/rtc_m41t81.c

diff --git a/arch/mips/sibyte/swarm/Makefile b/arch/mips/sibyte/swarm/Makefile
index 7b45f19..8527db4 100644
--- a/arch/mips/sibyte/swarm/Makefile
+++ b/arch/mips/sibyte/swarm/Makefile
@@ -1,4 +1,3 @@
-obj-y				:= platform.o setup.o rtc_xicor1241.o \
-				   rtc_m41t81.o
+obj-y				:= platform.o setup.o rtc_xicor1241.o
 
 obj-$(CONFIG_I2C_BOARDINFO)	+= swarm-i2c.o
diff --git a/arch/mips/sibyte/swarm/rtc_m41t81.c b/arch/mips/sibyte/swarm/rtc_m41t81.c
deleted file mode 100644
index b732600..0000000
--- a/arch/mips/sibyte/swarm/rtc_m41t81.c
+++ /dev/null
@@ -1,233 +0,0 @@
-/*
- * Copyright (C) 2000, 2001 Broadcom Corporation
- *
- * Copyright (C) 2002 MontaVista Software Inc.
- * Author: jsun@mvista.com or jsun@junsun.net
- *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-#include <linux/bcd.h>
-#include <linux/types.h>
-#include <linux/time.h>
-
-#include <asm/time.h>
-#include <asm/addrspace.h>
-#include <asm/io.h>
-
-#include <asm/sibyte/sb1250.h>
-#include <asm/sibyte/sb1250_regs.h>
-#include <asm/sibyte/sb1250_smbus.h>
-
-
-/* M41T81 definitions */
-
-/*
- * Register bits
- */
-
-#define M41T81REG_SC_ST		0x80		/* stop bit */
-#define M41T81REG_HR_CB		0x40		/* century bit */
-#define M41T81REG_HR_CEB	0x80		/* century enable bit */
-#define M41T81REG_CTL_S		0x20		/* sign bit */
-#define M41T81REG_CTL_FT	0x40		/* frequency test bit */
-#define M41T81REG_CTL_OUT	0x80		/* output level */
-#define M41T81REG_WD_RB0	0x01		/* watchdog resolution bit 0 */
-#define M41T81REG_WD_RB1	0x02		/* watchdog resolution bit 1 */
-#define M41T81REG_WD_BMB0	0x04		/* watchdog multiplier bit 0 */
-#define M41T81REG_WD_BMB1	0x08		/* watchdog multiplier bit 1 */
-#define M41T81REG_WD_BMB2	0x10		/* watchdog multiplier bit 2 */
-#define M41T81REG_WD_BMB3	0x20		/* watchdog multiplier bit 3 */
-#define M41T81REG_WD_BMB4	0x40		/* watchdog multiplier bit 4 */
-#define M41T81REG_AMO_ABE	0x20		/* alarm in "battery back-up mode" enable bit */
-#define M41T81REG_AMO_SQWE	0x40		/* square wave enable */
-#define M41T81REG_AMO_AFE	0x80		/* alarm flag enable flag */
-#define M41T81REG_ADT_RPT5	0x40		/* alarm repeat mode bit 5 */
-#define M41T81REG_ADT_RPT4	0x80		/* alarm repeat mode bit 4 */
-#define M41T81REG_AHR_RPT3	0x80		/* alarm repeat mode bit 3 */
-#define M41T81REG_AHR_HT	0x40		/* halt update bit */
-#define M41T81REG_AMN_RPT2	0x80		/* alarm repeat mode bit 2 */
-#define M41T81REG_ASC_RPT1	0x80		/* alarm repeat mode bit 1 */
-#define M41T81REG_FLG_AF	0x40		/* alarm flag (read only) */
-#define M41T81REG_FLG_WDF	0x80		/* watchdog flag (read only) */
-#define M41T81REG_SQW_RS0	0x10		/* sqw frequency bit 0 */
-#define M41T81REG_SQW_RS1	0x20		/* sqw frequency bit 1 */
-#define M41T81REG_SQW_RS2	0x40		/* sqw frequency bit 2 */
-#define M41T81REG_SQW_RS3	0x80		/* sqw frequency bit 3 */
-
-
-/*
- * Register numbers
- */
-
-#define M41T81REG_TSC	0x00		/* tenths/hundredths of second */
-#define M41T81REG_SC	0x01		/* seconds */
-#define M41T81REG_MN	0x02		/* minute */
-#define M41T81REG_HR	0x03		/* hour/century */
-#define M41T81REG_DY	0x04		/* day of week */
-#define M41T81REG_DT	0x05		/* date of month */
-#define M41T81REG_MO	0x06		/* month */
-#define M41T81REG_YR	0x07		/* year */
-#define M41T81REG_CTL	0x08		/* control */
-#define M41T81REG_WD	0x09		/* watchdog */
-#define M41T81REG_AMO	0x0A		/* alarm: month */
-#define M41T81REG_ADT	0x0B		/* alarm: date */
-#define M41T81REG_AHR	0x0C		/* alarm: hour */
-#define M41T81REG_AMN	0x0D		/* alarm: minute */
-#define M41T81REG_ASC	0x0E		/* alarm: second */
-#define M41T81REG_FLG	0x0F		/* flags */
-#define M41T81REG_SQW	0x13		/* square wave register */
-
-#define M41T81_CCR_ADDRESS	0x68
-
-#define SMB_CSR(reg)	IOADDR(A_SMB_REGISTER(1, reg))
-
-static int m41t81_read(uint8_t addr)
-{
-	while (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_BUSY)
-		;
-
-	__raw_writeq(addr & 0xff, SMB_CSR(R_SMB_CMD));
-	__raw_writeq(V_SMB_ADDR(M41T81_CCR_ADDRESS) | V_SMB_TT_WR1BYTE,
-		     SMB_CSR(R_SMB_START));
-
-	while (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_BUSY)
-		;
-
-	__raw_writeq(V_SMB_ADDR(M41T81_CCR_ADDRESS) | V_SMB_TT_RD1BYTE,
-		     SMB_CSR(R_SMB_START));
-
-	while (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_BUSY)
-		;
-
-	if (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_ERROR) {
-		/* Clear error bit by writing a 1 */
-		__raw_writeq(M_SMB_ERROR, SMB_CSR(R_SMB_STATUS));
-		return -1;
-	}
-
-	return (__raw_readq(SMB_CSR(R_SMB_DATA)) & 0xff);
-}
-
-static int m41t81_write(uint8_t addr, int b)
-{
-	while (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_BUSY)
-		;
-
-	__raw_writeq(addr & 0xff, SMB_CSR(R_SMB_CMD));
-	__raw_writeq(b & 0xff, SMB_CSR(R_SMB_DATA));
-	__raw_writeq(V_SMB_ADDR(M41T81_CCR_ADDRESS) | V_SMB_TT_WR2BYTE,
-		     SMB_CSR(R_SMB_START));
-
-	while (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_BUSY)
-		;
-
-	if (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_ERROR) {
-		/* Clear error bit by writing a 1 */
-		__raw_writeq(M_SMB_ERROR, SMB_CSR(R_SMB_STATUS));
-		return -1;
-	}
-
-	/* read the same byte again to make sure it is written */
-	__raw_writeq(V_SMB_ADDR(M41T81_CCR_ADDRESS) | V_SMB_TT_RD1BYTE,
-		     SMB_CSR(R_SMB_START));
-
-	while (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_BUSY)
-		;
-
-	return 0;
-}
-
-int m41t81_set_time(unsigned long t)
-{
-	struct rtc_time tm;
-	unsigned long flags;
-
-	/* Note we don't care about the century */
-	rtc_time_to_tm(t, &tm);
-
-	/*
-	 * Note the write order matters as it ensures the correctness.
-	 * When we write sec, 10th sec is clear.  It is reasonable to
-	 * believe we should finish writing min within a second.
-	 */
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	tm.tm_sec = bin2bcd(tm.tm_sec);
-	m41t81_write(M41T81REG_SC, tm.tm_sec);
-
-	tm.tm_min = bin2bcd(tm.tm_min);
-	m41t81_write(M41T81REG_MN, tm.tm_min);
-
-	tm.tm_hour = bin2bcd(tm.tm_hour);
-	tm.tm_hour = (tm.tm_hour & 0x3f) | (m41t81_read(M41T81REG_HR) & 0xc0);
-	m41t81_write(M41T81REG_HR, tm.tm_hour);
-
-	/* tm_wday starts from 0 to 6 */
-	if (tm.tm_wday == 0) tm.tm_wday = 7;
-	tm.tm_wday = bin2bcd(tm.tm_wday);
-	m41t81_write(M41T81REG_DY, tm.tm_wday);
-
-	tm.tm_mday = bin2bcd(tm.tm_mday);
-	m41t81_write(M41T81REG_DT, tm.tm_mday);
-
-	/* tm_mon starts from 0, *ick* */
-	tm.tm_mon ++;
-	tm.tm_mon = bin2bcd(tm.tm_mon);
-	m41t81_write(M41T81REG_MO, tm.tm_mon);
-
-	/* we don't do century, everything is beyond 2000 */
-	tm.tm_year %= 100;
-	tm.tm_year = bin2bcd(tm.tm_year);
-	m41t81_write(M41T81REG_YR, tm.tm_year);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	return 0;
-}
-
-unsigned long m41t81_get_time(void)
-{
-	unsigned int year, mon, day, hour, min, sec;
-	unsigned long flags;
-
-	/*
-	 * min is valid if two reads of sec are the same.
-	 */
-	for (;;) {
-		spin_lock_irqsave(&rtc_lock, flags);
-		sec = m41t81_read(M41T81REG_SC);
-		min = m41t81_read(M41T81REG_MN);
-		if (sec == m41t81_read(M41T81REG_SC)) break;
-		spin_unlock_irqrestore(&rtc_lock, flags);
-	}
-	hour = m41t81_read(M41T81REG_HR) & 0x3f;
-	day = m41t81_read(M41T81REG_DT);
-	mon = m41t81_read(M41T81REG_MO);
-	year = m41t81_read(M41T81REG_YR);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	sec = bcd2bin(sec);
-	min = bcd2bin(min);
-	hour = bcd2bin(hour);
-	day = bcd2bin(day);
-	mon = bcd2bin(mon);
-	year = bcd2bin(year);
-
-	year += 2000;
-
-	return mktime(year, mon, day, hour, min, sec);
-}
-
-int m41t81_probe(void)
-{
-	unsigned int tmp;
-
-	/* enable chip if it is not enabled yet */
-	tmp = m41t81_read(M41T81REG_SC);
-	m41t81_write(M41T81REG_SC, tmp & 0x7f);
-
-	return (m41t81_read(M41T81REG_SC) != -1);
-}
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 41707a2..3cd0d27 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -60,10 +60,6 @@ extern int xicor_probe(void);
 extern int xicor_set_time(unsigned long);
 extern unsigned long xicor_get_time(void);
 
-extern int m41t81_probe(void);
-extern int m41t81_set_time(unsigned long);
-extern unsigned long m41t81_get_time(void);
-
 const char *get_system_type(void)
 {
 	return "SiByte " SIBYTE_BOARD_NAME;
@@ -82,7 +78,6 @@ int swarm_be_handler(struct pt_regs *regs, int is_fixup)
 enum swarm_rtc_type {
 	RTC_NONE,
 	RTC_XICOR,
-	RTC_M41T81,
 };
 
 enum swarm_rtc_type swarm_rtc_type;
@@ -96,10 +91,6 @@ void read_persistent_clock(struct timespec *ts)
 		sec = xicor_get_time();
 		break;
 
-	case RTC_M41T81:
-		sec = m41t81_get_time();
-		break;
-
 	case RTC_NONE:
 	default:
 		sec = mktime(2000, 1, 1, 0, 0, 0);
@@ -115,9 +106,6 @@ int rtc_mips_set_time(unsigned long sec)
 	case RTC_XICOR:
 		return xicor_set_time(sec);
 
-	case RTC_M41T81:
-		return m41t81_set_time(sec);
-
 	case RTC_NONE:
 	default:
 		return -1;
@@ -140,8 +128,6 @@ void __init plat_mem_setup(void)
 
 	if (xicor_probe())
 		swarm_rtc_type = RTC_XICOR;
-	if (m41t81_probe())
-		swarm_rtc_type = RTC_M41T81;
 
 #ifdef CONFIG_VT
 	screen_info = (struct screen_info) {
-- 
1.7.3.4
