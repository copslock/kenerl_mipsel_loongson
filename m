Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Nov 2010 05:53:58 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:48030 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491067Ab0KOExN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Nov 2010 05:53:13 +0100
Received: by mail-yw0-f49.google.com with SMTP id 7so1814926ywf.36
        for <multiple recipients>; Sun, 14 Nov 2010 20:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=xjY5Rx29mx1wztFVSGJMO92P9c0I09KEI5o0g40TyaQ=;
        b=tHCFUm7sM6dloGTPZZazSNgnFosBcokWTjKNRc/I3TBnYnMEl2msW2EQan+mF93HZy
         Gl4lFEaQnWuDfvE5LeFRdRY/XvPSno6doIg4SRTiC/WKyyAe6gdipruAJ16rpQRmFzwH
         sBI0zj31lFXmvaTNgK9ahtdb4LOGjilJTP+lA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Hhl33KwaiD7ixuDSo5PzyDdMYLqbxqpcXE4/5unWevc1veklV/spIj4XF5RSKVmCqj
         26fDzUXv8T1Q2R4FKY+pl7tl8wsnGyZiJlbAAgJQmUy3WrPxwLKzJrjz4Un3irBzA/FP
         +WihqC3wnUh3+KAFtOWcTz5ilGji223wT3joQ=
Received: by 10.90.57.3 with SMTP id f3mr7147560aga.120.1289796792640;
        Sun, 14 Nov 2010 20:53:12 -0800 (PST)
Received: from mattst88@gmail.com (cpe-065-190-173-137.nc.res.rr.com [65.190.173.137])
        by mx.google.com with ESMTPS id j64sm4328211yha.24.2010.11.14.20.53.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 20:53:11 -0800 (PST)
Received: by mattst88@gmail.com (sSMTP sendmail emulation); Sun, 14 Nov 2010 23:54:37 -0500
From:   Matt Turner <mattst88@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>, kaloz@openwrt.org,
        Mark Zhan <rongkai.zhan@windriver.com>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 2/3] MIPS: clean up SWARM RTC setup
Date:   Sun, 14 Nov 2010 23:53:48 -0500
Message-Id: <1289796829-29222-3-git-send-email-mattst88@gmail.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1289796829-29222-1-git-send-email-mattst88@gmail.com>
References: <1289796829-29222-1-git-send-email-mattst88@gmail.com>
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28395
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
 arch/mips/sibyte/swarm/setup.c |   49 +--------------------------------------
 1 files changed, 2 insertions(+), 47 deletions(-)

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
