Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Nov 2014 09:56:34 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:52651 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013061AbaKII4d1vtA4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Nov 2014 09:56:33 +0100
Received: by mail-pa0-f42.google.com with SMTP id bj1so6310485pad.1
        for <linux-mips@linux-mips.org>; Sun, 09 Nov 2014 00:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hny+BuWeqMS+DA+IpstQ6EN1tPyxgw7+rPFXjlH/yVE=;
        b=GDa3wVk5//DgoZGq8v2/Fet58HYxgk3s6tqfvNF+LLJwGibpN620RgRuJRhJCEWvIC
         gY5w5hTNtMK6NHODk4Quc+1J/49KgT5N/VGBllJYy3wQBBJhLqWC8dobo3dJdV+VNKwW
         0fFpUCOqIrMf1QLUuDu04uRocyFOGzG7WxKArdfH4+n0hMmLyKhIq946qvWpq2HwPIQE
         gRgtEoRYBNGVR5dT73cAqjuh3y+b0Iebwo0OQLkHdKfwgb9D+QjtR3SKWdHcBE+INRdW
         fakLZh21gGbYN5ucf92wosKMJen7nRv9rpW1nvN/zfDwG40sPIBGLp5s+H8jKP1fP5ok
         mpSg==
X-Received: by 10.68.68.141 with SMTP id w13mr24468184pbt.82.1415523387143;
        Sun, 09 Nov 2014 00:56:27 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id i11sm13248958pbq.84.2014.11.09.00.56.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Nov 2014 00:56:26 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/2] of: Fix crash if an earlycon driver is not found
Date:   Sun,  9 Nov 2014 00:55:47 -0800
Message-Id: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

__earlycon_of_table_sentinel.compatible is a char[128], not a pointer, so
it will never be NULL.  Checking it against NULL causes the match loop to
run past the end of the array, and eventually match a bogus entry, under
the following conditions:

 - Kernel command line specifies "earlycon" with no parameters
 - DT has a stdout-path pointing to a UART node
 - The UART driver doesn't use OF_EARLYCON_DECLARE (or maybe the console
   driver is compiled out)

Fix this by checking to see if match->compatible is a non-empty string.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Cc: <stable@vger.kernel.org> # 3.16+
---
 drivers/of/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d1ffca8..30e97bc 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -773,7 +773,7 @@ int __init early_init_dt_scan_chosen_serial(void)
 	if (offset < 0)
 		return -ENODEV;
 
-	while (match->compatible) {
+	while (match->compatible[0]) {
 		unsigned long addr;
 		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
 			match++;
-- 
2.1.1
