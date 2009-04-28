Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 06:50:35 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.250]:15179 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023855AbZD1Fu2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2009 06:50:28 +0100
Received: by rv-out-0708.google.com with SMTP id k29so238637rvb.24
        for <multiple recipients>; Mon, 27 Apr 2009 22:50:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject:cc
         :message-id:from:date;
        bh=Pi7CEBO/kimanAdkF4OQl3o4uoPW5dQ90YTm0Mw7nzI=;
        b=ZuXtP6cnIEgbPI/1tZcBCOKRoyNs9c90aAEl9WwGktVo9JSPDZ4chpxJh1mWaZ+IJC
         K3mGrHRAz+tfKg51WOl9xYUkA8x2dvJWijRIPO9x62N2qCLPU6uu3R87DML5sFhyI5m0
         CbQnH8YqG+IrQpfnL4qPn4YWi2Lf5JC5TG9w4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:cc:message-id:from:date;
        b=miMBCtox67JBG4s44CwdLZdvRsZL8bn8qFVRGmaGZNrLohUk6yfgBKFOSOqJlCKlDx
         OOHXbv/0GlG7cggCrEnIP8B9muyTBZ47maFdEruESfAWDsttQuKFFCc7aCoOdRnM3TkR
         bUxXZNrbCggbWqp4acdSvE7v0kqSwq474q714=
Received: by 10.140.162.21 with SMTP id k21mr2069334rve.191.1240897826484;
        Mon, 27 Apr 2009 22:50:26 -0700 (PDT)
Received: from localhost (207-47-250-185.sktn.hsdb.sasknet.sk.ca [207.47.250.185])
        by mx.google.com with ESMTPS id f42sm3282635rvb.1.2009.04.27.22.50.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 22:50:25 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.63)
	(envelope-from <shane@localhost>)
	id 1LygCz-00068C-Ay; Mon, 27 Apr 2009 23:50:21 -0600
To:	linux-mips@linux-mips.org
Subject: [MIPS] Resolve multiple definition of plat_timer_setup in msp71xx
Cc:	ralf@linux-mips.org
Message-Id: <E1LygCz-00068C-Ay@localhost>
From:	Shane McDonald <mcdonald.shane@gmail.com>
Date:	Mon, 27 Apr 2009 23:50:21 -0600
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

There have been a number of compile problems with the msp71xx
configuration ever since it was included in the linux-mips.org
repository.  This patch resolves the "multiple definition of
plat_timer_setup" problem, and creates the required
get_c0_compare_int function.

This patch has been compile-tested against the current HEAD.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
 arch/mips/pmc-sierra/msp71xx/msp_time.c  |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c b/arch/mips/pmc-sierra/msp71xx/msp_time.c
index 7cfeda5..cca64e1 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_time.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
@@ -81,10 +81,7 @@ void __init plat_time_init(void)
 	mips_hpt_frequency = cpu_rate/2;
 }
 
-void __init plat_timer_setup(struct irqaction *irq)
+unsigned int __init get_c0_compare_int(void)
 {
-#ifdef CONFIG_IRQ_MSP_CIC
-	/* we are using the vpe0 counter for timer interrupts */
-	setup_irq(MSP_INT_VPE0_TIMER, irq);
-#endif
+	return MSP_INT_VPE0_TIMER;
 }
-- 
1.5.6.5
