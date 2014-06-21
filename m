Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jun 2014 23:24:17 +0200 (CEST)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:64246 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859946AbaFUVYKzHi1p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jun 2014 23:24:10 +0200
Received: by mail-wg0-f48.google.com with SMTP id n12so4970745wgh.31
        for <linux-mips@linux-mips.org>; Sat, 21 Jun 2014 14:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=u6DO3Gg2J3PlBVFIiUZumgAkdu/tImfFPIGaInC3o7g=;
        b=naym+zgh8b1TPEmN+Kgzi1JJNl0pz0rdtBjb0jQaXkwiFeYs91Q894oA8ADQQFaW70
         gwLPuVIks93p4quZLsH8yOP4LwnbgJ55afapR9UCQUJE3RmHVnskP1gBZRg4EM931GYI
         V3Wlqa5Xb2RSqBk2cBbA9wny7vD4mT4VopQEqeVeggp8BuBAFmzB0seoyMhKJELxM4Ht
         9qyFHkgz0j4e5tMwOl/IFPO+jzFYhHUMt0J6BwgsxxoBvtxhUTnxf2EY9KJVak34kX1h
         5+pU8wpYsqQ9/gHmoTagjZFPecEv9fcxLo558bhDQYMTwYD34cR8VU/aR/tDBg1DGA4n
         nDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=u6DO3Gg2J3PlBVFIiUZumgAkdu/tImfFPIGaInC3o7g=;
        b=JkChKd7KceS9oDH3i3GQ6zSVMHua6G80UnjXxH7f/0NKWjq3JTZ1klSy4TnPMZjaEE
         fG6n1fz9qrMkWMcFUCSWG81MtWxeGpbQFA21uBzeLTBe1+JJoW+k9Lt3lyzwzWM3nMIj
         1IjBy454kFGz3kkfuBvOm+wHOondVXIoLgGSVLQJkM780KKKiJyXyzb+EE1eB/87lUnk
         TIxw/iKCSwqUJbd0+jbmOWuSkXklZjbi3ISyS8NtO8nQTKHwp+nO7bw554aDC/bbJick
         /qBnKH2IbKynZZWA/LsqpxAbobXgrxL5z3WP1WfSaTuBKOXbqtBRb/ZmNmt7NVr/10EW
         nxSg==
X-Gm-Message-State: ALoCoQkM4EGVbvzObhSIJfMTT7JwIMLUfyq+WLDMhpgvNRIcUbaf0EpKNEAiSmrkNm6owmNQXtnO
X-Received: by 10.180.73.106 with SMTP id k10mr13956360wiv.11.1403385845452;
        Sat, 21 Jun 2014 14:24:05 -0700 (PDT)
Received: from google.com ([2620:0:1040:202:2e44:fdff:fe1c:7ea6])
        by mx.google.com with ESMTPSA id r5sm24736363wjq.26.2014.06.21.14.24.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 21 Jun 2014 14:24:04 -0700 (PDT)
Date:   Sat, 21 Jun 2014 22:24:02 +0100
From:   Daniel Walter <dwalter@google.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [arch/mips] rb532: replace mac_addr parsing
Message-ID: <20140621212402.GA20842@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dwalter@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwalter@google.com
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

Replace parse_mac_addr with sscanf.

Signed-off-by: Daniel Walter <dwalter@google.com>
---
Patch applies against current linux-tree
---
 arch/mips/rb532/devices.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)
---
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 3af00b2..6e32819b 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -250,28 +250,6 @@ static struct platform_device *rb532_devs[] = {
 	&rb532_wdt
 };
 
-static void __init parse_mac_addr(char *macstr)
-{
-	int i, h, l;
-
-	for (i = 0; i < 6; i++) {
-		if (i != 5 && *(macstr + 2) != ':')
-			return;
-
-		h = hex_to_bin(*macstr++);
-		if (h == -1)
-			return;
-
-		l = hex_to_bin(*macstr++);
-		if (l == -1)
-			return;
-
-		macstr++;
-		korina_dev0_data.mac[i] = (h << 4) + l;
-	}
-}
-
-
 /* NAND definitions */
 #define NAND_CHIP_DELAY 25
 
@@ -333,7 +311,13 @@ static int __init plat_setup_devices(void)
 static int __init setup_kmac(char *s)
 {
 	printk(KERN_INFO "korina mac = %s\n", s);
-	parse_mac_addr(s);
+	sscanf(macstr, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
+			&korina_dev0_data.mac[0],
+			&korina_dev0_data.mac[1],
+			&korina_dev0_data.mac[2],
+			&korina_dev0_data.mac[3],
+			&korina_dev0_data.mac[4],
+			&korina_dev0_data.mac[5]);
 	return 0;
 }
 
