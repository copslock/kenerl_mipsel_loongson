Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 08:52:38 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:37797 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021895AbXC1Hwe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 08:52:34 +0100
Received: by ug-out-1314.google.com with SMTP id 40so140407uga
        for <linux-mips@linux-mips.org>; Wed, 28 Mar 2007 00:51:34 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=qCk1BSJqKIfNXIhMkHjFIJPyMrGwsUdIn8v5Oq+Im0l4jaD4KpvDK3KCT7V6ASyKkkNOgbIs1NKBZ69lIJMaqUA8U/4ep5ST/VbTdHJi/Vg/RbdINecd5M1i2NR9U6bG1QlXdir0TSjhRsu4c9tIuH34O+rIk+yCpmteV+vLHZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=Kxtny8o0DTDGwM8kCgwFHafNzQKlx1d1xptjENwalveV6+YOPrdjLP6tgoZLZ5aef9RcIEpUJKeSglthnswUm8HzOy/n1Ew11dnoIgsIaIY17tDo7QkjhlJWqt9nx7B9ItQglo2tygRvT6TYAKyHti2myppsKI1uliNexyU2TYs=
Received: by 10.66.243.2 with SMTP id q2mr452937ugh.1175068294354;
        Wed, 28 Mar 2007 00:51:34 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id z33sm22394118ikz.2007.03.28.00.51.33;
        Wed, 28 Mar 2007 00:51:33 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 441C223F76F; Wed, 28 Mar 2007 08:51:30 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 1/2] early_printk: use init section
Date:	Wed, 28 Mar 2007 08:51:29 +0200
Message-Id: <11750646902981-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.rc1.27.g1d848
In-Reply-To: <20070327175733.GA26496@linux-mips.org>
References: <20070327175733.GA26496@linux-mips.org>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/early_printk.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/early_printk.c b/arch/mips/kernel/early_printk.c
index 304efdc..57ba73a 100644
--- a/arch/mips/kernel/early_printk.c
+++ b/arch/mips/kernel/early_printk.c
@@ -12,7 +12,8 @@
 
 extern void prom_putchar(char);
 
-static void early_console_write(struct console *con, const char *s, unsigned n)
+static void __init
+early_console_write(struct console *con, const char *s, unsigned n)
 {
 	while (n-- && *s) {
 		if (*s == '\n')
@@ -22,7 +23,7 @@ static void early_console_write(struct console *con, const char *s, unsigned n)
 	}
 }
 
-static struct console early_console = {
+static struct console early_console __initdata = {
 	.name	= "early",
 	.write	= early_console_write,
 	.flags	= CON_PRINTBUFFER | CON_BOOT,
-- 
1.5.1.rc1.27.g1d848
