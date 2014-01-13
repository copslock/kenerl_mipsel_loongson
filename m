Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2014 20:05:31 +0100 (CET)
Received: from mail-ee0-f51.google.com ([74.125.83.51]:46013 "EHLO
        mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6828766AbaAMTF3Ig8PN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jan 2014 20:05:29 +0100
Received: by mail-ee0-f51.google.com with SMTP id b15so3378875eek.10
        for <multiple recipients>; Mon, 13 Jan 2014 11:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=mdykYy6kc74YnTELVmNV3OSQn3gTGq/sBgQVkyD02iw=;
        b=uN1m4cTLospob3dP2B1ofs1fdwlyWBJnUjW1GmxlEaShLoO8Pm/gyON98fw9wyLLjM
         AGnQ8ARkGss0olGZs6MsCeJKLgYucgL1QIHHOrpL/ZFYawsN6+lE8StRAQKCX2ByDVA9
         QCLNyvgogXxsEyn6GJPO1T8Gprw8BfI0rqTHlNrNZ7kahlGs99Gsjk8KfBYqgfNbbP+G
         asvtOk393ZmmZYxpw3ZlnFr9GJTnoVhv8POICMLXxkTHTLdeuJCtqLdbWeT6EXtcl9xD
         EUjHHtspMiicQByV/fyx6Vzg1EMycQEG1bvcYY1zipQkFvHZvHfAXMtlpihhI7vdSJyM
         f/aA==
X-Received: by 10.14.175.131 with SMTP id z3mr29710261eel.65.1389639923782;
        Mon, 13 Jan 2014 11:05:23 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id 7sm42236001eee.12.2014.01.13.11.05.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2014 11:05:23 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] bcma: gpio: don't cast u32 to unsigned long
Date:   Mon, 13 Jan 2014 20:05:17 +0100
Message-Id: <1389639917-21615-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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


Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 drivers/bcma/driver_gpio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index c2728a0..69c82e2 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -117,13 +117,13 @@ static irqreturn_t bcma_gpio_irq_handler(int irq, void *dev_id)
 	u32 val = bcma_cc_read32(cc, BCMA_CC_GPIOIN);
 	u32 mask = bcma_cc_read32(cc, BCMA_CC_GPIOIRQ);
 	u32 pol = bcma_cc_read32(cc, BCMA_CC_GPIOPOL);
-	u32 irqs = (val ^ pol) & mask;
+	unsigned long irqs = (val ^ pol) & mask;
 	int gpio;
 
 	if (!irqs)
 		return IRQ_NONE;
 
-	for_each_set_bit(gpio, (unsigned long *)&irqs, cc->gpio.ngpio)
+	for_each_set_bit(gpio, &irqs, cc->gpio.ngpio)
 		generic_handle_irq(bcma_gpio_to_irq(&cc->gpio, gpio));
 	bcma_chipco_gpio_polarity(cc, irqs, val & irqs);
 
-- 
1.7.10.4
