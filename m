Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 08:55:09 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:58638 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903560Ab2FSGyb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2012 08:54:31 +0200
Received: by pbbrq13 with SMTP id rq13so9839568pbb.36
        for <multiple recipients>; Mon, 18 Jun 2012 23:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NqkWiWKYvBRe8cUzhSFlsUBPbfbFueU4EEe26bOHSxA=;
        b=aAym67bMwmn7FVBLClAFGueIvbxW/7faRjiETfdcvuYVw4uG+cHuhgtoiVoc60L3da
         5nqCVIUsejuorXqLQ8ACSIdJxW7oOU2doEFWVKH9vPyWgtkG9BqUc35L8hgGntNIsLSY
         Lg9SdFiy+6ZyfeAE+zSkGAwlAAqA/uf6Smpf7XYzNmmgUPHRhIDB/iZUgALQig2rpRSG
         KMeeVSEcrpQG5H5mVC0Q1F4j+4bYvys7VAec7UI4AqLfTdLnP0SMYzr2OVfT2zCYL9ro
         qYppCtYbYHGWiJntu//jZMInCcKXrLaiowcVJP9x/ybu0klBc4gKuhDs5VAknuNoaqih
         g2IA==
Received: by 10.68.213.234 with SMTP id nv10mr60537052pbc.56.1340088864413;
        Mon, 18 Jun 2012 23:54:24 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id gk3sm20156319pbc.1.2012.06.18.23.54.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2012 23:54:23 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V2 06/16] MIPS: Loongson 3: Add HT-linked PCI support.
Date:   Tue, 19 Jun 2012 14:50:14 +0800
Message-Id: <1340088624-25550-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Loongson family machines use Hyper-Transport bus for inter-core
connection and device connection. The PCI bus is a subordinate
linked at HT1.

With UEFI-like firmware interface, We don't need PCI irq routing
fixup.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    7 ++
 arch/mips/include/asm/mach-loongson/pci.h      |    5 +
 arch/mips/pci/Makefile                         |    1 +
 arch/mips/pci/fixup-loongson3.c                |   50 +++++++++++
 arch/mips/pci/ops-loongson3.c                  |  104 ++++++++++++++++++++++++
 5 files changed, 167 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/pci/fixup-loongson3.c
 create mode 100644 arch/mips/pci/ops-loongson3.c

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 7efb911..f36f348 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <boot_param.h>
 
 /* loongson internal northbridge initialization */
 extern void bonito_irq_init(void);
@@ -100,7 +101,13 @@ static inline void do_perfcnt_IRQ(void)
 #define LOONGSON_PCICFG_BASE	0x1fe80000
 #define LOONGSON_PCICFG_SIZE	0x00000800	/* 2K */
 #define LOONGSON_PCICFG_TOP	(LOONGSON_PCICFG_BASE+LOONGSON_PCICFG_SIZE-1)
+
+#if defined(CONFIG_HT_PCI)
+#define LOONGSON_PCIIO_BASE	loongson_pciio_base
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
index c703f43..4e0980c 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
 obj-$(CONFIG_SOC_PNX8550)	+= fixup-pnx8550.o ops-pnx8550.o
 obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-loongson2.o
 obj-$(CONFIG_LEMOTE_MACH2F)	+= fixup-lemote2f.o ops-loongson2.o
+obj-$(CONFIG_LEMOTE_MACH3A)	+= fixup-loongson3.o ops-loongson3.o
 obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/fixup-loongson3.c b/arch/mips/pci/fixup-loongson3.c
new file mode 100644
index 0000000..226b262
--- /dev/null
+++ b/arch/mips/pci/fixup-loongson3.c
@@ -0,0 +1,50 @@
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
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/pci.h>
+
+static void print_fixup_info(const struct pci_dev * pdev)
+{
+	printk(KERN_INFO "Fixup: bus%d dev%xh fun%xh %x:%x irq %d\n",
+			pdev->bus->number, PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+			pdev->vendor, pdev->device, pdev->irq);
+
+}
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	print_fixup_info(dev);
+	return dev->irq;
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
diff --git a/arch/mips/pci/ops-loongson3.c b/arch/mips/pci/ops-loongson3.c
new file mode 100644
index 0000000..b29d333
--- /dev/null
+++ b/arch/mips/pci/ops-loongson3.c
@@ -0,0 +1,104 @@
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
+	if (busnum == 0) {
+		if (device > 31)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		addr = (device << 11) | (function << 8) | reg;
+	    addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE) | (addr & 0xffff));
+		type = 0;
+
+	} else {
+		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+	    addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE_TP1) | (addr));
+		type = 0x10000;
+	}
+
+	if (access_type == PCI_ACCESS_WRITE)
+		*(volatile unsigned int *)addrp = cpu_to_le32(*data);
+	else {
+		*data = le32_to_cpu(*(volatile unsigned int *)addrp);
+		if (*data == 0xffffffff) {
+			*data = -1;
+	        return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int loongson3_pci_pcibios_read(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 * val)
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
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return ret;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+struct pci_ops loongson_pci_ops = {
+	.read = loongson3_pci_pcibios_read,
+	.write = loongson3_pci_pcibios_write
+};
-- 
1.7.7.3
