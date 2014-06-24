Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 15:13:42 +0200 (CEST)
Received: from mail-we0-f178.google.com ([74.125.82.178]:57838 "EHLO
        mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860809AbaFXLOjOFstj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 13:14:39 +0200
Received: by mail-we0-f178.google.com with SMTP id x48so157666wes.37
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=8SUeu1cfmDvf4Hg+oGBs6JNatAPgFvO1jFdfk0+KZfo=;
        b=KWmdwnGBY0U+XMnXxF3wlymVrpcm16AGdZxciU0SMeU9K1X7yq+742dqY/ShcPve2r
         Q16UtbD7M66zUGN1QP3C0Knvw5U68u0hE9HwMJTqpwzH3UPFOCYGQHKz8wodGwztCnXv
         fjuo2rysYy6bl1l6sprNgNJ+8qCw3X2NQA3Xkx8JhA0m/J0ELQGckdYX1rnNWqW92QAb
         /TxpwzIyV0nTCSZeIsOVow1uJF0Ohl9blgGDJjR31sr0SpANXJAo5gFOgljlkZby+Fug
         /QNIIWuiHSrw0ShtZgqJpPRbAgbWZi+WrZz8uAaCVBLwXql+LN2bu3860246jr05i7ES
         QOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=8SUeu1cfmDvf4Hg+oGBs6JNatAPgFvO1jFdfk0+KZfo=;
        b=ITKa0hdq0IknyxJmRGM+VOvpVPf3IRw0/ZXkClEZKQ5w7nhHJJFErjh63nCelwaeo+
         Mbiq6NKgoWGgGf846RFUVbZiVCK1fZYk3002OBly1R8JVHuXnGgKRYAwUBI6KcTAEArg
         iWOZa8irfwqe6QCra0PF0zoY7CF8xCr4WnokjdV/Y+9mG0D9aBK4NNzkq/9w5Te3UTMm
         TIkPEnS9lXABcoehGoF3k7C1UbcGYqaTV+WfLV0as4twu6MyuM8McGD+iAKQ5QgNnmYd
         Bgw7iGfpDBtUwRC10lmP+M+JM/o1CbLF1QiV/ousMohKoQJP7xPJoeZvlM7lElh/5okl
         iYkg==
X-Gm-Message-State: ALoCoQnfTO2ueMpduOFrZFsf4R5n02cjJ5oqcynjJxQj6p2OrCrgoyvX7DMEw1cgjepnKXPyKqYl
X-Received: by 10.194.86.42 with SMTP id m10mr365297wjz.132.1403608468945;
        Tue, 24 Jun 2014 04:14:28 -0700 (PDT)
Received: from google.com ([2620:0:1040:202:2e44:fdff:fe1c:7ea6])
        by mx.google.com with ESMTPSA id r9sm42275377wia.17.2014.06.24.04.14.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 04:14:28 -0700 (PDT)
Date:   Tue, 24 Jun 2014 12:14:26 +0100
From:   Daniel Walter <dwalter@google.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     james.hogan@imgtec.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] arch/mips/rb532: replace mac_addr parsing
Message-ID: <20140624111426.GA15160@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dwalter@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40725
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

Replace parse_mac_addr with mac_pton().


Signed-off-by: Daniel Walter <dwalter@google.com>
---
Changes since v2
  Use mac_pton() instead of sscanf()
  added error handling in case could not be parsed
---
Patch applies against current linux-git
---
 arch/mips/rb532/devices.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)
---
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 3af00b2..03a4cdc 100644
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
 
@@ -333,7 +311,10 @@ static int __init plat_setup_devices(void)
 static int __init setup_kmac(char *s)
 {
 	printk(KERN_INFO "korina mac = %s\n", s);
-	parse_mac_addr(s);
+	if (!mac_pton(s, korina_dev0_data.mac)) {
+		printk(KERN_ERR "Invalid mac\n");
+		return -EINVAL;
+	}
 	return 0;
 }
 
