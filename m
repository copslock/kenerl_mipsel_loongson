Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Oct 2010 09:23:15 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:50346 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491037Ab0JLHXL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Oct 2010 09:23:11 +0200
Received: by wwe15 with SMTP id 15so3850174wwe.24
        for <multiple recipients>; Tue, 12 Oct 2010 00:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cf/4WkVQP2LaBl+nGiVTWafDTp7QSqIo3XI9kPsTD4s=;
        b=EsMg4QEds2UM/lXxtR45MSnrjpqZ5xSl7nkc/WnSeZkMjMAvtGTq+u/adFWHExEkpt
         daSp42Fyg1t6lCk7OiR8VQaDAu2RgpYGapIKpUi5MbZHrY8igSxJHmJf3W6SsUTmbjtX
         OPF5sXLhBqbLLTOA3ACEHHzIlu/kvJoirrdE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aPRUkMh/7Oi25x6mzOuBzr0SK9IV2DFiGfnXOroqpQp8dIQbdh9+tNhBhhmpqgx9IK
         7xYSvN2CE7BwfRK0cL/YaJASl/Kf+ywxtEhCjuKtGPexktPxmc2znmcdJ1b2HEIEpSUG
         FU7WiDVwC1AtfIiZtqcyDYxAaHjXR3YnABp9w=
MIME-Version: 1.0
Received: by 10.227.147.79 with SMTP id k15mr6517001wbv.128.1286868183727;
 Tue, 12 Oct 2010 00:23:03 -0700 (PDT)
Received: by 10.227.152.7 with HTTP; Tue, 12 Oct 2010 00:23:03 -0700 (PDT)
In-Reply-To: <1286574473-23098-3-git-send-email-ddaney@caviumnetworks.com>
References: <1286574473-23098-1-git-send-email-ddaney@caviumnetworks.com>
        <1286574473-23098-3-git-send-email-ddaney@caviumnetworks.com>
Date:   Tue, 12 Oct 2010 12:53:03 +0530
Message-ID: <AANLkTikLhpsV4kTbeHVT9Yw=viha2q0Pk-nUC6z8vAku@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb: Add EHCI and OHCH glue for OCTEON II SOCs.
From:   Maulik Mankad <mankad.maulik@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org, gregkh@suse.de,
        dbrownell@users.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mankad.maulik@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mankad.maulik@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Sat, Oct 9, 2010 at 3:17 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> The OCTEON II SOC has USB EHCI and OHCI controllers connected directly
> to the internal I/O bus.  This patch adds the necessary 'glue' logic
> to allow ehci-hcd and ohci-hcd drivers to work on OCTEON II.
>
> The OCTEON normally runs big-endian, and the ehci/ohci internal
> registers have host endianness, so we need to select
> USB_EHCI_BIG_ENDIAN_MMIO.
>
> The ehci and ohci blocks share a common clocking and PHY
> infrastructure.  Initialization of the host controller and PHY clocks
> is common between the two and is factored out into the
> octeon2-common.c file.
>
> Setting of USB_ARCH_HAS_OHCI and USB_ARCH_HAS_EHCI is done in
> arch/mips/Kconfig in a following patch.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  drivers/usb/host/Kconfig          |   27 +++++-
>  drivers/usb/host/Makefile         |    1 +
>  drivers/usb/host/ehci-hcd.c       |    5 +
>  drivers/usb/host/ehci-octeon.c    |  207 +++++++++++++++++++++++++++++++++++
>  drivers/usb/host/octeon2-common.c |  185 ++++++++++++++++++++++++++++++++
>  drivers/usb/host/ohci-hcd.c       |    5 +
>  drivers/usb/host/ohci-octeon.c    |  214 +++++++++++++++++++++++++++++++++++++
>  7 files changed, 643 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/usb/host/ehci-octeon.c
>  create mode 100644 drivers/usb/host/octeon2-common.c
>  create mode 100644 drivers/usb/host/ohci-octeon.c
>

It would be good to have EHCI and OHCI support in separate patches.

> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 2d926ce..a03d688 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -93,7 +93,7 @@ config USB_EHCI_TT_NEWSCHED
>
>  config USB_EHCI_BIG_ENDIAN_MMIO
>        bool
> -       depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX || ARCH_IXP4XX || XPS_USB_HCD_XILINX)
> +       depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX || ARCH_IXP4XX || XPS_USB_HCD_XILINX || CPU_CAVIUM_OCTEON)
>        default y
>
>  config USB_EHCI_BIG_ENDIAN_DESC
> @@ -428,3 +428,28 @@ config USB_IMX21_HCD
>          To compile this driver as a module, choose M here: the
>          module will be called "imx21-hcd".
>
> +config USB_OCTEON_EHCI
> +       bool "Octeon on-chip EHCI support"
> +       depends on USB && USB_EHCI_HCD && CPU_CAVIUM_OCTEON
> +       default n
> +       select USB_EHCI_BIG_ENDIAN_MMIO
> +       help
> +         Enable support for the Octeon II SOC's on-chip EHCI
> +         controller.  It is needed for high-speed (480Mbit/sec)
> +         USB 2.0 device support.  All CN6XXX based chips with USB are
> +         supported.
> +
> +config USB_OCTEON_OHCI
> +       bool "Octeon on-chip OHCI support"
> +       depends on USB && USB_OHCI_HCD && CPU_CAVIUM_OCTEON
> +       default USB_OCTEON_EHCI
> +       select USB_OHCI_BIG_ENDIAN_MMIO
> +       select USB_OHCI_LITTLE_ENDIAN
> +       help
> +         Enable support for the Octeon II SOC's on-chip OHCI
> +         controller.  It is needed for low-speed USB 1.0 device
> +         support.  All CN6XXX based chips with USB are supported.
> +
> +config USB_OCTEON2_COMMON
> +       bool
> +       default y if USB_OCTEON_EHCI || USB_OCTEON_OHCI
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index b6315aa..36099ce 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -33,4 +33,5 @@ obj-$(CONFIG_USB_R8A66597_HCD)        += r8a66597-hcd.o
>  obj-$(CONFIG_USB_ISP1760_HCD)  += isp1760.o
>  obj-$(CONFIG_USB_HWA_HCD)      += hwa-hc.o
>  obj-$(CONFIG_USB_IMX21_HCD)    += imx21-hcd.o
> +obj-$(CONFIG_USB_OCTEON2_COMMON) += octeon2-common.o
>
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 34a928d..158a520 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -1197,6 +1197,11 @@ MODULE_LICENSE ("GPL");
>  #define        PLATFORM_DRIVER         ehci_atmel_driver
>  #endif
>
> +#ifdef CONFIG_USB_OCTEON_EHCI
> +#include "ehci-octeon.c"
> +#define PLATFORM_DRIVER                ehci_octeon_driver
> +#endif
> +
>  #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER) && \
>     !defined(PS3_SYSTEM_BUS_DRIVER) && !defined(OF_PLATFORM_DRIVER) && \
>     !defined(XILINX_OF_PLATFORM_DRIVER)
> diff --git a/drivers/usb/host/ehci-octeon.c b/drivers/usb/host/ehci-octeon.c
> new file mode 100644
> index 0000000..a31a031
> --- /dev/null
> +++ b/drivers/usb/host/ehci-octeon.c
> @@ -0,0 +1,207 @@
> +/*
> + * EHCI HCD glue for Cavium Octeon II SOCs.
> + *
> + * Loosely based on ehci-au1xxx.c
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2010 Cavium Networks
> + *
> + */
> +
> +#include <linux/platform_device.h>
> +
> +#include <asm/octeon/octeon.h>
> +#include <asm/octeon/cvmx-uctlx-defs.h>
> +
> +#define OCTEON_EHCI_HCD_NAME "octeon-ehci"
> +
> +/* Common clock init code.  */
> +void octeon2_usb_clocks_start(void);
> +void octeon2_usb_clocks_stop(void);
> +
> +static void ehci_octeon_start(void)
> +{
> +       union cvmx_uctlx_ehci_ctl ehci_ctl;
> +
> +       octeon2_usb_clocks_start();
> +
> +       ehci_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_EHCI_CTL(0));
> +       /* Use 64-bit addressing. */
> +       ehci_ctl.s.ehci_64b_addr_en = 1;
> +       ehci_ctl.s.l2c_addr_msb = 0;
> +       ehci_ctl.s.l2c_buff_emod = 1; /* Byte swapped. */
> +       ehci_ctl.s.l2c_desc_emod = 1; /* Byte swapped. */
> +       cvmx_write_csr(CVMX_UCTLX_EHCI_CTL(0), ehci_ctl.u64);
> +}
> +
> +static void ehci_octeon_stop(void)
> +{
> +       octeon2_usb_clocks_stop();
> +}
> +
> +static const struct hc_driver ehci_octeon_hc_driver = {
> +       .description            = hcd_name,
> +       .product_desc           = "Octeon EHCI",
> +       .hcd_priv_size          = sizeof(struct ehci_hcd),
> +
> +       /*
> +        * generic hardware linkage
> +        */
> +       .irq                    = ehci_irq,
> +       .flags                  = HCD_MEMORY | HCD_USB2,
> +
> +       /*
> +        * basic lifecycle operations
> +        */
> +       .reset                  = ehci_init,
> +       .start                  = ehci_run,
> +       .stop                   = ehci_stop,
> +       .shutdown               = ehci_shutdown,
> +
> +       /*
> +        * managing i/o requests and associated device resources
> +        */
> +       .urb_enqueue            = ehci_urb_enqueue,
> +       .urb_dequeue            = ehci_urb_dequeue,
> +       .endpoint_disable       = ehci_endpoint_disable,
> +       .endpoint_reset         = ehci_endpoint_reset,
> +
> +       /*
> +        * scheduling support
> +        */
> +       .get_frame_number       = ehci_get_frame,
> +
> +       /*
> +        * root hub support
> +        */
> +       .hub_status_data        = ehci_hub_status_data,
> +       .hub_control            = ehci_hub_control,
> +       .bus_suspend            = ehci_bus_suspend,
> +       .bus_resume             = ehci_bus_resume,
> +       .relinquish_port        = ehci_relinquish_port,
> +       .port_handed_over       = ehci_port_handed_over,
> +
> +       .clear_tt_buffer_complete       = ehci_clear_tt_buffer_complete,
> +};
> +
> +static u64 ehci_octeon_dma_mask = DMA_BIT_MASK(64);
> +
> +static int ehci_octeon_drv_probe(struct platform_device *pdev)
> +{
> +       struct usb_hcd *hcd;
> +       struct ehci_hcd *ehci;
> +       struct resource *res_mem;
> +       int irq;
> +       int ret;
> +
> +       if (usb_disabled())
> +               return -ENODEV;
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(&pdev->dev, "No irq assigned\n");
> +               return -ENODEV;
> +       }
> +
> +       res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (res_mem == NULL) {
> +               dev_err(&pdev->dev, "No register space assigned\n");
> +               return -ENODEV;
> +       }
> +
> +       /*
> +        * We can DMA from anywhere. But the descriptors must be in
> +        * the lower 4GB.
> +        */
> +       pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +       pdev->dev.dma_mask = &ehci_octeon_dma_mask;
> +
> +       hcd = usb_create_hcd(&ehci_octeon_hc_driver, &pdev->dev, "octeon");
> +       if (!hcd)
> +               return -ENOMEM;
> +
> +       hcd->rsrc_start = res_mem->start;
> +       hcd->rsrc_len = res_mem->end - res_mem->start + 1;

You can use resource_size() to compute the length of the resource.

> +
> +       if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len,
> +                               OCTEON_EHCI_HCD_NAME)) {
> +               dev_err(&pdev->dev, "request_mem_region failed\n");
> +               ret = -EBUSY;
> +               goto err1;
> +       }
> +
> +       hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
> +       if (!hcd->regs) {
> +               dev_err(&pdev->dev, "ioremap failed\n");
> +               ret = -ENOMEM;
> +               goto err2;
> +       }
> +
> +       ehci_octeon_start();
> +
> +       ehci = hcd_to_ehci(hcd);
> +
> +       /* Octeon EHCI matches CPU endianness. */
> +#ifdef __BIG_ENDIAN
> +       ehci->big_endian_mmio = 1;
> +#endif
> +
> +       ehci->caps = hcd->regs;
> +       ehci->regs = hcd->regs +
> +               HC_LENGTH(ehci_readl(ehci, &ehci->caps->hc_capbase));
> +       /* cache this readonly data; minimize chip reads */
> +       ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
> +
> +       ret = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
> +       if (ret) {
> +               dev_dbg(&pdev->dev, "failed to add hcd with err %d\n", ret);
> +               goto err3;
> +       }
> +
> +       platform_set_drvdata(pdev, hcd);
> +
> +       /* root ports should always stay powered */
> +       ehci_port_power(ehci, 1);
> +
> +       return 0;
> +err3:
> +       ehci_octeon_stop();
> +
> +       iounmap(hcd->regs);
> +err2:
> +       release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
> +err1:
> +       usb_put_hcd(hcd);
> +       return ret;
> +}

[...]

> +static int ohci_octeon_drv_probe(struct platform_device *pdev)
> +{
> +       struct usb_hcd *hcd;
> +       struct ohci_hcd *ohci;
> +       void *reg_base;
> +       struct resource *res_mem;
> +       int irq;
> +       int ret;
> +
> +       if (usb_disabled())
> +               return -ENODEV;
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(&pdev->dev, "No irq assigned\n");
> +               return -ENODEV;
> +       }
> +
> +       res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (res_mem == NULL) {
> +               dev_err(&pdev->dev, "No register space assigned\n");
> +               return -ENODEV;
> +       }
> +
> +       /* Ohci is a 32-bit device. */
> +       pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +       pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> +
> +       hcd = usb_create_hcd(&ohci_octeon_hc_driver, &pdev->dev, "octeon");
> +       if (!hcd)
> +               return -ENOMEM;
> +
> +       hcd->rsrc_start = res_mem->start;
> +       hcd->rsrc_len = res_mem->end - res_mem->start + 1;
> +

Same here.

> +       if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len,
> +                               OCTEON_OHCI_HCD_NAME)) {
> +               dev_err(&pdev->dev, "request_mem_region failed\n");
> +               ret = -EBUSY;
> +               goto err1;
> +       }
> +
> +       reg_base = ioremap(hcd->rsrc_start, hcd->rsrc_len);
> +       if (!reg_base) {
> +               dev_err(&pdev->dev, "ioremap failed\n");
> +               ret = -ENOMEM;
> +               goto err2;
> +       }
> +
> +       ohci_octeon_hw_start();
> +
> +       hcd->regs = reg_base;
> +
> +       ohci = hcd_to_ohci(hcd);
> +
> +       /* Octeon OHCI matches CPU endianness. */
> +#ifdef __BIG_ENDIAN
> +       ohci->flags |= OHCI_QUIRK_BE_MMIO;
> +#endif
> +
> +       ohci_hcd_init(ohci);
> +
> +       ret = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
> +       if (ret) {
> +               dev_dbg(&pdev->dev, "failed to add hcd with err %d\n", ret);
> +               goto err3;
> +       }
> +
> +       platform_set_drvdata(pdev, hcd);
> +
> +       return 0;
> +
> +err3:
> +       ohci_octeon_hw_stop();
> +
> +       iounmap(hcd->regs);
> +err2:
> +       release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
> +err1:
> +       usb_put_hcd(hcd);
> +       return ret;
> +}
> +

Regards,
Maulik
