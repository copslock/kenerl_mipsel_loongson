Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 06:40:03 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:39622 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491124Ab0ACFj6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 06:39:58 +0100
Received: by yxe42 with SMTP id 42so14484519yxe.22
        for <multiple recipients>; Sat, 02 Jan 2010 21:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=RC4wGJMPB5FFgaqQlRQ0gIkX2rs9Yd+FrvubCPjCqt8=;
        b=sDpEVY0SQcK9mlMj0qtn5G/EvWgVR3e57tm4oRht09aodGe9DNU2MosWXkw8MOE5jD
         n6SJq9X0z3b36JLGEjKOuh2pg3vr+FfCvQHceJH7aTBddnu+WFJrldBoVeUyLMnQoXOY
         gbczW7MTIN2jde4pNXbCpHJ4S1romSb9PYGDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=YV/uN68d00je1n+J+w3nVbqCvnr3UZSJKzaxoj+7Kx3q1sIvFpn+1Z61cI80kh/U8k
         H/kIv7n1kytDJZvPywli/TOGDXc8KtLBnxi4ADu4DybZ5wS6EP4Zg9yjOfi9LcPxiuVC
         quB6qr91FgqFrgOQCmLIKg9G4Df6Tej3CqPMI=
Received: by 10.90.9.5 with SMTP id 5mr10885133agi.48.1262497191526;
        Sat, 02 Jan 2010 21:39:51 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 16sm8426687gxk.11.2010.01.02.21.39.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 21:39:48 -0800 (PST)
Date:   Sun, 3 Jan 2010 14:39:11 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: bcm63xx fix copy CONFIG_CMDLINE twice
Message-Id: <20100103143911.dafb7e06.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 25471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1841

builtin cmdline is copied by arch_mem_init()

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/bcm63xx/prom.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index fb284fb..be252ef 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -40,9 +40,6 @@ void __init prom_init(void)
 	reg &= ~mask;
 	bcm_perf_writel(reg, PERF_CKCTL_REG);
 
-	/* assign command line from kernel config */
-	strcpy(arcs_cmdline, CONFIG_CMDLINE);
-
 	/* register gpiochip */
 	bcm63xx_gpio_init();
 
-- 
1.6.5.7
