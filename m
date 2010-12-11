Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Dec 2010 14:13:16 +0100 (CET)
Received: from mail-ew0-f54.google.com ([209.85.215.54]:47273 "EHLO
        mail-ew0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491138Ab0LKNNN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Dec 2010 14:13:13 +0100
Received: by ewy24 with SMTP id 24so3180780ewy.27
        for <multiple recipients>; Sat, 11 Dec 2010 05:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=v0cTdGci7cw4E8rob7CoM0vvgFVfikIE3L+mg7WJ8xE=;
        b=wjD0RQhugVDTwYeqzblk1KNvWo4JLN2xIdttMRipTH08cfrm94wM2BUQqa3qis7mn/
         8x5xscYCCjM8eFp0t0cK60pfGq7ZCVXI04B6LKrmkl0ejy8Xn/9jkjrBpFDzYGHcmrSN
         o2JpLQ7MpVmOQXuji+DVhht3/zjHq30ALjqEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jNOspWbK1vb4U0bxlcEP7kBmFZLSEz3bvgWTiW20p9GWHSFaBKJ/KXtO8cbR5hnxLY
         QJwftADsYsqHrvM/1nWV353Kwh0GNkcfL8DDBRLMI2EZgdN5fSJWNnok2mgmOg/fYxl2
         mJOAlzDdk7KYzOVgSBHvceyD4Veu8t+q7egWI=
Received: by 10.213.108.72 with SMTP id e8mr515613ebp.70.1292073192742;
        Sat, 11 Dec 2010 05:13:12 -0800 (PST)
Received: from localhost.localdomain (178-191-12-185.adsl.highway.telekom.at [178.191.12.185])
        by mx.google.com with ESMTPS id u1sm918517eeh.22.2010.12.11.05.13.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Dec 2010 05:13:12 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH v3] MIPS: Alchemy: fix build with SERIAL_8250=n
Date:   Sat, 11 Dec 2010 14:13:04 +0100
Message-Id: <1292073184-24117-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.3.3
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

In commit 7d172bfe ("Alchemy: Add UART PM methods") I introduced
platform PM methods which call a function of the 8250 driver;
this patch works around link failures when the kernel is built
without 8250 support.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Run-tested on DB1200.

v3: account for modular 8250 code.
v2: added commit name to patch description as per Sergei's suggestion.

 arch/mips/alchemy/common/platform.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 3691630..66ca7c5 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -27,6 +27,12 @@
 static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
 			    unsigned int old_state)
 {
+	/* account for 8250.c built as module.  This code can only be called
+	 * by 8250.c so symbol_get should never fail.
+	 */
+	void(*pm_func)(struct uart_port *, unsigned int, unsigned int);
+	pm_func = symbol_get(serial8250_do_pm);
+
 	switch (state) {
 	case 0:
 		if ((__raw_readl(port->membase + UART_MOD_CNTRL) & 3) != 3) {
@@ -38,17 +44,19 @@ static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
 		}
 		__raw_writel(3, port->membase + UART_MOD_CNTRL); /* full on */
 		wmb();
-		serial8250_do_pm(port, state, old_state);
+		pm_func(port, state, old_state);
 		break;
 	case 3:		/* power off */
-		serial8250_do_pm(port, state, old_state);
+		pm_func(port, state, old_state);
 		__raw_writel(0, port->membase + UART_MOD_CNTRL);
 		wmb();
 		break;
 	default:
-		serial8250_do_pm(port, state, old_state);
+		pm_func(port, state, old_state);
 		break;
 	}
+
+	symbol_put(pm_func);
 }
 
 #define PORT(_base, _irq)					\
-- 
1.7.3.3
