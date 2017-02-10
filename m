Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2017 10:07:13 +0100 (CET)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35978 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991976AbdBJJHGBLN3a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2017 10:07:06 +0100
Received: by mail-wm0-f66.google.com with SMTP id r18so6410949wmd.3;
        Fri, 10 Feb 2017 01:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5GALU244mnaWDgqN0hdkPaQ32y4vx/CSqfU3+9m1WJw=;
        b=HaAPHalGJbVcfT7joZOPqNV8rmN/KXUBn+R7i7px9YSQ0YIRnkoSP1ztFrt0GZBHbW
         JBqn3NWE2LqowrxGTRMKduH9bnV2sfSrPeCLks9OT0atwD8jtauJWme907kyeOWWImi5
         RtraqOZOP+u0TLd9aheS/MrLqU4NYh+gRTZNjqpO13rkGdNWIwWhvHDpSWVoxqHJjHti
         ZI9dquc56WRT18me0sNocBg/mm863roiBz5E7028ShmUm3uuQwnJXTaqzcMxNTYyq0C6
         jV5LLulcwtwMvb/74HKOvplaonfQjUfRDkptmKDrrH9nq2yK+/QYnWsJkNIRGCY9PF9E
         Ub1A==
X-Gm-Message-State: AMke39l4ZCvykt7enbObvaw59EGXQmMCEw3Nq5RBUOM01wRhmmtoEZ9MK49Sgyj7JKe8VQ==
X-Received: by 10.28.213.142 with SMTP id m136mr6959729wmg.90.1486717620712;
        Fri, 10 Feb 2017 01:07:00 -0800 (PST)
Received: from tfsielt31850.tycofs.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id r100sm1683928wrb.20.2017.02.10.01.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Feb 2017 01:07:00 -0800 (PST)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH] MIPS: ralink: fix mt7628 alternative functions names
Date:   Fri, 10 Feb 2017 09:06:59 +0000
Message-Id: <20170210090659.21873-1-git@andred.net>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <andre.draszik@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: git@andred.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

They're all referenced as utif in the datasheet, not util.

Fixes: 53263a1c6852 ("MIPS: ralink: add mt7628an support")
Fixes: 2b436a351803 ("MIPS: ralink: add MT7628 EPHY LEDs pinmux support")

Signed-off-by: André Draszik <git@andred.net>
---
 arch/mips/ralink/mt7620.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 3c7c9bf57bf3..6f892c1f3ad7 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -176,7 +176,7 @@ static struct rt2880_pmx_func spi_cs1_grp_mt7628[] = {
 
 static struct rt2880_pmx_func spis_grp_mt7628[] = {
 	FUNC("pwm_uart2", 3, 14, 4),
-	FUNC("util", 2, 14, 4),
+	FUNC("utif", 2, 14, 4),
 	FUNC("gpio", 1, 14, 4),
 	FUNC("spis", 0, 14, 4),
 };
@@ -190,28 +190,28 @@ static struct rt2880_pmx_func gpio_grp_mt7628[] = {
 
 static struct rt2880_pmx_func p4led_kn_grp_mt7628[] = {
 	FUNC("jtag", 3, 30, 1),
-	FUNC("util", 2, 30, 1),
+	FUNC("utif", 2, 30, 1),
 	FUNC("gpio", 1, 30, 1),
 	FUNC("p4led_kn", 0, 30, 1),
 };
 
 static struct rt2880_pmx_func p3led_kn_grp_mt7628[] = {
 	FUNC("jtag", 3, 31, 1),
-	FUNC("util", 2, 31, 1),
+	FUNC("utif", 2, 31, 1),
 	FUNC("gpio", 1, 31, 1),
 	FUNC("p3led_kn", 0, 31, 1),
 };
 
 static struct rt2880_pmx_func p2led_kn_grp_mt7628[] = {
 	FUNC("jtag", 3, 32, 1),
-	FUNC("util", 2, 32, 1),
+	FUNC("utif", 2, 32, 1),
 	FUNC("gpio", 1, 32, 1),
 	FUNC("p2led_kn", 0, 32, 1),
 };
 
 static struct rt2880_pmx_func p1led_kn_grp_mt7628[] = {
 	FUNC("jtag", 3, 33, 1),
-	FUNC("util", 2, 33, 1),
+	FUNC("utif", 2, 33, 1),
 	FUNC("gpio", 1, 33, 1),
 	FUNC("p1led_kn", 0, 33, 1),
 };
@@ -232,28 +232,28 @@ static struct rt2880_pmx_func wled_kn_grp_mt7628[] = {
 
 static struct rt2880_pmx_func p4led_an_grp_mt7628[] = {
 	FUNC("jtag", 3, 39, 1),
-	FUNC("util", 2, 39, 1),
+	FUNC("utif", 2, 39, 1),
 	FUNC("gpio", 1, 39, 1),
 	FUNC("p4led_an", 0, 39, 1),
 };
 
 static struct rt2880_pmx_func p3led_an_grp_mt7628[] = {
 	FUNC("jtag", 3, 40, 1),
-	FUNC("util", 2, 40, 1),
+	FUNC("utif", 2, 40, 1),
 	FUNC("gpio", 1, 40, 1),
 	FUNC("p3led_an", 0, 40, 1),
 };
 
 static struct rt2880_pmx_func p2led_an_grp_mt7628[] = {
 	FUNC("jtag", 3, 41, 1),
-	FUNC("util", 2, 41, 1),
+	FUNC("utif", 2, 41, 1),
 	FUNC("gpio", 1, 41, 1),
 	FUNC("p2led_an", 0, 41, 1),
 };
 
 static struct rt2880_pmx_func p1led_an_grp_mt7628[] = {
 	FUNC("jtag", 3, 42, 1),
-	FUNC("util", 2, 42, 1),
+	FUNC("utif", 2, 42, 1),
 	FUNC("gpio", 1, 42, 1),
 	FUNC("p1led_an", 0, 42, 1),
 };
-- 
2.11.0
