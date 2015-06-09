Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jun 2015 09:35:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37592 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006695AbbFIHfoMI00e (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Jun 2015 09:35:44 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t597Zeqs003430;
        Tue, 9 Jun 2015 09:35:40 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t597ZYuJ003429;
        Tue, 9 Jun 2015 09:35:34 +0200
Date:   Tue, 9 Jun 2015 09:35:34 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Huacai Chen <chenhc@lemote.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 3/4] mips: make loongsoon serial driver explicitly modular
Message-ID: <20150609073533.GB2753@linux-mips.org>
References: <1433276168-21550-1-git-send-email-paul.gortmaker@windriver.com>
 <1433276168-21550-4-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433276168-21550-4-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jun 02, 2015 at 04:16:07PM -0400, Paul Gortmaker wrote:

Ccing a few people with interest in Loongson stuff.

> The file looks as if it is non-modular, but it piggy-backs
> off CONFIG_SERIAL_8250 which is tristate.  If set to "=m"
> we will get this after the init/module header cleanup:
> 
> arch/mips/loongson/common/serial.c:76:1: error: data definition has no type or storage class [-Werror]
> arch/mips/loongson/common/serial.c:76:1: error: type defaults to 'int' in declaration of 'device_initcall' [-Werror=implicit-int]
> arch/mips/loongson/common/serial.c:76:1: error: parameter names (without types) in function declaration [-Werror]
> arch/mips/loongson/common/serial.c:58:19: error: 'serial_init' defined but not used [-Werror=unused-function]
> cc1: all warnings being treated as errors
> make[3]: *** [arch/mips/loongson/common/serial.o] Error 1
> 
> Make it clearly modular, and add a module_exit function,
> so that we avoid the above breakage.

Following up on our IRC discussion - your commit would result in
platform device registrations from module code which opens another can
of worms.  This and the whole philosophy of platforms devices to show
what devices do exist in a system, not which drivers are configured.
So just always build serial.c into the kernel.

A related issue is uart_base.o which I think is required to register
properly initialized platform devices.  It depends on
CONFIG_LOONGSON_UART_BASE but probably should also be put into the
kernel whenever we register the UART platform devices and that's
always.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index e70c33f..f2e8153 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -3,15 +3,13 @@
 #
 
 obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
-    bonito-irq.o mem.o machtype.o platform.o
+    bonito-irq.o mem.o machtype.o platform.o serial.o
 obj-$(CONFIG_PCI) += pci.o
 
 #
 # Serial port support
 #
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
-loongson-serial-$(CONFIG_SERIAL_8250) := serial.o
-obj-y += $(loongson-serial-m) $(loongson-serial-y)
 obj-$(CONFIG_LOONGSON_UART_BASE) += uart_base.o
 obj-$(CONFIG_LOONGSON_MC146818) += rtc.o
 
