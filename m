Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 11:38:35 +0200 (CEST)
Received: from mail-wi0-f170.google.com ([209.85.212.170]:48129 "EHLO
        mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860319AbaFXIpszz06j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 10:45:48 +0200
Received: by mail-wi0-f170.google.com with SMTP id cc10so5431086wib.3
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 01:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=JnyrGWaR4E0ZLB0Yb3VE3RtpF1m73XNfA/fj4N3+qio=;
        b=pXnUtD/wxTHw1rm8HFHoQt14CZbOuaszFTAslHhNKgBR6JObojwsej3nnIUTkKvF8v
         M7+ckVjoM5BEG7kC4A0GUikJNk3I3jem3/LoyMRpCsoRxxxtrWfUIWiNpeqcQZLLYNU9
         yoFm0S/vJDHr6jY++NFH87ndOAQ3v7N2UnDvq9a3wrGSM5IFMPT3Qm72BTmfNVFudL6n
         1tiFmWtxjgEUo6lH2R+j3ISdeQ6HaETQSn934vU4VGqirwMWFHmxRc0IOcJFq7h05lGj
         4BK3NTTnbTlP4PSqMPeni/M1EJIGU0CSzvR+9a2aBOuQO5vG7YRSI7DFORqj/9jBG3li
         +QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=JnyrGWaR4E0ZLB0Yb3VE3RtpF1m73XNfA/fj4N3+qio=;
        b=HlD5WwopNi07hX78lUezF6u6VTv7WCpPYCTXt0XX5t0bt9B669biuTTyeaj/0LKMOG
         ZE2kWuTM3jQoboDsUHnsAJD7okipjvAqfuP8pJRnh31kY8MFp8N6KtAs0LDENy8ip6uR
         R9iZTJfAP44NC229xxKf1+OLXZKmICpDnNfty1uOGC+LBk3/A+PprQSlnCLQUBQn5BfC
         hp/vXOOgtO3rv4Y/DxeVJgKG+O++6PsPDERJ8IiddVg+KRyd4Qf460gMYwBrrxT+8eAP
         7Fj1bNA8pv8ruvjpf3ac9p3GDgB4T4h5267yEyn01SKnZkR3zwVLH/js+lGooXUhspMX
         qKaQ==
X-Gm-Message-State: ALoCoQkNChoxk0XrSYRYTcbFcqrKb/QlI0rIN/TfelUDl8gFq3di6dbcLZxcbKQnLFoDLfIJ3EEX
X-Received: by 10.194.89.40 with SMTP id bl8mr33703414wjb.90.1403599543556;
        Tue, 24 Jun 2014 01:45:43 -0700 (PDT)
Received: from google.com ([2620:0:1040:202:2e44:fdff:fe1c:7ea6])
        by mx.google.com with ESMTPSA id wi9sm41693412wjc.23.2014.06.24.01.45.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 01:45:43 -0700 (PDT)
Date:   Tue, 24 Jun 2014 09:45:40 +0100
From:   Daniel Walter <dwalter@google.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arch/mips rb532: replace mac_addr parsing
Message-ID: <20140624084540.GA22930@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dwalter@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40704
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
Changes since v1:
  sending in the working patch
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
+	sscanf(s, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
+			&korina_dev0_data.mac[0],
+			&korina_dev0_data.mac[1],
+			&korina_dev0_data.mac[2],
+			&korina_dev0_data.mac[3],
+			&korina_dev0_data.mac[4],
+			&korina_dev0_data.mac[5]);
 	return 0;
 }
 
