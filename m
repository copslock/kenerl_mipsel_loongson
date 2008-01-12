Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2008 13:04:55 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.159]:10459 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20031728AbYALNEr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 12 Jan 2008 13:04:47 +0000
Received: by fg-out-1718.google.com with SMTP id d23so1426083fga.32
        for <linux-mips@linux-mips.org>; Sat, 12 Jan 2008 05:04:46 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=M9oxPAlivF3jWDRHCrrFn63SdHADbAElvwq/a/06cE4=;
        b=bE1HQ1EZhDWOoVOf96/05z8nFDdTRSMn9sGo4aFQbnTbEw9i73pxpqfjNQzS4iOsWPeUEgRICHQQhmTbxYwZZlSXRt7vY5vgIbQzDB14nsvSh6FvUhXH4ZWN5+ZTLHRejfNHuMKCMlBCsCn7AsyoRYdKRsTWiwEB6TILdqeoR94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=BEULqgzGrEmJy6STuv/qXMd4HUNRB4LVEGrHsieMsw8gPVG6vimOPgWQtrPh+Rd9KUgWobCLk8zd2UyYg5kYaT8esELKLjO8s6LHLgi9qUS441lr9q8yqnwSfAJisKLaESEnWYBKLkEzusNXHwBOzkMjD6bt+4oLaFEKgXz5eV0=
Received: by 10.82.116.15 with SMTP id o15mr7369881buc.3.1200143086471;
        Sat, 12 Jan 2008 05:04:46 -0800 (PST)
Received: from ?89.253.12.221? ( [89.253.12.221])
        by mx.google.com with ESMTPS id w5sm13368539mue.2.2008.01.12.05.04.40
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jan 2008 05:04:45 -0800 (PST)
Message-ID: <4788BAAC.3020908@gmail.com>
Date:	Sat, 12 Jan 2008 16:03:40 +0300
From:	Vitaly Wool <vitalywool@gmail.com>
User-Agent: Icedove 1.5.0.12 (X11/20070607)
MIME-Version: 1.0
To:	ralf@linux-mips.org, sshtylyov@ru.mvista.com
CC:	linux-mips@linux-mips.org
Subject: [patch] pnx8xxx clocksource cleanups
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vitalywool@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vitalywool@gmail.com
Precedence: bulk
X-list: linux-mips

This patch does some PNX8XXX clocksource cleanups.

 arch/mips/philips/pnx8550/common/time.c |   35 ++++++++++----------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

Index: linux-mips.git/arch/mips/philips/pnx8550/common/time.c
===================================================================
--- linux-mips.git.orig/arch/mips/philips/pnx8550/common/time.c
+++ linux-mips.git/arch/mips/philips/pnx8550/common/time.c
@@ -47,11 +47,6 @@ static struct clocksource pnx_clocksourc
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static void timer_ack(void)
-{
-	write_c0_compare(cpj);
-}
-
 static irqreturn_t pnx8xxx_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *c = dev_id;
@@ -94,30 +89,22 @@ static struct clock_event_device pnx8xxx
 	.set_next_event = pnx8xxx_set_next_event,
 };
 
-/*
- * plat_time_init() - it does the following things:
- *
- * 1) plat_time_init() -
- * 	a) (optional) set up RTC routines,
- *      b) (optional) calibrate and set the mips_hpt_frequency
- *	    (only needed if you intended to use cpu counter as timer interrupt
- *	     source)
- */
+static inline void timer_ack(void)
+{
+	write_c0_compare(cpj);
+}
 
 __init void plat_time_init(void)
 {
-	unsigned int             configPR;
-	unsigned int             n;
-	unsigned int             m;
-	unsigned int             p;
-	unsigned int             pow2p;
+	unsigned int configPR;
+	unsigned int n;
+	unsigned int m;
+	unsigned int p;
+	unsigned int pow2p;
 
 	clockevents_register_device(&pnx8xxx_clockevent);
 	clocksource_register(&pnx_clocksource);
 
-	setup_irq(PNX8550_INT_TIMER1, &pnx8xxx_timer_irq);
-	setup_irq(PNX8550_INT_TIMER2, &monotonic_irqaction);
-
 	/* Timer 1 start */
 	configPR = read_c0_config7();
 	configPR &= ~0x00000008;
@@ -158,6 +145,6 @@ __init void plat_time_init(void)
 	write_c0_count2(0);
 	write_c0_compare2(0xffffffff);
 
+	setup_irq(PNX8550_INT_TIMER1, &pnx8xxx_timer_irq);
+	setup_irq(PNX8550_INT_TIMER2, &monotonic_irqaction);
 }
-
-
