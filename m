Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2012 09:44:56 +0200 (CEST)
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:43411 "EHLO
        na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901163Ab2HTHom (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2012 09:44:42 +0200
Received: from mail-lpp01m010-f54.google.com ([209.85.215.54]) (using TLSv1) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
        ID DSNKUDHq5ogOoKnFbFNlAjC/y/SCOek8Y0Gd@postini.com; Mon, 20 Aug 2012 00:44:40 PDT
Received: by lage12 with SMTP id e12so5211280lag.27
        for <linux-mips@linux-mips.org>; Mon, 20 Aug 2012 00:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=KQ2ESL6ug8xGy9kihqoOpPdQ3EsNM4H3oX5I5vK+mXY=;
        b=jD+36wSSxNgcD343V3TOlTvRxDKWRxMNiL4FPyPOSu20JOlpzook9jD/7/zCZSE6pR
         OxWTyg4ko1vZlSo6Sw4zjCo3mUw/0dXR2w91X5fjRT8xz7/rgwApz/T+/8EqLcu0mcVw
         yJjrKWdVl/NoeFgHZIMsl9/TC219TpiwLgafGi+PxNbHQwt92QEpEEpCdgF/0RH/yW0C
         jHmTqHQVr7Ryaq5jS4R6GbsH55wU7RRSlysFkpo3KVWlmjHNiWMTPoUPNoiL+SZTPwll
         vGEKWs9GPk46Q88zMIvzb9bgatyyIvWpak22vaiQzFTT5VmcfiITkztq9DEujGIWYujp
         YIOQ==
Received: by 10.152.103.11 with SMTP id fs11mr12943129lab.23.1345448677204;
        Mon, 20 Aug 2012 00:44:37 -0700 (PDT)
Received: from localhost (cs78217178.pp.htv.fi. [62.78.217.178])
        by mx.google.com with ESMTPS id nf5sm15055546lab.3.2012.08.20.00.44.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 00:44:36 -0700 (PDT)
Date:   Mon, 20 Aug 2012 10:40:42 +0300
From:   Felipe Balbi <balbi@ti.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     balbi@ti.com, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: bcm63xx UDC driver
Message-ID: <20120820074041.GH17455@arwen.pp.htv.fi>
Reply-To: balbi@ti.com
References: <97cb21b8063a02a9664baf8b749ae200@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
Content-Disposition: inline
In-Reply-To: <97cb21b8063a02a9664baf8b749ae200@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQlMVUZCRz8QR+KuZQJ3XIg24XwZJdvoUhY2xzwAAZQlMLkxlsBQNPnw8+0aHteK06J4xLIj
X-archive-position: 34286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: balbi@ti.com
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


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 18, 2012 at 10:18:01AM -0700, Kevin Cernekee wrote:
> diff --git a/drivers/usb/gadget/bcm63xx_udc.c b/drivers/usb/gadget/bcm63x=
x_udc.c
> new file mode 100644
> index 0000000..da68f43
> --- /dev/null
> +++ b/drivers/usb/gadget/bcm63xx_udc.c
> @@ -0,0 +1,2411 @@
> +/*
> + * bcm63xx_udc.c -- BCM63xx UDC high/full speed USB device controller
> + *
> + * Copyright (C) 2012 Kevin Cernekee <cernekee@gmail.com>
> + * Copyright (C) 2012 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/bug.h>
> +#include <linux/clk.h>
> +#include <linux/compiler.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <linux/kconfig.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +#include <linux/timer.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/workqueue.h>
> +
> +#include <bcm63xx_cpu.h>
> +#include <bcm63xx_iudma.h>
> +#include <bcm63xx_dev_usb_usbd.h>
> +#include <bcm63xx_io.h>
> +#include <bcm63xx_regs.h>
> +
> +#define DRV_MODULE_NAME		"bcm63xx_udc"
> +
> +static const char ep0name[] =3D "ep0";
> +static const char *const ep_name[] =3D {
> +	ep0name,
> +	"ep1in-bulk", "ep2out-bulk", "ep3in-int", "ep4out-int",
> +};
> +
> +static bool use_fullspeed;
> +module_param(use_fullspeed, bool, S_IRUGO);
> +MODULE_PARM_DESC(use_fullspeed, "true for fullspeed only");
> +
> +/*
> + * RX IRQ coalescing options:
> + *
> + * false (default) - one IRQ per DATAx packet.  Slow but reliable.  The
> + * driver is able to pass the "testusb" suite and recover from condition=
s like:
> + *
> + *   1) Device queues up a 2048-byte RX IUDMA transaction on an OUT bulk=
 ep
> + *   2) Host sends 512 bytes of data
> + *   3) Host decides to reconfigure the device and sends SET_INTERFACE
> + *   4) Device shuts down the endpoint and cancels the RX transaction
> + *
> + * true - one IRQ per transfer, for transfers <=3D 2048B.  Generates
> + * considerably fewer IRQs, but error recovery is less robust.  Does not
> + * reliably pass "testusb".
> + *
> + * TX always uses coalescing, because we can cancel partially complete TX
> + * transfers by repeatedly flushing the FIFO.  The hardware doesn't allow
> + * this on RX.
> + */
> +static bool irq_coalesce;
> +module_param(irq_coalesce, bool, S_IRUGO);
> +MODULE_PARM_DESC(irq_coalesce, "take one IRQ per RX transfer");
> +
> +#define DMA_ADDR_INVALID		(~((dma_addr_t)0))
> +
> +#define NUM_EP				5
> +#define NUM_IUDMA			6
> +#define NUM_FIFO_PAIRS			3
> +
> +#define IUDMA_RESET_TIMEOUT_US		10000
> +
> +#define EP0_RXCHAN			0
> +#define EP0_TXCHAN			1
> +
> +#define MAX_FRAGMENT			2048
> +#define MAX_CTRL_PKT			64
> +
> +#define EPTYP_CTRL			0x00
> +#define EPTYP_ISOC			0x01
> +#define EPTYP_BULK			0x02
> +#define EPTYP_INTR			0x03
> +
> +#define EPDIR_OUT			0x00
> +#define EPDIR_IN			0x01
> +
> +#define SPD_FULL			1
> +#define SPD_HIGH			0
> +#define SPD_UNKNOWN			-1
> +
> +#define DMAC_OFFSET			0x200
> +#define DMAS_OFFSET			0x400
> +
> +enum ep0_state {

even though all your symbols/functions/enumerations/structures/etc are
only acessible from this file, please prepend them with some bcm63xx_ or
bcm_ or something similar.

> +	EP0_REQUEUE,
> +	EP0_IDLE,
> +	EP0_IN_DATA_PHASE_SETUP,
> +	EP0_IN_DATA_PHASE_COMPLETE,
> +	EP0_OUT_DATA_PHASE_SETUP,
> +	EP0_OUT_DATA_PHASE_COMPLETE,
> +	EP0_OUT_STATUS_PHASE,
> +	EP0_IN_FAKE_STATUS_PHASE,
> +	EP0_SHUTDOWN,
> +};
> +
> +static const char __maybe_unused ep0_state_names[][32] =3D {
> +	"REQUEUE",
> +	"IDLE",
> +	"IN_DATA_PHASE_SETUP",
> +	"IN_DATA_PHASE_COMPLETE",
> +	"OUT_DATA_PHASE_SETUP",
> +	"OUT_DATA_PHASE_COMPLETE",
> +	"OUT_STATUS_PHASE",
> +	"IN_FAKE_STATUS_PHASE",
> +	"SHUTDOWN",
> +};
> +
> +/**
> + * struct iudma_ch_cfg - Static configuration for an IUDMA channel.
> + * @ep_num: USB endpoint number.
> + * @n_bds: Number of buffer descriptors in the ring.
> + * @ep_type: Endpoint type (control, bulk, interrupt).
> + * @dir: Direction (in, out).
> + * @n_fifo_slots: Number of FIFO entries to allocate for this channel.
> + * @max_pkt_hs: Maximum packet size in high speed mode.
> + * @max_pkt_fs: Maximum packet size in full speed mode.
> + */
> +struct iudma_ch_cfg {
> +	int				ep_num;
> +	int				n_bds;
> +	int				ep_type;
> +	int				dir;
> +	int				n_fifo_slots;
> +	int				max_pkt_hs;
> +	int				max_pkt_fs;
> +};
> +
> +static const struct iudma_ch_cfg iudma_defaults[] =3D {
> +
> +	/* This controller was designed to support a CDC/RNDIS application.
> +	   It may be possible to reconfigure some of the endpoints, but
> +	   the hardware limitations (FIFO sizing and number of DMA channels)
> +	   may significantly impact flexibility and/or stability.  Change
> +	   these values at your own risk.
> +
> +	      ep_num       ep_type           n_fifo_slots    max_pkt_fs
> +	idx      |  n_bds     |         dir       |  max_pkt_hs  |
> +	 |       |    |       |          |        |      |       |       */
> +	[0] =3D { -1,   4, EPTYP_CTRL, EPDIR_OUT,  32,    64,     64 },
> +	[1] =3D {  0,   4, EPTYP_CTRL, EPDIR_OUT,  32,    64,     64 },
> +	[2] =3D {  2,  16, EPTYP_BULK, EPDIR_OUT, 128,   512,     64 },
> +	[3] =3D {  1,  16, EPTYP_BULK, EPDIR_IN,  128,   512,     64 },
> +	[4] =3D {  4,   4, EPTYP_INTR, EPDIR_OUT,  32,    64,     64 },
> +	[5] =3D {  3,   4, EPTYP_INTR, EPDIR_IN,   32,    64,     64 },
> +};
> +
> +/**
> + * struct iudma_ch - Represents the current state of a single IUDMA chan=
nel.
> + * @ch_idx: IUDMA channel index (0 to NUM_IUDMA-1).
> + * @irq: Linux interrupt number for this channel.
> + * @ep_num: USB endpoint number.  -1 for ep0 RX.
> + * @enabled: Whether bcm63xx_ep_enable() has been called.
> + * @max_pkt: "Chunk size" on the USB interface.  Based on interface spee=
d.
> + * @is_tx: true for TX, false for RX.
> + * @bep: Pointer to the associated endpoint.  NULL for ep0 RX.
> + * @read_bd: Next buffer descriptor to reap from the hardware.
> + * @write_bd: Next BD available for a new packet.
> + * @end_bd: Points to the final BD in the ring.
> + * @n_bds_used: Number of BD entries currently occupied.
> + * @bd_ring: Base pointer to the BD ring.
> + * @bd_ring_dma: Physical (DMA) address of bd_ring.
> + * @n_bds: Total number of BDs in the ring.
> + *
> + * ep0 has two IUDMA channels (EP0_RXCHAN and EP0_TXCHAN), as it is
> + * bidirectional.  The "struct usb_ep" associated with ep0 is for TX (IN)
> + * only.
> + *
> + * Each bulk/intr endpoint has a single IUDMA channel and a single
> + * struct usb_ep.
> + */
> +struct iudma_ch {
> +	unsigned int			ch_idx;
> +	int				irq;
> +	int				ep_num;
> +	bool				enabled;
> +	int				max_pkt;
> +	bool				is_tx;
> +	struct bcm63xx_ep		*bep;
> +
> +	struct bcm_enet_desc		*read_bd;
> +	struct bcm_enet_desc		*write_bd;
> +	struct bcm_enet_desc		*end_bd;
> +	int				n_bds_used;
> +
> +	struct bcm_enet_desc		*bd_ring;
> +	dma_addr_t			bd_ring_dma;
> +	unsigned int			n_bds;
> +};
> +
> +struct bcm63xx_udc;
> +
> +/**
> + * struct bcm63xx_ep - Internal (driver) state of a single endpoint.
> + * @ep_num: USB endpoint number.
> + * @iudma: Pointer to IUDMA channel state.
> + * @ep: USB gadget layer representation of the EP.
> + * @udc: Reference to the device controller.
> + * @queue: Linked list of outstanding requests for this EP.
> + * @halted: 1 if the EP is stalled; 0 otherwise.
> + */
> +struct bcm63xx_ep {
> +	unsigned int			ep_num;
> +	struct iudma_ch			*iudma;
> +	struct usb_ep			ep;
> +	struct bcm63xx_udc		*udc;
> +	struct list_head		queue;
> +	unsigned			halted:1;
> +};
> +
> +/**
> + * struct bcm63xx_req - Internal (driver) state of a single request.
> + * @queue: Links back to the EP's request list.
> + * @req: USB gadget layer representation of the request.
> + * @offset: Current byte offset into the data buffer (next byte to queue=
).
> + * @bd_bytes: Number of data bytes in outstanding BD entries.
> + * @iudma: IUDMA channel used for the request.
> + */
> +struct bcm63xx_req {
> +	struct list_head		queue;		/* ep's requests */
> +	struct usb_request		req;
> +	unsigned int			offset;
> +	unsigned int			bd_bytes;
> +	struct iudma_ch			*iudma;
> +};
> +
> +/**
> + * struct bcm63xx_udc - Driver/hardware private context.
> + * @lock: Spinlock to mediate access to this struct, and (most) HW regs.
> + * @dev: Generic Linux device structure.
> + * @pd: Platform data (board/port info).
> + * @usbd_clk: Clock descriptor for the USB device block.
> + * @usbh_clk: Clock descriptor for the USB host block.
> + * @gadget: USB slave device.
> + * @driver: Driver for USB slave devices.
> + * @usbd_regs: Base address of the USBD/USB20D block.
> + * @iudma_regs: Base address of the USBD's associated IUDMA block.
> + * @bep: Array of endpoints, including ep0.
> + * @iudma: Array of all IUDMA channels used by this controller.
> + * @cfg: USB configuration number, from SET_CONFIGURATION wValue.
> + * @iface: USB interface number, from SET_INTERFACE wIndex.
> + * @alt_iface: USB alt interface number, from SET_INTERFACE wValue.
> + * @ep0_ctrl_req: Request object for bcm63xx_udc-initiated ep0 transacti=
ons.
> + * @ep0_ctrl_buf: Data buffer for ep0_ctrl_req.
> + * @ep0state: Current state of the ep0 state machine.
> + * @ep0_wq: Workqueue struct used to wake up the ep0 state machine.
> + * @wedgemap: Bitmap of wedged endpoints.
> + * @ep0_req_reset: USB reset is pending.
> + * @ep0_req_set_cfg: Need to spoof a SET_CONFIGURATION packet.
> + * @ep0_req_set_iface: Need to spoof a SET_INTERFACE packet.
> + * @ep0_req_shutdown: Driver is shutting down; requesting ep0 to halt ac=
tivity.
> + * @ep0_req_completed: ep0 request has completed; worker has not seen it=
 yet.
> + * @ep0_reply: Pending reply from gadget driver.
> + * @ep0_request: Outstanding ep0 request.
> + * @debugfs_root: debugfs directory: /sys/kernel/debug/<DRV_MODULE_NAME>.
> + * @debugfs_usbd: debugfs file "usbd" for controller state.
> + * @debugfs_iudma: debugfs file "usbd" for IUDMA state.
> + */
> +struct bcm63xx_udc {
> +	spinlock_t			lock;
> +
> +	struct device			*dev;
> +	struct bcm63xx_usbd_platform_data *pd;
> +	struct clk			*usbd_clk;
> +	struct clk			*usbh_clk;
> +
> +	struct usb_gadget		gadget;
> +	struct usb_gadget_driver	*driver;
> +
> +	void __iomem			*usbd_regs;
> +	void __iomem			*iudma_regs;
> +
> +	struct bcm63xx_ep		bep[NUM_EP];
> +	struct iudma_ch			iudma[NUM_IUDMA];
> +
> +	int				cfg;
> +	int				iface;
> +	int				alt_iface;
> +
> +	struct bcm63xx_req		ep0_ctrl_req;
> +	u8				*ep0_ctrl_buf;
> +
> +	int				ep0state;
> +	struct work_struct		ep0_wq;
> +
> +	unsigned long			wedgemap;
> +
> +	unsigned			ep0_req_reset:1;
> +	unsigned			ep0_req_set_cfg:1;
> +	unsigned			ep0_req_set_iface:1;
> +	unsigned			ep0_req_shutdown:1;
> +
> +	unsigned			ep0_req_completed:1;
> +	struct usb_request		*ep0_reply;
> +	struct usb_request		*ep0_request;
> +
> +	struct dentry			*debugfs_root;
> +	struct dentry			*debugfs_usbd;
> +	struct dentry			*debugfs_iudma;
> +};
> +
> +static const struct usb_ep_ops bcm63xx_udc_ep_ops;
> +
> +/***********************************************************************
> + * Convenience functions
> + ***********************************************************************/
> +
> +static inline struct bcm63xx_udc *gadget_to_udc(struct usb_gadget *g)
> +{
> +	return container_of(g, struct bcm63xx_udc, gadget);
> +}
> +
> +static inline struct bcm63xx_ep *our_ep(struct usb_ep *ep)
> +{
> +	return container_of(ep, struct bcm63xx_ep, ep);
> +}
> +
> +static inline struct bcm63xx_req *our_req(struct usb_request *req)
> +{
> +	return container_of(req, struct bcm63xx_req, req);
> +}
> +
> +static inline u32 usbd_readl(struct bcm63xx_udc *udc, u32 off)
> +{
> +	return bcm_readl(udc->usbd_regs + off);
> +}
> +
> +static inline void usbd_writel(struct bcm63xx_udc *udc, u32 val, u32 off)
> +{
> +	bcm_writel(val, udc->usbd_regs + off);
> +}
> +
> +static inline u32 usb_dma_readl(struct bcm63xx_udc *udc, u32 off)
> +{
> +	return bcm_readl(udc->iudma_regs + off);
> +}
> +
> +static inline void usb_dma_writel(struct bcm63xx_udc *udc, u32 val, u32 =
off)
> +{
> +	bcm_writel(val, udc->iudma_regs + off);
> +}
> +
> +static inline u32 usb_dmac_readl(struct bcm63xx_udc *udc, u32 off)
> +{
> +	return bcm_readl(udc->iudma_regs + DMAC_OFFSET + off);
> +}
> +
> +static inline void usb_dmac_writel(struct bcm63xx_udc *udc, u32 val, u32=
 off)
> +{
> +	bcm_writel(val, udc->iudma_regs + DMAC_OFFSET + off);
> +}
> +
> +static inline u32 usb_dmas_readl(struct bcm63xx_udc *udc, u32 off)
> +{
> +	return bcm_readl(udc->iudma_regs + DMAS_OFFSET + off);
> +}
> +
> +static inline void usb_dmas_writel(struct bcm63xx_udc *udc, u32 val, u32=
 off)
> +{
> +	bcm_writel(val, udc->iudma_regs + DMAS_OFFSET + off);
> +}
> +
> +/***********************************************************************
> + * Low-level IUDMA / FIFO operations
> + ***********************************************************************/
> +
> +/**
> + * ep_dma_select - Helper function to set up the init_sel signal.
> + * @udc: Reference to the device controller.
> + * @idx: Desired init_sel value.
> + *
> + * The "init_sel" signal is used as a selection index for both endpoints
> + * and IUDMA channels.  Since these do not map 1:1, the use of this sign=
al
> + * depends on the context.
> + */
> +static void ep_dma_select(struct bcm63xx_udc *udc, int idx)
> +{
> +	u32 val =3D usbd_readl(udc, USBD_CONTROL_REG);
> +
> +	val &=3D ~USBD_CONTROL_INIT_SEL_MASK;
> +	val |=3D idx << USBD_CONTROL_INIT_SEL_SHIFT;
> +	usbd_writel(udc, val, USBD_CONTROL_REG);
> +}
> +
> +/**
> + * set_stall - Enable/disable stall on one endpoint.
> + * @udc: Reference to the device controller.
> + * @bep: Endpoint on which to operate.
> + * @is_stalled: true to enable stall, false to disable.
> + *
> + * See notes in update_wedge() regarding automatic clearing of halt/stall
> + * conditions.
> + */
> +static void set_stall(struct bcm63xx_udc *udc, struct bcm63xx_ep *bep,
> +	bool is_stalled)
> +{
> +	u32 val;
> +
> +	val =3D USBD_STALL_UPDATE_MASK |
> +		(is_stalled ? USBD_STALL_ENABLE_MASK : 0) |
> +		(bep->ep_num << USBD_STALL_EPNUM_SHIFT);
> +	usbd_writel(udc, val, USBD_STALL_REG);
> +}
> +
> +/**
> + * fifo_setup - (Re)initialize FIFO boundaries and settings.
> + * @udc: Reference to the device controller.
> + *
> + * These parameters depend on the USB link speed.  Settings are
> + * per-IUDMA-channel-pair.
> + */
> +static void fifo_setup(struct bcm63xx_udc *udc)
> +{
> +	int is_hs =3D udc->gadget.speed =3D=3D USB_SPEED_HIGH;
> +	u32 i, val, rx_fifo_slot, tx_fifo_slot;
> +
> +	/* set up FIFO boundaries and packet sizes; this is done in pairs */
> +	for (i =3D rx_fifo_slot =3D tx_fifo_slot =3D 0; i < NUM_IUDMA; i +=3D 2=
) {
> +		const struct iudma_ch_cfg *rx_cfg =3D &iudma_defaults[i];
> +		const struct iudma_ch_cfg *tx_cfg =3D &iudma_defaults[i + 1];
> +
> +		ep_dma_select(udc, i >> 1);
> +
> +		val =3D (rx_fifo_slot << USBD_RXFIFO_CONFIG_START_SHIFT) |
> +			((rx_fifo_slot + rx_cfg->n_fifo_slots - 1) <<
> +			 USBD_RXFIFO_CONFIG_END_SHIFT);
> +		rx_fifo_slot +=3D rx_cfg->n_fifo_slots;
> +		usbd_writel(udc, val, USBD_RXFIFO_CONFIG_REG);
> +		usbd_writel(udc,
> +			    is_hs ? rx_cfg->max_pkt_hs : rx_cfg->max_pkt_fs,
> +			    USBD_RXFIFO_EPSIZE_REG);
> +
> +		val =3D (tx_fifo_slot << USBD_TXFIFO_CONFIG_START_SHIFT) |
> +			((tx_fifo_slot + tx_cfg->n_fifo_slots - 1) <<
> +			 USBD_TXFIFO_CONFIG_END_SHIFT);
> +		tx_fifo_slot +=3D tx_cfg->n_fifo_slots;
> +		usbd_writel(udc, val, USBD_TXFIFO_CONFIG_REG);
> +		usbd_writel(udc,
> +			    is_hs ? tx_cfg->max_pkt_hs : tx_cfg->max_pkt_fs,
> +			    USBD_TXFIFO_EPSIZE_REG);
> +
> +		usbd_readl(udc, USBD_TXFIFO_EPSIZE_REG);
> +	}
> +}
> +
> +/**
> + * fifo_reset_ep - Flush a single endpoint's FIFO.
> + * @udc: Reference to the device controller.
> + * @ep_num: Endpoint number.
> + */
> +static void fifo_reset_ep(struct bcm63xx_udc *udc, int ep_num)
> +{
> +	u32 val;
> +
> +	ep_dma_select(udc, ep_num);
> +
> +	val =3D usbd_readl(udc, USBD_CONTROL_REG);
> +	val |=3D USBD_CONTROL_FIFO_RESET_MASK;
> +	usbd_writel(udc, val, USBD_CONTROL_REG);
> +	usbd_readl(udc, USBD_CONTROL_REG);
> +}
> +
> +/**
> + * fifo_reset - Flush all hardware FIFOs.
> + * @udc: Reference to the device controller.
> + */
> +static void fifo_reset(struct bcm63xx_udc *udc)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < NUM_FIFO_PAIRS; i++)
> +		fifo_reset_ep(udc, i);
> +}
> +
> +/**
> + * ep_init - Initial (one-time) endpoint initialization.
> + * @udc: Reference to the device controller.
> + */
> +static void ep_init(struct bcm63xx_udc *udc)
> +{
> +	u32 i, val;
> +
> +	for (i =3D 0; i < NUM_IUDMA; i++) {
> +		const struct iudma_ch_cfg *cfg =3D &iudma_defaults[i];
> +
> +		if (cfg->ep_num < 0)
> +			continue;
> +
> +		ep_dma_select(udc, cfg->ep_num);
> +		val =3D (cfg->ep_type << USBD_EPNUM_TYPEMAP_TYPE_SHIFT) |
> +			((i >> 1) << USBD_EPNUM_TYPEMAP_DMA_CH_SHIFT);
> +		usbd_writel(udc, val, USBD_EPNUM_TYPEMAP_REG);
> +	}
> +}
> +
> +/**
> + * ep_setup - Configure per-endpoint settings.
> + * @udc: Reference to the device controller.
> + *
> + * This needs to be rerun if the speed/cfg/intf/altintf changes.
> + */
> +static void ep_setup(struct bcm63xx_udc *udc)
> +{
> +	u32 val, i;
> +
> +	usbd_writel(udc, USBD_CSR_SETUPADDR_DEF, USBD_CSR_SETUPADDR_REG);
> +
> +	for (i =3D 0; i < NUM_IUDMA; i++) {
> +		const struct iudma_ch_cfg *cfg =3D &iudma_defaults[i];
> +		int max_pkt =3D udc->gadget.speed =3D=3D USB_SPEED_HIGH ?
> +			      cfg->max_pkt_hs : cfg->max_pkt_fs;
> +		int idx =3D cfg->ep_num;
> +
> +		udc->iudma[i].max_pkt =3D max_pkt;
> +
> +		if (idx < 0)
> +			continue;
> +		udc->bep[idx].ep.maxpacket =3D max_pkt;
> +
> +		val =3D (idx << USBD_CSR_EP_LOG_SHIFT) |
> +		      (cfg->dir << USBD_CSR_EP_DIR_SHIFT) |
> +		      (cfg->ep_type << USBD_CSR_EP_TYPE_SHIFT) |
> +		      (udc->cfg << USBD_CSR_EP_CFG_SHIFT) |
> +		      (udc->iface << USBD_CSR_EP_IFACE_SHIFT) |
> +		      (udc->alt_iface << USBD_CSR_EP_ALTIFACE_SHIFT) |
> +		      (max_pkt << USBD_CSR_EP_MAXPKT_SHIFT);
> +		usbd_writel(udc, val, USBD_CSR_EP_REG(idx));
> +	}
> +}
> +
> +/**
> + * iudma_write - Queue a single IUDMA transaction.
> + * @udc: Reference to the device controller.
> + * @iudma: IUDMA channel to use.
> + * @breq: Request containing the transaction data.
> + *
> + * For RX IUDMA, this will queue a single buffer descriptor, as RX IUDMA
> + * does not honor SOP/EOP so the handling of multiple buffers is ambiguo=
us.
> + * So iudma_write() may be called several times to fulfill a single
> + * usb_request.
> + *
> + * For TX IUDMA, this can queue multiple buffer descriptors if needed.
> + */
> +static void iudma_write(struct bcm63xx_udc *udc, struct iudma_ch *iudma,
> +	struct bcm63xx_req *breq)
> +{
> +	int first_bd =3D 1, last_bd =3D 0, extra_zero_pkt =3D 0;
> +	unsigned int bytes_left =3D breq->req.length - breq->offset;
> +	const int max_bd_bytes =3D !irq_coalesce && !iudma->is_tx ?
> +		iudma->max_pkt : MAX_FRAGMENT;
> +
> +	iudma->n_bds_used =3D 0;
> +	breq->bd_bytes =3D 0;
> +	breq->iudma =3D iudma;
> +
> +	BUG_ON(breq->req.dma =3D=3D DMA_ADDR_INVALID && breq->req.length);

I wouldn't hang the entire machine for that. BTW, you shouldn't have
DMA_ADDR_INVALID defined anywhere, and you should be using the generic
map/unmap routines defined in udc-core.c

> +
> +	if ((bytes_left % iudma->max_pkt =3D=3D 0) && bytes_left && breq->req.z=
ero)
> +		extra_zero_pkt =3D 1;
> +
> +	do {
> +		struct bcm_enet_desc *d =3D iudma->write_bd;
> +		u32 dmaflags =3D 0;
> +		unsigned int n_bytes;
> +
> +		if (d =3D=3D iudma->end_bd) {
> +			dmaflags |=3D DMADESC_WRAP_MASK;
> +			iudma->write_bd =3D iudma->bd_ring;
> +		} else {
> +			iudma->write_bd++;
> +		}
> +		iudma->n_bds_used++;
> +
> +		n_bytes =3D min_t(int, bytes_left, max_bd_bytes);
> +		if (n_bytes)
> +			dmaflags |=3D n_bytes << DMADESC_LENGTH_SHIFT;
> +		else
> +			dmaflags |=3D (1 << DMADESC_LENGTH_SHIFT) |
> +				    DMADESC_USB_ZERO_MASK;
> +
> +		dmaflags |=3D DMADESC_OWNER_MASK;
> +		if (first_bd) {
> +			dmaflags |=3D DMADESC_SOP_MASK;
> +			first_bd =3D 0;
> +		}
> +
> +		/*
> +		 * extra_zero_pkt forces one more iteration through the loop
> +		 * after all data is queued up, to send the zero packet
> +		 */
> +		if (extra_zero_pkt && !bytes_left)
> +			extra_zero_pkt =3D 0;
> +
> +		if (!iudma->is_tx || iudma->n_bds_used =3D=3D iudma->n_bds ||
> +		    (n_bytes =3D=3D bytes_left && !extra_zero_pkt)) {
> +			last_bd =3D 1;
> +			dmaflags |=3D DMADESC_EOP_MASK;
> +		}
> +
> +		d->address =3D breq->req.dma + breq->offset;
> +		mb();
> +		d->len_stat =3D dmaflags;
> +
> +		breq->offset +=3D n_bytes;
> +		breq->bd_bytes +=3D n_bytes;
> +		bytes_left -=3D n_bytes;
> +	} while (!last_bd);
> +
> +	usb_dmac_writel(udc, ENETDMAC_CHANCFG_EN_MASK,
> +			ENETDMAC_CHANCFG_REG(iudma->ch_idx));
> +}
> +
> +/**
> + * iudma_read - Check for IUDMA buffer completion.
> + * @udc: Reference to the device controller.
> + * @iudma: IUDMA channel to use.
> + *
> + * This checks to see if ALL of the outstanding BDs on the DMA channel
> + * have been filled.  If so, it returns the actual transfer length;
> + * otherwise it returns -EBUSY.
> + */
> +static int iudma_read(struct bcm63xx_udc *udc, struct iudma_ch *iudma)
> +{
> +	int i, actual_len =3D 0;
> +	struct bcm_enet_desc *d =3D iudma->read_bd;
> +
> +	if (!iudma->n_bds_used)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < iudma->n_bds_used; i++) {
> +		u32 dmaflags;
> +
> +		dmaflags =3D d->len_stat;
> +
> +		if (dmaflags & DMADESC_OWNER_MASK)
> +			return -EBUSY;
> +
> +		actual_len +=3D (dmaflags & DMADESC_LENGTH_MASK) >>
> +			      DMADESC_LENGTH_SHIFT;
> +		if (d =3D=3D iudma->end_bd)
> +			d =3D iudma->bd_ring;
> +		else
> +			d++;
> +	}
> +
> +	iudma->read_bd =3D d;
> +	iudma->n_bds_used =3D 0;
> +	return actual_len;
> +}
> +
> +/**
> + * iudma_reset_channel - Stop DMA on a single channel.
> + * @udc: Reference to the device controller.
> + * @iudma: IUDMA channel to reset.
> + */
> +static void iudma_reset_channel(struct bcm63xx_udc *udc, struct iudma_ch=
 *iudma)
> +{
> +	int timeout =3D IUDMA_RESET_TIMEOUT_US;
> +	struct bcm_enet_desc *d;
> +
> +	if (!iudma->is_tx)
> +		fifo_reset_ep(udc, max(0, iudma->ep_num));
> +
> +	/* stop DMA, then wait for the hardware to wrap up */
> +	usb_dmac_writel(udc, 0, ENETDMAC_CHANCFG_REG(iudma->ch_idx));
> +
> +	while (usb_dmac_readl(udc, ENETDMAC_CHANCFG_REG(iudma->ch_idx)) &
> +				   ENETDMAC_CHANCFG_EN_MASK) {
> +		udelay(1);
> +
> +		/* repeatedly flush the FIFO data until the BD completes */
> +		if (iudma->is_tx && iudma->ep_num >=3D 0)
> +			fifo_reset_ep(udc, iudma->ep_num);
> +
> +		if (!timeout--) {
> +			dev_err(udc->dev, "can't reset IUDMA channel %d\n",
> +				iudma->ch_idx);
> +			break;
> +		}
> +		if (timeout =3D=3D IUDMA_RESET_TIMEOUT_US / 2) {
> +			dev_warn(udc->dev, "forcibly halting IUDMA channel %d\n",
> +				 iudma->ch_idx);
> +			usb_dmac_writel(udc, ENETDMAC_CHANCFG_BUFHALT_MASK,
> +					ENETDMAC_CHANCFG_REG(iudma->ch_idx));
> +		}
> +	}
> +	usb_dmac_writel(udc, ~0, ENETDMAC_IR_REG(iudma->ch_idx));
> +
> +	/* don't leave "live" HW-owned entries for the next guy to step on */
> +	for (d =3D iudma->bd_ring; d <=3D iudma->end_bd; d++)
> +		d->len_stat =3D 0;
> +	mb();
> +
> +	iudma->read_bd =3D iudma->write_bd =3D iudma->bd_ring;
> +	iudma->n_bds_used =3D 0;
> +	usb_dmas_writel(udc, 0, ENETDMAS_SRAM2_REG(iudma->ch_idx));
> +}
> +
> +/**
> + * iudma_init_channel - One-time IUDMA channel initialization.
> + * @udc: Reference to the device controller.
> + * @ch_idx: Channel to initialize.
> + */
> +static int iudma_init_channel(struct bcm63xx_udc *udc, unsigned int ch_i=
dx)
> +{
> +	struct iudma_ch *iudma =3D &udc->iudma[ch_idx];
> +	const struct iudma_ch_cfg *cfg =3D &iudma_defaults[ch_idx];
> +	unsigned int n_bds =3D cfg->n_bds;
> +	struct bcm63xx_ep *bep =3D NULL;
> +
> +	iudma->ep_num =3D cfg->ep_num;
> +	iudma->ch_idx =3D ch_idx;
> +	iudma->is_tx =3D !!(ch_idx & 0x01);
> +	if (iudma->ep_num >=3D 0) {
> +		bep =3D &udc->bep[iudma->ep_num];
> +		bep->iudma =3D iudma;
> +		INIT_LIST_HEAD(&bep->queue);
> +	}
> +
> +	iudma->bep =3D bep;
> +
> +	/* ep0 is always active; others are controlled by the gadget driver */
> +	if (iudma->ep_num <=3D 0)
> +		iudma->enabled =3D true;
> +
> +	iudma->n_bds =3D n_bds;
> +	iudma->bd_ring =3D dmam_alloc_coherent(udc->dev,
> +		n_bds * sizeof(struct bcm_enet_desc),
> +		&iudma->bd_ring_dma, GFP_KERNEL);
> +	if (!iudma->bd_ring)
> +		return -ENOMEM;
> +
> +	iudma->end_bd =3D &iudma->bd_ring[n_bds - 1];
> +
> +	iudma_reset_channel(udc, iudma);
> +
> +	/* set up IRQs, UBUS burst size, and BD base for this channel */
> +	usb_dmac_writel(udc, ENETDMAC_IR_BUFDONE_MASK,
> +			ENETDMAC_IRMASK_REG(ch_idx));
> +	usb_dmac_writel(udc, 8, ENETDMAC_MAXBURST_REG(ch_idx));
> +
> +	usb_dmas_writel(udc, iudma->bd_ring_dma, ENETDMAS_RSTART_REG(ch_idx));
> +	usb_dmas_writel(udc, 0, ENETDMAS_SRAM2_REG(ch_idx));
> +
> +	return 0;
> +}
> +
> +/**
> + * iudma_init - Initialize IUDMA channels.
> + * @udc: Reference to the device controller.
> + * @enable_iudma: true to turn on the global enable bits; false to disab=
le.
> + *
> + * Disable: kill IRQs, flush channels, kill DMA.
> + * Enable: enable DMA, flush channels, enable IRQs.
> + */
> +static int iudma_init(struct bcm63xx_udc *udc, bool enable_iudma)
> +{
> +	int i, rc;
> +
> +	if (enable_iudma)
> +		usb_dma_writel(udc, ENETDMA_CFG_EN_MASK, ENETDMA_CFG_REG);
> +	else
> +		usb_dma_writel(udc, 0, ENETDMA_GLB_IRQMASK_REG);
> +
> +	for (i =3D 0; i < NUM_IUDMA; i++) {
> +		rc =3D iudma_init_channel(udc, i);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (enable_iudma)
> +		usb_dma_writel(udc, BIT(NUM_IUDMA)-1, ENETDMA_GLB_IRQMASK_REG);
> +	else
> +		usb_dma_writel(udc, 0, ENETDMA_CFG_REG);
> +
> +	return 0;
> +}
> +
> +/***********************************************************************
> + * Other low-level USBD operations
> + ***********************************************************************/
> +
> +/**
> + * set_ctrl_irqs - Mask/unmask control path interrupts.
> + * @udc: Reference to the device controller.
> + * @enable_irqs: true to enable, false to disable.
> + */
> +static void set_ctrl_irqs(struct bcm63xx_udc *udc, bool enable_irqs)
> +{
> +	u32 val;
> +
> +	usbd_writel(udc, 0, USBD_STATUS_REG);
> +
> +	val =3D BIT(USBD_EVENT_IRQ_USB_RESET) |
> +	      BIT(USBD_EVENT_IRQ_SETUP) |
> +	      BIT(USBD_EVENT_IRQ_SETCFG) |
> +	      BIT(USBD_EVENT_IRQ_SETINTF) |
> +	      BIT(USBD_EVENT_IRQ_USB_LINK);
> +	usbd_writel(udc, enable_irqs ? val : 0, USBD_EVENT_IRQ_MASK_REG);
> +	usbd_writel(udc, val, USBD_EVENT_IRQ_STATUS_REG);
> +}
> +
> +/**
> + * select_phy_mode - Select between USB device and host mode.
> + * @udc: Reference to the device controller.
> + * @is_device: true for device, false for host.
> + *
> + * This should probably be reworked to use the drivers/usb/otg
> + * infrastructure.
> + *
> + * By default, the AFE/pullups are disabled in device mode, until
> + * select_pullup() is called.
> + */
> +static void select_phy_mode(struct bcm63xx_udc *udc, bool is_device)
> +{
> +	u32 val, portmask =3D BIT(udc->pd->port_no);
> +
> +	if (BCMCPU_IS_6328()) {
> +		/* configure pinmux to sense VBUS signal */
> +		val =3D bcm_gpio_readl(GPIO_PINMUX_OTHR_REG);
> +		val &=3D ~GPIO_PINMUX_OTHR_6328_USB_MASK;
> +		val |=3D is_device ? GPIO_PINMUX_OTHR_6328_USB_DEV :
> +			       GPIO_PINMUX_OTHR_6328_USB_HOST;
> +		bcm_gpio_writel(val, GPIO_PINMUX_OTHR_REG);
> +	}
> +
> +	val =3D bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_UTMI_CTL_6368_REG);
> +	if (is_device) {
> +		val |=3D (portmask << USBH_PRIV_UTMI_CTL_HOSTB_SHIFT);
> +		val |=3D (portmask << USBH_PRIV_UTMI_CTL_NODRIV_SHIFT);
> +	} else {
> +		val &=3D ~(portmask << USBH_PRIV_UTMI_CTL_HOSTB_SHIFT);
> +		val &=3D ~(portmask << USBH_PRIV_UTMI_CTL_NODRIV_SHIFT);
> +	}
> +	bcm_rset_writel(RSET_USBH_PRIV, val, USBH_PRIV_UTMI_CTL_6368_REG);
> +
> +	val =3D bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_SWAP_6368_REG);
> +	if (is_device)
> +		val |=3D USBH_PRIV_SWAP_USBD_MASK;
> +	else
> +		val &=3D ~USBH_PRIV_SWAP_USBD_MASK;
> +	bcm_rset_writel(RSET_USBH_PRIV, val, USBH_PRIV_SWAP_6368_REG);
> +}
> +
> +/**
> + * select_pullup - Enable/disable the pullup on D+
> + * @udc: Reference to the device controller.
> + * @is_on: true to enable the pullup, false to disable.
> + *
> + * If the pullup is active, the host will sense a FS/HS device connected=
 to
> + * the port.  If the pullup is inactive, the host will think the USB
> + * device has been disconnected.
> + */
> +static void select_pullup(struct bcm63xx_udc *udc, bool is_on)
> +{
> +	u32 val, portmask =3D BIT(udc->pd->port_no);
> +
> +	val =3D bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_UTMI_CTL_6368_REG);
> +	if (is_on)
> +		val &=3D ~(portmask << USBH_PRIV_UTMI_CTL_NODRIV_SHIFT);
> +	else
> +		val |=3D (portmask << USBH_PRIV_UTMI_CTL_NODRIV_SHIFT);
> +	bcm_rset_writel(RSET_USBH_PRIV, val, USBH_PRIV_UTMI_CTL_6368_REG);
> +}
> +
> +/**
> + * uninit_udc_hw - Shut down the hardware prior to driver removal.
> + * @udc: Reference to the device controller.
> + *
> + * This just masks the IUDMA IRQs and releases the clocks.  It is assumed
> + * that bcm63xx_udc_stop() has already run.
> + */
> +static void uninit_udc_hw(struct bcm63xx_udc *udc)
> +{
> +	iudma_init(udc, false);
> +
> +	clk_disable(udc->usbd_clk);
> +	clk_disable(udc->usbh_clk);
> +	clk_put(udc->usbd_clk);
> +	clk_put(udc->usbh_clk);
> +}
> +
> +/**
> + * init_udc_hw - Initialize the controller hardware and data structures.
> + * @udc: Reference to the device controller.
> + */
> +static int init_udc_hw(struct bcm63xx_udc *udc)
> +{
> +	int i, rc;
> +	u32 val;
> +
> +	udc->ep0_ctrl_buf =3D devm_kzalloc(udc->dev, MAX_CTRL_PKT, GFP_KERNEL);
> +	if (!udc->ep0_ctrl_buf)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&udc->gadget.ep_list);
> +	for (i =3D 0; i < NUM_EP; i++) {
> +		struct bcm63xx_ep *bep =3D &udc->bep[i];
> +
> +		bep->ep.name =3D ep_name[i];
> +		bep->ep_num =3D i;
> +		bep->ep.ops =3D &bcm63xx_udc_ep_ops;
> +		list_add_tail(&bep->ep.ep_list, &udc->gadget.ep_list);
> +		bep->halted =3D 0;
> +		bep->ep.maxpacket =3D MAX_CTRL_PKT;
> +		bep->udc =3D udc;
> +		bep->ep.desc =3D NULL;
> +		INIT_LIST_HEAD(&bep->queue);
> +	}
> +
> +	udc->gadget.ep0 =3D &udc->bep[0].ep;
> +	list_del(&udc->bep[0].ep.ep_list);
> +
> +	udc->gadget.speed =3D USB_SPEED_UNKNOWN;
> +	udc->ep0state =3D EP0_SHUTDOWN;
> +
> +	udc->usbh_clk =3D clk_get(udc->dev, "usbh");
> +	if (IS_ERR(udc->usbh_clk))
> +		return -EIO;
> +
> +	udc->usbd_clk =3D clk_get(udc->dev, "usbd");
> +	if (IS_ERR(udc->usbd_clk)) {
> +		clk_put(udc->usbh_clk);
> +		return -EIO;
> +	}
> +	clk_enable(udc->usbh_clk);
> +	clk_enable(udc->usbd_clk);
> +
> +	val =3D USBD_CONTROL_AUTO_CSRS_MASK |
> +	      USBD_CONTROL_DONE_CSRS_MASK |
> +	      (irq_coalesce ? USBD_CONTROL_RXZSCFG_MASK : 0);
> +	usbd_writel(udc, val, USBD_CONTROL_REG);
> +
> +	val =3D USBD_STRAPS_APP_SELF_PWR_MASK |
> +	      USBD_STRAPS_APP_RAM_IF_MASK |
> +	      USBD_STRAPS_APP_CSRPRGSUP_MASK |
> +	      USBD_STRAPS_APP_8BITPHY_MASK |
> +	      USBD_STRAPS_APP_RMTWKUP_MASK;
> +
> +	if (udc->gadget.max_speed =3D=3D USB_SPEED_HIGH)
> +		val |=3D (SPD_HIGH << USBD_STRAPS_SPEED_SHIFT);
> +	else
> +		val |=3D (SPD_FULL << USBD_STRAPS_SPEED_SHIFT);
> +	usbd_writel(udc, val, USBD_STRAPS_REG);
> +
> +	set_ctrl_irqs(udc, false);
> +
> +	usbd_writel(udc, 0, USBD_EVENT_IRQ_CFG_LO_REG);
> +
> +	val =3D USBD_EVENT_IRQ_CFG_FALLING(USBD_EVENT_IRQ_ENUM_ON) |
> +	      USBD_EVENT_IRQ_CFG_FALLING(USBD_EVENT_IRQ_SET_CSRS);
> +	usbd_writel(udc, val, USBD_EVENT_IRQ_CFG_HI_REG);
> +
> +	rc =3D iudma_init(udc, true);
> +	if (rc) {
> +		uninit_udc_hw(udc);
> +		return rc;
> +	}
> +
> +	fifo_setup(udc);
> +	ep_init(udc);
> +	ep_setup(udc);
> +	fifo_reset(udc);
> +	select_phy_mode(udc, true);
> +
> +	return 0;
> +}
> +
> +/***********************************************************************
> + * Standard EP gadget operations
> + ***********************************************************************/
> +
> +/**
> + * bcm63xx_ep_enable - Enable one endpoint.
> + * @ep: Endpoint to enable.
> + * @desc: Contains max packet, direction, etc.
> + *
> + * Most of the endpoint parameters are fixed in this controller, so there
> + * isn't much for this function to do.
> + */
> +static int bcm63xx_ep_enable(struct usb_ep *ep,
> +	const struct usb_endpoint_descriptor *desc)
> +{
> +	struct bcm63xx_ep *bep =3D our_ep(ep);
> +	struct bcm63xx_udc *udc =3D bep->udc;
> +	struct iudma_ch *iudma =3D bep->iudma;
> +	unsigned long flags;
> +
> +	if (!ep || !desc || ep->name =3D=3D ep0name)
> +		return -EINVAL;
> +
> +	if ((desc->bmAttributes =3D=3D USB_ENDPOINT_XFER_BULK &&
> +	     usb_endpoint_maxp(desc) !=3D bep->ep.maxpacket) ||
> +	     !desc->wMaxPacketSize)
> +		return -ERANGE;

this will never happen, you can remove this check IMHO.

> +
> +	if (!udc->driver)
> +		return -ESHUTDOWN;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +	if (iudma->enabled) {
> +		spin_unlock_irqrestore(&udc->lock, flags);
> +		return -EINVAL;
> +	}
> +
> +	iudma->enabled =3D true;
> +	BUG_ON(!list_empty(&bep->queue));
> +
> +	iudma_reset_channel(udc, iudma);
> +
> +	bep->halted =3D 0;
> +	set_stall(udc, bep, false);
> +	clear_bit(bep->ep_num, &udc->wedgemap);
> +
> +	ep->desc =3D desc;
> +	ep->maxpacket =3D usb_endpoint_maxp(desc);
> +
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +	return 0;
> +}
> +
> +/**
> + * bcm63xx_ep_disable - Disable one endpoint.
> + * @ep: Endpoint to disable.
> + */
> +static int bcm63xx_ep_disable(struct usb_ep *ep)
> +{
> +	struct bcm63xx_ep *bep =3D our_ep(ep);
> +	struct bcm63xx_udc *udc =3D bep->udc;
> +	struct iudma_ch *iudma =3D bep->iudma;
> +	struct list_head *pos, *n;
> +	unsigned long flags;
> +
> +	if (!ep || !ep->desc)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +	if (!iudma->enabled) {
> +		spin_unlock_irqrestore(&udc->lock, flags);
> +		return -EINVAL;
> +	}
> +	iudma->enabled =3D false;
> +
> +	iudma_reset_channel(udc, iudma);
> +
> +	if (!list_empty(&bep->queue)) {
> +		list_for_each_safe(pos, n, &bep->queue) {
> +			struct bcm63xx_req *breq =3D
> +				list_entry(pos, struct bcm63xx_req, queue);
> +
> +			usb_gadget_unmap_request(&udc->gadget, &breq->req,
> +						 iudma->is_tx);
> +			list_del(&breq->queue);
> +			breq->req.status =3D -ESHUTDOWN;
> +
> +			spin_unlock_irqrestore(&udc->lock, flags);
> +			breq->req.complete(&iudma->bep->ep, &breq->req);
> +			spin_lock_irqsave(&udc->lock, flags);
> +		}
> +	}
> +	ep->desc =3D NULL;
> +
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +	return 0;
> +}
> +
> +/**
> + * bcm63xx_udc_alloc_request - Allocate a new request.
> + * @ep: Endpoint associated with the request.
> + * @mem_flags: Flags to pass to kzalloc().
> + */
> +static struct usb_request *bcm63xx_udc_alloc_request(struct usb_ep *ep,
> +	gfp_t mem_flags)
> +{
> +	struct bcm63xx_req *breq;
> +
> +	breq =3D kzalloc(sizeof(*breq), mem_flags);
> +	if (!breq)
> +		return NULL;
> +	breq->req.dma =3D DMA_ADDR_INVALID;

drop the DMA_ADDR_INVALID;

> +	return &breq->req;
> +}
> +
> +/**
> + * bcm63xx_udc_free_request - Free a request.
> + * @ep: Endpoint associated with the request.
> + * @req: Request to free.
> + */
> +static void bcm63xx_udc_free_request(struct usb_ep *ep,
> +	struct usb_request *req)
> +{
> +	struct bcm63xx_req *breq =3D our_req(req);
> +	kfree(breq);
> +}
> +
> +/**
> + * bcm63xx_udc_queue - Queue up a new request.
> + * @ep: Endpoint associated with the request.
> + * @req: Request to add.
> + * @mem_flags: Unused.
> + *
> + * If the queue is empty, start this request immediately.  Otherwise, add
> + * it to the list.
> + *
> + * ep0 replies are sent through this function from the gadget driver, but
> + * they are treated differently because they need to be handled by the e=
p0
> + * state machine.  (Sometimes they are replies to control requests that
> + * were spoofed by this driver, and so they shouldn't be transmitted at =
all.)
> + */
> +static int bcm63xx_udc_queue(struct usb_ep *ep, struct usb_request *req,
> +	gfp_t mem_flags)
> +{
> +	struct bcm63xx_ep *bep =3D our_ep(ep);
> +	struct bcm63xx_udc *udc =3D bep->udc;
> +	struct bcm63xx_req *breq =3D our_req(req);
> +	unsigned long flags;
> +	int rc =3D 0;
> +
> +	if (unlikely(!req || !req->complete || !req->buf || !ep))
> +		return -EINVAL;
> +
> +	req->actual =3D 0;
> +	req->status =3D 0;
> +	breq->offset =3D 0;
> +
> +	if (bep =3D=3D &udc->bep[0]) {
> +		/* only one reply per request, please */
> +		if (udc->ep0_reply)
> +			return -EINVAL;
> +
> +		udc->ep0_reply =3D req;
> +		schedule_work(&udc->ep0_wq);
> +		return 0;
> +	}
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +	if (!bep->iudma->enabled) {
> +		rc =3D -ESHUTDOWN;
> +		goto out;
> +	}
> +
> +	rc =3D usb_gadget_map_request(&udc->gadget, req, bep->iudma->is_tx);
> +	if (rc =3D=3D 0) {
> +		list_add_tail(&breq->queue, &bep->queue);
> +		if (list_is_singular(&bep->queue))
> +			iudma_write(udc, bep->iudma, breq);
> +	}
> +
> +out:
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +	return rc;
> +}
> +
> +/**
> + * bcm63xx_udc_dequeue - Remove a pending request from the queue.
> + * @ep: Endpoint associated with the request.
> + * @req: Request to remove.
> + *
> + * If the request is not at the head of the queue, this is easy - just n=
uke
> + * it.  If the request is at the head of the queue, we'll need to stop t=
he
> + * DMA transaction and then queue up the successor.
> + */
> +static int bcm63xx_udc_dequeue(struct usb_ep *ep, struct usb_request *re=
q)
> +{
> +	struct bcm63xx_ep *bep =3D our_ep(ep);
> +	struct bcm63xx_udc *udc =3D bep->udc;
> +	struct bcm63xx_req *breq =3D our_req(req), *cur;
> +	unsigned long flags;
> +	int rc =3D 0;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +	if (list_empty(&bep->queue)) {
> +		rc =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	cur =3D list_first_entry(&bep->queue, struct bcm63xx_req, queue);
> +	usb_gadget_unmap_request(&udc->gadget, &breq->req, bep->iudma->is_tx);
> +
> +	if (breq =3D=3D cur) {
> +		iudma_reset_channel(udc, bep->iudma);
> +		list_del(&breq->queue);
> +
> +		if (!list_empty(&bep->queue)) {
> +			struct bcm63xx_req *next;
> +
> +			next =3D list_first_entry(&bep->queue,
> +				struct bcm63xx_req, queue);
> +			iudma_write(udc, bep->iudma, next);
> +		}
> +	} else {
> +		list_del(&breq->queue);
> +	}
> +
> +out:
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +
> +	req->status =3D -ESHUTDOWN;
> +	req->complete(ep, req);
> +
> +	return rc;
> +}
> +
> +/**
> + * bcm63xx_udc_set_halt - Enable/disable STALL flag in the hardware.
> + * @ep: Endpoint to halt.
> + * @value: Zero to clear halt; nonzero to set halt.
> + *
> + * See comments in update_wedge().
> + */
> +static int bcm63xx_udc_set_halt(struct usb_ep *ep, int value)
> +{
> +	struct bcm63xx_ep *bep =3D our_ep(ep);
> +	struct bcm63xx_udc *udc =3D bep->udc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +	set_stall(udc, bep, !!value);
> +	bep->halted =3D value;
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +
> +	return 0;
> +}
> +
> +/**
> + * bcm63xx_udc_set_wedge - Stall the endpoint until the next reset.
> + * @ep: Endpoint to wedge.
> + *
> + * See comments in update_wedge().
> + */
> +static int bcm63xx_udc_set_wedge(struct usb_ep *ep)
> +{
> +	struct bcm63xx_ep *bep =3D our_ep(ep);
> +	struct bcm63xx_udc *udc =3D bep->udc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +	set_bit(bep->ep_num, &udc->wedgemap);
> +	set_stall(udc, bep, true);
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +
> +	return 0;
> +}
> +
> +static const struct usb_ep_ops bcm63xx_udc_ep_ops =3D {
> +	.enable		=3D bcm63xx_ep_enable,
> +	.disable	=3D bcm63xx_ep_disable,
> +
> +	.alloc_request	=3D bcm63xx_udc_alloc_request,
> +	.free_request	=3D bcm63xx_udc_free_request,
> +
> +	.queue		=3D bcm63xx_udc_queue,
> +	.dequeue	=3D bcm63xx_udc_dequeue,
> +
> +	.set_halt	=3D bcm63xx_udc_set_halt,
> +	.set_wedge	=3D bcm63xx_udc_set_wedge,
> +};
> +
> +/***********************************************************************
> + * EP0 handling
> + ***********************************************************************/
> +
> +/**
> + * ep0_setup_callback - Drop spinlock to invoke ->setup callback.
> + * @udc: Reference to the device controller.
> + * @ctrl: 8-byte SETUP request.
> + */
> +static int ep0_setup_callback(struct bcm63xx_udc *udc,
> +	struct usb_ctrlrequest *ctrl)
> +{
> +	int rc;
> +
> +	spin_unlock_irq(&udc->lock);
> +	rc =3D udc->driver->setup(&udc->gadget, ctrl);
> +	spin_lock_irq(&udc->lock);
> +	return rc;
> +}
> +
> +/**
> + * ep0_spoof_set_cfg - Synthesize a SET_CONFIGURATION request.
> + * @udc: Reference to the device controller.
> + *
> + * Many standard requests are handled automatically in the hardware, but
> + * we still need to pass them to the gadget driver so that it can
> + * reconfigure the interfaces/endpoints if necessary.
> + *
> + * Unfortunately we are not able to send a STALL response if the host
> + * requests an invalid configuration.  If this happens, we'll have to be
> + * content with printing a warning.
> + */
> +static void ep0_spoof_set_cfg(struct bcm63xx_udc *udc)
> +{
> +	struct usb_ctrlrequest ctrl;
> +
> +	ctrl.bRequestType =3D USB_DIR_OUT | USB_RECIP_DEVICE;
> +	ctrl.bRequest =3D USB_REQ_SET_CONFIGURATION;
> +	ctrl.wValue =3D cpu_to_le16(udc->cfg);
> +	ctrl.wIndex =3D 0;
> +	ctrl.wLength =3D 0;
> +	if (ep0_setup_callback(udc, &ctrl) < 0) {
> +		dev_warn_ratelimited(udc->dev,
> +			"hardware auto-acked bad SET_CONFIGURATION(%d) request\n",
> +			udc->cfg);
> +	}
> +}
> +
> +/**
> + * ep0_spoof_set_iface - Synthesize a SET_INTERFACE request.
> + * @udc: Reference to the device controller.
> + */
> +static void ep0_spoof_set_iface(struct bcm63xx_udc *udc)
> +{
> +	struct usb_ctrlrequest ctrl;
> +
> +	ctrl.bRequestType =3D USB_DIR_OUT | USB_RECIP_INTERFACE;
> +	ctrl.bRequest =3D USB_REQ_SET_INTERFACE;
> +	ctrl.wValue =3D cpu_to_le16(udc->alt_iface);
> +	ctrl.wIndex =3D cpu_to_le16(udc->iface);
> +	ctrl.wLength =3D 0;
> +	if (ep0_setup_callback(udc, &ctrl) < 0) {
> +		dev_warn_ratelimited(udc->dev,
> +			"hardware auto-acked bad SET_INTERFACE(%d,%d) request\n",
> +			udc->iface, udc->alt_iface);
> +	}
> +}

so this HW really doesn't give you oportunity to handle SetConfiguration
and SetInterface on your own ?? That's crazy :-p

> +/**
> + * ep0_map_write - dma_map and iudma_write a single request.
> + * @udc: Reference to the device controller.
> + * @ch_idx: IUDMA channel number.
> + * @req: USB gadget layer representation of the request.
> + */
> +static void ep0_map_write(struct bcm63xx_udc *udc, int ch_idx,
> +	struct usb_request *req)
> +{
> +	struct bcm63xx_req *breq =3D our_req(req);
> +	struct iudma_ch *iudma =3D &udc->iudma[ch_idx];
> +
> +	BUG_ON(udc->ep0_request);
> +	udc->ep0_request =3D req;
> +
> +	req->actual =3D 0;
> +	breq->offset =3D 0;
> +	usb_gadget_map_request(&udc->gadget, req, iudma->is_tx);
> +	iudma_write(udc, iudma, breq);
> +}
> +
> +/**
> + * ep0_complete - Set completion status and "stage" the callback.
> + * @udc: Reference to the device controller.
> + * @req: USB gadget layer representation of the request.
> + * @status: Status to return to the gadget driver.
> + */
> +static void ep0_complete(struct bcm63xx_udc *udc, struct usb_request *re=
q,
> +	int status)
> +{
> +	req->status =3D status;
> +	if (status)
> +		req->actual =3D 0;
> +	if (req->complete)
> +		req->complete(&udc->bep[0].ep, req);
> +}
> +
> +/**
> + * ep0_nuke_reply - Abort request from the gadget driver due to reset/sh=
utdown.
> + * @udc: Reference to the device controller.
> + * @is_tx: Nonzero for TX (IN), zero for RX (OUT).
> + */
> +static void ep0_nuke_reply(struct bcm63xx_udc *udc, int is_tx)
> +{
> +	struct usb_request *req =3D udc->ep0_reply;
> +
> +	udc->ep0_reply =3D NULL;
> +	if (req->dma !=3D DMA_ADDR_INVALID)
> +		usb_gadget_unmap_request(&udc->gadget, req, is_tx);
> +	if (udc->ep0_request =3D=3D req) {
> +		udc->ep0_req_completed =3D 0;
> +		udc->ep0_request =3D NULL;
> +	}
> +	ep0_complete(udc, req, -ESHUTDOWN);
> +}
> +
> +/**
> + * ep0_read_complete - Close out the pending ep0 request; return transfe=
r len.
> + * @udc: Reference to the device controller.
> + */
> +static int ep0_read_complete(struct bcm63xx_udc *udc)
> +{
> +	struct usb_request *req =3D udc->ep0_request;
> +
> +	udc->ep0_req_completed =3D 0;
> +	udc->ep0_request =3D NULL;
> +
> +	return req->actual;
> +}
> +
> +/**
> + * ep0_internal_request - Helper function to submit an ep0 request.
> + * @udc: Reference to the device controller.
> + * @ch_idx: IUDMA channel number.
> + * @length: Number of bytes to TX/RX.
> + *
> + * Used for simple transfers performed by the ep0 worker.  This will alw=
ays
> + * use ep0_ctrl_req / ep0_ctrl_buf.
> + */
> +static void ep0_internal_request(struct bcm63xx_udc *udc, int ch_idx,
> +	int length)
> +{
> +	struct usb_request *req =3D &udc->ep0_ctrl_req.req;
> +
> +	req->buf =3D udc->ep0_ctrl_buf;
> +	req->dma =3D DMA_ADDR_INVALID;
> +	req->length =3D length;
> +	req->complete =3D NULL;
> +
> +	ep0_map_write(udc, ch_idx, req);
> +}
> +
> +/**
> + * ep0_do_setup - Parse new SETUP packet and decide how to handle it.
> + * @udc: Reference to the device controller.
> + *
> + * EP0_IDLE probably shouldn't ever happen.  EP0_REQUEUE means we're rea=
dy
> + * for the next packet.  Anything else means the transaction requires mu=
ltiple
> + * stages of handling.
> + */
> +static enum ep0_state ep0_do_setup(struct bcm63xx_udc *udc)
> +{
> +	int rc;
> +	struct usb_ctrlrequest *ctrl =3D (void *)udc->ep0_ctrl_buf;
> +
> +	rc =3D ep0_read_complete(udc);
> +
> +	if (rc < 0) {
> +		dev_err(udc->dev, "missing SETUP packet\n");
> +		return EP0_IDLE;
> +	}
> +
> +	/*
> +	 * Handle 0-byte IN STATUS acknowledgement.  The hardware doesn't
> +	 * ALWAYS deliver these 100% of the time, so if we happen to see one,
> +	 * just throw it away.
> +	 */
> +	if (rc =3D=3D 0)
> +		return EP0_REQUEUE;
> +
> +	/* Drop malformed SETUP packets */
> +	if (rc !=3D sizeof(*ctrl)) {
> +		dev_warn_ratelimited(udc->dev,
> +			"malformed SETUP packet (%d bytes)\n", rc);
> +		return EP0_REQUEUE;
> +	}
> +
> +	/* Process new SETUP packet arriving on ep0 */
> +	rc =3D ep0_setup_callback(udc, ctrl);
> +	if (rc < 0) {
> +		set_stall(udc, &udc->bep[0], true);
> +		return EP0_REQUEUE;
> +	}
> +
> +	if (!ctrl->wLength)
> +		return EP0_REQUEUE;
> +	else if (ctrl->bRequestType & USB_DIR_IN)
> +		return EP0_IN_DATA_PHASE_SETUP;
> +	else
> +		return EP0_OUT_DATA_PHASE_SETUP;
> +}
> +
> +/**
> + * ep0_do_idle - Check for outstanding requests if ep0 is idle.
> + * @udc: Reference to the device controller.
> + *
> + * In state EP0_IDLE, the RX descriptor is either pending, or has been
> + * filled with a SETUP packet from the host.  This function handles new
> + * SETUP packets, control IRQ events (which can generate fake SETUP pack=
ets),
> + * and reset/shutdown events.
> + *
> + * Returns 0 if work was done; -EAGAIN if nothing to do.
> + */
> +static int ep0_do_idle(struct bcm63xx_udc *udc)
> +{
> +	if (udc->ep0_req_reset) {
> +		udc->ep0_req_reset =3D 0;
> +	} else if (udc->ep0_req_completed) {
> +		udc->ep0state =3D ep0_do_setup(udc);
> +		return udc->ep0state =3D=3D EP0_IDLE ? -EAGAIN : 0;
> +	} else if (udc->ep0_req_set_cfg) {
> +		udc->ep0_req_set_cfg =3D 0;
> +		ep0_spoof_set_cfg(udc);
> +		udc->ep0state =3D EP0_IN_FAKE_STATUS_PHASE;
> +	} else if (udc->ep0_req_set_iface) {
> +		udc->ep0_req_set_iface =3D 0;
> +		ep0_spoof_set_iface(udc);
> +		udc->ep0state =3D EP0_IN_FAKE_STATUS_PHASE;
> +	} else if (udc->ep0_req_shutdown) {
> +		udc->ep0_req_shutdown =3D 0;
> +		udc->ep0_req_completed =3D 0;
> +		udc->ep0_request =3D NULL;
> +		udc->ep0state =3D EP0_SHUTDOWN;
> +		iudma_reset_channel(udc, &udc->iudma[EP0_RXCHAN]);
> +		usb_gadget_unmap_request(&udc->gadget,
> +			&udc->ep0_ctrl_req.req, 0);
> +	} else if (udc->ep0_reply) {
> +		/*
> +		 * This could happen if a USB RESET shows up during an ep0
> +		 * transaction (especially if a laggy driver like gadgetfs
> +		 * is in use).
> +		 */
> +		dev_warn(udc->dev, "nuking unexpected reply\n");
> +		ep0_nuke_reply(udc, 0);
> +	} else {
> +		return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ep0_one_round - Handle the current ep0 state.
> + * @udc: Reference to the device controller.
> + *
> + * Returns 0 if work was done; -EAGAIN if nothing to do.
> + */
> +static int ep0_one_round(struct bcm63xx_udc *udc)
> +{
> +	enum ep0_state ep0state =3D udc->ep0state;
> +	bool shutdown =3D udc->ep0_req_reset || udc->ep0_req_shutdown;
> +
> +	switch (udc->ep0state) {
> +	case EP0_REQUEUE:
> +		/* set up descriptor to receive SETUP packet */
> +		ep0_internal_request(udc, EP0_RXCHAN, MAX_CTRL_PKT);
> +		ep0state =3D EP0_IDLE;
> +		break;
> +	case EP0_IDLE:
> +		return ep0_do_idle(udc);
> +	case EP0_IN_DATA_PHASE_SETUP:
> +		/*
> +		 * Normal case: TX request is in ep0_reply (queued by the
> +		 * callback), or will be queued shortly.  When it's here,
> +		 * send it to the HW and go to EP0_IN_DATA_PHASE_COMPLETE.
> +		 *
> +		 * Shutdown case: Stop waiting for the reply.  Just
> +		 * REQUEUE->IDLE.  The gadget driver is NOT expected to
> +		 * queue anything else now.
> +		 */
> +		if (udc->ep0_reply) {
> +			ep0_map_write(udc, EP0_TXCHAN, udc->ep0_reply);
> +			ep0state =3D EP0_IN_DATA_PHASE_COMPLETE;
> +		} else if (shutdown) {
> +			ep0state =3D EP0_REQUEUE;
> +		}
> +		break;
> +	case EP0_IN_DATA_PHASE_COMPLETE: {
> +		/*
> +		 * Normal case: TX packet (ep0_reply) is in flight; wait for
> +		 * it to finish, then go back to REQUEUE->IDLE.
> +		 *
> +		 * Shutdown case: Reset the TX channel, send -ESHUTDOWN
> +		 * completion to the gadget driver, then REQUEUE->IDLE.
> +		 */
> +		if (udc->ep0_req_completed) {
> +			udc->ep0_reply =3D NULL;
> +			ep0_read_complete(udc);
> +			/* the "ack" sometimes gets eaten (see ep0_do_idle) */
> +			ep0state =3D EP0_REQUEUE;
> +		} else if (shutdown) {
> +			iudma_reset_channel(udc, &udc->iudma[EP0_TXCHAN]);
> +			ep0_nuke_reply(udc, 1);
> +			ep0state =3D EP0_REQUEUE;
> +		}
> +		break;
> +	}
> +	case EP0_OUT_DATA_PHASE_SETUP:
> +		/* Similar behavior to EP0_IN_DATA_PHASE_SETUP */
> +		if (udc->ep0_reply) {
> +			ep0_map_write(udc, EP0_RXCHAN, udc->ep0_reply);
> +			ep0state =3D EP0_OUT_DATA_PHASE_COMPLETE;
> +		} else if (shutdown) {
> +			ep0state =3D EP0_REQUEUE;
> +		}
> +		break;
> +	case EP0_OUT_DATA_PHASE_COMPLETE: {
> +		/* Similar behavior to EP0_IN_DATA_PHASE_COMPLETE */
> +		if (udc->ep0_req_completed) {
> +			udc->ep0_reply =3D NULL;
> +			ep0_read_complete(udc);
> +
> +			/* send 0-byte ack to host */
> +			ep0_internal_request(udc, EP0_TXCHAN, 0);
> +			ep0state =3D EP0_OUT_STATUS_PHASE;
> +		} else if (shutdown) {
> +			iudma_reset_channel(udc, &udc->iudma[EP0_RXCHAN]);
> +			ep0_nuke_reply(udc, 0);
> +			ep0state =3D EP0_REQUEUE;
> +		}
> +		break;
> +	}
> +	case EP0_OUT_STATUS_PHASE:
> +		/*
> +		 * Normal case: 0-byte OUT ack packet is in flight; wait
> +		 * for it to finish, then go back to REQUEUE->IDLE.
> +		 *
> +		 * Shutdown case: just cancel the transmission.  Don't bother
> +		 * calling the completion, because it originated from this
> +		 * function anyway.  Then go back to REQUEUE->IDLE.
> +		 */
> +		if (udc->ep0_req_completed) {
> +			ep0_read_complete(udc);
> +			ep0state =3D EP0_REQUEUE;
> +		} else if (shutdown) {
> +			iudma_reset_channel(udc, &udc->iudma[EP0_TXCHAN]);
> +			udc->ep0_request =3D NULL;
> +			ep0state =3D EP0_REQUEUE;
> +		}
> +		break;
> +	case EP0_IN_FAKE_STATUS_PHASE: {
> +		/*
> +		 * Normal case: we spoofed a SETUP packet and are now
> +		 * waiting for the gadget driver to send a 0-byte reply.
> +		 * This doesn't actually get sent to the HW because the
> +		 * HW has already sent its own reply.  Once we get the
> +		 * response, return to IDLE.
> +		 *
> +		 * Shutdown case: return to IDLE immediately.
> +		 *
> +		 * Note that the ep0 RX descriptor has remained queued
> +		 * (and possibly unfilled) during this entire transaction.
> +		 * The HW datapath (IUDMA) never even sees SET_CONFIGURATION
> +		 * or SET_INTERFACE transactions.
> +		 */
> +		struct usb_request *r =3D udc->ep0_reply;
> +
> +		if (!r) {
> +			if (shutdown)
> +				ep0state =3D EP0_IDLE;
> +			break;
> +		}
> +
> +		ep0_complete(udc, r, 0);
> +		udc->ep0_reply =3D NULL;
> +		ep0state =3D EP0_IDLE;
> +		break;
> +	}
> +	case EP0_SHUTDOWN:
> +		break;
> +	}
> +
> +	if (udc->ep0state =3D=3D ep0state)
> +		return -EAGAIN;
> +
> +	udc->ep0state =3D ep0state;
> +	return 0;
> +}
> +
> +/**
> + * ep0_worker - ep0 worker thread / state machine.
> + * @w: Workqueue struct.
> + *
> + * ep0_worker is triggered any time an event occurs on ep0.  It is used =
to
> + * synchronize ep0 events and ensure that both HW and SW events occur in
> + * a well-defined order.  When the ep0 IUDMA queues are idle, it may
> + * synthesize SET_CONFIGURATION / SET_INTERFACE requests that were consu=
med
> + * by the USBD hardware.
> + *
> + * The worker function will continue iterating around the state machine
> + * until there is nothing left to do.  Usually "nothing left to do" means
> + * that we're waiting for a new event from the hardware.
> + */
> +static void ep0_worker(struct work_struct *w)
> +{
> +	struct bcm63xx_udc *udc =3D container_of(w, struct bcm63xx_udc, ep0_wq);
> +
> +	spin_lock_irq(&udc->lock);
> +	while (ep0_one_round(udc) =3D=3D 0)
> +		;
> +	spin_unlock_irq(&udc->lock);
> +}
> +
> +/***********************************************************************
> + * Standard UDC gadget operations
> + ***********************************************************************/
> +
> +/**
> + * bcm63xx_udc_get_frame - Read current SOF frame number from the HW.
> + * @gadget: USB slave device.
> + */
> +static int bcm63xx_udc_get_frame(struct usb_gadget *gadget)
> +{
> +	struct bcm63xx_udc *udc =3D gadget_to_udc(gadget);
> +
> +	return (usbd_readl(udc, USBD_STATUS_REG) &
> +		USBD_STATUS_SOF_MASK) >> USBD_STATUS_SOF_SHIFT;
> +}
> +
> +/**
> + * bcm63xx_udc_pullup - Enable/disable pullup on D+ line.
> + * @gadget: USB slave device.
> + * @is_on: 0 to disable pullup, 1 to enable.
> + *
> + * See notes in select_pullup().
> + */
> +static int bcm63xx_udc_pullup(struct usb_gadget *gadget, int is_on)
> +{
> +	struct bcm63xx_udc *udc =3D gadget_to_udc(gadget);
> +	unsigned long flags;
> +	int i;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +
> +	if (is_on) {
> +		udc->gadget.speed =3D USB_SPEED_UNKNOWN;
> +		udc->ep0state =3D EP0_REQUEUE;
> +		fifo_setup(udc);
> +		fifo_reset(udc);
> +		ep_setup(udc);
> +
> +		bitmap_zero(&udc->wedgemap, NUM_EP);
> +		for (i =3D 0; i < NUM_EP; i++)
> +			set_stall(udc, &udc->bep[i], false);
> +
> +		set_ctrl_irqs(udc, true);
> +		select_pullup(gadget_to_udc(gadget), true);
> +
> +		spin_unlock_irqrestore(&udc->lock, flags);
> +	} else {
> +		select_pullup(gadget_to_udc(gadget), false);
> +
> +		udc->ep0_req_shutdown =3D 1;
> +		schedule_work(&udc->ep0_wq);
> +
> +		while (udc->ep0state !=3D EP0_SHUTDOWN) {
> +			spin_unlock_irqrestore(&udc->lock, flags);
> +			schedule_timeout(HZ);
> +			spin_lock_irqsave(&udc->lock, flags);
> +		}
> +		set_ctrl_irqs(udc, false);
> +
> +		spin_unlock_irqrestore(&udc->lock, flags);
> +		cancel_work_sync(&udc->ep0_wq);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * bcm63xx_udc_start - Start the controller.
> + * @gadget: USB slave device.
> + * @driver: Driver for USB slave devices.
> + */
> +static int bcm63xx_udc_start(struct usb_gadget *gadget,
> +		struct usb_gadget_driver *driver)
> +{
> +	struct bcm63xx_udc *udc =3D gadget_to_udc(gadget);
> +	unsigned long flags;
> +
> +	if (!driver || driver->max_speed < USB_SPEED_HIGH ||
> +	    !driver->setup)
> +		return -EINVAL;
> +	if (!udc)
> +		return -ENODEV;
> +	if (udc->driver)
> +		return -EBUSY;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +	udc->driver =3D driver;
> +	driver->driver.bus =3D NULL;
> +	udc->gadget.dev.driver =3D &driver->driver;
> +	udc->gadget.dev.of_node =3D udc->dev->of_node;
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +
> +	dev_dbg(udc->dev, "bound to %s\n", driver->driver.name);

Ok, you're missing the point of udc_start/udc_stop. The idea was that we
would only initialize the HW when this gets called. Meaning that on
module probe, we pretty much just allocate memory for our use later,
then we udc_start() gets called, we initialize the actual HW. The idea
is that we keep HW turned off until it's actually needed.

> +	return 0;
> +}
> +
> +/**
> + * bcm63xx_udc_stop - Shut down the controller.
> + * @gadget: USB slave device.
> + * @driver: Driver for USB slave devices.
> + */
> +static int bcm63xx_udc_stop(struct usb_gadget *gadget,
> +		struct usb_gadget_driver *driver)
> +{
> +	struct bcm63xx_udc *udc =3D gadget_to_udc(gadget);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&udc->lock, flags);
> +	udc->driver =3D NULL;
> +	udc->gadget.dev.driver =3D NULL;
> +	spin_unlock_irqrestore(&udc->lock, flags);
> +
> +	dev_dbg(udc->dev, "unbound from %s\n", driver->driver.name);

likewise, this should be quiescing the HW. BTW, on both cases, udc-core
will already print debugging messages. You can drop yours.

> +	return 0;
> +}
> +
> +static const struct usb_gadget_ops bcm63xx_udc_ops =3D {
> +	.get_frame	=3D bcm63xx_udc_get_frame,
> +	.pullup		=3D bcm63xx_udc_pullup,
> +	.udc_start	=3D bcm63xx_udc_start,
> +	.udc_stop	=3D bcm63xx_udc_stop,
> +};
> +
> +/***********************************************************************
> + * IRQ handling
> + ***********************************************************************/
> +
> +/**
> + * update_cfg_iface - Read current configuration/interface settings.
> + * @udc: Reference to the device controller.
> + *
> + * This controller intercepts SET_CONFIGURATION and SET_INTERFACE messag=
es.
> + * The driver never sees the raw control packets coming in on the ep0
> + * IUDMA channel, but at least we get an interrupt event to tell us that
> + * new values are waiting in the USBD_STATUS register.
> + */
> +static void update_cfg_iface(struct bcm63xx_udc *udc)
> +{
> +	u32 reg =3D usbd_readl(udc, USBD_STATUS_REG);
> +
> +	udc->cfg =3D (reg & USBD_STATUS_CFG_MASK) >> USBD_STATUS_CFG_SHIFT;
> +	udc->iface =3D (reg & USBD_STATUS_INTF_MASK) >> USBD_STATUS_INTF_SHIFT;
> +	udc->alt_iface =3D (reg & USBD_STATUS_ALTINTF_MASK) >>
> +			 USBD_STATUS_ALTINTF_SHIFT;
> +	ep_setup(udc);
> +}
> +
> +/**
> + * update_link_speed - Check to see if the link speed has changed.
> + * @udc: Reference to the device controller.
> + *
> + * The link speed update coincides with a SETUP IRQ.  Returns 1 if the
> + * speed has changed, so that the caller can update the endpoint setting=
s.
> + */
> +static int update_link_speed(struct bcm63xx_udc *udc)
> +{
> +	u32 reg =3D usbd_readl(udc, USBD_STATUS_REG);
> +	enum usb_device_speed oldspeed =3D udc->gadget.speed;
> +
> +	switch ((reg & USBD_STATUS_SPD_MASK) >> USBD_STATUS_SPD_SHIFT) {
> +	case SPD_HIGH:
> +		udc->gadget.speed =3D USB_SPEED_HIGH;
> +		break;
> +	case SPD_FULL:
> +		udc->gadget.speed =3D USB_SPEED_FULL;
> +		break;
> +	default:
> +		/* this should never happen */
> +		udc->gadget.speed =3D USB_SPEED_UNKNOWN;
> +		dev_err(udc->dev,
> +			"received SETUP packet with invalid link speed\n");
> +		return 0;
> +	}
> +
> +	if (udc->gadget.speed !=3D oldspeed) {
> +		dev_info(udc->dev, "link up, %s-speed mode\n",
> +			 udc->gadget.speed =3D=3D USB_SPEED_HIGH ? "high" : "full");
> +		return 1;
> +	} else {
> +		return 0;
> +	}
> +}
> +
> +/**
> + * update_wedge - Iterate through wedged endpoints.
> + * @udc: Reference to the device controller.
> + * @new_status: true to "refresh" wedge status; false to clear it.
> + *
> + * On a SETUP interrupt, we need to manually "refresh" the wedge status
> + * because the controller hardware is designed to automatically clear
> + * stalls in response to a CLEAR_FEATURE request from the host.
> + *
> + * On a RESET interrupt, we do want to restore all wedged endpoints.
> + */
> +static void update_wedge(struct bcm63xx_udc *udc, bool new_status)
> +{
> +	int i;
> +
> +	for_each_set_bit(i, &udc->wedgemap, NUM_EP) {
> +		set_stall(udc, &udc->bep[i], new_status);
> +		if (!new_status)
> +			clear_bit(i, &udc->wedgemap);
> +	}
> +}
> +
> +/**
> + * bcm63xx_udc_ctrl_isr - ISR for control path events (USBD).
> + * @irq: IRQ number (unused).
> + * @dev_id: Device private data.
> + *
> + * This is where we handle link (VBUS) down, USB reset, speed changes,
> + * SET_CONFIGURATION, and SET_INTERFACE events.
> + */
> +static irqreturn_t bcm63xx_udc_ctrl_isr(int irq, void *dev_id)
> +{
> +	struct bcm63xx_udc *udc =3D dev_id;
> +	u32 stat;
> +	bool disconnected =3D false;
> +
> +	stat =3D usbd_readl(udc, USBD_EVENT_IRQ_STATUS_REG) &
> +	       usbd_readl(udc, USBD_EVENT_IRQ_MASK_REG);
> +
> +	usbd_writel(udc, stat, USBD_EVENT_IRQ_STATUS_REG);
> +
> +	spin_lock(&udc->lock);
> +	if (stat & BIT(USBD_EVENT_IRQ_USB_LINK)) {
> +		/* VBUS toggled */
> +
> +		if (!(usbd_readl(udc, USBD_EVENTS_REG) &
> +		      USBD_EVENTS_USB_LINK_MASK) &&
> +		      udc->gadget.speed !=3D USB_SPEED_UNKNOWN)
> +			dev_info(udc->dev, "link down\n");
> +
> +		udc->gadget.speed =3D USB_SPEED_UNKNOWN;
> +		disconnected =3D true;
> +	}
> +	if (stat & BIT(USBD_EVENT_IRQ_USB_RESET)) {
> +		fifo_setup(udc);
> +		fifo_reset(udc);
> +		ep_setup(udc);
> +
> +		update_wedge(udc, false);
> +
> +		udc->ep0_req_reset =3D 1;
> +		schedule_work(&udc->ep0_wq);
> +		disconnected =3D true;
> +	}
> +	if (stat & BIT(USBD_EVENT_IRQ_SETUP)) {
> +		if (update_link_speed(udc)) {
> +			fifo_setup(udc);
> +			ep_setup(udc);
> +		}
> +		update_wedge(udc, true);
> +	}
> +	if (stat & BIT(USBD_EVENT_IRQ_SETCFG)) {
> +		update_cfg_iface(udc);
> +		udc->ep0_req_set_cfg =3D 1;
> +		schedule_work(&udc->ep0_wq);
> +	}
> +	if (stat & BIT(USBD_EVENT_IRQ_SETINTF)) {
> +		update_cfg_iface(udc);
> +		udc->ep0_req_set_iface =3D 1;
> +		schedule_work(&udc->ep0_wq);

no workqueues, please either handle the IRQ here or use threaded_irqs.

> +	}
> +	spin_unlock(&udc->lock);
> +
> +	if (disconnected && udc->driver)
> +		udc->driver->disconnect(&udc->gadget);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * bcm63xx_udc_data_isr - ISR for data path events (IUDMA).
> + * @irq: IRQ number, used to determine which IUDMA channel the IRQ is fo=
r.
> + * @dev_id: Device private data.
> + *
> + * For the two ep0 channels, we have special handling that triggers the
> + * ep0 worker thread.  For normal bulk/intr channels, either queue up
> + * the next buffer descriptor for the transaction (incomplete transactio=
n),
> + * or invoke the completion callback (complete transactions).
> + */
> +static irqreturn_t bcm63xx_udc_data_isr(int irq, void *dev_id)
> +{
> +	struct bcm63xx_udc *udc =3D dev_id;
> +	struct bcm63xx_ep *bep;
> +	struct iudma_ch *iudma =3D NULL;
> +	struct usb_request *req =3D NULL;
> +	struct bcm63xx_req *breq =3D NULL;
> +	int is_done =3D 0, rc, i;
> +
> +	spin_lock(&udc->lock);
> +
> +	for (i =3D 0; i < NUM_IUDMA; i++)
> +		if (udc->iudma[i].irq =3D=3D irq)
> +			iudma =3D &udc->iudma[i];
> +	BUG_ON(!iudma);
> +
> +	usb_dmac_writel(udc, ENETDMAC_IR_BUFDONE_MASK,
> +			ENETDMAC_IR_REG(iudma->ch_idx));
> +	bep =3D iudma->bep;
> +	rc =3D iudma_read(udc, iudma);
> +
> +	/* special handling for EP0 RX (0) and TX (1) */
> +	if (iudma->ch_idx =3D=3D EP0_RXCHAN || iudma->ch_idx =3D=3D EP0_TXCHAN)=
 {
> +		req =3D udc->ep0_request;
> +		breq =3D our_req(req);
> +
> +		/* a single request could require multiple submissions */
> +		if (rc >=3D 0) {
> +			req->actual +=3D rc;
> +
> +			if (req->actual >=3D req->length || breq->bd_bytes > rc) {
> +				udc->ep0_req_completed =3D 1;
> +				is_done =3D 1;
> +
> +				/* "actual" on a ZLP is 1 byte */
> +				req->actual =3D min(req->actual, req->length);
> +
> +				schedule_work(&udc->ep0_wq);

again, no workqueues.

--=20
balbi

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQMen4AAoJEIaOsuA1yqREkRMP/2cG0gh1AjlJVi7+8syLB67U
bjUyDU8/TO8YhR1V4c80VkxW+UBIVFwY1AMoHd2jwww/RT25vZ58XVjBKGkfmc5k
EepewHUR7kyZ8LZKbomZ8h81+X/HmgWIuZrDTq/SYw3pE20z/cG81oiEbvPsw1lr
yJCr6ES5dSzJjH5Y0qeoZpI3v5xWPxmwrFCpvWiCXrUVDjiF+1GuXLwHZv46v8kb
SDsS6QOshLaPCfUJBW/W0xxNPcILgVZOoDRQIBresgyYlZ2YoN7ffofIxV/U6ngJ
mXLSMlvdPi93oZry3n4KQFfsNbEmsZdPnxfOoK5UhNpnYUPW2LzmquW+GD//BPOF
SY0WP84+vVFa6ZetuMa3nE0zp3ElNNhFuavvFN6tDm1ERXtdC9arAty8PF0Ay8xb
Rf+n9sFqXGptrQJfz9oPapP/QMsCmMVkdhrA1A+pjvjXXJ+A0W8hA/MkVL5cStc6
U2f2WioiE2x34sXM3f8n0aJ2+xc3b8DXJArLEobtXJ8cZ+9HJxJAspFUOxoOu8rP
IwrYjuE9z4u8uXZbu10+CtjM1h70veAC1sOweE6bhWhGRhmvsnDkJyEv7zZTZVrd
OknIFsoa1N0t4X+F57vEmMGpvFUoJ6Bd2ePY1tN2aJLwNFSNVQtcHa5+f99HaJRm
kroeP4G8Cy/+CD0t3Dsv
=QHIM
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--
