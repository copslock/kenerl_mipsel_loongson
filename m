Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2008 06:23:50 +0100 (BST)
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:39050
	"EHLO QMTA02.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20022287AbYGaFXm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2008 06:23:42 +0100
Received: from OMTA01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by QMTA02.westchester.pa.mail.comcast.net with comcast
	id wCjY1Z0020EZKEL52VPaXr; Thu, 31 Jul 2008 05:23:34 +0000
Received: from [192.168.1.4] ([69.140.18.238])
	by OMTA01.westchester.pa.mail.comcast.net with comcast
	id wVPY1Z00558Be2l3MVPYrg; Thu, 31 Jul 2008 05:23:34 +0000
X-Authority-Analysis: v=1.0 c=1 a=mepaRKJI6foA:10 a=7-cKWoymOU4A:10
 a=tvxfl1igwzCMz7S90nsA:9 a=ges3ETY5ScIoHAbheq0A:7
 a=A-TaHNGM3Vk0MiDmkoo2F8epHScA:4 a=3SmO1NJXDBsA:10 a=4fx944YoYJDtdv8luQgA:9
 a=jQblB9lGmLcU2ZH3hxEA:7 a=M8rlAFSP5dixaIuJPaQrG_HEX9sA:4 a=fqpxGZ1F0YcA:10
 a=i92e0Ub4el8A:10 a=d_-3mwAUsuEA:10 a=1DbiqZag68YA:10 a=W39ifWXXhksA:10
 a=NfA2RSpTaHsA:10
Message-ID: <48914C54.3020505@gentoo.org>
Date:	Thu, 31 Jul 2008 01:23:32 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH/RFC]: SGI Octane (IP30) Patches, Part one, Intro & IOC3
Content-Type: multipart/mixed;
 boundary="------------040602000001050804070607"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040602000001050804070607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hey all,

Herein is the current IP30 Patches that I have.  They apply to 2.6.26 using a 
recent snap from LMO Git.  So far, everything works pretty well, and my box had 
been building several times gcc-4.3.1 the last few days (which isn't much of a 
test, but I digress).  2.6.25 seems busted, so I decided to skip even looking at 
that.

Anyways, the point of posting this here is to get other eyes to look at it and 
maybe elicit some help in getting these things cleaned up so we can finally get 
this sucker into mainline in the near future.

There's several pieces to this patchset, the first being IOC3 changes.  A lot of 
this are in the SN version of the IOC3 driver, and I know some work was done on 
making that driver cross-functional with mips, but I don't think that work ever 
got merged in.  So maybe this is a starting point for that?

Feel free to poke n' prod and make suggestions.


Thanks!,


--Kumba

-- 
Unofficial Gentoo/MIPS Hermit & Kernel Monkey

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

--------------040602000001050804070607
Content-Type: text/plain;
 name="misc-2.6.26-ioc3-metadriver-r27.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.6.26-ioc3-metadriver-r27.patch"

diff -Naurp linux-2.6.26.orig/arch/mips/Kconfig linux-2.6.26/arch/mips/Kconfig
--- linux-2.6.26.orig/arch/mips/Kconfig	2008-07-23 22:26:29.000000000 -0400
+++ linux-2.6.26/arch/mips/Kconfig	2008-07-25 01:03:02.000000000 -0400
@@ -2000,6 +2000,14 @@ config PCI_DOMAINS
 
 source "drivers/pci/Kconfig"
 
+config SGI_IOC3
+	bool "SGI IOC3 Master Driver"
+	depends on PCI
+	help
+	  If you have a Silicon Graphics Origin or Octane, say Y.
+	  This driver provides base for IOC3 feature drivers, such as
+	  Ethernet, keyboard, mouse, serial ports, LEDs and RTC.
+
 #
 # ISA support is now enabled via select.  Too many systems still have the one
 # or other ISA chip on the board that users don't know about so don't expect
diff -Naurp linux-2.6.26.orig/arch/mips/pci/Makefile linux-2.6.26/arch/mips/pci/Makefile
--- linux-2.6.26.orig/arch/mips/pci/Makefile	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/arch/mips/pci/Makefile	2008-07-25 01:03:02.000000000 -0400
@@ -48,3 +48,6 @@ obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
 obj-$(CONFIG_WR_PPMC)		+= fixup-wrppmc.o
+
+obj-$(CONFIG_SGI_IOC3)		+= ioc3.o
+
diff -Naurp linux-2.6.26.orig/arch/mips/pci/ioc3.c linux-2.6.26/arch/mips/pci/ioc3.c
--- linux-2.6.26.orig/arch/mips/pci/ioc3.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/arch/mips/pci/ioc3.c	2008-07-25 01:03:02.000000000 -0400
@@ -0,0 +1,898 @@
+/*
+ * SGI IOC3 master driver and IRQ demuxer
+ *
+ * Copyright (c) 2005 Stanislaw Skowronek <skylark@linux-mips.org>
+ * Heavily based on similar work by:
+ *   Brent Casavant <bcasavan@sgi.com> - IOC4 master driver
+ *   Pat Gefre <pfg@sgi.com> - IOC3 serial port IRQ demuxer
+ *
+ * Updated for no pt_regs - (c) 2006 Stanislaw Skowronek
+ */
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+
+#include <linux/ioc3.h>
+#include <asm/sn/ioc3.h>
+
+#define IOC3_PCI_SIZE 0x100000
+
+static LIST_HEAD(ioc3_devices);
+static int ioc3_counter;
+static DECLARE_RWSEM(ioc3_devices_rwsem);
+
+static struct ioc3_submodule *ioc3_submodules[IOC3_MAX_SUBMODULES];
+static struct ioc3_submodule *ioc3_ethernet;
+static DEFINE_RWLOCK(ioc3_submodules_lock);
+
+
+/* NIC probing code */
+static inline unsigned mcr_pack(unsigned pulse, unsigned sample)
+{
+	return (pulse << 10) | (sample << 2);
+}
+
+static int nic_wait(struct ioc3_driver_data *idd)
+{
+	unsigned mcr;
+
+	do {
+		mcr = readl(&idd->vma->mcr);
+	} while (!(mcr & 2));
+
+	return mcr & 1;
+}
+
+static int nic_reset(struct ioc3_driver_data *idd)
+{
+	int presence;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	writel(mcr_pack(500, 65), &idd->vma->mcr);
+	presence = nic_wait(idd);
+	local_irq_restore(flags);
+
+	udelay(500);
+
+	return presence;
+}
+
+static int nic_read_bit(struct ioc3_driver_data *idd)
+{
+	int result;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	writel(mcr_pack(6, 13), &idd->vma->mcr);
+	result = nic_wait(idd);
+	local_irq_restore(flags);
+
+	udelay(500);
+
+	return result;
+}
+
+static void nic_write_bit(struct ioc3_driver_data *idd, int bit)
+{
+	if (bit)
+		writel(mcr_pack(6, 110), &idd->vma->mcr);
+	else
+		writel(mcr_pack(80, 30), &idd->vma->mcr);
+
+	nic_wait(idd);
+}
+
+static unsigned nic_read_byte(struct ioc3_driver_data *idd)
+{
+	unsigned result = 0;
+	int i;
+
+	for (i = 0; i < 8; i++)
+		result = (result >> 1) | (nic_read_bit(idd) << 7);
+
+	return result;
+}
+
+static void nic_write_byte(struct ioc3_driver_data *idd, int byte)
+{
+	int i, bit;
+
+	for (i = 8; i; i--) {
+		bit = byte & 1;
+		byte >>= 1;
+
+		nic_write_bit(idd, bit);
+	}
+}
+
+static unsigned long nic_find(struct ioc3_driver_data *idd, int *last,
+			      unsigned long addr)
+{
+	int a, b, index, disc;
+
+	nic_reset(idd);
+
+	/* Search ROM.  */
+	nic_write_byte(idd, 0xf0);
+
+	/* Algorithm from ``Book of iButton Standards''.  */
+	for (index = 0, disc = 0; index < 64; index++) {
+		a = nic_read_bit(idd);
+		b = nic_read_bit(idd);
+
+		if (a && b) {
+			printk(KERN_WARNING "IOC3 NIC search failed.\n");
+			*last = 0;
+			return 0;
+		}
+
+		if (!a && !b) {
+			if (index == *last) {
+				addr |= 1UL << index;
+			} else if (index > *last) {
+				addr &= ~(1UL << index);
+				disc = index;
+			} else if ((addr & (1UL << index)) == 0)
+				disc = index;
+			nic_write_bit(idd, (addr >> index) & 1);
+			continue;
+		} else {
+			if (a)
+				addr |= 1UL << index;
+			else
+				addr &= ~(1UL << index);
+			nic_write_bit(idd, a);
+			continue;
+		}
+	}
+
+	*last = disc;
+
+	return addr;
+}
+
+static void nic_addr(struct ioc3_driver_data *idd, unsigned long addr)
+{
+	int index;
+
+	nic_reset(idd);
+	nic_write_byte(idd, 0xf0);
+	for (index = 0; index < 64; index++) {
+		nic_read_bit(idd);
+		nic_read_bit(idd);
+		nic_write_bit(idd, (addr >> index) & 1);
+	}
+}
+
+static void crc16_byte(unsigned int *crc, unsigned char db)
+{
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		*crc <<= 1;
+		if ((db ^ (*crc >> 16)) & 1)
+			*crc ^= 0x8005;
+		db >>= 1;
+	}
+	*crc &= 0xffff;
+}
+
+static unsigned int crc16_area(unsigned char *dbs, int size, unsigned int crc)
+{
+	while (size--)
+		crc16_byte(&crc, *(dbs++));
+	return crc;
+}
+
+static void crc8_byte(unsigned int *crc, unsigned char db)
+{
+	int i, f;
+
+	for (i = 0; i < 8; i++) {
+		f = (*crc ^ db) & 1;
+		*crc >>= 1;
+		db >>= 1;
+		if (f)
+			*crc ^= 0x8c;
+	}
+	*crc &= 0xff;
+}
+
+static unsigned int crc8_addr(unsigned long addr)
+{
+	int i;
+	unsigned int crc = 0x00;
+
+	for (i = 0; i < 8; i++)
+		crc8_byte(&crc, addr >> (i << 3));
+	return crc;
+}
+
+static void read_redir_page(struct ioc3_driver_data *idd, unsigned long addr,
+			    int page, unsigned char *redir, unsigned char *data)
+{
+	int loops = 16, i;
+
+	while (redir[page] != 0xff) {
+		page = (redir[page] ^ 0xff);
+		loops--;
+		if (loops < 0) {
+			printk(KERN_ERR "IOC3: NIC circular redirection\n");
+			return;
+		}
+	}
+
+	loops = 3;
+	while (loops > 0) {
+		nic_addr(idd, addr);
+		nic_write_byte(idd, 0xf0);
+		nic_write_byte(idd, (page << 5) & 0xe0);
+		nic_write_byte(idd, (page >> 3) & 0x1f);
+		for (i = 0; i < 0x20; i++)
+			data[i] = nic_read_byte(idd);
+
+		if (crc16_area(data, 0x20, 0x0000) == 0x800d)
+			return;
+
+		loops--;
+	}
+
+	printk(KERN_ERR "IOC3: CRC error in data page\n");
+	for (i = 0; i < 0x20; i++)
+		data[i] = 0x00;
+}
+
+static void read_redir_map(struct ioc3_driver_data *idd, unsigned long addr,
+			   unsigned char *redir)
+{
+	int i, j, loops = 3, crc_ok;
+	unsigned int crc;
+
+	while (loops > 0) {
+		crc_ok = 1;
+		nic_addr(idd, addr);
+		nic_write_byte(idd, 0xaa);
+		nic_write_byte(idd, 0x00);
+		nic_write_byte(idd, 0x01);
+
+		for (i = 0; i < 64; i += 8) {
+			for (j = 0; j < 8; j++)
+				redir[i + j] = nic_read_byte(idd);
+			crc = crc16_area((redir + i), 8,
+					 (i == 0) ? 0x8707 : 0x0000);
+			crc16_byte(&crc, nic_read_byte(idd));
+			crc16_byte(&crc, nic_read_byte(idd));
+			if (crc != 0x800d)
+				crc_ok = 0;
+		}
+
+		if (crc_ok)
+			return;
+
+		loops--;
+	}
+
+	printk(KERN_ERR "IOC3: CRC error in redirection page\n");
+	for (i = 0; i < 64; i++)
+		redir[i] = 0xff;
+}
+
+static void read_nic(struct ioc3_driver_data *idd, unsigned long addr)
+{
+	unsigned char redir[64];
+	unsigned char data[64],part[32];
+	int i, j;
+
+	/* read redirections */
+	read_redir_map(idd, addr, redir);
+
+	/* read data pages */
+	read_redir_page(idd, addr, 0, redir, data);
+	read_redir_page(idd, addr, 1, redir, (data + 32));
+
+	/* assemble the part # */
+	j = 0;
+	for (i = 0; i < 19; i++)
+		if (data[i + 11] != ' ')
+			part[j++] = data[i + 11];
+	for (i = 0; i < 6; i++)
+		if (data[i + 32] != ' ')
+			part[j++] = data[i + 32];
+	part[j] = 0;
+
+#ifdef CONFIG_SGI_IP30
+	/* skip Octane (IP30) power supplies */
+	if (!(strncmp(part, "060-0035-", 9)) || 
+	    !(strncmp(part, "060-0038-", 9)) ||
+	    !(strncmp(part, "060-0028-", 9)))
+		return;
+
+#endif
+	strcpy(idd->nic_part, part);
+
+	/* assemble the serial # */
+	j = 0;
+	for (i = 0; i < 10; i++)
+		if (data[i + 1] != ' ')
+			idd->nic_serial[j++] = data[i + 1];
+
+	idd->nic_serial[j] = 0;
+}
+
+static void read_mac(struct ioc3_driver_data *idd, unsigned long addr)
+{
+	int i, loops = 3;
+	unsigned char data[13];
+	while (loops > 0) {
+		nic_addr(idd, addr);
+		nic_write_byte(idd, 0xf0);
+		nic_write_byte(idd, 0x00);
+		nic_write_byte(idd, 0x00);
+		nic_read_byte(idd);
+
+		for (i = 0; i < 13; i++)
+			data[i] = nic_read_byte(idd);
+
+		if (crc16_area(data, 13, 0x0000) == 0x800d) {
+			for (i = 10; i > 4; i--)
+				idd->nic_mac[10 - i] = data[i];
+			return;
+		}
+		loops--;
+	}
+	printk(KERN_ERR "IOC3: CRC error in MAC address\n");
+
+	for (i = 0; i < 6; i++)
+		idd->nic_mac[i] = 0x00;
+}
+
+static void probe_nic(struct ioc3_driver_data *idd)
+{
+	int save = 0, loops = 3;
+	unsigned long first, addr;
+
+	writel(GPCR_MLAN_EN, &idd->vma->gpcr_s);
+
+	while (loops > 0) {
+		idd->nic_part[0] = 0;
+		idd->nic_serial[0] = 0;
+		addr = first = nic_find(idd, &save, 0);
+		if (!first)
+			return;
+
+		while (1) {
+			if (crc8_addr(addr))
+				break;
+			else {
+				switch (addr & 0xff) {
+				case 0x0b:
+					read_nic(idd, addr);
+					break;
+				case 0x09:
+				case 0x89:
+				case 0x91:
+					read_mac(idd, addr);
+					break;
+				}
+			}
+			addr = nic_find(idd, &save, addr);
+			if (addr == first)
+				return;
+		}
+		loops--;
+	}
+	printk(KERN_ERR "IOC3: CRC error in NIC address\n");
+}
+
+
+/* Interrupts */
+#define IOC3_W_IES		0
+#define IOC3_W_IEC		1
+static void write_ireg(struct ioc3_driver_data *idd, uint32_t val, int which)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&idd->ir_lock, flags);
+	switch (which) {
+	case IOC3_W_IES:
+		writel(val, &idd->vma->sio_ies);
+		break;
+	case IOC3_W_IEC:
+		writel(val, &idd->vma->sio_iec);
+		break;
+	}
+	spin_unlock_irqrestore(&idd->ir_lock, flags);
+}
+
+static inline uint32_t get_pending_intrs(struct ioc3_driver_data *idd)
+{
+	unsigned long flag;
+	uint32_t intrs = 0;
+
+	spin_lock_irqsave(&idd->ir_lock, flag);
+	intrs = readl(&idd->vma->sio_ir);
+	intrs &= readl(&idd->vma->sio_ies);
+	spin_unlock_irqrestore(&idd->ir_lock, flag);
+	return intrs;
+}
+
+static irqreturn_t ioc3_intr_io(int irq, void *arg)
+{
+	unsigned long flags;
+	struct ioc3_driver_data *idd = (struct ioc3_driver_data *)arg;
+	int handled = 1, id;
+	unsigned int pending;
+
+	read_lock_irqsave(&ioc3_submodules_lock, flags);
+
+	if (!idd->dual_irq && readb(idd->vma->eisr))	/* send Ethernet IRQ to the driver */
+		if (ioc3_ethernet && idd->active[ioc3_ethernet->id] &&
+						 ioc3_ethernet->intr)
+			handled = handled && !ioc3_ethernet->intr(ioc3_ethernet,
+								  idd, 0);
+
+	pending = get_pending_intrs(idd);	/* look at the IO IRQs */
+	for (id = 0; id < IOC3_MAX_SUBMODULES; id++)
+		if (idd->active[id] && ioc3_submodules[id] &&
+		    (pending & ioc3_submodules[id]->irq_mask) &&
+		     ioc3_submodules[id]->intr)
+		{
+			write_ireg(idd, ioc3_submodules[id]->irq_mask, IOC3_W_IEC);
+			if (!ioc3_submodules[id]->intr(ioc3_submodules[id], idd,
+						       (pending &
+							ioc3_submodules[id]->irq_mask)))
+				pending &=~ ioc3_submodules[id]->irq_mask;
+			write_ireg(idd, ioc3_submodules[id]->irq_mask, IOC3_W_IES);
+		}
+	read_unlock_irqrestore(&ioc3_submodules_lock, flags);
+
+	if (pending) {
+		printk(KERN_WARNING
+		       "IOC3: Pending IRQs 0x%08x discarded and disabled\n",
+		       pending);
+		write_ireg(idd, pending, IOC3_W_IEC);
+		handled = 1;
+	}
+	return handled ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static irqreturn_t ioc3_intr_eth(int irq, void *arg)
+{
+	unsigned long flags;
+	struct ioc3_driver_data *idd = (struct ioc3_driver_data *)arg;
+	int handled = 1;
+
+	if (!idd->dual_irq)
+		return IRQ_NONE;
+
+	read_lock_irqsave(&ioc3_submodules_lock, flags);
+	if (ioc3_ethernet && idd->active[ioc3_ethernet->id] && ioc3_ethernet->intr)
+		handled = handled && !ioc3_ethernet->intr(ioc3_ethernet, idd, 0);
+	read_unlock_irqrestore(&ioc3_submodules_lock, flags);
+	return handled ? IRQ_HANDLED : IRQ_NONE;
+}
+
+void ioc3_enable(struct ioc3_submodule *is, struct ioc3_driver_data *idd,
+		 unsigned int irqs)
+{
+	write_ireg(idd, (irqs & is->irq_mask), IOC3_W_IES);
+}
+
+void ioc3_ack(struct ioc3_submodule *is, struct ioc3_driver_data *idd,
+	      unsigned int irqs)
+{
+	writel(irqs & is->irq_mask, &idd->vma->sio_ir);
+}
+
+void ioc3_disable(struct ioc3_submodule *is, struct ioc3_driver_data *idd,
+		  unsigned int irqs)
+{
+	write_ireg(idd, (irqs & is->irq_mask), IOC3_W_IEC);
+}
+
+#ifdef CONFIG_IA64_SGI_SN2
+/* SGI SN2 writes to gpcr to set GPIOs to output */
+void ioc3_gpcr_set(struct ioc3_driver_data *idd, unsigned int val)
+{
+        unsigned long flags;
+        spin_lock_irqsave(&idd->gpio_lock, flags);
+        writel(val, &idd->vma->gpcr_s);
+        spin_unlock_irqrestore(&idd->gpio_lock, flags);
+}
+#else
+/* IP27, IP30 writes to gpdr to set GPIOs to 1 */
+void ioc3_gpio(struct ioc3_driver_data *idd, unsigned int mask, unsigned int val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&idd->gpio_lock, flags);
+	idd->gpdr_shadow &= ~mask;
+	idd->gpdr_shadow |= (val & mask);
+	writel(idd->gpdr_shadow, &idd->vma->gpdr);
+	spin_unlock_irqrestore(&idd->gpio_lock, flags);
+}
+#endif
+
+
+/* Keep it simple, stupid! */
+static int find_slot(void **tab, int max)
+{
+	int i;
+	for (i = 0; i < max; i++)
+		if (!(tab[i]))
+			return i;
+	return -1;
+}
+
+/* Register an IOC3 submodule */
+int ioc3_register_submodule(struct ioc3_submodule *is)
+{
+	struct ioc3_driver_data *idd;
+	int alloc_id;
+	unsigned long flags;
+
+	write_lock_irqsave(&ioc3_submodules_lock, flags);
+	alloc_id = find_slot((void **)ioc3_submodules, IOC3_MAX_SUBMODULES);
+	if (alloc_id != -1) {
+		ioc3_submodules[alloc_id] = is;
+		if (is->ethernet) {
+			if (ioc3_ethernet == NULL)
+				ioc3_ethernet = is;
+			else
+				printk(KERN_WARNING
+				       "IOC3 Ethernet module already registered!\n");
+		}
+	}
+	write_unlock_irqrestore(&ioc3_submodules_lock, flags);
+
+	if (alloc_id == -1) {
+		printk(KERN_WARNING "Increase IOC3_MAX_SUBMODULES!\n");
+		return -ENOMEM;
+	}
+
+	is->id=alloc_id;
+
+	/* Initialize submodule for each IOC3 */
+	if (!is->probe)
+		return 0;
+
+	down_read(&ioc3_devices_rwsem);
+	list_for_each_entry(idd, &ioc3_devices, list) {
+		/* set to 1 for IRQs in probe */
+		idd->active[alloc_id] = 1;
+		idd->active[alloc_id] = !is->probe(is, idd);
+	}
+	up_read(&ioc3_devices_rwsem);
+
+	return 0;
+}
+
+/* Unregister an IOC3 submodule */
+void ioc3_unregister_submodule(struct ioc3_submodule *is)
+{
+	struct ioc3_driver_data *idd;
+	unsigned long flags;
+
+	write_lock_irqsave(&ioc3_submodules_lock, flags);
+	if (ioc3_submodules[is->id] == is)
+		ioc3_submodules[is->id] = NULL;
+	else
+		printk(KERN_WARNING "IOC3 submodule %s has wrong ID.\n",
+				    is->name);
+	if (ioc3_ethernet == is)
+		ioc3_ethernet = NULL;
+	write_unlock_irqrestore(&ioc3_submodules_lock, flags);
+
+	/* Remove submodule for each IOC3 */
+	down_read(&ioc3_devices_rwsem);
+	list_for_each_entry(idd, &ioc3_devices, list)
+		if (idd->active[is->id]) {
+			if (is->remove)
+				if (is->remove(is, idd))
+					printk(KERN_WARNING
+					       "%s: IOC3 submodule %s remove failed "
+					       "for pci_dev %s.\n",
+					       __FUNCTION__, module_name(is->owner),
+					       pci_name(idd->pdev));
+			idd->active[is->id] = 0;
+			if (is->irq_mask)
+				write_ireg(idd, is->irq_mask, IOC3_W_IEC);
+		}
+	up_read(&ioc3_devices_rwsem);
+}
+
+
+/*********************
+ * Device management *
+ *********************/
+
+static char *ioc3_class_names[] = {"unknown", "IP27 BaseIO", "IP30 system",
+				   "MENET 1/2/3", "MENET 4", "CADduo",
+				   "Altix Serial"};
+
+static int ioc3_class(struct ioc3_driver_data *idd)
+{
+	int res = IOC3_CLASS_NONE;
+
+	/* NIC-based logic */
+#ifdef CONFIG_SGI_IP30
+	if (!strncmp(idd->nic_part, "030-0891-", 9))
+		res = IOC3_CLASS_BASE_IP30;
+#endif
+	if (!strncmp(idd->nic_part, "030-1155-", 9))
+		res = IOC3_CLASS_CADDUO;
+	if (!strncmp(idd->nic_part, "030-1657-", 9))
+		res = IOC3_CLASS_SERIAL;
+	if (!strncmp(idd->nic_part, "030-1664-", 9))
+		res = IOC3_CLASS_SERIAL;
+#ifdef CONFIG_SGI_IP27
+	/* total random heuristics */
+	if (!idd->nic_part[0])
+		res = IOC3_CLASS_BASE_IP27;
+#endif
+	/* print educational message */
+	printk(KERN_INFO "IOC3 part: [%s], serial: [%s] => class %s\n",
+			 idd->nic_part, idd->nic_serial,
+			 ioc3_class_names[res]);
+	return res;
+}
+
+/* Adds a new instance of an IOC3 card */
+static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *pci_id)
+{
+	struct ioc3_driver_data *idd;
+	uint32_t pcmd;
+	int ret, id;
+
+	/* Enable IOC3 and take ownership of it */
+	if ((ret = pci_enable_device(pdev))) {
+		printk(KERN_WARNING
+		       "%s: Failed to enable IOC3 device for pci_dev %s.\n",
+		       __FUNCTION__, pci_name(pdev));
+		goto out;
+	}
+	pci_set_master(pdev);
+
+	ret = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
+	if (!ret) {
+		ret = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
+		if (ret < 0) {
+			printk(KERN_WARNING "%s: Unable to obtain 64 bit DMA "
+				"for consistent allocations\n",
+				__FUNCTION__);
+		}
+	}
+
+	/* Set up per-IOC3 data */
+	idd = kmalloc(sizeof(struct ioc3_driver_data), GFP_KERNEL);
+	if (!idd) {
+		printk(KERN_WARNING
+		       "%s: Failed to allocate IOC3 data for pci_dev %s.\n",
+		       __FUNCTION__, pci_name(pdev));
+		ret = -ENODEV;
+		goto out_idd;
+	}
+	memset(idd, 0, sizeof(struct ioc3_driver_data));
+	spin_lock_init(&idd->ir_lock);
+	spin_lock_init(&idd->gpio_lock);
+	idd->pdev = pdev;
+
+	/* Map all IOC3 registers.  These are shared between subdevices
+	 * so the main IOC3 module manages them.
+	 */
+	idd->pma = pci_resource_start(pdev, 0);
+	if (!idd->pma) {
+		printk(KERN_WARNING
+		       "%s: Unable to find IOC3 resource "
+		       "for pci_dev %s.\n",
+		       __FUNCTION__, pci_name(pdev));
+		ret = -ENODEV;
+		goto out_pci;
+	}
+	if (!request_mem_region(idd->pma, IOC3_PCI_SIZE, "ioc3")) {
+		printk(KERN_WARNING
+		       "%s: Unable to request IOC3 region "
+		       "for pci_dev %s.\n",
+		       __FUNCTION__, pci_name(pdev));
+		ret = -ENODEV;
+		goto out_pci;
+	}
+	idd->vma = ioremap(idd->pma, IOC3_PCI_SIZE);
+	if (!idd->vma) {
+		printk(KERN_WARNING
+		       "%s: Unable to remap IOC3 region "
+		       "for pci_dev %s.\n",
+		       __FUNCTION__, pci_name(pdev));
+		ret = -ENODEV;
+		goto out_misc_region;
+	}
+
+	/* Track PCI-device specific data */
+	pci_set_drvdata(pdev, idd);
+	down_write(&ioc3_devices_rwsem);
+	list_add_tail(&idd->list, &ioc3_devices);
+	idd->id = ioc3_counter++;
+	up_write(&ioc3_devices_rwsem);
+
+	idd->gpdr_shadow = readl(&idd->vma->gpdr);
+
+	/* Read IOC3 NIC contents */
+	probe_nic(idd);
+
+	/* Detect IOC3 class */
+	idd->class = ioc3_class(idd);
+
+	/* Initialize IOC3 */
+	pci_read_config_dword(pdev, PCI_COMMAND, &pcmd);
+	pci_write_config_dword(pdev, PCI_COMMAND,
+			       pcmd | PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
+
+	write_ireg(idd, ~0, IOC3_W_IEC);
+	writel(~0, &idd->vma->sio_ir);
+
+	/* Set up IRQs */
+	if (idd->class == IOC3_CLASS_BASE_IP30 ||
+	    idd->class == IOC3_CLASS_BASE_IP27) {
+
+		writel(0, &idd->vma->eier);
+		writel(~0, &idd->vma->eisr);
+
+		idd->dual_irq = 1;
+		if (!request_irq(pdev->irq, ioc3_intr_eth, IRQF_SHARED,
+				 "ioc3-eth", (void *)idd)) {
+			idd->irq_eth = pdev->irq;
+		} else {
+			printk(KERN_WARNING
+			       "%s : request_irq fails for IRQ 0x%x\n ",
+			       __FUNCTION__, pdev->irq);
+		}
+		if (!request_irq((pdev->irq + 2), ioc3_intr_io, IRQF_SHARED,
+				 "ioc3-io", (void *)idd)) {
+			idd->irq_io = (pdev->irq + 2);
+		} else {
+			printk(KERN_WARNING
+			       "%s : request_irq fails for IRQ 0x%x\n ",
+			       __FUNCTION__, (pdev->irq + 2));
+		}
+	} else {
+		if (!request_irq(pdev->irq, ioc3_intr_io, IRQF_SHARED,
+				 "ioc3", (void *)idd)) {
+			idd->irq_io = pdev->irq;
+		} else {
+			printk(KERN_WARNING
+			       "%s : request_irq fails for IRQ 0x%x\n ",
+			       __FUNCTION__, pdev->irq);
+		}
+	}
+
+	/* Add this IOC3 to all submodules */
+	read_lock(&ioc3_submodules_lock);
+	for (id = 0; id < IOC3_MAX_SUBMODULES; id++)
+		if (ioc3_submodules[id] && ioc3_submodules[id]->probe) {
+			idd->active[id] = 1;
+			idd->active[id] = !ioc3_submodules[id]->probe
+						(ioc3_submodules[id], idd);
+		}
+	read_unlock(&ioc3_submodules_lock);
+
+	printk(KERN_INFO "IOC3 Master Driver loaded for %s\n", pci_name(pdev));
+
+	return 0;
+
+out_misc_region:
+	release_mem_region(idd->pma, IOC3_PCI_SIZE);
+out_pci:
+	kfree(idd);
+out_idd:
+	pci_disable_device(pdev);
+out:
+	return ret;
+}
+
+/* Removes a particular instance of an IOC3 card. */
+static void ioc3_remove(struct pci_dev *pdev)
+{
+	int id;
+	struct ioc3_driver_data *idd;
+
+	idd = pci_get_drvdata(pdev);
+
+	/* Remove this IOC3 from all submodules */
+	read_lock(&ioc3_submodules_lock);
+	for (id = 0; id < IOC3_MAX_SUBMODULES; id++)
+		if (idd->active[id]) {
+			if (ioc3_submodules[id] && ioc3_submodules[id]->remove)
+				if (ioc3_submodules[id]->remove(ioc3_submodules[id], idd))
+					printk(KERN_WARNING
+						"%s: IOC3 submodule 0x%s remove failed "
+						"for pci_dev %s.\n",
+						__FUNCTION__,
+						module_name(ioc3_submodules[id]->owner),
+						pci_name(pdev));
+			idd->active[id] = 0;
+		}
+	read_unlock(&ioc3_submodules_lock);
+
+	/* Clear and disable all IRQs */
+	write_ireg(idd, ~0, IOC3_W_IEC);
+	writel(~0, &idd->vma->sio_ir);
+
+	/* Release resources */
+	free_irq(idd->irq_io, (void *)idd);
+	if (idd->dual_irq)
+		free_irq(idd->irq_eth, (void *)idd);
+	iounmap(idd->vma);
+	release_mem_region(idd->pma, IOC3_PCI_SIZE);
+
+	/* Disable IOC3 and relinquish */
+	pci_disable_device(pdev);
+
+	/* Remove and free driver data */
+	down_write(&ioc3_devices_rwsem);
+	list_del(&idd->list);
+	up_write(&ioc3_devices_rwsem);
+	kfree(idd);
+}
+
+static struct pci_device_id ioc3_id_table[] = {
+	{PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3, PCI_ANY_ID, PCI_ANY_ID},
+	{0}
+};
+
+static struct pci_driver ioc3_driver = {
+	.name = "SGI IOC3",
+	.id_table = ioc3_id_table,
+	.probe = ioc3_probe,
+	.remove = ioc3_remove,
+};
+
+MODULE_DEVICE_TABLE(pci, ioc3_id_table);
+
+/*********************
+ * Module management *
+ *********************/
+
+/* Module load */
+static int __devinit ioc3_init(void)
+{
+#ifdef CONFIG_IA64_SGI_SN2
+	if (ia64_platform_is("sn2"))
+		return pci_register_driver(&ioc3_driver);
+	return 0;
+#else
+	return pci_register_driver(&ioc3_driver);
+#endif
+}
+
+/* Module unload */
+static void __devexit ioc3_exit(void)
+{
+	pci_unregister_driver(&ioc3_driver);
+}
+
+module_init(ioc3_init);
+module_exit(ioc3_exit);
+
+MODULE_AUTHOR("Stanislaw Skowronek <skylark@linux-mips.org>");
+MODULE_DESCRIPTION("PCI driver for SGI IOC3");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("R27");
+
+EXPORT_SYMBOL_GPL(ioc3_register_submodule);
+EXPORT_SYMBOL_GPL(ioc3_unregister_submodule);
+EXPORT_SYMBOL_GPL(ioc3_ack);
+EXPORT_SYMBOL_GPL(ioc3_disable);
+EXPORT_SYMBOL_GPL(ioc3_enable);
+
+#ifdef CONFIG_IA64_SGI_SN2
+EXPORT_SYMBOL_GPL(ioc3_gpcr_set);
+#else
+EXPORT_SYMBOL_GPL(ioc3_gpio);
+#endif
+
diff -Naurp linux-2.6.26.orig/drivers/input/serio/Kconfig linux-2.6.26/drivers/input/serio/Kconfig
--- linux-2.6.26.orig/drivers/input/serio/Kconfig	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/drivers/input/serio/Kconfig	2008-07-25 01:03:02.000000000 -0400
@@ -18,6 +18,13 @@ config SERIO
 
 if SERIO
 
+config SERIO_SGI_IOC3
+	tristate "SGI IOC3 keyboard controller"
+	default y
+	depends on SGI_IOC3
+	---help---
+	  If you have an Octane and you want to use its keyboard, select this.
+
 config SERIO_I8042
 	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
 	default y
diff -Naurp linux-2.6.26.orig/drivers/input/serio/Makefile linux-2.6.26/drivers/input/serio/Makefile
--- linux-2.6.26.orig/drivers/input/serio/Makefile	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/drivers/input/serio/Makefile	2008-07-25 01:03:02.000000000 -0400
@@ -19,5 +19,6 @@ obj-$(CONFIG_HP_SDC)		+= hp_sdc.o
 obj-$(CONFIG_HIL_MLC)		+= hp_sdc_mlc.o hil_mlc.o
 obj-$(CONFIG_SERIO_PCIPS2)	+= pcips2.o
 obj-$(CONFIG_SERIO_MACEPS2)	+= maceps2.o
+obj-$(CONFIG_SERIO_SGI_IOC3)	+= ioc3kbd.o
 obj-$(CONFIG_SERIO_LIBPS2)	+= libps2.o
 obj-$(CONFIG_SERIO_RAW)		+= serio_raw.o
diff -Naurp linux-2.6.26.orig/drivers/input/serio/ioc3kbd.c linux-2.6.26/drivers/input/serio/ioc3kbd.c
--- linux-2.6.26.orig/drivers/input/serio/ioc3kbd.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/drivers/input/serio/ioc3kbd.c	2008-07-25 01:03:02.000000000 -0400
@@ -0,0 +1,187 @@
+/*
+ * SGI IOC3 PS/2 controller driver for linux
+ *
+ * Copyright (C) 2005 Stanislaw Skowronek <skylark@linux-mips.org>
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serio.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+#include <linux/pci.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/system.h>
+#include <linux/ioc3.h>
+
+
+struct ioc3kbd_data {
+	struct ioc3_driver_data *idd;
+	struct serio *kbd,*aux;
+};
+
+static int ioc3kbd_write(struct serio *dev, unsigned char val)
+{
+	struct ioc3kbd_data *d = (struct ioc3kbd_data *)(dev->port_data);
+	unsigned mask;
+	unsigned long timeout=0;
+
+	mask = (dev == d->aux) ? KM_CSR_M_WRT_PEND : KM_CSR_K_WRT_PEND;
+	while ((d->idd->vma->km_csr & mask) && (timeout < 1000)) {
+		udelay(100);
+		timeout++;
+	}
+
+	if (dev == d->aux)
+		d->idd->vma->m_wd = ((unsigned)val) & 0x000000ff;
+	else
+		d->idd->vma->k_wd = ((unsigned)val) & 0x000000ff;
+
+	if (timeout >= 1000)
+		return -1;
+	return 0;
+}
+
+static int ioc3kbd_intr(struct ioc3_submodule *is, struct ioc3_driver_data *idd, unsigned int irq)
+{
+	struct ioc3kbd_data *d = (struct ioc3kbd_data *)(idd->data[is->id]);
+	unsigned int data_k, data_m;
+
+	ioc3_ack(is,idd,irq);
+	data_k = d->idd->vma->k_rd;
+	data_m = d->idd->vma->m_rd;
+
+	if (data_k & KM_RD_VALID_0)
+		serio_interrupt(d->kbd, (data_k >> KM_RD_DATA_0_SHIFT) & 0xff, 0);
+	if (data_k & KM_RD_VALID_1)
+		serio_interrupt(d->kbd, (data_k >> KM_RD_DATA_1_SHIFT) & 0xff, 0);
+	if (data_k & KM_RD_VALID_2)
+		serio_interrupt(d->kbd, (data_k >> KM_RD_DATA_2_SHIFT) & 0xff, 0);
+	if (data_m & KM_RD_VALID_0)
+		serio_interrupt(d->aux, (data_m >> KM_RD_DATA_0_SHIFT) & 0xff, 0);
+	if (data_m & KM_RD_VALID_1)
+		serio_interrupt(d->aux, (data_m >> KM_RD_DATA_1_SHIFT) & 0xff, 0);
+	if (data_m & KM_RD_VALID_2)
+		serio_interrupt(d->aux, (data_m >> KM_RD_DATA_2_SHIFT) & 0xff, 0);
+
+	return 0;
+}
+
+static int ioc3kbd_open(struct serio *dev)
+{
+	return 0;
+}
+
+static void ioc3kbd_close(struct serio *dev)
+{
+	/* Empty */
+}
+
+static struct ioc3kbd_data * __init ioc3kbd_allocate_port(int idx, struct ioc3_driver_data *idd)
+{
+	struct serio *sk, *sa;
+	struct ioc3kbd_data *d;
+
+	sk = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	sa = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	d = kmalloc(sizeof(struct ioc3kbd_data), GFP_KERNEL);
+
+	if (sk && sa && d) {
+		memset(sk, 0, sizeof(struct serio));
+		sk->id.type = SERIO_8042;
+		sk->write = ioc3kbd_write;
+		sk->open = ioc3kbd_open;
+		sk->close = ioc3kbd_close;
+
+		snprintf(sk->name, sizeof(sk->name), "IOC3 keyboard %d", idx);
+		snprintf(sk->phys, sizeof(sk->phys), "ioc3/serio%dkbd", idx);
+
+		sk->port_data = d;
+		sk->dev.parent = &(idd->pdev->dev);
+		memset(sa, 0, sizeof(struct serio));
+		sa->id.type = SERIO_8042;
+		sa->write = ioc3kbd_write;
+		sa->open = ioc3kbd_open;
+		sa->close = ioc3kbd_close;
+
+		snprintf(sa->name, sizeof(sa->name), "IOC3 auxiliary %d", idx);
+		snprintf(sa->phys, sizeof(sa->phys), "ioc3/serio%daux", idx);
+
+		sa->port_data = d;
+		sa->dev.parent = &(idd->pdev->dev);
+		d->idd = idd;
+		d->kbd = sk;
+		d->aux = sa;
+		return d;
+	}
+
+	return NULL;
+}
+
+static int ioc3kbd_probe(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
+{
+	struct ioc3kbd_data *d;
+
+	if ((idd->class != IOC3_CLASS_BASE_IP30) &&
+	    (idd->class != IOC3_CLASS_CADDUO))
+		return 1;
+
+	d = ioc3kbd_allocate_port(idd->id, idd);
+	idd->data[is->id] = d;
+
+	if (!d)
+		return 1;
+
+	ioc3_enable(is, idd, is->irq_mask);
+	serio_register_port(d->kbd);
+	serio_register_port(d->aux);
+	return 0;
+}
+
+static int ioc3kbd_remove(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
+{
+	struct ioc3kbd_data *d = (struct ioc3kbd_data *)(idd->data[is->id]);
+	serio_unregister_port(d->kbd);
+	serio_unregister_port(d->aux);
+	kfree(d->kbd);
+	kfree(d->aux);
+	kfree(d);
+	idd->data[is->id] = NULL;
+	return 0;
+}
+
+static struct ioc3_submodule ioc3kbd_submodule = {
+	.name = "serio",
+	.probe = ioc3kbd_probe,
+	.remove = ioc3kbd_remove,
+	.irq_mask = SIO_IR_KBD_INT,
+	.intr = ioc3kbd_intr,
+	.owner = THIS_MODULE,
+};
+
+static int __init ioc3kbd_init(void)
+{
+	ioc3_register_submodule(&ioc3kbd_submodule);
+	return 0;
+}
+
+static void __exit ioc3kbd_exit(void)
+{
+	ioc3_unregister_submodule(&ioc3kbd_submodule);
+}
+
+module_init(ioc3kbd_init);
+module_exit(ioc3kbd_exit);
+
+MODULE_AUTHOR("Stanislaw Skowronek <skylark@linux-mips.org>");
+MODULE_DESCRIPTION("SGI IOC3 serio driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("R27");
+
diff -Naurp linux-2.6.26.orig/drivers/net/Kconfig linux-2.6.26/drivers/net/Kconfig
--- linux-2.6.26.orig/drivers/net/Kconfig	2008-07-23 22:26:29.000000000 -0400
+++ linux-2.6.26/drivers/net/Kconfig	2008-07-25 01:03:02.000000000 -0400
@@ -492,7 +492,7 @@ config MIPS_AU1X00_ENET
 
 config SGI_IOC3_ETH
 	bool "SGI IOC3 Ethernet"
-	depends on PCI && SGI_IP27
+	depends on SGI_IOC3
 	select CRC32
 	select MII
 	help
diff -Naurp linux-2.6.26.orig/drivers/net/ioc3-eth.c linux-2.6.26/drivers/net/ioc3-eth.c
--- linux-2.6.26.orig/drivers/net/ioc3-eth.c	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/drivers/net/ioc3-eth.c	2008-07-25 01:03:02.000000000 -0400
@@ -7,6 +7,7 @@
  *
  * Copyright (C) 1999, 2000, 01, 03, 06 Ralf Baechle
  * Copyright (C) 1995, 1999, 2000, 2001 by Silicon Graphics, Inc.
+ * Copyright (C) 2005 Stanislaw Skowronek (port to meta-driver)
  *
  * References:
  *  o IOC3 ASIC specification 4.51, 1996-04-18
@@ -20,15 +21,13 @@
  *  o Use prefetching for large packets.  What is a good lower limit for
  *    prefetching?
  *  o We're probably allocating a bit too much memory.
- *  o Use hardware checksums.
- *  o Convert to using a IOC3 meta driver.
  *  o Which PHYs might possibly be attached to the IOC3 in real live,
  *    which workarounds are required for them?  Do we ever have Lucent's?
  *  o For the 2.5 branch kill the mii-tool ioctls.
  */
 
 #define IOC3_NAME	"ioc3-eth"
-#define IOC3_VERSION	"2.6.3-4"
+#define IOC3_VERSION	"2.6.5-s2"
 
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -45,12 +44,6 @@
 #include <linux/udp.h>
 #include <linux/dma-mapping.h>
 
-#ifdef CONFIG_SERIAL_8250
-#include <linux/serial_core.h>
-#include <linux/serial_8250.h>
-#include <linux/serial_reg.h>
-#endif
-
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
@@ -61,21 +54,29 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
+
+#ifdef CONFIG_SGI_IP30
+#include <asm/mach-ip30/addrs.h>
+#else
 #include <asm/sn/types.h>
 #include <asm/sn/ioc3.h>
+#endif /* CONFIG_SGI_IP30 */
 #include <asm/pci/bridge.h>
 
+#include <linux/ioc3.h>
+
 /*
  * 64 RX buffers.  This is tunable in the range of 16 <= x < 512.  The
  * value must be a power of two.
  */
 #define RX_BUFFS 64
 
-#define ETCSR_FD	((17<<ETCSR_IPGR2_SHIFT) | (11<<ETCSR_IPGR1_SHIFT) | 21)
-#define ETCSR_HD	((21<<ETCSR_IPGR2_SHIFT) | (21<<ETCSR_IPGR1_SHIFT) | 21)
+#define ETCSR_FD	((17 << ETCSR_IPGR2_SHIFT) | (11 << ETCSR_IPGR1_SHIFT) | 21)
+#define ETCSR_HD	((21 << ETCSR_IPGR2_SHIFT) | (21 << ETCSR_IPGR1_SHIFT) | 21)
 
 /* Private per NIC data of the driver.  */
 struct ioc3_private {
+	struct ioc3_driver_data *idd;
 	struct ioc3 *regs;
 	unsigned long *rxr;		/* pointer to receiver ring */
 	struct ioc3_etxd *txr;
@@ -147,8 +148,15 @@ static inline unsigned long ioc3_map(voi
 	return vdev | (0xaUL << PCI64_ATTR_TARG_SHFT) | PCI64_ATTR_PREF |
 	       ((unsigned long)ptr & TO_PHYS_MASK);
 #else
+#ifdef CONFIG_SGI_IP30
+	vdev <<= 58;   /* Shift to PCI64_ATTR_VIRTUAL */
+
+	return vdev | (0x8UL << PCI64_ATTR_TARG_SHFT) | PCI64_ATTR_PREF |
+	       ((unsigned long)ptr & TO_PHYS_MASK);
+#else
 	return virt_to_bus(ptr);
 #endif
+#endif
 }
 
 /* BEWARE: The IOC3 documentation documents the size of rx buffers as
@@ -224,218 +232,6 @@ static inline unsigned long ioc3_map(voi
 #define ioc3_r_midr_w()		be32_to_cpu(ioc3->midr_w)
 #define ioc3_w_midr_w(v)	do { ioc3->midr_w = cpu_to_be32(v); } while (0)
 
-static inline u32 mcr_pack(u32 pulse, u32 sample)
-{
-	return (pulse << 10) | (sample << 2);
-}
-
-static int nic_wait(struct ioc3 *ioc3)
-{
-	u32 mcr;
-
-        do {
-                mcr = ioc3_r_mcr();
-        } while (!(mcr & 2));
-
-        return mcr & 1;
-}
-
-static int nic_reset(struct ioc3 *ioc3)
-{
-        int presence;
-
-	ioc3_w_mcr(mcr_pack(500, 65));
-	presence = nic_wait(ioc3);
-
-	ioc3_w_mcr(mcr_pack(0, 500));
-	nic_wait(ioc3);
-
-        return presence;
-}
-
-static inline int nic_read_bit(struct ioc3 *ioc3)
-{
-	int result;
-
-	ioc3_w_mcr(mcr_pack(6, 13));
-	result = nic_wait(ioc3);
-	ioc3_w_mcr(mcr_pack(0, 100));
-	nic_wait(ioc3);
-
-	return result;
-}
-
-static inline void nic_write_bit(struct ioc3 *ioc3, int bit)
-{
-	if (bit)
-		ioc3_w_mcr(mcr_pack(6, 110));
-	else
-		ioc3_w_mcr(mcr_pack(80, 30));
-
-	nic_wait(ioc3);
-}
-
-/*
- * Read a byte from an iButton device
- */
-static u32 nic_read_byte(struct ioc3 *ioc3)
-{
-	u32 result = 0;
-	int i;
-
-	for (i = 0; i < 8; i++)
-		result = (result >> 1) | (nic_read_bit(ioc3) << 7);
-
-	return result;
-}
-
-/*
- * Write a byte to an iButton device
- */
-static void nic_write_byte(struct ioc3 *ioc3, int byte)
-{
-	int i, bit;
-
-	for (i = 8; i; i--) {
-		bit = byte & 1;
-		byte >>= 1;
-
-		nic_write_bit(ioc3, bit);
-	}
-}
-
-static u64 nic_find(struct ioc3 *ioc3, int *last)
-{
-	int a, b, index, disc;
-	u64 address = 0;
-
-	nic_reset(ioc3);
-	/* Search ROM.  */
-	nic_write_byte(ioc3, 0xf0);
-
-	/* Algorithm from ``Book of iButton Standards''.  */
-	for (index = 0, disc = 0; index < 64; index++) {
-		a = nic_read_bit(ioc3);
-		b = nic_read_bit(ioc3);
-
-		if (a && b) {
-			printk("NIC search failed (not fatal).\n");
-			*last = 0;
-			return 0;
-		}
-
-		if (!a && !b) {
-			if (index == *last) {
-				address |= 1UL << index;
-			} else if (index > *last) {
-				address &= ~(1UL << index);
-				disc = index;
-			} else if ((address & (1UL << index)) == 0)
-				disc = index;
-			nic_write_bit(ioc3, address & (1UL << index));
-			continue;
-		} else {
-			if (a)
-				address |= 1UL << index;
-			else
-				address &= ~(1UL << index);
-			nic_write_bit(ioc3, a);
-			continue;
-		}
-	}
-
-	*last = disc;
-
-	return address;
-}
-
-static int nic_init(struct ioc3 *ioc3)
-{
-	const char *unknown = "unknown";
-	const char *type = unknown;
-	u8 crc;
-	u8 serial[6];
-	int save = 0, i;
-
-	while (1) {
-		u64 reg;
-		reg = nic_find(ioc3, &save);
-
-		switch (reg & 0xff) {
-		case 0x91:
-			type = "DS1981U";
-			break;
-		default:
-			if (save == 0) {
-				/* Let the caller try again.  */
-				return -1;
-			}
-			continue;
-		}
-
-		nic_reset(ioc3);
-
-		/* Match ROM.  */
-		nic_write_byte(ioc3, 0x55);
-		for (i = 0; i < 8; i++)
-			nic_write_byte(ioc3, (reg >> (i << 3)) & 0xff);
-
-		reg >>= 8; /* Shift out type.  */
-		for (i = 0; i < 6; i++) {
-			serial[i] = reg & 0xff;
-			reg >>= 8;
-		}
-		crc = reg & 0xff;
-		break;
-	}
-
-	printk("Found %s NIC", type);
-	if (type != unknown) {
-		printk (" registration number %02x:%02x:%02x:%02x:%02x:%02x,"
-			" CRC %02x", serial[0], serial[1], serial[2],
-			serial[3], serial[4], serial[5], crc);
-	}
-	printk(".\n");
-
-	return 0;
-}
-
-/*
- * Read the NIC (Number-In-a-Can) device used to store the MAC address on
- * SN0 / SN00 nodeboards and PCI cards.
- */
-static void ioc3_get_eaddr_nic(struct ioc3_private *ip)
-{
-	struct ioc3 *ioc3 = ip->regs;
-	u8 nic[14];
-	int tries = 2; /* There may be some problem with the battery?  */
-	int i;
-
-	ioc3_w_gpcr_s(1 << 21);
-
-	while (tries--) {
-		if (!nic_init(ioc3))
-			break;
-		udelay(500);
-	}
-
-	if (tries < 0) {
-		printk("Failed to read MAC address\n");
-		return;
-	}
-
-	/* Read Memory.  */
-	nic_write_byte(ioc3, 0xf0);
-	nic_write_byte(ioc3, 0x00);
-	nic_write_byte(ioc3, 0x00);
-
-	for (i = 13; i >= 0; i--)
-		nic[i] = nic_read_byte(ioc3);
-
-	for (i = 2; i < 8; i++)
-		priv_netdev(ip)->dev_addr[i - 2] = nic[i];
-}
-
 /*
  * Ok, this is hosed by design.  It's necessary to know what machine the
  * NIC is in in order to know how to read the NIC address.  We also have
@@ -444,11 +240,18 @@ static void ioc3_get_eaddr_nic(struct io
 static void ioc3_get_eaddr(struct ioc3_private *ip)
 {
 	DECLARE_MAC_BUF(mac);
+	int i, nz = 0;
 
-	ioc3_get_eaddr_nic(ip);
+	for (i =0; i< 6; i++)
+		nz |= (priv_netdev(ip)->dev_addr[i] = ip->idd->nic_mac[i]);
 
-	printk("Ethernet address is %s.\n",
-	       print_mac(mac, priv_netdev(ip)->dev_addr));
+	if (!nz)
+		printk("Ethernet address is unreadable.\n");
+	else
+		printk("Ethernet address is %s.\n",
+			print_mac(mac, priv_netdev(ip)->dev_addr));
+
+	return;
 }
 
 static void __ioc3_set_mac_address(struct net_device *dev)
@@ -736,9 +539,9 @@ static void ioc3_error(struct ioc3_priva
 
 /* The interrupt handler does all of the Rx thread work and cleans up
    after the Tx thread.  */
-static irqreturn_t ioc3_interrupt(int irq, void *_dev)
+static int ioc3eth_intr(struct ioc3_submodule *is, struct ioc3_driver_data *idd, unsigned int irq)
 {
-	struct net_device *dev = (struct net_device *)_dev;
+	struct net_device *dev = (struct net_device *)(idd->data[is->id]);
 	struct ioc3_private *ip = netdev_priv(dev);
 	struct ioc3 *ioc3 = ip->regs;
 	const u32 enabled = EISR_RXTIMERINT | EISR_RXOFLO | EISR_RXBUFOFLO |
@@ -759,7 +562,7 @@ static irqreturn_t ioc3_interrupt(int ir
 	if (eisr & EISR_TXEXPLICIT)
 		ioc3_tx(ip);
 
-	return IRQ_HANDLED;
+	return 0;
 }
 
 static inline void ioc3_setup_duplex(struct ioc3_private *ip)
@@ -833,6 +636,7 @@ static void ioc3_mii_start(struct ioc3_p
 	ip->ioc3_timer.expires = jiffies + (12 * HZ)/10;  /* 1.2 sec. */
 	ip->ioc3_timer.data = (unsigned long) ip;
 	ip->ioc3_timer.function = &ioc3_timer;
+
 	add_timer(&ip->ioc3_timer);
 }
 
@@ -1015,7 +819,7 @@ static void ioc3_init(struct net_device 
 	(void) ioc3_r_emcr();
 
 	/* Misc registers  */
-#ifdef CONFIG_SGI_IP27
+#if (defined CONFIG_SGI_IP27) || (defined CONFIG_SGI_IP30)
 	ioc3_w_erbar(PCI64_ATTR_BAR >> 32);	/* Barrier on last store */
 #else
 	ioc3_w_erbar(0);			/* Let PCI API get it right */
@@ -1052,12 +856,6 @@ static int ioc3_open(struct net_device *
 {
 	struct ioc3_private *ip = netdev_priv(dev);
 
-	if (request_irq(dev->irq, ioc3_interrupt, IRQF_SHARED, ioc3_str, dev)) {
-		printk(KERN_ERR "%s: Can't get irq %d\n", dev->name, dev->irq);
-
-		return -EAGAIN;
-	}
-
 	ip->ehar_h = 0;
 	ip->ehar_l = 0;
 	ioc3_init(dev);
@@ -1076,153 +874,13 @@ static int ioc3_close(struct net_device 
 	netif_stop_queue(dev);
 
 	ioc3_stop(ip);
-	free_irq(dev->irq, dev);
 
 	ioc3_free_rings(ip);
 	return 0;
 }
 
-/*
- * MENET cards have four IOC3 chips, which are attached to two sets of
- * PCI slot resources each: the primary connections are on slots
- * 0..3 and the secondaries are on 4..7
- *
- * All four ethernets are brought out to connectors; six serial ports
- * (a pair from each of the first three IOC3s) are brought out to
- * MiniDINs; all other subdevices are left swinging in the wind, leave
- * them disabled.
- */
-
-static int ioc3_adjacent_is_ioc3(struct pci_dev *pdev, int slot)
-{
-	struct pci_dev *dev = pci_get_slot(pdev->bus, PCI_DEVFN(slot, 0));
-	int ret = 0;
-
-	if (dev) {
-		if (dev->vendor == PCI_VENDOR_ID_SGI &&
-			dev->device == PCI_DEVICE_ID_SGI_IOC3)
-			ret = 1;
-		pci_dev_put(dev);
-	}
-
-	return ret;
-}
-
-static int ioc3_is_menet(struct pci_dev *pdev)
-{
-	return pdev->bus->parent == NULL &&
-	       ioc3_adjacent_is_ioc3(pdev, 0) &&
-	       ioc3_adjacent_is_ioc3(pdev, 1) &&
-	       ioc3_adjacent_is_ioc3(pdev, 2);
-}
-
-#ifdef CONFIG_SERIAL_8250
-/*
- * Note about serial ports and consoles:
- * For console output, everyone uses the IOC3 UARTA (offset 0x178)
- * connected to the master node (look in ip27_setup_console() and
- * ip27prom_console_write()).
- *
- * For serial (/dev/ttyS0 etc), we can not have hardcoded serial port
- * addresses on a partitioned machine. Since we currently use the ioc3
- * serial ports, we use dynamic serial port discovery that the serial.c
- * driver uses for pci/pnp ports (there is an entry for the SGI ioc3
- * boards in pci_boards[]). Unfortunately, UARTA's pio address is greater
- * than UARTB's, although UARTA on o200s has traditionally been known as
- * port 0. So, we just use one serial port from each ioc3 (since the
- * serial driver adds addresses to get to higher ports).
- *
- * The first one to do a register_console becomes the preferred console
- * (if there is no kernel command line console= directive). /dev/console
- * (ie 5, 1) is then "aliased" into the device number returned by the
- * "device" routine referred to in this console structure
- * (ip27prom_console_dev).
- *
- * Also look in ip27-pci.c:pci_fixup_ioc3() for some comments on working
- * around ioc3 oddities in this respect.
- *
- * The IOC3 serials use a 22MHz clock rate with an additional divider which
- * can be programmed in the SCR register if the DLAB bit is set.
- *
- * Register to interrupt zero because we share the interrupt with
- * the serial driver which we don't properly support yet.
- *
- * Can't use UPF_IOREMAP as the whole of IOC3 resources have already been
- * registered.
- */
-static void __devinit ioc3_8250_register(struct ioc3_uartregs __iomem *uart)
-{
-#define COSMISC_CONSTANT 6
-
-	struct uart_port port = {
-		.irq		= 0,
-		.flags		= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF,
-		.iotype		= UPIO_MEM,
-		.regshift	= 0,
-		.uartclk	= (22000000 << 1) / COSMISC_CONSTANT,
-
-		.membase	= (unsigned char __iomem *) uart,
-		.mapbase	= (unsigned long) uart,
-	};
-	unsigned char lcr;
-
-	lcr = uart->iu_lcr;
-	uart->iu_lcr = lcr | UART_LCR_DLAB;
-	uart->iu_scr = COSMISC_CONSTANT,
-	uart->iu_lcr = lcr;
-	uart->iu_lcr;
-	serial8250_register_port(&port);
-}
-
-static void __devinit ioc3_serial_probe(struct pci_dev *pdev, struct ioc3 *ioc3)
-{
-	/*
-	 * We need to recognice and treat the fourth MENET serial as it
-	 * does not have an SuperIO chip attached to it, therefore attempting
-	 * to access it will result in bus errors.  We call something an
-	 * MENET if PCI slot 0, 1, 2 and 3 of a master PCI bus all have an IOC3
-	 * in it.  This is paranoid but we want to avoid blowing up on a
-	 * showhorn PCI box that happens to have 4 IOC3 cards in it so it's
-	 * not paranoid enough ...
-	 */
-	if (ioc3_is_menet(pdev) && PCI_SLOT(pdev->devfn) == 3)
-		return;
-
-	/*
-	 * Switch IOC3 to PIO mode.  It probably already was but let's be
-	 * paranoid
-	 */
-	ioc3->gpcr_s = GPCR_UARTA_MODESEL | GPCR_UARTB_MODESEL;
-	ioc3->gpcr_s;
-	ioc3->gppr_6 = 0;
-	ioc3->gppr_6;
-	ioc3->gppr_7 = 0;
-	ioc3->gppr_7;
-	ioc3->sscr_a = ioc3->sscr_a & ~SSCR_DMA_EN;
-	ioc3->sscr_a;
-	ioc3->sscr_b = ioc3->sscr_b & ~SSCR_DMA_EN;
-	ioc3->sscr_b;
-	/* Disable all SA/B interrupts except for SA/B_INT in SIO_IEC. */
-	ioc3->sio_iec &= ~ (SIO_IR_SA_TX_MT | SIO_IR_SA_RX_FULL |
-			    SIO_IR_SA_RX_HIGH | SIO_IR_SA_RX_TIMER |
-			    SIO_IR_SA_DELTA_DCD | SIO_IR_SA_DELTA_CTS |
-			    SIO_IR_SA_TX_EXPLICIT | SIO_IR_SA_MEMERR);
-	ioc3->sio_iec |= SIO_IR_SA_INT;
-	ioc3->sscr_a = 0;
-	ioc3->sio_iec &= ~ (SIO_IR_SB_TX_MT | SIO_IR_SB_RX_FULL |
-			    SIO_IR_SB_RX_HIGH | SIO_IR_SB_RX_TIMER |
-			    SIO_IR_SB_DELTA_DCD | SIO_IR_SB_DELTA_CTS |
-			    SIO_IR_SB_TX_EXPLICIT | SIO_IR_SB_MEMERR);
-	ioc3->sio_iec |= SIO_IR_SB_INT;
-	ioc3->sscr_b = 0;
-
-	ioc3_8250_register(&ioc3->sregs.uarta);
-	ioc3_8250_register(&ioc3->sregs.uartb);
-}
-#endif
-
-static int __devinit ioc3_probe(struct pci_dev *pdev,
-	const struct pci_device_id *ent)
+static int __devinit ioc3eth_probe(struct ioc3_submodule *is, 
+	struct ioc3_driver_data *idd)
 {
 	unsigned int sw_physid1, sw_physid2;
 	struct net_device *dev = NULL;
@@ -1232,28 +890,9 @@ static int __devinit ioc3_probe(struct p
 	u32 vendor, model, rev;
 	int err, pci_using_dac;
 
-	/* Configure DMA attributes. */
-	err = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
-	if (!err) {
-		pci_using_dac = 1;
-		err = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
-		if (err < 0) {
-			printk(KERN_ERR "%s: Unable to obtain 64 bit DMA "
-			       "for consistent allocations\n", pci_name(pdev));
-			goto out;
-		}
-	} else {
-		err = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
-		if (err) {
-			printk(KERN_ERR "%s: No usable DMA configuration, "
-			       "aborting.\n", pci_name(pdev));
-			goto out;
-		}
-		pci_using_dac = 0;
-	}
-
-	if (pci_enable_device(pdev))
-		return -ENODEV;
+	/* check for board type */
+	if (idd->class == IOC3_CLASS_SERIAL)
+		return 1;
 
 	dev = alloc_etherdev(sizeof(struct ioc3_private));
 	if (!dev) {
@@ -1261,33 +900,19 @@ static int __devinit ioc3_probe(struct p
 		goto out_disable;
 	}
 
-	if (pci_using_dac)
-		dev->features |= NETIF_F_HIGHDMA;
+	idd->data[is->id] = dev;
 
-	err = pci_request_regions(pdev, "ioc3");
-	if (err)
-		goto out_free;
+	/* assume we always have DAC */
+	dev->features |= NETIF_F_HIGHDMA;
 
-	SET_NETDEV_DEV(dev, &pdev->dev);
+	SET_NETDEV_DEV(dev, &(idd->pdev->dev));
 
 	ip = netdev_priv(dev);
 
-	dev->irq = pdev->irq;
+	dev->irq = idd->pdev->irq;
 
-	ioc3_base = pci_resource_start(pdev, 0);
-	ioc3_size = pci_resource_len(pdev, 0);
-	ioc3 = (struct ioc3 *) ioremap(ioc3_base, ioc3_size);
-	if (!ioc3) {
-		printk(KERN_CRIT "ioc3eth(%s): ioremap failed, goodbye.\n",
-		       pci_name(pdev));
-		err = -ENOMEM;
-		goto out_res;
-	}
-	ip->regs = ioc3;
-
-#ifdef CONFIG_SERIAL_8250
-	ioc3_serial_probe(pdev, ioc3);
-#endif
+	ip->idd = idd;
+	ip->regs = ioc3 = idd->vma;
 
 	spin_lock_init(&ip->ioc3_lock);
 	init_timer(&ip->ioc3_timer);
@@ -1295,7 +920,7 @@ static int __devinit ioc3_probe(struct p
 	ioc3_stop(ip);
 	ioc3_init(dev);
 
-	ip->pdev = pdev;
+	ip->pdev = idd->pdev;
 
 	ip->mii.phy_id_mask = 0x1f;
 	ip->mii.reg_num_mask = 0x1f;
@@ -1307,7 +932,7 @@ static int __devinit ioc3_probe(struct p
 
 	if (ip->mii.phy_id == -1) {
 		printk(KERN_CRIT "ioc3-eth(%s): Didn't find a PHY, goodbye.\n",
-		       pci_name(pdev));
+		       pci_name(idd->pdev));
 		err = -ENODEV;
 		goto out_stop;
 	}
@@ -1353,58 +978,42 @@ out_stop:
 	ioc3_stop(ip);
 	del_timer_sync(&ip->ioc3_timer);
 	ioc3_free_rings(ip);
-out_res:
-	pci_release_regions(pdev);
-out_free:
 	free_netdev(dev);
 out_disable:
-	/*
-	 * We should call pci_disable_device(pdev); here if the IOC3 wasn't
-	 * such a weird device ...
-	 */
 out:
 	return err;
 }
 
-static void __devexit ioc3_remove_one (struct pci_dev *pdev)
+static int ioc3eth_remove(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
 {
-	struct net_device *dev = pci_get_drvdata(pdev);
+	struct net_device *dev = idd->data[is->id];
 	struct ioc3_private *ip = netdev_priv(dev);
-	struct ioc3 *ioc3 = ip->regs;
 
 	unregister_netdev(dev);
 	del_timer_sync(&ip->ioc3_timer);
 
-	iounmap(ioc3);
-	pci_release_regions(pdev);
 	free_netdev(dev);
-	/*
-	 * We should call pci_disable_device(pdev); here if the IOC3 wasn't
-	 * such a weird device ...
-	 */
+	return 0;
 }
 
-static struct pci_device_id ioc3_pci_tbl[] = {
-	{ PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3, PCI_ANY_ID, PCI_ANY_ID },
-	{ 0 }
-};
-MODULE_DEVICE_TABLE(pci, ioc3_pci_tbl);
-
-static struct pci_driver ioc3_driver = {
-	.name		= "ioc3-eth",
-	.id_table	= ioc3_pci_tbl,
-	.probe		= ioc3_probe,
-	.remove		= __devexit_p(ioc3_remove_one),
+static struct ioc3_submodule ioc3eth_submodule = {
+	.name = "ethernet",
+	.probe = ioc3eth_probe,
+	.remove = ioc3eth_remove,
+	.ethernet = 1,
+	.intr = ioc3eth_intr,
+	.owner = THIS_MODULE,
 };
 
 static int __init ioc3_init_module(void)
 {
-	return pci_register_driver(&ioc3_driver);
+	ioc3_register_submodule(&ioc3eth_submodule);
+	return 0;
 }
 
 static void __exit ioc3_cleanup_module(void)
 {
-	pci_unregister_driver(&ioc3_driver);
+	ioc3_unregister_submodule(&ioc3eth_submodule);
 }
 
 static int ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
diff -Naurp linux-2.6.26.orig/drivers/serial/8250.c linux-2.6.26/drivers/serial/8250.c
--- linux-2.6.26.orig/drivers/serial/8250.c	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/drivers/serial/8250.c	2008-07-25 01:03:02.000000000 -0400
@@ -368,6 +368,9 @@ static unsigned int serial_in(struct uar
 	case UPIO_MEM32:
 		return readl(up->port.membase + offset);
 
+	case UPIO_IOC3:
+		return readb(up->port.membase + (offset^3));
+
 #ifdef CONFIG_SERIAL_8250_AU1X00
 	case UPIO_AU:
 		return __raw_readl(up->port.membase + offset);
@@ -407,6 +410,10 @@ serial_out(struct uart_8250_port *up, in
 		writel(value, up->port.membase + offset);
 		break;
 
+	case UPIO_IOC3:
+		writeb(value, up->port.membase + (offset^3));
+		break;
+
 #ifdef CONFIG_SERIAL_8250_AU1X00
 	case UPIO_AU:
 		__raw_writel(value, up->port.membase + offset);
diff -Naurp linux-2.6.26.orig/drivers/serial/Kconfig linux-2.6.26/drivers/serial/Kconfig
--- linux-2.6.26.orig/drivers/serial/Kconfig	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/drivers/serial/Kconfig	2008-07-25 01:03:02.000000000 -0400
@@ -278,6 +278,13 @@ config SERIAL_8250_RM9K
 	  port hardware found on MIPS RM9122 and similar processors.
 	  If unsure, say N.
 
+config SGI_IOC3_UART
+	bool "SGI IOC3 UART support"
+	depends on SGI_IOC3 && SERIAL_8250
+	help
+	  Enable this if you have a SGI Origin or Octane machine. This module
+	  provides serial port support for IOC3 chips on those systems.
+
 comment "Non-8250 serial port support"
 
 config SERIAL_AMBA_PL010
diff -Naurp linux-2.6.26.orig/drivers/serial/Makefile linux-2.6.26/drivers/serial/Makefile
--- linux-2.6.26.orig/drivers/serial/Makefile	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/drivers/serial/Makefile	2008-07-25 01:03:02.000000000 -0400
@@ -59,6 +59,7 @@ obj-$(CONFIG_SERIAL_SC26XX) += sc26xx.o
 obj-$(CONFIG_SERIAL_JSM) += jsm/
 obj-$(CONFIG_SERIAL_TXX9) += serial_txx9.o
 obj-$(CONFIG_SERIAL_VR41XX) += vr41xx_siu.o
+obj-$(CONFIG_SGI_IOC3_UART) += ioc3uart.o
 obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
 obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
 obj-$(CONFIG_SERIAL_ATMEL) += atmel_serial.o
diff -Naurp linux-2.6.26.orig/drivers/serial/ioc3uart.c linux-2.6.26/drivers/serial/ioc3uart.c
--- linux-2.6.26.orig/drivers/serial/ioc3uart.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/drivers/serial/ioc3uart.c	2008-07-25 01:03:02.000000000 -0400
@@ -0,0 +1,142 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ *      Driver for the SGI IOC3 bridge for UARTs
+ *
+ *      Copyright (C) 2005-2007 Stanislaw Skowronek <skylark@linux-mips.org>
+ *
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serio.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+#include <linux/pci.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/system.h>
+#include <linux/ioc3.h>
+
+#include <linux/serial.h>
+#include <asm/serial.h>
+
+#include "8250.h"
+
+#define IOC3_UARTCLK (22000000 / 3)
+
+
+/* !!! write dynirq support for IP27 !!! */
+#ifdef CONFIG_SGI_IP30
+int new_dynamic_irq(void);
+void call_dynamic_irq(int irq);
+void delete_dynamic_irq(int irq);
+#else
+int new_dynamic_irq(void) { return 0; }
+void call_dynamic_irq(int irq) { }
+void delete_dynamic_irq(int irq) { }
+#endif
+
+struct ioc3uart_data {
+	int line_a, line_b;
+	int irq;
+};
+
+static int ioc3uart_intr(struct ioc3_submodule *is, struct ioc3_driver_data *idd, unsigned int irq)
+{
+	struct ioc3uart_data *d = (struct ioc3uart_data *)(idd->data[is->id]);
+
+	ioc3_ack(is, idd, irq);
+	call_dynamic_irq(d->irq);
+
+	return 0;
+}
+
+static int ioc3uart_probe(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
+{
+	struct uart_port port;
+	struct ioc3uart_data *d;
+
+	/* check for UART-less add-on boards */
+	if (idd->class == IOC3_CLASS_MENET_4 || idd->class == IOC3_CLASS_CADDUO)
+		return 1;
+
+	/* set PIO mode for SuperIO UARTs */
+	idd->vma->sscr_a = 0;
+	idd->vma->sscr_b = 0;
+	udelay(1000);
+	idd->vma->sregs.uarta.iu_fcr = 0;
+	idd->vma->sregs.uartb.iu_fcr = 0;
+	udelay(1000);
+
+	d = kmalloc(sizeof(struct ioc3uart_data), GFP_KERNEL);
+	idd->data[is->id] = d;
+	d->irq = new_dynamic_irq();
+
+	/* register serial ports with 8250.c */
+	memset(&port, 0, sizeof(struct uart_port));
+	port.irq = d->irq;
+	port.flags = UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	port.uartclk = IOC3_UARTCLK;
+	port.iotype = UPIO_IOC3;
+	port.regshift = 0;
+	port.dev = &(idd->pdev->dev);
+
+	port.membase = (unsigned char *) &idd->vma->sregs.uarta;
+	port.mapbase = ((unsigned long) port.membase) & 0xffffffffff;
+	d->line_a = serial8250_register_port(&port);
+
+	port.membase = (unsigned char *) &idd->vma->sregs.uartb;
+	port.mapbase = ((unsigned long) port.membase) & 0xffffffffff;
+	d->line_b = serial8250_register_port(&port);
+
+	ioc3_enable(is, idd, is->irq_mask);
+	return 0;
+}
+
+static int ioc3uart_remove(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
+{
+	struct ioc3uart_data *d = (struct ioc3uart_data *)(idd->data[is->id]);
+	serial8250_unregister_port(d->line_a);
+	serial8250_unregister_port(d->line_b);
+	delete_dynamic_irq(d->irq);
+	kfree(d);
+	idd->data[is->id] = NULL;
+	return 0;
+}
+
+static struct ioc3_submodule ioc3uart_submodule = {
+	.name = "uart",
+	.probe = ioc3uart_probe,
+	.remove = ioc3uart_remove,
+	.irq_mask = SIO_IR_SA_INT | SIO_IR_SB_INT,
+	.intr = ioc3uart_intr,
+	.owner = THIS_MODULE,
+};
+
+static int __init ioc3uart_init(void)
+{
+	ioc3_register_submodule(&ioc3uart_submodule);
+	return 0;
+}
+
+static void __exit ioc3uart_exit(void)
+{
+	ioc3_unregister_submodule(&ioc3uart_submodule);
+}
+
+module_init(ioc3uart_init);
+module_exit(ioc3uart_exit);
+
+MODULE_AUTHOR("Stanislaw Skowronek <skylark@linux-mips.org>");
+MODULE_DESCRIPTION("SGI IOC3 UART driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("R27");
diff -Naurp linux-2.6.26.orig/drivers/serial/serial_core.c linux-2.6.26/drivers/serial/serial_core.c
--- linux-2.6.26.orig/drivers/serial/serial_core.c	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/drivers/serial/serial_core.c	2008-07-25 01:03:02.000000000 -0400
@@ -2162,6 +2162,10 @@ uart_report_port(struct uart_driver *drv
 		snprintf(address, sizeof(address),
 			 "MMIO 0x%llx", (unsigned long long)port->mapbase);
 		break;
+	case UPIO_IOC3:
+		snprintf(address, sizeof(address), "IOC3 0x%lx",
+			 port->mapbase);
+		break;
 	default:
 		strlcpy(address, "*unknown*", sizeof(address));
 		break;
@@ -2573,6 +2577,7 @@ int uart_match_port(struct uart_port *po
 	case UPIO_AU:
 	case UPIO_TSI:
 	case UPIO_DWAPB:
+	case UPIO_IOC3:
 		return (port1->mapbase == port2->mapbase);
 	}
 	return 0;
diff -Naurp linux-2.6.26.orig/include/asm-mips/mach-ip27/mangle-port.h linux-2.6.26/include/asm-mips/mach-ip27/mangle-port.h
--- linux-2.6.26.orig/include/asm-mips/mach-ip27/mangle-port.h	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/include/asm-mips/mach-ip27/mangle-port.h	2008-07-25 01:03:02.000000000 -0400
@@ -8,7 +8,7 @@
 #ifndef __ASM_MACH_IP27_MANGLE_PORT_H
 #define __ASM_MACH_IP27_MANGLE_PORT_H
 
-#define __swizzle_addr_b(port)	(port)
+#define __swizzle_addr_b(port)	((port) ^ 3)
 #define __swizzle_addr_w(port)	((port) ^ 2)
 #define __swizzle_addr_l(port)	(port)
 #define __swizzle_addr_q(port)	(port)
diff -Naurp linux-2.6.26.orig/include/linux/ioc3.h linux-2.6.26/include/linux/ioc3.h
--- linux-2.6.26.orig/include/linux/ioc3.h	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/include/linux/ioc3.h	2008-07-25 01:03:02.000000000 -0400
@@ -9,7 +9,7 @@
 #ifndef _LINUX_IOC3_H
 #define _LINUX_IOC3_H
 
-#include <asm/sn/ioc3.h>
+#include <asm-mips/sn/ioc3.h>
 
 #define IOC3_MAX_SUBMODULES	32
 
@@ -27,7 +27,7 @@ struct ioc3_driver_data {
 	int id;				/* IOC3 sequence number */
 	/* PCI mapping */
 	unsigned long pma;		/* physical address */
-	struct ioc3 __iomem *vma;	/* pointer to registers */
+	struct __iomem ioc3 *vma;	/* pointer to registers */
 	struct pci_dev *pdev;		/* PCI device */
 	/* IRQ stuff */
 	int dual_irq;			/* set if separate IRQs are used */
@@ -72,9 +72,6 @@ struct ioc3_submodule {
  * Functions needed by submodules *
  **********************************/
 
-#define IOC3_W_IES		0
-#define IOC3_W_IEC		1
-
 /* registers a submodule for all existing and future IOC3 chips */
 extern int ioc3_register_submodule(struct ioc3_submodule *);
 /* unregisters a submodule */
@@ -85,9 +82,11 @@ extern void ioc3_enable(struct ioc3_subm
 extern void ioc3_ack(struct ioc3_submodule *, struct ioc3_driver_data *, unsigned int);
 /* disables IRQs indicated by irq_mask for a specified IOC3 chip */
 extern void ioc3_disable(struct ioc3_submodule *, struct ioc3_driver_data *, unsigned int);
-/* atomically sets GPCR bits */
-extern void ioc3_gpcr_set(struct ioc3_driver_data *, unsigned int);
-/* general ireg writer */
-extern void ioc3_write_ireg(struct ioc3_driver_data *idd, uint32_t value, int reg);
-
+/* atomically sets/clears GPIO bits */
+#ifdef CONFIG_IA64_SGI_SN2
+extern void ioc3_gpcr_set(struct ioc3_driver_data *, unsigned int)
+#else
+extern void ioc3_gpio(struct ioc3_driver_data *, unsigned int, unsigned int);
 #endif
+
+#endif /* _LINUX_IOC3_H */
diff -Naurp linux-2.6.26.orig/include/linux/serial.h linux-2.6.26/include/linux/serial.h
--- linux-2.6.26.orig/include/linux/serial.h	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/include/linux/serial.h	2008-07-25 01:03:02.000000000 -0400
@@ -81,6 +81,7 @@ struct serial_struct {
 #define SERIAL_IO_PORT	0
 #define SERIAL_IO_HUB6	1
 #define SERIAL_IO_MEM	2
+#define SERIAL_IO_IOC3	5
 
 struct serial_uart_config {
 	char	*name;
diff -Naurp linux-2.6.26.orig/include/linux/serial_core.h linux-2.6.26/include/linux/serial_core.h
--- linux-2.6.26.orig/include/linux/serial_core.h	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/include/linux/serial_core.h	2008-07-25 01:03:02.000000000 -0400
@@ -261,6 +261,7 @@ struct uart_port {
 #define UPIO_TSI		(5)			/* Tsi108/109 type IO */
 #define UPIO_DWAPB		(6)			/* DesignWare APB UART */
 #define UPIO_RM9000		(7)			/* RM9000 type IO */
+#define UPIO_IOC3		(8)			/* SGI IOC3 (IP30) UART */
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */

--------------040602000001050804070607--
