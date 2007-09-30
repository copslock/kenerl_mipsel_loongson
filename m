Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Sep 2007 10:56:09 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:32384 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S20025704AbXI3Jzj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 30 Sep 2007 10:55:39 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id l8U9tVpv009450;
	Sun, 30 Sep 2007 02:55:31 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Sep 2007 02:55:31 -0700
Received: from [128.224.162.179] ([128.224.162.179]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Sep 2007 02:55:30 -0700
Message-ID: <46FF7283.7050702@windriver.com>
Date:	Sun, 30 Sep 2007 17:55:15 +0800
From:	Mark Zhan <rongkai.zhan@windriver.com>
User-Agent: Thunderbird 1.5.0.13 (X11/20070824)
MIME-Version: 1.0
To:	i2c@lm-sensors.org, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
CC:	ralf@linux-mips.org, a.zummo@towertech.it,
	rongkai.zhan@windriver.com
Subject: [PATCH 4/4] MIPS: Remove the legacy RTC codes of MIPS sibyte boards
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2007 09:55:30.0759 (UTC) FILETIME=[093D2570:01C80348]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

This patch removes the legacy RTC codes of MIPS sibyte boards,
which are replaced by new RTC class drivers. And a board init
routine is added to register sibyte platform devices.

Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
---
  arch/mips/sibyte/swarm/Makefile        |    2
  arch/mips/sibyte/swarm/rtc_m41t81.c    |  232 ---------------------------------
  arch/mips/sibyte/swarm/rtc_xicor1241.c |  209 -----------------------------
  arch/mips/sibyte/swarm/setup.c         |   56 +++++--
  4 files changed, 37 insertions(+), 462 deletions(-)

--- a/arch/mips/sibyte/swarm/Makefile
+++ b/arch/mips/sibyte/swarm/Makefile
@@ -1,3 +1,3 @@
-lib-y				= setup.o rtc_xicor1241.o rtc_m41t81.o
+lib-y				= setup.o

  lib-$(CONFIG_KGDB)		+= dbg_io.o
--- a/arch/mips/sibyte/swarm/rtc_m41t81.c
+++ /dev/null
@@ -1,232 +0,0 @@
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
-	to_tm(t, &tm);
-
-	/*
-	 * Note the write order matters as it ensures the correctness.
-	 * When we write sec, 10th sec is clear.  It is reasonable to
-	 * believe we should finish writing min within a second.
-	 */
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	tm.tm_sec = BIN2BCD(tm.tm_sec);
-	m41t81_write(M41T81REG_SC, tm.tm_sec);
-
-	tm.tm_min = BIN2BCD(tm.tm_min);
-	m41t81_write(M41T81REG_MN, tm.tm_min);
-
-	tm.tm_hour = BIN2BCD(tm.tm_hour);
-	tm.tm_hour = (tm.tm_hour & 0x3f) | (m41t81_read(M41T81REG_HR) & 0xc0);
-	m41t81_write(M41T81REG_HR, tm.tm_hour);
-
-	/* tm_wday starts from 0 to 6 */
-	if (tm.tm_wday == 0) tm.tm_wday = 7;
-	tm.tm_wday = BIN2BCD(tm.tm_wday);
-	m41t81_write(M41T81REG_DY, tm.tm_wday);
-
-	tm.tm_mday = BIN2BCD(tm.tm_mday);
-	m41t81_write(M41T81REG_DT, tm.tm_mday);
-
-	/* tm_mon starts from 0, *ick* */
-	tm.tm_mon ++;
-	tm.tm_mon = BIN2BCD(tm.tm_mon);
-	m41t81_write(M41T81REG_MO, tm.tm_mon);
-
-	/* we don't do century, everything is beyond 2000 */
-	tm.tm_year %= 100;
-	tm.tm_year = BIN2BCD(tm.tm_year);
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
-	sec = BCD2BIN(sec);
-	min = BCD2BIN(min);
-	hour = BCD2BIN(hour);
-	day = BCD2BIN(day);
-	mon = BCD2BIN(mon);
-	year = BCD2BIN(year);
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
--- a/arch/mips/sibyte/swarm/rtc_xicor1241.c
+++ /dev/null
@@ -1,209 +0,0 @@
-/*
- * Copyright (C) 2000, 2001 Broadcom Corporation
- *
- * Copyright (C) 2002 MontaVista Software Inc.
- * Author: jsun@mvista.com or jsun@junsun.net
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
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
-/* Xicor 1241 definitions */
-
-/*
- * Register bits
- */
-
-#define X1241REG_SR_BAT	0x80		/* currently on battery power */
-#define X1241REG_SR_RWEL 0x04		/* r/w latch is enabled, can write RTC */
-#define X1241REG_SR_WEL 0x02		/* r/w latch is unlocked, can enable r/w now */
-#define X1241REG_SR_RTCF 0x01		/* clock failed */
-#define X1241REG_BL_BP2 0x80		/* block protect 2 */
-#define X1241REG_BL_BP1 0x40		/* block protect 1 */
-#define X1241REG_BL_BP0 0x20		/* block protect 0 */
-#define X1241REG_BL_WD1	0x10
-#define X1241REG_BL_WD0	0x08
-#define X1241REG_HR_MIL 0x80		/* military time format */
-
-/*
- * Register numbers
- */
-
-#define X1241REG_BL	0x10		/* block protect bits */
-#define X1241REG_INT	0x11		/*  */
-#define X1241REG_SC	0x30		/* Seconds */
-#define X1241REG_MN	0x31		/* Minutes */
-#define X1241REG_HR	0x32		/* Hours */
-#define X1241REG_DT	0x33		/* Day of month */
-#define X1241REG_MO	0x34		/* Month */
-#define X1241REG_YR	0x35		/* Year */
-#define X1241REG_DW	0x36		/* Day of Week */
-#define X1241REG_Y2K	0x37		/* Year 2K */
-#define X1241REG_SR	0x3F		/* Status register */
-
-#define X1241_CCR_ADDRESS	0x6F
-
-#define SMB_CSR(reg)	IOADDR(A_SMB_REGISTER(1, reg))
-
-static int xicor_read(uint8_t addr)
-{
-        while (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_BUSY)
-                ;
-
-	__raw_writeq((addr >> 8) & 0x7, SMB_CSR(R_SMB_CMD));
-	__raw_writeq(addr & 0xff, SMB_CSR(R_SMB_DATA));
-	__raw_writeq(V_SMB_ADDR(X1241_CCR_ADDRESS) | V_SMB_TT_WR2BYTE,
-		     SMB_CSR(R_SMB_START));
-
-        while (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_BUSY)
-                ;
-
-	__raw_writeq(V_SMB_ADDR(X1241_CCR_ADDRESS) | V_SMB_TT_RD1BYTE,
-		     SMB_CSR(R_SMB_START));
-
-        while (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_BUSY)
-                ;
-
-        if (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_ERROR) {
-                /* Clear error bit by writing a 1 */
-                __raw_writeq(M_SMB_ERROR, SMB_CSR(R_SMB_STATUS));
-                return -1;
-        }
-
-	return (__raw_readq(SMB_CSR(R_SMB_DATA)) & 0xff);
-}
-
-static int xicor_write(uint8_t addr, int b)
-{
-        while (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_BUSY)
-                ;
-
-	__raw_writeq(addr, SMB_CSR(R_SMB_CMD));
-	__raw_writeq((addr & 0xff) | ((b & 0xff) << 8), SMB_CSR(R_SMB_DATA));
-	__raw_writeq(V_SMB_ADDR(X1241_CCR_ADDRESS) | V_SMB_TT_WR3BYTE,
-		     SMB_CSR(R_SMB_START));
-
-        while (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_BUSY)
-                ;
-
-        if (__raw_readq(SMB_CSR(R_SMB_STATUS)) & M_SMB_ERROR) {
-                /* Clear error bit by writing a 1 */
-                __raw_writeq(M_SMB_ERROR, SMB_CSR(R_SMB_STATUS));
-                return -1;
-        } else {
-		return 0;
-	}
-}
-
-int xicor_set_time(unsigned long t)
-{
-	struct rtc_time tm;
-	int tmp;
-	unsigned long flags;
-
-	to_tm(t, &tm);
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	/* unlock writes to the CCR */
-	xicor_write(X1241REG_SR, X1241REG_SR_WEL);
-	xicor_write(X1241REG_SR, X1241REG_SR_WEL | X1241REG_SR_RWEL);
-
-	/* trivial ones */
-	tm.tm_sec = BIN2BCD(tm.tm_sec);
-	xicor_write(X1241REG_SC, tm.tm_sec);
-
-	tm.tm_min = BIN2BCD(tm.tm_min);
-	xicor_write(X1241REG_MN, tm.tm_min);
-
-	tm.tm_mday = BIN2BCD(tm.tm_mday);
-	xicor_write(X1241REG_DT, tm.tm_mday);
-
-	/* tm_mon starts from 0, *ick* */
-	tm.tm_mon ++;
-	tm.tm_mon = BIN2BCD(tm.tm_mon);
-	xicor_write(X1241REG_MO, tm.tm_mon);
-
-	/* year is split */
-	tmp = tm.tm_year / 100;
-	tm.tm_year %= 100;
-	xicor_write(X1241REG_YR, tm.tm_year);
-	xicor_write(X1241REG_Y2K, tmp);
-
-	/* hour is the most tricky one */
-	tmp = xicor_read(X1241REG_HR);
-	if (tmp & X1241REG_HR_MIL) {
-		/* 24 hour format */
-		tm.tm_hour = BIN2BCD(tm.tm_hour);
-		tmp = (tmp & ~0x3f) | (tm.tm_hour & 0x3f);
-	} else {
-		/* 12 hour format, with 0x2 for pm */
-		tmp = tmp & ~0x3f;
-		if (tm.tm_hour >= 12) {
-			tmp |= 0x20;
-			tm.tm_hour -= 12;
-		}
-		tm.tm_hour = BIN2BCD(tm.tm_hour);
-		tmp |= tm.tm_hour;
-	}
-	xicor_write(X1241REG_HR, tmp);
-
-	xicor_write(X1241REG_SR, 0);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	return 0;
-}
-
-unsigned long xicor_get_time(void)
-{
-	unsigned int year, mon, day, hour, min, sec, y2k;
-	unsigned long flags;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	sec = xicor_read(X1241REG_SC);
-	min = xicor_read(X1241REG_MN);
-	hour = xicor_read(X1241REG_HR);
-
-	if (hour & X1241REG_HR_MIL) {
-		hour &= 0x3f;
-	} else {
-		if (hour & 0x20)
-			hour = (hour & 0xf) + 0x12;
-	}
-
-	day = xicor_read(X1241REG_DT);
-	mon = xicor_read(X1241REG_MO);
-	year = xicor_read(X1241REG_YR);
-	y2k = xicor_read(X1241REG_Y2K);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	sec = BCD2BIN(sec);
-	min = BCD2BIN(min);
-	hour = BCD2BIN(hour);
-	day = BCD2BIN(day);
-	mon = BCD2BIN(mon);
-	year = BCD2BIN(year);
-	y2k = BCD2BIN(y2k);
-
-	year += (y2k * 100);
-
-	return mktime(year, mon, day, hour, min, sec);
-}
-
-int xicor_probe(void)
-{
-	return (xicor_read(X1241REG_SC) != -1);
-}
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -29,6 +29,8 @@
  #include <linux/kernel.h>
  #include <linux/screen_info.h>
  #include <linux/initrd.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>

  #include <asm/irq.h>
  #include <asm/io.h>
@@ -56,14 +58,6 @@ extern void sb1250_setup(void);
  #error invalid SiByte board configuration
  #endif

-extern int xicor_probe(void);
-extern int xicor_set_time(unsigned long);
-extern unsigned long xicor_get_time(void);
-
-extern int m41t81_probe(void);
-extern int m41t81_set_time(unsigned long);
-extern unsigned long m41t81_get_time(void);
-
  const char *get_system_type(void)
  {
  	return "SiByte " SIBYTE_BOARD_NAME;
@@ -104,6 +98,40 @@ int swarm_be_handler(struct pt_regs *reg
  	return (is_fixup ? MIPS_BE_FIXUP : MIPS_BE_FATAL);
  }

+static struct platform_device swarm_i2c_adapters[2] = {
+	{
+		.name	= "i2c-sibyte",
+		.id	= 0,
+	}, {
+		.name	= "i2c-sibyte",
+		.id	= 1,
+	},
+};
+
+static struct platform_device __initdata *swarm_devices[] = {
+	&swarm_i2c_adapters[0],
+	&swarm_i2c_adapters[1],
+};
+
+static struct i2c_board_info __initdata swarm_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("rtc-m41t80", 0x68),
+		.type = "m41t81",
+	}, {
+		I2C_BOARD_INFO("rtc-xicor1241", 0x6F),
+		.type = "xicor1241",
+	},
+};
+
+static int __init swarm_init_devices(void)
+{
+	i2c_register_board_info(1, swarm_i2c_devices,
+			ARRAY_SIZE(swarm_i2c_devices));
+	platform_add_devices(swarm_devices, ARRAY_SIZE(swarm_devices));
+	return 0;
+}
+arch_initcall(swarm_init_devices);
+
  void __init plat_mem_setup(void)
  {
  #if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
@@ -119,18 +147,6 @@ void __init plat_mem_setup(void)
  	board_time_init = swarm_time_init;
  	board_be_handler = swarm_be_handler;

-	if (xicor_probe()) {
-		printk("swarm setup: Xicor 1241 RTC detected.\n");
-		rtc_mips_get_time = xicor_get_time;
-		rtc_mips_set_time = xicor_set_time;
-	}
-
-	if (m41t81_probe()) {
-		printk("swarm setup: M41T81 RTC detected.\n");
-		rtc_mips_get_time = m41t81_get_time;
-		rtc_mips_set_time = m41t81_set_time;
-	}
-
  	printk("This kernel optimized for "
  #ifdef CONFIG_SIMULATION
  	       "simulation"
