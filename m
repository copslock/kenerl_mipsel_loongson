Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2011 17:41:58 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45826 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491932Ab1F0PiI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jun 2011 17:38:08 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5RFc2G5019402;
        Mon, 27 Jun 2011 16:38:03 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5RFc2cY019400;
        Mon, 27 Jun 2011 16:38:02 +0100
Message-Id: <76e1849ea61248353ebb2b2b60ba36c6ea1b34b4.1309182743.git.ralf@linux-mips.org>
In-Reply-To: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Richard Purdie <rpurdie@rpsys.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Date:   Sun, 26 Jun 2011 12:30:22 +0100
Subject: [PATCH 08/12] LED: lp5521: Fix section mismatches
X-archive-position: 30530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21987

WARNING: drivers/leds/leds-lp5521.o(.text+0xf2c): Section mismatch in reference from the function lp5521_probe() to the function .init.text:lp5521_init_led()
The function lp5521_probe() references
the function __init lp5521_init_led().
This is often because lp5521_probe lacks a __init
annotation or the annotation of lp5521_init_led is wrong.

Fixing this mismatch triggers one more mismatch, fix that one as well.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/leds/leds-lp5521.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
index c0cff64..cc1dc48 100644
--- a/drivers/leds/leds-lp5521.c
+++ b/drivers/leds/leds-lp5521.c
@@ -593,7 +593,7 @@ static void lp5521_unregister_sysfs(struct i2c_client *client)
 				&lp5521_led_attribute_group);
 }
 
-static int __init lp5521_init_led(struct lp5521_led *led,
+static int __devinit lp5521_init_led(struct lp5521_led *led,
 				struct i2c_client *client,
 				int chan, struct lp5521_platform_data *pdata)
 {
@@ -637,7 +637,7 @@ static int __init lp5521_init_led(struct lp5521_led *led,
 	return 0;
 }
 
-static int lp5521_probe(struct i2c_client *client,
+static int __devinit lp5521_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct lp5521_chip		*chip;
-- 
1.7.4.4
