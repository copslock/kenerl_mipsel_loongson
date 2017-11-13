Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 14:03:35 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993859AbdKMNC1li4RS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 14:02:27 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9889B9C;
        Mon, 13 Nov 2017 13:02:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>,
        Nicolas Schichan <nschichan@freebox.fr>,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.9 74/87] MIPS: AR7: Defer registration of GPIO
Date:   Mon, 13 Nov 2017 13:56:31 +0100
Message-Id: <20171113125621.897389572@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171113125615.304035578@linuxfoundation.org>
References: <20171113125615.304035578@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60863
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jonas.gorski@gmail.com>

commit e6b03ab63b4d270e0249f96536fde632409dc1dc upstream.

When called from prom init code, ar7_gpio_init() will fail as it will
call gpiochip_add() which relies on a working kmalloc() to alloc
the gpio_desc array and kmalloc is not useable yet at prom init time.

Move ar7_gpio_init() to ar7_register_devices() (a device_initcall)
where kmalloc works.

Fixes: 14e85c0e69d5 ("gpio: remove gpio_descs global array")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Cc: Nicolas Schichan <nschichan@freebox.fr>
Cc: linux-mips@linux-mips.org
Cc: linux-serial@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17542/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ar7/platform.c |    4 ++++
 arch/mips/ar7/prom.c     |    2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -654,6 +654,10 @@ static int __init ar7_register_devices(v
 	u32 val;
 	int res;
 
+	res = ar7_gpio_init();
+	if (res)
+		pr_warn("unable to register gpios: %d\n", res);
+
 	res = ar7_register_uarts();
 	if (res)
 		pr_err("unable to setup uart(s): %d\n", res);
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -246,8 +246,6 @@ void __init prom_init(void)
 	ar7_init_cmdline(fw_arg0, (char **)fw_arg1);
 	ar7_init_env((struct env_var *)fw_arg2);
 	console_config();
-
-	ar7_gpio_init();
 }
 
 #define PORT(offset) (KSEG1ADDR(AR7_REGS_UART0 + (offset * 4)))
