Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2011 14:43:07 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56102 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491819Ab1HOMnD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Aug 2011 14:43:03 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p7FCgDKk025623
        for <linux-mips@linux-mips.org>; Mon, 15 Aug 2011 13:42:13 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p7FCgDAf025621
        for linux-mips@linux-mips.org; Mon, 15 Aug 2011 13:42:13 +0100
Resent-From: Ralf Baechle <ralf@linux-mips.org>
Resent-Date: Mon, 15 Aug 2011 13:42:13 +0100
Resent-Message-ID: <20110815124213.GA25536@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Received: from vger.kernel.org ([209.132.180.67]:42299 "EHLO vger.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491931Ab1HOJSK (ORCPT <rfc822;ralf@linux-mips.org>);
        Mon, 15 Aug 2011 11:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726Ab1HOJSJ (ORCPT <rfc822;ralf@linux-mips.org> + 1 other);
        Mon, 15 Aug 2011 05:18:09 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45800 "EHLO
        mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674Ab1HOJSI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Aug 2011 05:18:08 -0400
Received: by wwf5 with SMTP id 5so4661742wwf.1
        for <linux-serial@vger.kernel.org>; Mon, 15 Aug 2011 02:18:07 -0700 (PDT)
Received: by 10.227.19.137 with SMTP id a9mr3210231wbb.105.1313399887364;
        Mon, 15 Aug 2011 02:18:07 -0700 (PDT)
Received: from localhost (gw-ba1.picochip.com [94.175.234.108])
        by mx.google.com with ESMTPS id em16sm4394259wbb.50.2011.08.15.02.18.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Aug 2011 02:18:05 -0700 (PDT)
From:   Jamie Iles <jamie@jamieiles.com>
To:     linux-serial@vger.kernel.org
Cc:     arnd@arndb.de, Jamie Iles <jamie@jamieiles.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/5] mips: msp71xx/serial: convert to pr_foo() helpers
Date:   Mon, 15 Aug 2011 10:17:53 +0100
Message-Id: <1313399875-11006-4-git-send-email-jamie@jamieiles.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
References: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
X-archive-position: 30875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10802

Convert to pr_foo() helpers rather than printk(KERN_.*).

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/mips/pmc-sierra/msp71xx/msp_serial.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_serial.c b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
index f726162..c3247b5 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_serial.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
@@ -65,7 +65,7 @@ void __init msp_serial_setup(void)
 	up.line         = 0;
 	up.private_data		= (void*)UART0_STATUS_REG;
 	if (early_serial_setup(&up))
-		printk(KERN_ERR "Early serial init of port 0 failed\n");
+		pr_err("Early serial init of port 0 failed\n");
 
 	/* Initialize the second serial port, if one exists */
 	switch (mips_machtype) {
@@ -89,5 +89,5 @@ void __init msp_serial_setup(void)
 	up.line         = 1;
 	up.private_data		= (void*)UART1_STATUS_REG;
 	if (early_serial_setup(&up))
-		printk(KERN_ERR "Early serial init of port 1 failed\n");
+		pr_err("Early serial init of port 1 failed\n");
 }
-- 
1.7.4.1

