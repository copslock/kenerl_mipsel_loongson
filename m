Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 19:28:10 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:50359 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20037755AbWJJS2H (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Oct 2006 19:28:07 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GXLKb-0007fC-93
	for linux-mips@linux-mips.org; Tue, 10 Oct 2006 19:24:04 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.63)
	(envelope-from <giometti@enneenne.com>)
	id 1GXMKR-0005yK-NN
	for linux-mips@linux-mips.org; Tue, 10 Oct 2006 20:27:47 +0200
Date:	Tue, 10 Oct 2006 20:27:47 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20061010182747.GA14539@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Problem on au1100 USB device support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I'm just working on adding USB device support for au1100 CPUs.

I wrote the driver (attached) but I cannot understand why when I
insert the USB cable I see no activities on the bus... my USB sniffer
says that the target port is "disconnected/reset".

USB host controller is working so I suppose the clock is well routed
to USB device controller too.

Someone may halp me in understing where the problem could be? My
driver doesn't use DMA, as suggested by the CPU's data sheet... it
could be wrong?

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--gKMricLos+KVdGMg
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="au1x00_udc.c"

/*
 * linux/drivers/usb/gadget/au1x00_udc.c
 * AMD Alchemy AU1000/AU1100 on-chip full speed USB device controller
 *
 * Copyright (C) 2006 Rodolfo Giometti <giometti@linux.it>
 * Copyright (C) 2006 Eurotech S.p.A. <info@eurotech.it>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

#undef DEBUG
#define DEBUG

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/ioport.h>
#include <linux/types.h>
#include <linux/errno.h>
#include <linux/delay.h>
#include <linux/sched.h>
#include <linux/slab.h>
#include <linux/init.h>
#include <linux/timer.h>
#include <linux/list.h>
#include <linux/interrupt.h>
#include <linux/proc_fs.h>
#include <linux/mm.h>
#include <linux/platform_device.h>

#include <asm/byteorder.h>
#include <asm/io.h>
#include <asm/irq.h>
#include <asm/system.h>
#include <asm/unaligned.h>

#include <linux/usb_ch9.h>
#include <linux/usb_gadget.h>

#include <linux/platform_device.h>
#include <au1xxx.h>
#include <asm/cpu.h>
#include "au1x00_udc.h"

static const char driver_name[] = "au1x00_udc";

/* --- Misc functions ------------------------------------------------------ */

/* --- Debugging support --------------------------------------------------- */

#ifdef CONFIG_USB_GADGET_DEBUG_FILES

static const char proc_node_name[] = "driver/udc";

static int au1x00_udc_proc_read(char *page, char **start, off_t off, int count, int *eof, void *_dev)
{
	struct au1x00_udc	*dev = _dev;
	unsigned long		flags;

	char			*buf = page;
	char			*next = buf;
	unsigned		size = count;
	int			i, t;

	if (off != 0)
		return 0;

	local_irq_save(flags);

	/* Basic device status */
	t = scnprintf(next, size,
		"Gadget driver: %s\n", driver_name);
	size -= t;
	next += t;

	/* EP0 registers */
	t = scnprintf(next, size,
		"ep0cs %08X ep0rdstat %08X ep0wrstat %08X\n",
		usbd_read(USBD_EP0CS), usbd_read(USBD_EP0RDSTAT),
		usbd_read(USBD_EP0WRSTAT));
	size -= t;
	next += t;

	/* Other EPs registers */
	t = scnprintf(next, size,
		"ep1cs %08X                    ep1wrstat %08X\n",
		usbd_read(USBD_EP1CS), usbd_read(USBD_EP1WRSTAT));
	size -= t;
	next += t;
	t = scnprintf(next, size,
		"ep2cs %08X                    ep2wrstat %08X\n",
		usbd_read(USBD_EP2CS), usbd_read(USBD_EP2WRSTAT));
	size -= t;
	next += t;
	t = scnprintf(next, size,
		"ep3cs %08X ep3rdstat %08X\n",
		usbd_read(USBD_EP3CS), usbd_read(USBD_EP3RDSTAT));
	size -= t;
	next += t;
	t = scnprintf(next, size,
		"ep4cs %08X ep4rdstat %08X\n",
		usbd_read(USBD_EP4CS), usbd_read(USBD_EP4RDSTAT));
	size -= t;
	next += t;

	/* Misc registers */
	t = scnprintf(next, size,
		"inten %08X intstat %08X\nframenum %08X\n",
		usbd_read(USBD_INTEN), usbd_read(USBD_INTSTAT),
		usbd_read(USBD_FRAMENUM));
	size -= t;
	next += t;

	if (!dev->driver)
		goto done;

	/* Driver info */
	t = scnprintf(next, size, "device speed:  %s\n",
			dev->driver->speed == USB_SPEED_FULL ? "full" : "");
	size -= t;
	next += t;
	t = scnprintf(next, size, "device status: %sconnectd\n",
			dev->driver->disconnect ? "dis" : "");
	size -= t;
	next += t;

	/* Dump endpoint queues */
	for (i = 0; i < AU1X00_UDC_NUM_ENDPOINTS; i++) {
		struct au1x00_ep	*ep = &dev->ep [i];
		struct au1x00_request	*req;
		int			t;

		if (list_empty(&ep->queue)) {
			t = scnprintf(next, size, "\t(nothing queued)\n");
			if (t <= 0 || t > size)
				goto done;
			size -= t;
			next += t;
			continue;
		}
		list_for_each_entry(req, &ep->queue, queue) {
			t = scnprintf(next, size,
				"\treq %p len %d/%d buf %p\n",
				&req->req, req->req.actual,
				req->req.length, req->req.buf);
			if (t <= 0 || t > size)
				goto done;
			size -= t;
			next += t;
		}
	}

done:
	local_irq_restore(flags);

	*eof = 1;
	return count-size;;
}

#define create_proc_files() \
	create_proc_read_entry(proc_node_name, 0, NULL, au1x00_udc_proc_read, dev)
#define remove_proc_files() \
	remove_proc_entry(proc_node_name, NULL)

#else	/* !CONFIG_USB_GADGET_DEBUG_FILES */

#define create_proc_files() do {} while (0)
#define remove_proc_files() do {} while (0)

#endif	/* CONFIG_USB_GADGET_DEBUG_FILES */

/* "function" sysfs attribute */
static ssize_t show_function(struct device *_dev, struct device_attribute *attr, char *buf)
{
	struct au1x00_udc *dev = dev_get_drvdata (_dev);

	if (!dev->driver || !dev->driver->function || \
	    strlen(dev->driver->function) > PAGE_SIZE)
		return 0;
	return scnprintf(buf, PAGE_SIZE, "%s\n", dev->driver->function);
}
static DEVICE_ATTR (function, S_IRUGO, show_function, NULL);

/* --- Interrupts handler -------------------------------------------------- */

/* A DATA0/1 or SETUP packet has been received on one of the OUT endpoints
 * (0, 4 or 5) */
static void au1x00_process_ep_receive(struct au1x00_udc *dev, struct au1x00_ep *ep)
{
printk("%s\n", __FUNCTION__);
}

/* This ISR handles the receive complete and suspend events */
static irqreturn_t au1x00_udc_irq(int irq, void *dev_id, struct pt_regs *regs)
{
	struct au1x00_udc *dev = dev_id;
	u32 status;
	int i;

printk("INTERRUPT %s %d\n", __FUNCTION__, irq);
	if (irq == dev->irq_sus) { /* handle recv complete and suspend events */
		pr_error("SUSPEND\n");
		status = au_readl(dev->base_addr+USBD_INTSTAT);
		au_writel(status, dev->base_addr+USBD_INTSTAT); /* ack */
printk("STATUS %x\n", status);

		for (i = 0; i < AU1X00_UDC_NUM_ENDPOINTS; i++)
			if (status&(1<<i))
				au1x00_process_ep_receive(dev, &dev->ep[i]);
	}
	else {
		pr_error("FIXME!\n");
	}

	return IRQ_HANDLED;
}

/* --- Endpoints managing functions ---------------------------------------- */

static void au1x00_ep_stall(struct au1x00_ep *ep, int status)
{
	struct au1x00_udc *dev = ep->dev;
	u32 tmp;

	pr_debug("%s on ep%d, status %d\n", __FUNCTION__, ep->num, status);

	tmp = usbd_read(ep->reg_cs)&~USBDEV_CS_STALL;
	usbd_write(tmp|(status ? USBDEV_CS_STALL : 0), ep->reg_cs);
}

static void au1x00_ep_reset(struct au1x00_ep *ep)
{
	struct au1x00_udc *dev = ep->dev;

	pr_debug("%s on ep%d\n", __FUNCTION__, ep->num);

	/* Setup Endpoint control register */
	usbd_write((ep->ep.maxpacket<<USBDEV_CS_TSIZE_BIT), ep->reg_cs);	

	/* Clear FIFO status register */
	usbd_write(0x70, ep->reg_stat);
	if (ep->num == 0) {
		usbd_write(0x70, ep->reg_stat+1); /* set ep0 write FIFO */
		au1x00_ep_stall(ep, 1);		  /* force STALL condition */
	}

	ep->desc = NULL;
	ep->stopped = 1;
	ep->irqs = 0;
}

/* --- Endpoints operations ------------------------------------------------ */

static int au1x00_ep_enable(struct usb_ep *_ep, const struct usb_endpoint_descriptor *desc)
{
	struct au1x00_ep *ep;
	struct au1x00_udc *dev;

printk("%s\n", __FUNCTION__);
	/* Sanity checks */
	if (!_ep)
		return -ENODEV;
	ep = container_of(_ep, struct au1x00_ep, ep);
	if (!desc || ep->desc || desc->bDescriptorType != USB_DT_ENDPOINT)
		return -EINVAL;
	dev = ep->dev;
	if (ep == &dev->ep[0])	/* cannot manage ep0 here! */
		return -EINVAL;
	if (!dev->driver || dev->gadget.speed == USB_SPEED_UNKNOWN)
		return -ESHUTDOWN;
	if (ep->num != (desc->bEndpointAddress & 0x0f))
		return -EINVAL;

	/* We manage only BULK and INT packets even if our controller
	 * can do more... */
	switch (desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) {
	case USB_ENDPOINT_XFER_BULK:
	case USB_ENDPOINT_XFER_INT:
		break;
	default:
		pr_error("unsupported ep type\n");
		return -EINVAL;
	}

	pr_debug("enable %s\n", _ep->name);

	/* FIXME */

	return 0;
}

static int au1x00_ep_disable(struct usb_ep *_ep)
{
	struct au1x00_ep *ep;
	struct au1x00_udc *dev;

printk("%s\n", __FUNCTION__);
	/* Sanity checks */
        if (!_ep)
		return -ENODEV;
	ep = container_of(_ep, struct au1x00_ep, ep);
        if (!ep->desc)
		return -ENODEV;
	dev = ep->dev;
	if (dev->ep0state == EP0_SUSPEND)
		return -EBUSY;

	pr_debug("disable %s\n", _ep->name);

	/* FIXME */

	return 0;
}

static struct usb_request *au1x00_ep_alloc_request(struct usb_ep *_ep, gfp_t gfp_flags)
{
	struct au1x00_request *req;

printk("%s\n", __FUNCTION__);

	if (!_ep)
		return NULL;
	req = kmalloc(sizeof *req, gfp_flags);
	if (!req)
		return NULL;

	req->req.dma = 0;
	INIT_LIST_HEAD(&req->queue);
printk("%s END\n", __FUNCTION__);
	return &req->req;
}

static void au1x00_ep_free_request(struct usb_ep *_ep, struct usb_request *_req)
{
	struct au1x00_request *req;
printk("%s\n", __FUNCTION__);

	if (!_ep || !_req)
		return;

	req = container_of(_req, struct au1x00_request, req);
	WARN_ON(!list_empty(&req->queue));
	kfree(req);
}

static void *au1x00_ep_alloc_buffer(struct usb_ep *_ep, unsigned bytes, dma_addr_t *dma, gfp_t gfp_flags)
{
	struct au1x00_ep *ep;

printk("%s\n", __FUNCTION__);

	if (!_ep)
		return NULL;
	ep = container_of(_ep, struct au1x00_ep, ep);
	*dma = 0;

	return kmalloc(bytes, gfp_flags);
}

static void au1x00_ep_free_buffer(struct usb_ep *_ep, void *buf, dma_addr_t dma, unsigned bytes)
{
printk("%s\n", __FUNCTION__);

	/* FIXME */

	kfree(buf);
}

static int au1x00_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
{
printk("%s\n", __FUNCTION__);

	/* FIXME */

	return -EINVAL;
}

/* dequeue JUST ONE request */
static int au1x00_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
{
printk("%s\n", __FUNCTION__);

	/* FIXME */

	return -EINVAL;
}

static int au1x00_ep_set_halt(struct usb_ep *_ep, int value)
{
	struct au1x00_ep  *ep;
	int ret = 0;
printk("%s\n", __FUNCTION__);

	if (!_ep)
		return -ENODEV;
	ep = container_of(_ep, struct au1x00_ep, ep);
	if (ep->num != 0 && !ep->desc) {
		pr_debug("%s on bad ep \"%s\"\n", __FUNCTION__, ep->ep.name);
		return -EINVAL;
	}

	if (ep->num == 0) {
		ep->dev->ep0state = value ? EP0_STALL : EP0_IDLE; /* FIXME */
		au1x00_ep_stall(ep, value);
	} 
	else if (!ep->desc) {
		pr_debug("%s %s inactive?\n", __FUNCTION__, ep->ep.name);
		return -EINVAL;
	}
 
	if (!list_empty(&ep->queue))
		ret = -EAGAIN;
	else if (value && (ep->num == 3 || ep->num == 4) &&
			/* FIXME: data in (either) packet buffer? */
			1)
		ret = -EAGAIN;
	else if (!value)
		au1x00_ep_stall(ep, 0);
	else {
		pr_debug("%s %s set halt\n", __FUNCTION__, ep->ep.name);
		au1x00_ep_stall(ep, 0);
	}

	return ret;
}

static int au1x00_ep_fifo_status(struct usb_ep *_ep)
{
printk("%s\n", __FUNCTION__);

	/* FIXME */

	return 0;
}

static void au1x00_ep_fifo_flush(struct usb_ep *_ep)
{
printk("%s\n", __FUNCTION__);

	/* FIXME */
}

static struct usb_ep_ops au1x00_ep_ops = {
	.enable		= au1x00_ep_enable,
	.disable	= au1x00_ep_disable,

	.alloc_request	= au1x00_ep_alloc_request,
	.free_request	= au1x00_ep_free_request,

	.alloc_buffer	= au1x00_ep_alloc_buffer,
	.free_buffer	= au1x00_ep_free_buffer,

	.queue		= au1x00_ep_queue,
	.dequeue	= au1x00_ep_dequeue,

	.set_halt	= au1x00_ep_set_halt,
	.fifo_status	= au1x00_ep_fifo_status,
	.fifo_flush	= au1x00_ep_fifo_flush,
};

/* --- Gadget operations --------------------------------------------------- */

static int au1x00_udc_get_frame(struct usb_gadget *_gadget)
{
	struct au1x00_udc *dev = container_of(_gadget, struct au1x00_udc, gadget);
printk("%s\n", __FUNCTION__);

	return usbd_read(USBD_FRAMENUM)&0x07ff;
}

static const struct usb_gadget_ops au1x00_udc_ops = {
	.get_frame	= au1x00_udc_get_frame,
};

/* --- Requests managing functions ----------------------------------------- */

/* Mark request's status */
static void au1x00_done(struct au1x00_ep *ep, struct au1x00_request *req, int status)
{
	struct au1x00_udc *dev;
	unsigned stopped = ep->stopped;

	list_del_init(&req->queue);

	if (likely(req->req.status == -EINPROGRESS))
		req->req.status = status;
	else
		status = req->req.status;

	dev = ep->dev;

#ifndef USB_TRACE
	if (status && status != -ESHUTDOWN)
#endif
	pr_debug("complete %s req %p stat %d len %u/%u\n",
		ep->ep.name, &req->req, status,
		req->req.actual, req->req.length);

	/* don't modify queue heads during completion callback */
	ep->stopped = 1;
	req->req.complete(&ep->ep, &req->req);
	ep->stopped = stopped;
}

/* Dequeue ALL requests */
static void au1x00_nuke(struct au1x00_ep *ep, int status)
{
	struct au1x00_request *req;

	ep->stopped = 1;
	if (list_empty(&ep->queue))
		return;

	while (!list_empty(&ep->queue)) {
		req = list_entry(ep->queue.next, struct au1x00_request, queue);
		au1x00_done(ep, req, status);
	}
}

/* --- UDC managing functions ---------------------------------------------- */

static void au1x00_udc_reset(struct au1x00_udc *dev)
{
	pr_debug("%s\n", __FUNCTION__);

	/* Disable the controller */
	usbd_write(0x00, USBD_ENABLE);
}

static u8 au1x00_udc_config[];

static void au1x00_udc_init(struct au1x00_udc *dev)
{
	struct au1x00_ep *ep;
	unsigned int i;

	pr_debug("%s\n", __FUNCTION__);

	/* Device/ep0 records init */
	INIT_LIST_HEAD(&dev->gadget.ep_list);
	dev->gadget.ep0 = &dev->ep[0].ep;
	dev->gadget.speed = USB_SPEED_UNKNOWN;
	dev->ep0state = EP0_DISCONNECT;

	/* Enable the controller */
	usbd_write(0x02, USBD_ENABLE);
	udelay(100);
	usbd_write(0x03, USBD_ENABLE); 
	udelay(100);

	/* Write 25-byte configuration data */
	for (i = 0; i < 25; i++) {
		usbd_write(au1x00_udc_config[i], USBD_CONFIG);
		pr_debug("usbd_config[%d] = %08x\n", i, au1x00_udc_config[i]);
	}
	udelay(100);

	/* Basic endpoint records init */
	for (i = 0; i < AU1X00_UDC_NUM_ENDPOINTS; i++) {
		ep = &dev->ep[i];

		pr_debug("init %s\n", ep->ep.name);

		switch (i) {
		case 0:
			ep->reg_fifo = USBD_EP0RD;
			ep->reg_stat = USBD_EP0RDSTAT;
			ep->reg_cs = USBD_EP0CS;

			break;
		case 3:
		case 4:
			ep->reg_fifo = USBD_EP3RD+(i-3)*4;
			ep->reg_stat = USBD_EP3RDSTAT+(i-3)*4;
			ep->reg_cs = USBD_EP3CS+(i-3)*4;

			break;
		case 1:
		case 2:
			ep->reg_fifo = USBD_EP1WR+(i-1)*4;
			ep->reg_stat = USBD_EP1WRSTAT+(i-1)*4;
			ep->reg_cs = USBD_EP1CS+(i-1)*4;

			break;
		}

		list_add_tail(&ep->ep.ep_list, &dev->gadget.ep_list);
		ep->dev = dev;
		INIT_LIST_HEAD (&ep->queue);

		au1x00_ep_reset(ep);
	}

	list_del_init(&dev->ep[0].ep.ep_list);
}

static void au1x00_udc_enable(struct au1x00_udc *dev)
{
	pr_debug("%s\n", __FUNCTION__);

	/* Clear all interrupt status bits */
	usbd_write(0x1fff, USBD_INTSTAT);

	/* Remove ep0 from STALL condition */
	au1x00_ep_stall(&dev->ep[0], 0);

	/* Enable FIFO interrupts */
	usbd_write(0x103f, USBD_INTEN);
}

static void au1x00_stop_activity(struct au1x00_udc *dev, struct usb_gadget_driver *driver)
{
	int i;

	pr_debug("%s\n", __FUNCTION__);

	/* Don't disconnect drivers more than once */
	if (dev->gadget.speed == USB_SPEED_UNKNOWN)
		driver = NULL;
	dev->gadget.speed = USB_SPEED_UNKNOWN;

	/* Disconnect gadget driver after quiesceing hw and the driver */
	for (i = 0; i < AU1X00_UDC_NUM_ENDPOINTS; i++)
		au1x00_nuke(&dev->ep[i], -ESHUTDOWN);
	if (driver)
		driver->disconnect(&dev->gadget);
}

static void au1x00_udc_disable(struct au1x00_udc *dev)
{
	int i;

	pr_debug("%s\n", __FUNCTION__);

	/* Block all interrupts */
	usbd_write(0x00, USBD_INTEN);

	/* Reset Endpoints */
	for (i = 0; i < AU1X00_UDC_NUM_ENDPOINTS; i++)
		au1x00_ep_reset(&dev->ep[0]);
}

/* --- Exported functions -------------------------------------------------- */

static struct au1x00_udc *the_controller;

int usb_gadget_register_driver(struct usb_gadget_driver *driver)
{
	struct au1x00_udc *dev = the_controller;
	int ret;

printk("%s\n", __FUNCTION__);
	if (!driver || \
	    (driver->speed != USB_SPEED_FULL) || \
	    !driver->bind || \
	    !driver->unbind || \
	    !driver->disconnect || \
	    !driver->setup)
		return -EINVAL;
	if (!dev)
		return -ENODEV;
	if (dev->driver)
		return -EBUSY;

	/* Hook up the driver... */
	driver->driver.bus = NULL;
	dev->driver = driver;
	dev->gadget.dev.driver = &driver->driver;
	ret = driver->bind(&dev->gadget);
	if (ret) {
		pr_debug("bind to driver %s error %d\n",
				driver->driver.name, ret);
		dev->driver = NULL;
		dev->gadget.dev.driver = NULL;
		return ret;
	}
	device_create_file(dev->dev, &dev_attr_function);

	/* ... then enable host detection and ep0; and we're ready
	 * for set_configuration as well as eventual disconnect */
	au1x00_udc_enable(dev);

	pr_info("registered gadget driver '%s'\n", driver->driver.name);

printk("%s END\n", __FUNCTION__);
	return 0;
}
EXPORT_SYMBOL(usb_gadget_register_driver);

int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
{
	struct au1x00_udc *dev = the_controller;

printk("%s\n", __FUNCTION__);
	if (!dev)
		return -ENODEV;
	if (!driver || driver != dev->driver)
		return -EINVAL;

	dev->driver = NULL;
	au1x00_stop_activity(dev, driver);
	au1x00_udc_disable(dev);

	driver->unbind(&dev->gadget);

	device_del(&dev->gadget.dev);
	device_remove_file(dev->dev, &dev_attr_function);

	pr_info("unregistered gadget driver '%s'\n", driver->driver.name);

	return 0;
}
EXPORT_SYMBOL(usb_gadget_unregister_driver);

/* --- Endpoints definition ------------------------------------------------ */

#define EP0_FIFO_SIZE	64
#define INT_FIFO_SIZE	64
#define BULK_FIFO_SIZE	64

/* This is a fixed configuration "suggested" by the AU1100 data sheet that
 * should be enough for several gadget driver.
 * If you wish modifying it you have to keep in mind that you have to modify
 * table au1x00_udc_config accordingly */

static struct au1x00_udc memory = {
	.gadget = {
		.ops		= &au1x00_udc_ops,
		.ep0		= &memory.ep[0].ep,
		.name		= driver_name,
	},

	/* control endpoint */
	.ep[0] = {
		.num = 0,
		.ep = {
			.name		= "ep0",
			.ops		= &au1x00_ep_ops,
			.maxpacket	= EP0_FIFO_SIZE,
		},
		.dev		= &memory,
	},

	/* interrupt endpoint */
	.ep[1] = {
		.num = 1,
		.ep = {
			.name		= "ep1in-int",
			.ops		= &au1x00_ep_ops,
			.maxpacket	= INT_FIFO_SIZE,
		},
		.dev		= &memory,
	},

	/* bulk endpoints */
	.ep[2] = {
		.num = 2,
		.ep = {
			.name		= "ep2in-bulk",
			.ops		= &au1x00_ep_ops,
			.maxpacket	= BULK_FIFO_SIZE,
		},
		.dev		= &memory,
	},
	.ep[3] = {
		.num = 3,
		.ep = {
			.name		= "ep3out-bulk",
			.ops		= &au1x00_ep_ops,
			.maxpacket	= BULK_FIFO_SIZE,
		},
		.dev		= &memory,
	},
	.ep[4] = {
		.num = 4,
		.ep = {
			.name		= "ep4out-bulk",
			.ops		= &au1x00_ep_ops,
			.maxpacket	= BULK_FIFO_SIZE,
		},
		.dev		= &memory,
	},
};

/* See AU1100 data sheet at page 101 */

static u8 au1x00_udc_config[] = {
	0x04,		/* Endpoint number 0 */
	0x00,		/* Type = control */
	0x80,		/* Direction = bidirectional */
	0x00,		/* Max packet size = 64 bytes */
	0x00,		/* FIFOs 0 and 1 */

	0x14,		/* Endpoint number 1 */
	0x38,		/* Type = interrupt */
	0x80,		/* Direction = IN */
	0x00,		/* Max packet size = 64 bytes */
	0x02,		/* FIFO 2 */

	0x24,		/* Endpoint number 2 */
	0x28,		/* Type = bulk */
	0x80,		/* Direction = IN */
	0x00,		/* Max packet size = 64 bytes */
	0x03,		/* FIFO 3 */

	0x34,		/* Endpoint number 3 */
	0x20,		/* Type = bulk */
	0x80,		/* Direction = OUT */
	0x00,		/* Max packet size = 64 bytes */
	0x04,		/* FIFO 4 */

	0x44,		/* Endpoint number 4 */
	0x20,		/* Type = bulk */
	0x80,		/* Direction = OUT */
	0x00,		/* Max packet size = 64 bytes */
	0x05,		/* FIFO 5 */
};

/* ------------------------------------------------------------------------- */

#ifdef	CONFIG_PM
static int au1x00_udc_suspend(struct platform_device *dev, pm_message_t state)
{
	struct au1x00_udc *udc = platform_get_drvdata(dev);

	printk("%s\n", __FUNCTION__);

	return 0;
}

static int au1x00_udc_resume(struct platform_device *dev)
{
	struct au1x00_udc *udc = platform_get_drvdata(dev);

	printk("%s\n", __FUNCTION__);

	return 0;
}

#else
#define	au1x00_udc_suspend	NULL
#define	au1x00_udc_resume	NULL
#endif

static int __init au1x00_udc_probe(struct platform_device *pdev)
{
	struct au1x00_udc *dev = &memory;
	struct resource *res;
	u32 base_addr_phys;
	void *base_addr;
	int irq, irq_sus, ret;

	/* No more than one UDC in the system... */
	if (the_controller) {
		pr_error("already registerd UDC controller in the system\n");
		return -EBUSY;
	}

	/* Get the resource info */
	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "udc-base");
	if (!res) {
		ret = -ENODEV;
		goto out;
	}
	base_addr_phys = res->start;
	base_addr = ioremap(res->start, res->end - res->start);
	if (!base_addr) {
		pr_error("unable to remap address %lx\n",
				(unsigned long) res->start);
		ret = -EINVAL;
		goto out;
	}
	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "udc-irq");
	if (!res) {
		ret = -ENODEV;
		goto out_release_io;
	}
	irq = res->start;
	irq_sus = res->end;

	dev->dev = &pdev->dev;

	device_initialize(&dev->gadget.dev);
	dev->gadget.dev.parent = &pdev->dev;
	dev->gadget.dev.dma_mask = pdev->dev.dma_mask;

	platform_set_drvdata(pdev, dev);

	dev->base_addr = (u32) base_addr;
	dev->irq = irq;
	dev->irq_sus = irq_sus;

	create_proc_files();

	/* Init to known state, then setup irqs */
	au1x00_udc_init(dev);

	/* irq setup after old hardware state is cleaned up */
	ret = request_irq(irq, au1x00_udc_irq,
				IRQF_DISABLED, driver_name, dev);
	if (ret != 0) {
		pr_error("can't get irq %i, err %d\n", irq, ret);
		ret = -EBUSY;
		goto out_release_io;
	}
	ret = request_irq(irq_sus, au1x00_udc_irq,
				IRQF_DISABLED, driver_name, dev);
	if (ret != 0) {
		pr_error("can't get irq_sus %i, err %d\n", irq, ret);
		ret = -EBUSY;
		goto out_free_irq;
	}

	pr_info("Au1000 USB device controller found at 0x%x, irq %d-%d\n",
			base_addr_phys, irq, irq_sus);

	the_controller = dev;
	device_register(&dev->gadget.dev);

	return 0;

out_free_irq :
	free_irq(irq, dev);
out_release_io :
	iounmap(base_addr);
out :
	pr_error("UDC device not found (%d)\n", ret);

	return ret;
}

static void au1x00_udc_shutdown(struct platform_device *_dev)
{
printk("SHUTDOWN\n");
}

static int __exit au1x00_udc_remove(struct platform_device *pdev)
{
	struct au1x00_udc *dev = platform_get_drvdata(pdev);

	if (dev->driver)
		usb_gadget_unregister_driver(dev->driver);

	remove_proc_files();

	if (dev->irq) {
		free_irq(dev->irq, dev);
		dev->irq = 0;
	}
	if (dev->irq_sus) {
		free_irq(dev->irq_sus, dev);
		dev->irq_sus = 0;
	}
	iounmap((void *) dev->base_addr);

	device_unregister(&dev->gadget.dev);

	platform_set_drvdata(pdev, NULL);
	the_controller = NULL;

	au1x00_udc_reset(dev);

	return 0;
}

static struct platform_driver udc_driver = {
	.probe		= au1x00_udc_probe,
	.shutdown	= au1x00_udc_shutdown,
	.remove		= au1x00_udc_remove,
	.suspend	= au1x00_udc_suspend,
	.resume		= au1x00_udc_resume,
	.driver		= {
		.owner	= THIS_MODULE,
		.name	= "au1xxx-udc",
	},
};

static int __init udc_init(void)
{
	return platform_driver_register(&udc_driver);
}
module_init(udc_init);

static void __exit udc_exit(void)
{
	platform_driver_unregister(&udc_driver);
}
module_exit(udc_exit);

MODULE_DESCRIPTION("AMD Alchemy AU1X00 USB Device Controller driver");
MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
MODULE_LICENSE("GPL");

--gKMricLos+KVdGMg--
