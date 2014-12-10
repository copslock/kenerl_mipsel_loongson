Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2014 12:56:53 +0100 (CET)
Received: from mail-wg0-f51.google.com ([74.125.82.51]:51941 "EHLO
        mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007719AbaLJL4rbJj12 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Dec 2014 12:56:47 +0100
Received: by mail-wg0-f51.google.com with SMTP id x12so3393473wgg.10
        for <multiple recipients>; Wed, 10 Dec 2014 03:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ZGdx/VKvjeoHXy3hDHvqSqwVKHkbmyKtGpynW8BrD9E=;
        b=a99Qa/2REGPhP5w7qXkDdkVnul1/Dvk2vpksbaGJzm6v+RwVMab7pejZtLtTZvTuAE
         Ujzul2C5n2OsoRFSOZ/BYU1EjWOT+NJa4up+7nIHlfNextSly29zTLDqJKfHgMG98N1d
         3UbqRFb6LBP51nDXAhXoHFBLia3HN+eCh7GFBr8gBZat3pa2dzDTKfbN6y5enInI8obi
         jiPMFIu7xskcIbxfgpKu2F56GiC6dZwaSwH+sT/eLHSZxMlSfqvNmyIG7D+ZInwhIAjD
         WCEyhhscPqXcTxNN/VFzUAIigAvPMLmL0RS62Bp7pLY8k6qELZYRPvtQO9mg2WClO00a
         A5Vg==
X-Received: by 10.181.8.66 with SMTP id di2mr5552638wid.49.1418212602218;
        Wed, 10 Dec 2014 03:56:42 -0800 (PST)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id xt9sm5547046wjc.42.2014.12.10.03.56.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2014 03:56:41 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul@pwsan.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@kernel.org>,
        Jeff Garzik <jgarzik@redhat.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt.fleming@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-soc@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH][RFC] MIPS: BCM47XX: Move NVRAM driver to the drivers/firmware/
Date:   Wed, 10 Dec 2014 12:56:27 +0100
Message-Id: <1418212587-19774-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44614
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

After Broadcom switched from MIPS to ARM for their home routers we need
to have NVRAM driver in some common place (not arch/mips/).
We were thinking about putting it in bus directory, however there are
two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
won't fit there neither.
This is why I would like to move this driver to the drivers/firmware/

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
Hey, this is another try for the NVRAM driver. At first I tried moving it to the
drivers/misc/, but then decided drivers/soc/ will be better. Then after
discussion with Paul we decided to try drivers/firmware/ and so I do.

Meanwhile I've sent few patches cleaning nvram.c: following kernel coding style
and using helpers like readl.

I would like to get few Reviewed-by for this patch. If I get that, then I'll
re-send this patch to Ralf without the RFC.

If you want to review nvram.c code, please make sure to check version in
ralf/upstream-sfr.git repository as it contains many cleanups:
git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git
http://git.linux-mips.org/cgit/ralf/upstream-sfr.git/log/

Mentioned patches (more cleanups):
http://patchwork.linux-mips.org/project/linux-mips/list/?submitter=478

Finally: why drivers/firmware/? Please see Paul's e-mail:
<alpine.DEB.2.02.1411271926560.1406@utopia.booyaka.com>
http://www.linux-mips.org/archives/linux-mips/2014-11/msg00678.html

Unfortunately there is no mailing list for drivers/firmware/, so I've
picked ppl with 5+ commits to this directory. Hope this is OK.
---
 arch/mips/Kconfig                                             |  1 +
 arch/mips/bcm47xx/Makefile                                    |  2 +-
 drivers/firmware/Kconfig                                      |  1 +
 drivers/firmware/Makefile                                     |  1 +
 drivers/firmware/broadcom/Kconfig                             | 11 +++++++++++
 drivers/firmware/broadcom/Makefile                            |  1 +
 .../nvram.c => drivers/firmware/broadcom/bcm47xx_nvram.c      |  2 ++
 include/linux/bcm47xx_nvram.h                                 |  2 +-
 8 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/broadcom/Kconfig
 create mode 100644 drivers/firmware/broadcom/Makefile
 rename arch/mips/bcm47xx/nvram.c => drivers/firmware/broadcom/bcm47xx_nvram.c (99%)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d093889..ed9da3b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -174,6 +174,7 @@ config BCM47XX
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select GPIOLIB
 	select LEDS_GPIO_REGISTER
+	select BCM47XX_NVRAM
 	help
 	 Support for BCM47XX based boards
 
diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index d58c51b..66bea4e 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -3,5 +3,5 @@
 # under Linux.
 #
 
-obj-y				+= irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
+obj-y				+= irq.o prom.o serial.o setup.o time.o sprom.o
 obj-y				+= board.o buttons.o leds.o workarounds.o
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 4198388..ffbc9e4 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -132,6 +132,7 @@ config ISCSI_IBFT
 	  detect iSCSI boot parameters dynamically during system boot, say Y.
 	  Otherwise, say N.
 
+source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 5373dc5..e251f2b 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_ISCSI_IBFT_FIND)	+= iscsi_ibft_find.o
 obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
 obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
 
+obj-y				+= broadcom/
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
diff --git a/drivers/firmware/broadcom/Kconfig b/drivers/firmware/broadcom/Kconfig
new file mode 100644
index 0000000..6bed119
--- /dev/null
+++ b/drivers/firmware/broadcom/Kconfig
@@ -0,0 +1,11 @@
+config BCM47XX_NVRAM
+	bool "Broadcom NVRAM driver"
+	depends on BCM47XX || ARCH_BCM_5301X
+	help
+	  Broadcom home routers contain flash partition called "nvram" with all
+	  important hardware configuration as well as some minor user setup.
+	  NVRAM partition contains a text-like data representing name=value
+	  pairs.
+	  This driver provides an easy way to get value of requested parameter.
+	  It simply reads content of NVRAM and parses it. It doesn't control any
+	  hardware part itself.
diff --git a/drivers/firmware/broadcom/Makefile b/drivers/firmware/broadcom/Makefile
new file mode 100644
index 0000000..d0e6835
--- /dev/null
+++ b/drivers/firmware/broadcom/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_BCM47XX_NVRAM)		+= bcm47xx_nvram.o
diff --git a/arch/mips/bcm47xx/nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
similarity index 99%
rename from arch/mips/bcm47xx/nvram.c
rename to drivers/firmware/broadcom/bcm47xx_nvram.c
index 2975187..fe8c8c9 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -228,3 +228,5 @@ int bcm47xx_nvram_gpio_pin(const char *name)
 	return -ENOENT;
 }
 EXPORT_SYMBOL(bcm47xx_nvram_gpio_pin);
+
+MODULE_LICENSE("GPLv2");
diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
index b12b07e..0e52a92 100644
--- a/include/linux/bcm47xx_nvram.h
+++ b/include/linux/bcm47xx_nvram.h
@@ -11,7 +11,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 
-#ifdef CONFIG_BCM47XX
+#ifdef CONFIG_BCM47XX_NVRAM
 int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
 int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len);
 int bcm47xx_nvram_gpio_pin(const char *name);
-- 
1.8.4.5
