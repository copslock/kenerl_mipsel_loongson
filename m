Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Jul 2018 18:42:26 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994642AbeGAQmNN2j2h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Jul 2018 18:42:13 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A554BAA6;
        Sun,  1 Jul 2018 16:42:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Guinot <simon.guinot@sequanux.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.17 122/220] MIPS: pb44: Fix i2c-gpio GPIO descriptor table
Date:   Sun,  1 Jul 2018 18:22:26 +0200
Message-Id: <20180701160913.445786757@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

commit 326345f995a83e326fa2e01d54bfa9a6a307bd4d upstream.

I used bad names in my clumsiness when rewriting many board
files to use GPIO descriptors instead of platform data. A few
had the platform_device ID set to -1 which would indeed give
the device name "i2c-gpio".

But several had it set to >=0 which gives the names
"i2c-gpio.0", "i2c-gpio.1" ...

Fix the one affected board in the MIPS tree. Sorry.

Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
Reported-by: Simon Guinot <simon.guinot@sequanux.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon Guinot <simon.guinot@sequanux.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.15+
Patchwork: https://patchwork.linux-mips.org/patch/19387/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ath79/mach-pb44.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/ath79/mach-pb44.c
+++ b/arch/mips/ath79/mach-pb44.c
@@ -34,7 +34,7 @@
 #define PB44_KEYS_DEBOUNCE_INTERVAL	(3 * PB44_KEYS_POLL_INTERVAL)
 
 static struct gpiod_lookup_table pb44_i2c_gpiod_table = {
-	.dev_id = "i2c-gpio",
+	.dev_id = "i2c-gpio.0",
 	.table = {
 		GPIO_LOOKUP_IDX("ath79-gpio", PB44_GPIO_I2C_SDA,
 				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
