Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 16:42:33 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:53220 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011979AbcBPPmCW7Hgn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Feb 2016 16:42:02 +0100
Received: from wuerfel.lan. ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue003) with ESMTPA (Nemesis) id 0LpAdk-1a2AM12BpU-00epso; Tue, 16 Feb
 2016 16:41:13 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "# v4 . 3+" <stable@vger.kernel.org>, Alban Bedel <albeu@free.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 1/5] MIPS: jz4740: remove broken irq_to_gpio() call
Date:   Tue, 16 Feb 2016 16:40:34 +0100
Message-Id: <1455637261-2920972-1-git-send-email-arnd@arndb.de>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <455637086-2794174-1-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
X-Provags-ID: V03:K0:gSycZQZpcMneao4j+bplvES8VGXkXohQ0lbdhcmpTyYYyDQBE8k
 PT4qa7Pr0V/v53emodKthu5X77UOG4Zi9bVu/XQoswEXyRnCdmMf8RLRvV68ASER2jwW6Jp
 +wzsYF8s4p534evQ0NVwIrNNF1WwgSgfnigrGV97g5dC1tHh181jtqx0iDo7iOGYDbpT8Ty
 Nj27BZtLQQvSAoGSaZt0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZRt5ZyZSNH0=:IWlXwxYCG1u0IDjdJNiFfv
 sIE83fZ6GzlNUdxQA5+Luyc2UbjdiyAVmPLbmmAc0Y/N/aAZ51rpR6dQOMzf9lBvLSCQG4KiA
 /6fFjc6QTziD6H5VpPQdxYcT3byJcrqnKzhSgINUpYZCooYPw9knZ+KGErl6HvzgmYBvFAbp1
 BL0SwxJZ8QKUh9HYFKQUGXSAKxMY6svd5GtFiIdPaHMJfyNDCFUnHMAkXGyNiXxWGW38f1C+h
 TQSpq2FI9ADzHAyKPx1+T0LE8uDXqALr/JZy2DUnFs/wlPTzyydFMzu58gWGk8qpOiB8N1T0a
 dDyA75sJsLUEiQ2a0Otg9LAeNrCLlE4wCijcMfYQX/eAMzZ6l3VmcBYmOgEvBNtgpMnBoa6Og
 IuiCGjVekBl34kbMekN8+1cagiYJsGYNcz5BXarcM8gXgUcPhWdYkRIB7OkxOC9dgbas6JIM5
 sUoxf0Q8Vhh7pHcQLJonMNt9Qh6hraOm0MhKUKPb+irxkGm8YhIp6HqO9HHWJFz1YCnaAXwkx
 b6o82krNX0KpF82IXkRLnymtU+jBaTUoJrQDs0iqPSssh+kNmWjrMwZfNVTkWw81mCvccFjzr
 TDqRwKpqKuhG0Pk8D7fHOx+zhJrZSdUHE5vF2F+hum9TYTsPii672PxxaxAZPzz5Lv3QZJRMy
 Kc5EUucMzwodz5IObAJTHuVQ/yCyh6U6uvP6eFzKP3CyoDEfwB/UDR3YnYVMxbG/owGQ=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

gpiolib has removed the irq_to_gpio() API several years ago,
but the global header still provided a non-working stub.

With a MIPS-wide change to use the generic header file, the jz4740
platform is now using the wrong stub implementation of irq_to_gpio(),
which cannot work.

This uses an open-coded implementation in the only line it
is used in.

Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: <stable@vger.kernel.org> # v4.3+
Fixes: 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h").
---
 arch/mips/jz4740/gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index 8c6d76c9b2d6..d9907e57e9b9 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -270,7 +270,7 @@ uint32_t jz_gpio_port_get_value(int port, uint32_t mask)
 }
 EXPORT_SYMBOL(jz_gpio_port_get_value);
 
-#define IRQ_TO_BIT(irq) BIT(irq_to_gpio(irq) & 0x1f)
+#define IRQ_TO_BIT(irq) BIT((irq - JZ4740_IRQ_GPIO(0)) & 0x1f)
 
 static void jz_gpio_check_trigger_both(struct jz_gpio_chip *chip, unsigned int irq)
 {
-- 
2.7.0
