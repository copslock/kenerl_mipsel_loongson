Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Feb 2014 09:05:16 +0100 (CET)
Received: from mail-pb0-f52.google.com ([209.85.160.52]:63839 "EHLO
        mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822682AbaBPIDisT-H8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Feb 2014 09:03:38 +0100
Received: by mail-pb0-f52.google.com with SMTP id jt11so14025838pbb.25
        for <multiple recipients>; Sun, 16 Feb 2014 00:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ic+lEAnuOPdEbSEjSZ+jBQJlBNCWm84+pfcj4CJtovw=;
        b=esp47Tfo2Aa42b0paJEZaHEP32UKsQ8SPAAtAi9ngD9WS4Bj7zknUmZjj7UmE0K2MB
         xqSAGWbkp+tyaID76D6wD/u7/V7lLQNw0Q/JYydsGlYcbucq2hOChJ0XWNIHkBn5kNBI
         0xuPMI2FoZHxQhI0a8RYmkZP3JIlFaLAj7zjfazQtmz7s0KGXb90M91M4IYeJQQ6lGoY
         A5vxxLYU/b/lJGxx/CRtMRHnEl127QCZldUBQOJS9Md6w8f/XNeerJKo8vx4QSwTB0I4
         H0k4ImQaoMZsqLA8VYA9o8XuOlhvo+9oU0coN0y7HhWy8QA+b3kqn0m4mECCsHXv786/
         tj/Q==
X-Received: by 10.68.180.66 with SMTP id dm2mr1060921pbc.143.1392537812374;
        Sun, 16 Feb 2014 00:03:32 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id ei4sm33661111pbb.42.2014.02.16.00.03.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 16 Feb 2014 00:03:31 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V19 06/13] MIPS: Loongson 3: Add HT-linked PCI support
Date:   Sun, 16 Feb 2014 16:01:23 +0800
Message-Id: <1392537690-5961-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
References: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Loongson family machines use Hyper-Transport bus for inter-core
connection and device connection. The PCI bus is a subordinate
linked at HT1.

With LEFI firmware interface, We don't need fixup for PCI irq routing
(except providing a VBIOS of the integrated GPU).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Tested-by: Alex Smith <alex.smith@imgtec.com>
Reviewed-by: Alex Smith <alex.smith@imgtec.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    7 ++
 arch/mips/include/asm/mach-loongson/pci.h      |    5 +
 arch/mips/pci/Makefile                         |    1 +
 arch/mips/pci/fixup-loongson3.c                |   66 +++++++++++++++
 arch/mips/pci/ops-loongson3.c                  |  101 ++++++++++++++++++++++++
 5 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/pci/fixup-loongson3.c
 create mode 100644 arch/mips/pci/ops-loongson3.c

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 5913ea0..f0367ff 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/kconfig.h>
+#include <boot_param.h>
 
 /* loongson internal northbridge initialization */
 extern void bonito_irq_init(void);
@@ -101,7 +102,13 @@ static inline void do_perfcnt_IRQ(void)
 #define LOONGSON_PCICFG_BASE	0x1fe80000
 #define LOONGSON_PCICFG_SIZE	0x00000800	/* 2K */
 #define LOONGSON_PCICFG_TOP	(LOONGSON_PCICFG_BASE+LOONGSON_PCICFG_SIZE-1)
+
+#if defined(CONFIG_HT_PCI)
+#define LOONGSON_PCIIO_BASE	loongson_sysconf.pci_io_base
+#else
 #define LOONGSON_PCIIO_BASE	0x1fd00000
+#endif
+
 #define LOONGSON_PCIIO_SIZE	0x00100000	/* 1M */
 #define LOONGSON_PCIIO_TOP	(LOONGSON_PCIIO_BASE+LOONGSON_PCIIO_SIZE-1)
 
diff --git a/arch/mips/include/asm/mach-loongson/pci.h b/arch/mips/include/asm/mach-loongson/pci.h
index bc99dab..1212774 100644
--- a/arch/mips/include/asm/mach-loongson/pci.h
+++ b/arch/mips/include/asm/mach-loongson/pci.h
@@ -40,8 +40,13 @@ extern struct pci_ops loongson_pci_ops;
 #else	/* loongson2f/32bit & loongson2e */
 
 /* this pci memory space is mapped by pcimap in pci.c */
+#ifdef CONFIG_CPU_LOONGSON3
+#define LOONGSON_PCI_MEM_START	0x40000000UL
+#define LOONGSON_PCI_MEM_END	0x7effffffUL
+#else
 #define LOONGSON_PCI_MEM_START	LOONGSON_PCILO1_BASE
 #define LOONGSON_PCI_MEM_END	(LOONGSON_PCILO1_BASE + 0x04000000 * 2)
+#endif
 /* this is an offset from mips_io_port_base */
 #define LOONGSON_PCI_IO_START	0x00004000UL
 
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 137f2a6..d61138a 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_LASAT)		+= pci-lasat.o
 obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
 obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-loongson2.o
 obj-$(CONFIG_LEMOTE_MACH2F)	+= fixup-lemote2f.o ops-loongson2.o
+obj-$(CONFIG_LEMOTE_MACH3A)	+= fixup-loongson3.o ops-loongson3.o
 obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o pci-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/fixup-loongson3.c b/arch/mips/pci/fixup-loongson3.c
new file mode 100644
index 0000000..d708ae4
--- /dev/null
+++ b/arch/mips/pci/fixup-loongson3.c
@@ -0,0 +1,66 @@
+/*
+ * fixup-loongson3.c
+ *
+ * Copyright (C) 2012 Lemote, Inc.
+ * Author: Xiang Yu, xiangy@lemote.com
+ *         Chen Huacai, chenhc@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ * WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ * USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+#include <linux/pci.h>
+#include <boot_param.h>
+
+static void print_fixup_info(const struct pci_dev *pdev)
+{
+	dev_info(&pdev->dev, "Device %x:%x, irq %d\n",
+			pdev->vendor, pdev->device, pdev->irq);
+}
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	print_fixup_info(dev);
+	return dev->irq;
+}
+
+static void pci_fixup_radeon(struct pci_dev *pdev)
+{
+	if (pdev->resource[PCI_ROM_RESOURCE].start)
+		return;
+
+	if (!loongson_sysconf.vgabios_addr)
+		return;
+
+	pdev->resource[PCI_ROM_RESOURCE].start =
+		loongson_sysconf.vgabios_addr;
+	pdev->resource[PCI_ROM_RESOURCE].end   =
+		loongson_sysconf.vgabios_addr + 256*1024 - 1;
+	pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_COPY;
+
+	dev_info(&pdev->dev, "BAR %d: assigned %pR for Radeon ROM\n",
+			PCI_ROM_RESOURCE, &pdev->resource[PCI_ROM_RESOURCE]);
+}
+
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
+				PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_radeon);
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
diff --git a/arch/mips/pci/ops-loongson3.c b/arch/mips/pci/ops-loongson3.c
new file mode 100644
index 0000000..46ed541a
--- /dev/null
+++ b/arch/mips/pci/ops-loongson3.c
@@ -0,0 +1,101 @@
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+
+#include <asm/mips-boards/bonito64.h>
+
+#include <loongson.h>
+
+#define PCI_ACCESS_READ  0
+#define PCI_ACCESS_WRITE 1
+
+#define HT1LO_PCICFG_BASE      0x1a000000
+#define HT1LO_PCICFG_BASE_TP1  0x1b000000
+
+static int loongson3_pci_config_access(unsigned char access_type,
+		struct pci_bus *bus, unsigned int devfn,
+		int where, u32 *data)
+{
+	unsigned char busnum = bus->number;
+	u_int64_t addr, type;
+	void *addrp;
+	int device = PCI_SLOT(devfn);
+	int function = PCI_FUNC(devfn);
+	int reg = where & ~3;
+
+	addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+	if (busnum == 0) {
+		if (device > 31)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE) | (addr & 0xffff));
+		type = 0;
+
+	} else {
+		addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE_TP1) | (addr));
+		type = 0x10000;
+	}
+
+	if (access_type == PCI_ACCESS_WRITE)
+		writel(*data, addrp);
+	else {
+		*data = readl(addrp);
+		if (*data == 0xffffffff) {
+			*data = -1;
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int loongson3_pci_pcibios_read(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 *val)
+{
+	u32 data = 0;
+	int ret = loongson3_pci_config_access(PCI_ACCESS_READ,
+			bus, devfn, where, &data);
+
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return ret;
+
+	if (size == 1)
+		*val = (data >> ((where & 3) << 3)) & 0xff;
+	else if (size == 2)
+		*val = (data >> ((where & 3) << 3)) & 0xffff;
+	else
+		*val = data;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int loongson3_pci_pcibios_write(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 val)
+{
+	u32 data = 0;
+	int ret;
+
+	if (size == 4)
+		data = val;
+	else {
+		ret = loongson3_pci_config_access(PCI_ACCESS_READ,
+				bus, devfn, where, &data);
+		if (ret != PCIBIOS_SUCCESSFUL)
+			return ret;
+
+		if (size == 1)
+			data = (data & ~(0xff << ((where & 3) << 3))) |
+			    (val << ((where & 3) << 3));
+		else if (size == 2)
+			data = (data & ~(0xffff << ((where & 3) << 3))) |
+			    (val << ((where & 3) << 3));
+	}
+
+	ret = loongson3_pci_config_access(PCI_ACCESS_WRITE,
+			bus, devfn, where, &data);
+
+	return ret;
+}
+
+struct pci_ops loongson_pci_ops = {
+	.read = loongson3_pci_pcibios_read,
+	.write = loongson3_pci_pcibios_write
+};
-- 
1.7.7.3
