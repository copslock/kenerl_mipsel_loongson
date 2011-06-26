Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2011 17:38:10 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45791 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491923Ab1F0PiD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jun 2011 17:38:03 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5RFc0NB019374;
        Mon, 27 Jun 2011 16:38:00 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5RFbxTe019372;
        Mon, 27 Jun 2011 16:37:59 +0100
Message-Id: <ab495fabda7fe6b70a76e5592fb3a0c1180b325b.1309182743.git.ralf@linux-mips.org>
In-Reply-To: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Date:   Sun, 26 Jun 2011 12:21:31 +0100
Subject: [PATCH 02/12] NET: 3c509: Fix section mismatch
X-archive-position: 30521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21965

WARNING: drivers/net/3c509.o(.data+0x190): Section mismatch in reference from the variable el3_eisa_driver to the function .init.text:el3_eisa_probe()
The variable el3_eisa_driver references
the function __init el3_eisa_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/net/3c509.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/3c509.c b/drivers/net/3c509.c
index 44b28b2..dc4bf07 100644
--- a/drivers/net/3c509.c
+++ b/drivers/net/3c509.c
@@ -671,7 +671,7 @@ static int __init el3_mca_probe(struct device *device)
 #endif /* CONFIG_MCA */
 
 #ifdef CONFIG_EISA
-static int __init el3_eisa_probe (struct device *device)
+static int __devinit el3_eisa_probe(struct device *device)
 {
 	short i;
 	int ioaddr, irq, if_port;
-- 
1.7.4.4
