Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2012 18:19:29 +0100 (CET)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:51532 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823050Ab2KLRT1zNqNu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2012 18:19:27 +0100
Received: by mail-wg0-f43.google.com with SMTP id dq11so3926969wgb.24
        for <linux-mips@linux-mips.org>; Mon, 12 Nov 2012 09:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AF0J2Uy125djI7iCrVl4B5wKFX/3Hu5JmUnE9s0Y8K4=;
        b=BxLwsGfzTn6ZG++ZLBvp4XpFbkrPUq55aHd4jIrvdQRlbmY7y9iVVVCxSYiXsdqt3S
         1qrHB9pKVfcpFXUfcovJF9MrYY7W7Y060u9k2LZkn/ZreSR/Z5xqWcugTFiMS/fcuWi6
         Fwrw9mon+LNiraXzINrH7W2d4p437K8fhB3PCmWKYhIAw6wAizbYAZAzj7lEAsdOx0C5
         BYF0qySMbtmQDVQjYv2yoY4FNAsOn7R9i6rzfKRWxOkwai9BNB1oasEqTmR47E1JA5Pi
         /0b3f3jh6pjMRzrNKJt39gp3mxQWk0DzvsFhcquhNYDDOf8FSPZLj2/T3KCwua0gcSYC
         dQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=AF0J2Uy125djI7iCrVl4B5wKFX/3Hu5JmUnE9s0Y8K4=;
        b=JknF6yHQ5VXKx3Ftr/s3NnNe/vCOx6FjRVY9hK/Y/t7ElcDWrgrqZMDZhV1/UUn90s
         vexkOLE5/hK48lpUdiuyfXyFom+c/9tmbSD7IUbjS/eKJ2fZyOo6B9fUh+aWAjqtpBS1
         eout6iVokIhabVqaSAySz8E6uEI+Fg8UNwS1VSRhb7+Q/GlZI8J5zTtLIev6YM4ZYGec
         5LP2HFysNav33XJEGKanAJ+b5ijZRxJFOgiG1Zum25jYZmKqVdGZtWxyTaT3LBxCozmb
         fSBBEINoD/duKF4yAYLq+WpzXXmJHxSfb2cqvziJaheluFfojcyELrBvoqfQ5hIJdsYV
         taxA==
Received: by 10.180.106.9 with SMTP id gq9mr16114582wib.12.1352740762412; Mon,
 12 Nov 2012 09:19:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.216.208.139 with HTTP; Mon, 12 Nov 2012 09:19:02 -0800 (PST)
In-Reply-To: <1352709169-3481-7-git-send-email-chenhc@lemote.com>
References: <1352709169-3481-1-git-send-email-chenhc@lemote.com> <1352709169-3481-7-git-send-email-chenhc@lemote.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 12 Nov 2012 10:19:02 -0700
Message-ID: <CAErSpo6R8cbwA-pRVb7_U+BB0ehb=-wi055fpzb060G+XsH-XA@mail.gmail.com>
Subject: Re: [PATCH V8 06/13] MIPS: Loongson 3: Add HT-linked PCI support
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQkWNSHRDIBMGNV9d+5E5nyGVMJJEI5hY03X4OHtDa0mlJ94C9yVDp591xnNLM7aLNFnpxptsVl/M6S9PeGaE0RYVvIENgNX6ESiHJujenIqK6BgJXLRE+ZFHTQ5fEHZBsIAzpJZ8GeFMtoiz9LLbL18CAWIiXXvMDPiSG0u2g05cTxBQs23uPE9LeQzu6YG7dq644zfahhgH1OCOELOlogcOU2iBA==
X-archive-position: 34971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Mon, Nov 12, 2012 at 1:32 AM, Huacai Chen <chenhc@lemote.com> wrote:
> Loongson family machines use Hyper-Transport bus for inter-core
> connection and device connection. The PCI bus is a subordinate
> linked at HT1.
>
> With UEFI-like firmware interface, We don't need fixup for PCI irq
> routing.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> ---
>  arch/mips/include/asm/mach-loongson/loongson.h |    7 ++
>  arch/mips/include/asm/mach-loongson/pci.h      |    5 +
>  arch/mips/pci/Makefile                         |    1 +
>  arch/mips/pci/fixup-loongson3.c                |   64 +++++++++++++++
>  arch/mips/pci/ops-loongson3.c                  |  104 ++++++++++++++++++++++++
>  5 files changed, 181 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/pci/fixup-loongson3.c
>  create mode 100644 arch/mips/pci/ops-loongson3.c
>
> diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
> index 6a1bcf3..960811a 100644
> --- a/arch/mips/include/asm/mach-loongson/loongson.h
> +++ b/arch/mips/include/asm/mach-loongson/loongson.h
> @@ -15,6 +15,7 @@
>  #include <linux/init.h>
>  #include <linux/irq.h>
>  #include <linux/kconfig.h>
> +#include <boot_param.h>
>
>  /* loongson internal northbridge initialization */
>  extern void bonito_irq_init(void);
> @@ -101,7 +102,13 @@ static inline void do_perfcnt_IRQ(void)
>  #define LOONGSON_PCICFG_BASE   0x1fe80000
>  #define LOONGSON_PCICFG_SIZE   0x00000800      /* 2K */
>  #define LOONGSON_PCICFG_TOP    (LOONGSON_PCICFG_BASE+LOONGSON_PCICFG_SIZE-1)
> +
> +#if defined(CONFIG_HT_PCI)
> +#define LOONGSON_PCIIO_BASE    loongson_pciio_base
> +#else
>  #define LOONGSON_PCIIO_BASE    0x1fd00000
> +#endif
> +
>  #define LOONGSON_PCIIO_SIZE    0x00100000      /* 1M */
>  #define LOONGSON_PCIIO_TOP     (LOONGSON_PCIIO_BASE+LOONGSON_PCIIO_SIZE-1)
>
> diff --git a/arch/mips/include/asm/mach-loongson/pci.h b/arch/mips/include/asm/mach-loongson/pci.h
> index bc99dab..1212774 100644
> --- a/arch/mips/include/asm/mach-loongson/pci.h
> +++ b/arch/mips/include/asm/mach-loongson/pci.h
> @@ -40,8 +40,13 @@ extern struct pci_ops loongson_pci_ops;
>  #else  /* loongson2f/32bit & loongson2e */
>
>  /* this pci memory space is mapped by pcimap in pci.c */
> +#ifdef CONFIG_CPU_LOONGSON3
> +#define LOONGSON_PCI_MEM_START 0x40000000UL
> +#define LOONGSON_PCI_MEM_END   0x7effffffUL
> +#else
>  #define LOONGSON_PCI_MEM_START LOONGSON_PCILO1_BASE
>  #define LOONGSON_PCI_MEM_END   (LOONGSON_PCILO1_BASE + 0x04000000 * 2)
> +#endif
>  /* this is an offset from mips_io_port_base */
>  #define LOONGSON_PCI_IO_START  0x00004000UL
>
> diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
> index e13a71c..0723723 100644
> --- a/arch/mips/pci/Makefile
> +++ b/arch/mips/pci/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_MIPS_COBALT)     += fixup-cobalt.o
>  obj-$(CONFIG_SOC_PNX8550)      += fixup-pnx8550.o ops-pnx8550.o
>  obj-$(CONFIG_LEMOTE_FULOONG2E) += fixup-fuloong2e.o ops-loongson2.o
>  obj-$(CONFIG_LEMOTE_MACH2F)    += fixup-lemote2f.o ops-loongson2.o
> +obj-$(CONFIG_LEMOTE_MACH3A)    += fixup-loongson3.o ops-loongson3.o
>  obj-$(CONFIG_MIPS_MALTA)       += fixup-malta.o
>  obj-$(CONFIG_PMC_MSP7120_GW)   += fixup-pmcmsp.o ops-pmcmsp.o
>  obj-$(CONFIG_PMC_MSP7120_EVAL) += fixup-pmcmsp.o ops-pmcmsp.o
> diff --git a/arch/mips/pci/fixup-loongson3.c b/arch/mips/pci/fixup-loongson3.c
> new file mode 100644
> index 0000000..1d4f200
> --- /dev/null
> +++ b/arch/mips/pci/fixup-loongson3.c
> @@ -0,0 +1,64 @@
> +/*
> + * fixup-loongson3.c
> + *
> + * Copyright (C) 2012 Lemote, Inc.
> + * Author: Xiang Yu, xiangy@lemote.com
> + *         Chen Huacai, chenhc@lemote.com
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + * THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + * WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + * NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + * NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + * USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + * ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + * You should have received a copy of the  GNU General Public License along
> + * with this program; if not, write  to the Free Software Foundation, Inc.,
> + * 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +#include <linux/pci.h>
> +#include <boot_param.h>
> +
> +static void print_fixup_info(const struct pci_dev * pdev)
> +{
> +       printk(KERN_INFO "Fixup: bus%d dev%xh fun%xh %x:%x irq %d\n",
> +                       pdev->bus->number, PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
> +                       pdev->vendor, pdev->device, pdev->irq);

I don't know if this printk is necessary, but if it is, it should use
dev_info() rather than simulating it.

> +
> +}
> +
> +int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +       print_fixup_info(dev);
> +       return dev->irq;
> +}
> +
> +static void __devinit pci_fixup_radeon(struct pci_dev *pdev)
> +{
> +       if (pdev->resource[PCI_ROM_RESOURCE].start)
> +               return;
> +
> +       pdev->resource[PCI_ROM_RESOURCE].start  = vgabios_addr;
> +       pdev->resource[PCI_ROM_RESOURCE].end    = vgabios_addr + 256*1024 - 1;
> +       pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_COPY;

Here, on the other hand, we're effectively assigning a PCI dev
resource, and it might be useful to print a message about it, e.g.,

    dev_info(&pdev->dev, "BAR %d: assigned %pR for ATI ROM\n", ...);

> +}
> +
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
> +                               PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_radeon);
> +
> +/* Do platform specific device initialization at pci_enable_device() time */
> +int pcibios_plat_dev_init(struct pci_dev *dev)
> +{
> +       return 0;
> +}
> diff --git a/arch/mips/pci/ops-loongson3.c b/arch/mips/pci/ops-loongson3.c
> new file mode 100644
> index 0000000..b29d333
> --- /dev/null
> +++ b/arch/mips/pci/ops-loongson3.c
> @@ -0,0 +1,104 @@
> +#include <linux/types.h>
> +#include <linux/pci.h>
> +#include <linux/kernel.h>
> +
> +#include <asm/mips-boards/bonito64.h>
> +
> +#include <loongson.h>
> +
> +#define PCI_ACCESS_READ  0
> +#define PCI_ACCESS_WRITE 1
> +
> +#define HT1LO_PCICFG_BASE      0x1a000000
> +#define HT1LO_PCICFG_BASE_TP1  0x1b000000
> +
> +static int loongson3_pci_config_access(unsigned char access_type,
> +               struct pci_bus *bus, unsigned int devfn,
> +               int where, u32 *data)
> +{
> +       unsigned char busnum = bus->number;
> +       u_int64_t addr, type;
> +       void *addrp;
> +       int device = PCI_SLOT(devfn);
> +       int function = PCI_FUNC(devfn);
> +       int reg = where & ~3;
> +
> +       if (busnum == 0) {
> +               if (device > 31)
> +                       return PCIBIOS_DEVICE_NOT_FOUND;
> +               addr = (device << 11) | (function << 8) | reg;
> +           addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE) | (addr & 0xffff));
> +               type = 0;
> +
> +       } else {
> +               addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
> +           addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE_TP1) | (addr));
> +               type = 0x10000;
> +       }
> +
> +       if (access_type == PCI_ACCESS_WRITE)
> +               *(volatile unsigned int *)addrp = cpu_to_le32(*data);
> +       else {
> +               *data = le32_to_cpu(*(volatile unsigned int *)addrp);
> +               if (*data == 0xffffffff) {
> +                       *data = -1;
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +               }
> +       }
> +       return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int loongson3_pci_pcibios_read(struct pci_bus *bus, unsigned int devfn,
> +                                int where, int size, u32 * val)
> +{
> +       u32 data = 0;
> +       int ret = loongson3_pci_config_access(PCI_ACCESS_READ,
> +                       bus, devfn, where, &data);
> +
> +       if (ret != PCIBIOS_SUCCESSFUL)
> +               return ret;
> +
> +       if (size == 1)
> +               *val = (data >> ((where & 3) << 3)) & 0xff;
> +       else if (size == 2)
> +               *val = (data >> ((where & 3) << 3)) & 0xffff;
> +       else
> +               *val = data;
> +
> +       return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int loongson3_pci_pcibios_write(struct pci_bus *bus, unsigned int devfn,
> +                                 int where, int size, u32 val)
> +{
> +       u32 data = 0;
> +       int ret;
> +
> +       if (size == 4)
> +               data = val;
> +       else {
> +               ret = loongson3_pci_config_access(PCI_ACCESS_READ,
> +                               bus, devfn, where, &data);
> +               if (ret != PCIBIOS_SUCCESSFUL)
> +                       return ret;
> +
> +               if (size == 1)
> +                       data = (data & ~(0xff << ((where & 3) << 3))) |
> +                           (val << ((where & 3) << 3));
> +               else if (size == 2)
> +                       data = (data & ~(0xffff << ((where & 3) << 3))) |
> +                           (val << ((where & 3) << 3));
> +       }
> +
> +       ret = loongson3_pci_config_access(PCI_ACCESS_WRITE,
> +                       bus, devfn, where, &data);
> +       if (ret != PCIBIOS_SUCCESSFUL)
> +               return ret;
> +
> +       return PCIBIOS_SUCCESSFUL;
> +}
> +
> +struct pci_ops loongson_pci_ops = {
> +       .read = loongson3_pci_pcibios_read,
> +       .write = loongson3_pci_pcibios_write
> +};
> --
> 1.7.7.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
