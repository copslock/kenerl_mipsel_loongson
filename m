Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2006 21:49:16 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:35340 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133569AbWBSVtG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Feb 2006 21:49:06 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 117D864D3D; Sun, 19 Feb 2006 21:55:57 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 26DAD8D5D; Sun, 19 Feb 2006 21:55:50 +0000 (GMT)
Date:	Sun, 19 Feb 2006 21:55:50 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:	linux-mips@linux-mips.org,
	Stanislaw Skowronek <skylark@linux-mips.org>
Subject: Re: Merging Skylark's IOC3 patch
Message-ID: <20060219215550.GO10266@deprecation.cyrius.com>
References: <20060219211527.GA12848@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219211527.GA12848@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-02-19 21:15]:
> Can you please review and/or merge Skylark's IOC3 patch from
> ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/linux-mips-2.6.14-ioc3-r26.patch.bz2
> 
> From my basic understanding I believe that this patch needs to be split up
> and submitted to different sub-system maintainers.

(Dmitry, this is only a RFC for now since the main support patch
for IOC3 has not been merged yet.)


From: Stanislaw Skowronek <skylark@linux-mips.org>

[PATCH 2/5] serio: SGI IOC3 PS/2 controller driver

Add a PS/2 driver based on the SGI IOC3.  This is useful for SGI Octane
machines (IP27).

Signed-off-by: Stanislaw Skowronek <skylark@linux-mips.org>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 Kconfig   |    7 ++
 Makefile  |    1 
 ioc3kbd.c |  172 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 98acf17..7dedec0 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
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
diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
index 4155197..14cb41b 100644
--- a/drivers/input/serio/Makefile
+++ b/drivers/input/serio/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_HP_SDC)		+= hp_sdc.o
 obj-$(CONFIG_HIL_MLC)		+= hp_sdc_mlc.o hil_mlc.o
 obj-$(CONFIG_SERIO_PCIPS2)	+= pcips2.o
 obj-$(CONFIG_SERIO_MACEPS2)	+= maceps2.o
+obj-$(CONFIG_SERIO_SGI_IOC3)	+= ioc3kbd.o
 obj-$(CONFIG_SERIO_LIBPS2)	+= libps2.o
 obj-$(CONFIG_SERIO_RAW)		+= serio_raw.o
--- /dev/null	2006-02-13 15:11:07.474148640 +0000
+++ b/drivers/input/serio/ioc3kbd.c	2006-02-19 21:26:55.000000000 +0000
@@ -0,0 +1,172 @@
+/*
+ * SGI IOC3 PS/2 controller driver for Linux
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
+MODULE_AUTHOR("Stanislaw Skowronek <skylark@linux-mips.org>");
+MODULE_DESCRIPTION("SGI IOC3 serio driver");
+MODULE_LICENSE("GPL");
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
+	mask = (dev==d->aux) ? KM_CSR_M_WRT_PEND : KM_CSR_K_WRT_PEND;
+	while((d->idd->vma->km_csr & mask) && (timeout<1000)) {
+		udelay(100);
+		timeout++;
+	}
+
+	if(dev==d->aux)
+		d->idd->vma->m_wd=((unsigned)val)&0x000000ff;
+	else
+		d->idd->vma->k_wd=((unsigned)val)&0x000000ff;
+
+	if(timeout>=1000)
+		return -1;
+	return 0;
+}
+
+static int ioc3kbd_intr(struct ioc3_submodule *is, struct ioc3_driver_data *idd, unsigned int irq, struct pt_regs *regs)
+{
+	struct ioc3kbd_data *d = (struct ioc3kbd_data *)(idd->data[is->id]);
+	unsigned int data_k, data_m;
+
+	ioc3_ack(is,idd,irq);
+	data_k=d->idd->vma->k_rd;
+	data_m=d->idd->vma->m_rd;
+
+	if(data_k & KM_RD_VALID_0)
+		serio_interrupt(d->kbd, (data_k >> KM_RD_DATA_0_SHIFT) & 0xFF, 0, regs);
+	if(data_k & KM_RD_VALID_1)
+		serio_interrupt(d->kbd, (data_k >> KM_RD_DATA_1_SHIFT) & 0xFF, 0, regs);
+	if(data_k & KM_RD_VALID_2)
+		serio_interrupt(d->kbd, (data_k >> KM_RD_DATA_2_SHIFT) & 0xFF, 0, regs);
+	if(data_m & KM_RD_VALID_0)
+		serio_interrupt(d->aux, (data_m >> KM_RD_DATA_0_SHIFT) & 0xFF, 0, regs);
+	if(data_m & KM_RD_VALID_1)
+		serio_interrupt(d->aux, (data_m >> KM_RD_DATA_1_SHIFT) & 0xFF, 0, regs);
+	if(data_m & KM_RD_VALID_2)
+		serio_interrupt(d->aux, (data_m >> KM_RD_DATA_2_SHIFT) & 0xFF, 0, regs);
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
+	if (sk && sa && d) {
+		memset(sk, 0, sizeof(struct serio));
+		sk->id.type = SERIO_8042;
+		sk->write = ioc3kbd_write;
+		sk->open = ioc3kbd_open;
+		sk->close = ioc3kbd_close;
+		snprintf(sk->name, sizeof(sk->name), "IOC3 keyboard %d", idx);
+		snprintf(sk->phys, sizeof(sk->phys), "ioc3/serio%dkbd", idx);
+		sk->port_data = d;
+		sk->dev.parent = &(idd->pdev->dev);
+		memset(sa, 0, sizeof(struct serio));
+		sa->id.type = SERIO_8042;
+		sa->write = ioc3kbd_write;
+		sa->open = ioc3kbd_open;
+		sa->close = ioc3kbd_close;
+		snprintf(sa->name, sizeof(sa->name), "IOC3 auxiliary %d", idx);
+		snprintf(sa->phys, sizeof(sa->phys), "ioc3/serio%daux", idx);
+		sa->port_data = d;
+		sa->dev.parent = &(idd->pdev->dev);
+		d->idd = idd;
+		d->kbd = sk;
+		d->aux = sa;
+		return d;
+	}
+	return NULL;
+}
+
+static int ioc3kbd_probe(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
+{
+	struct ioc3kbd_data *d;
+	if(idd->class != IOC3_CLASS_BASE_IP30 && idd->class != IOC3_CLASS_CADDUO)
+		return 1;
+	d = ioc3kbd_allocate_port(idd->id, idd);
+	idd->data[is->id] = d;
+	if(!d)
+		return 1;
+	ioc3_enable(is, idd);
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


-- 
Martin Michlmayr
http://www.cyrius.com/
