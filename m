Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2011 17:39:30 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45801 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491926Ab1F0PiE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jun 2011 17:38:04 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5RFc1SR019387;
        Mon, 27 Jun 2011 16:38:01 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5RFc1d0019386;
        Mon, 27 Jun 2011 16:38:01 +0100
Message-Id: <5c64aa41d9d581af5c6863c4c7078fb9dfb381d5.1309182743.git.ralf@linux-mips.org>
In-Reply-To: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Jaroslav Kysela <perex@perex.cz>, netdev@vger.kernel.org,
        linux-mips@linux-mips.org
Date:   Sun, 26 Jun 2011 12:24:57 +0100
Subject: [PATCH 05/12] NET: hp100: Fix section mismatches
X-archive-position: 30524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21976

WARNING: drivers/net/hp100.o(.data+0x70): Section mismatch in reference from the variable hp100_eisa_driver to the function .init.text:hp100_eisa_probe()
The variable hp100_eisa_driver references
the function __init hp100_eisa_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: netdev@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/net/hp100.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/hp100.c b/drivers/net/hp100.c
index c3ecb11..9cd575f 100644
--- a/drivers/net/hp100.c
+++ b/drivers/net/hp100.c
@@ -2843,7 +2843,7 @@ static void cleanup_dev(struct net_device *d)
 }
 
 #ifdef CONFIG_EISA
-static int __init hp100_eisa_probe (struct device *gendev)
+static int __devinit hp100_eisa_probe(struct device *gendev)
 {
 	struct net_device *dev = alloc_etherdev(sizeof(struct hp100_private));
 	struct eisa_device *edev = to_eisa_device(gendev);
-- 
1.7.4.4
