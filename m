Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Dec 2010 05:16:45 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:43067 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490955Ab0LFEQj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Dec 2010 05:16:39 +0100
Received: by gyg4 with SMTP id 4so6224490gyg.36
        for <multiple recipients>; Sun, 05 Dec 2010 20:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=M0fXeTXpLLQwT1mJbj4gQt21/JDP8r3qeMA9kGhevb8=;
        b=YQsev6DYTDNdtBqddBQcElQQdZ03viPQjTP+PwR27TxMHJtIQrk1S+CGK2cUUSYexF
         IZ69fFLvLVeTcjpCM3434MJ7rI32r8T5zWcauMr08lBY9Ie/PHu9BAZLT2U3nbCAmoVS
         p/BxP90//68TmcECLXo8o0zagXW5WvWo66/lI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JQ/LNcu0nwUW8UhuF52n/e+65fKm2ih3S3pooEJVJtj9wDhRSXKsHlxLsaCUI421pM
         dj1kNILda2zorMd/nZWjJ1w3j0sOFcquzmvstW6uZeJUiVtJtKDqkx5lo63j18XY5a88
         gb2C38r8LMOhrj4KwvzXgAODk9eveXAxVXATU=
Received: by 10.151.150.4 with SMTP id c4mr8751987ybo.6.1291608992274;
        Sun, 05 Dec 2010 20:16:32 -0800 (PST)
Received: from localhost (cpe-065-190-173-137.nc.res.rr.com [65.190.173.137])
        by mx.google.com with ESMTPS id p30sm3014822ybk.20.2010.12.05.20.16.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 20:16:31 -0800 (PST)
From:   Matt Turner <mattst88@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jean Delvare <khali@linux-fr.org>, linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 2/3] MIPS: clean up SWARM RTC setup
Date:   Sun,  5 Dec 2010 23:16:40 -0500
Message-Id: <1291609000-17028-1-git-send-email-mattst88@gmail.com>
X-Mailer: git-send-email 1.7.2.2
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips

From: Maciej W. Rozycki <macro@linux-mips.org>

Tested-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/mips/sibyte/swarm/Makefile        |    3 +-
 arch/mips/sibyte/swarm/rtc_m41t81.c    |  233 --------------------------------
 arch/mips/sibyte/swarm/rtc_xicor1241.c |  210 ----------------------------
 arch/mips/sibyte/swarm/setup.c         |   49 +-------
 4 files changed, 3 insertions(+), 492 deletions(-)
 delete mode 100644 arch/mips/sibyte/swarm/rtc_m41t81.c
 delete mode 100644 arch/mips/sibyte/swarm/rtc_xicor1241.c

diff --git a/arch/mips/sibyte/swarm/Makefile b/arch/mips/sibyte/swarm/Makefile
index 7b45f19..4676af3 100644
--- a/arch/mips/sibyte/swarm/Makefile
+++ b/arch/mips/sibyte/swarm/Makefile
@@ -1,4 +1,3 @@
-obj-y				:= platform.o setup.o rtc_xicor1241.o \
-				   rtc_m41t81.o
+obj-y				:= platform.o setup.o
 
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
diff --git a/arch/mips/sibyte/swarm/rtc_xicor1241.c b/arch/mips/sibyte/swarm/rtc_xicor1241.c
deleted file mode 100644
index 4438b21..0000000
--- a/arch/mips/sibyte/swarm/rtc_xicor1241.c
+++ /dev/null
@@ -1,210 +0,0 @@
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
-	rtc_time_to_tm(t, &tm);
-	tm.tm_year += 1900;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	/* unlock writes to the CCR */
-	xicor_write(X1241REG_SR, X1241REG_SR_WEL);
-	xicor_write(X1241REG_SR, X1241REG_SR_WEL | X1241REG_SR_RWEL);
-
-	/* trivial ones */
-	tm.tm_sec = bin2bcd(tm.tm_sec);
-	xicor_write(X1241REG_SC, tm.tm_sec);
-
-	tm.tm_min = bin2bcd(tm.tm_min);
-	xicor_write(X1241REG_MN, tm.tm_min);
-
-	tm.tm_mday = bin2bcd(tm.tm_mday);
-	xicor_write(X1241REG_DT, tm.tm_mday);
-
-	/* tm_mon starts from 0, *ick* */
-	tm.tm_mon ++;
-	tm.tm_mon = bin2bcd(tm.tm_mon);
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
-		tm.tm_hour = bin2bcd(tm.tm_hour);
-		tmp = (tmp & ~0x3f) | (tm.tm_hour & 0x3f);
-	} else {
-		/* 12 hour format, with 0x2 for pm */
-		tmp = tmp & ~0x3f;
-		if (tm.tm_hour >= 12) {
-			tmp |= 0x20;
-			tm.tm_hour -= 12;
-		}
-		tm.tm_hour = bin2bcd(tm.tm_hour);
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
-	sec = bcd2bin(sec);
-	min = bcd2bin(min);
-	hour = bcd2bin(hour);
-	day = bcd2bin(day);
-	mon = bcd2bin(mon);
-	year = bcd2bin(year);
-	y2k = bcd2bin(y2k);
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
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 41707a2..5143f68 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -56,14 +56,6 @@ extern void sb1250_setup(void);
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
@@ -79,49 +71,17 @@ int swarm_be_handler(struct pt_regs *regs, int is_fixup)
 	return (is_fixup ? MIPS_BE_FIXUP : MIPS_BE_FATAL);
 }
 
-enum swarm_rtc_type {
-	RTC_NONE,
-	RTC_XICOR,
-	RTC_M41T81,
-};
-
-enum swarm_rtc_type swarm_rtc_type;
-
 void read_persistent_clock(struct timespec *ts)
 {
 	unsigned long sec;
-
-	switch (swarm_rtc_type) {
-	case RTC_XICOR:
-		sec = xicor_get_time();
-		break;
-
-	case RTC_M41T81:
-		sec = m41t81_get_time();
-		break;
-
-	case RTC_NONE:
-	default:
-		sec = mktime(2000, 1, 1, 0, 0, 0);
-		break;
-	}
+	sec = mktime(2000, 1, 1, 0, 0, 0);
 	ts->tv_sec = sec;
 	ts->tv_nsec = 0;
 }
 
 int rtc_mips_set_time(unsigned long sec)
 {
-	switch (swarm_rtc_type) {
-	case RTC_XICOR:
-		return xicor_set_time(sec);
-
-	case RTC_M41T81:
-		return m41t81_set_time(sec);
-
-	case RTC_NONE:
-	default:
-		return -1;
-	}
+	return -1;
 }
 
 void __init plat_mem_setup(void)
@@ -138,11 +98,6 @@ void __init plat_mem_setup(void)
 
 	board_be_handler = swarm_be_handler;
 
-	if (xicor_probe())
-		swarm_rtc_type = RTC_XICOR;
-	if (m41t81_probe())
-		swarm_rtc_type = RTC_M41T81;
-
 #ifdef CONFIG_VT
 	screen_info = (struct screen_info) {
 		.orig_video_page	= 52,
-- 
1.7.3.2
