Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Dec 2017 00:54:13 +0100 (CET)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:42765
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990718AbdLMXyBXubr9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Dec 2017 00:54:01 +0100
Received: by mail-it0-x242.google.com with SMTP id p139so7234342itb.1;
        Wed, 13 Dec 2017 15:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VkSG/yOmZPbnffz6rNawXSBKT7KuJ/9di+39WVCGPQM=;
        b=eN8wEKKX3NPrJ0YnzovocIvP5I+1hYYJTYIBxsPNnhcfvxFhb/6cInv1o8QRqs2uVR
         2tBsfTi3aVv5Y3aZqsHQJd0w70DF27YzqvhUr9tcOlCKdxiFmV98rlikuDOtWijB5Sgi
         KBtIu276rCw16UtFVIuNybmDq6xUB6HlLDNmsMUedOHnyKcutX7wHDMxElFojPJPIE34
         xzCqpMsG7Pl9EIZlOI7UMgxffWwW8bjP343Lx7XcR0UXlSn0v91Coqs3/VYux+nhUaaZ
         23mmLVUxvSzSENjaFJvEFsNK9Jfu9hApeJn7jB3xl3ERYWD58HKq1QfBx8AF9SdA360t
         z6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VkSG/yOmZPbnffz6rNawXSBKT7KuJ/9di+39WVCGPQM=;
        b=nesX/DPTLZOgkHwpj+8mY34GtFJ8xk9AtzyoL2/nH0TZMHTQ7hxtu/JjQ7Sasd1sKx
         jSUFfHzZy6kTzxXBA3xZkWXnvnEE4qRR6mhZ1bjRyUbX/Deh+TR0+R9qrxmDMyf4NiCr
         a2LeMPEYWlc1Y9fAXjidLUk1u9PcYIlGXk19LStl8/xaS6O1UbHMqbkBH8lWZF4y1Zvb
         xWsF1y8ltn/eqMjhbNhsmL9rPiHwp3swC9HxG63lDBQrxicBUJeFnAfaSNNlhpQhiML9
         xCXXYxXEJn8yhTjix3+Vd2WfyTfdoEioHxTJV5wks3XMtRDTJOD9QPa+uyksoUU9te3v
         5Qlg==
X-Gm-Message-State: AKGB3mJxIjjBTo2TcclL248RiiaIEgZOgcuKQ9ybh6IZSuOe2a35hSwC
        Y1UlxT3LXboXfy1WXhVecrIo7x/lhAnRAK3SIJo=
X-Google-Smtp-Source: ACJfBoszcaKucwGeDOkBuRG4c50JUhWWv2FZstUpzUKMA7jPkUrEZ+BQzwkBgghCGZBHpLxniXj9nZihOokiTFSt2PE=
X-Received: by 10.36.227.3 with SMTP id d3mr982038ith.47.1513209233969; Wed,
 13 Dec 2017 15:53:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.43.6 with HTTP; Wed, 13 Dec 2017 15:53:53 -0800 (PST)
In-Reply-To: <20171212221642.GB95453@bhelgaas-glaptop.roam.corp.google.com>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
 <1510697532-32828-4-git-send-email-jim2101024@gmail.com> <20171212221642.GB95453@bhelgaas-glaptop.roam.corp.google.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Wed, 13 Dec 2017 18:53:53 -0500
Message-ID: <CANCKTBvtqNWZYXpLdUnEWwA2=14XhJ6adR5muOAYubY_1SxZWw@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] PCI: brcmstb: Add Broadcom STB PCIe host
 controller driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

On Tue, Dec 12, 2017 at 5:16 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Nov 14, 2017 at 05:12:07PM -0500, Jim Quinlan wrote:
>> This commit adds the basic Broadcom STB PCIe controller.  Missing is
>> the ability to process MSI and also handle dma-ranges for inbound
>> memory accesses.  These two functionalities are added in subsequent
>> commits.
>>
>> The PCIe block contains an MDIO interface.  This is a local interface
>> only accessible by the PCIe controller.  It cannot be used or shared
>> by any other HW.  As such, the small amount of code for this
>> controller is included in this driver as there is little upside to put
>> it elsewhere.
>>
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> ---
>>  drivers/pci/host/Kconfig        |    9 +
>>  drivers/pci/host/Makefile       |    1 +
>>  drivers/pci/host/pcie-brcmstb.c | 1124 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 1134 insertions(+)
>>  create mode 100644 drivers/pci/host/pcie-brcmstb.c
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index b868803..751463e 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -220,4 +220,13 @@ config VMD
>>         To compile this driver as a module, choose M here: the
>>         module will be called vmd.
>>
>> +config PCIE_BRCMSTB
>> +     tristate "Broadcom Brcmstb PCIe platform host driver"
>> +     depends on ARCH_BRCMSTB || BMIPS_GENERIC
>> +     depends on OF
>> +     depends on SOC_BRCMSTB
>> +     default ARCH_BRCMSTB || BMIPS_GENERIC
>> +     help
>> +       Adds support for Broadcom Settop Box PCIe host controller.
>> +
>>  endmenu
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> index 1238278..a8b9923 100644
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> @@ -21,6 +21,7 @@ obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
>>  obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
>>  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
>>  obj-$(CONFIG_VMD) += vmd.o
>> +obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
>>
>>  # The following drivers are for devices that use the generic ACPI
>>  # pci_root.c driver but don't support standard ECAM config access.
>> diff --git a/drivers/pci/host/pcie-brcmstb.c b/drivers/pci/host/pcie-brcmstb.c
>> new file mode 100644
>> index 0000000..d8a8f7a
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-brcmstb.c
>> @@ -0,0 +1,1124 @@
>> +/*
>> + * Copyright (C) 2009 - 2017 Broadcom
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/compiler.h>
>> +#include <linux/delay.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/ioport.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/log2.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_pci.h>
>> +#include <linux/of_pci.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/pci.h>
>> +#include <linux/printk.h>
>> +#include <linux/sizes.h>
>> +#include <linux/slab.h>
>> +#include <soc/brcmstb/memory_api.h>
>> +#include <linux/string.h>
>> +#include <linux/types.h>
>> +
>> +/* BRCM_PCIE_CAP_REGS - Offset for the mandatory capability config regs */
>> +#define BRCM_PCIE_CAP_REGS                           0x00ac
>
> Add a blank line before multi-line comments.
>
>> +/*
>> + * Broadcom Settop Box PCIE Register Offsets. The names are from
>> + * the chip's RDB and we use them here so that a script can correlate
>> + * this code and the RDB to prevent discrepancies.
>
> Use "PCIe" capitalization in English text and messages.
>
>> + */
>> +#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1              0x0188
>> +#define PCIE_RC_CFG_PRIV1_ID_VAL3                    0x043c
>> +#define PCIE_RC_DL_MDIO_ADDR                         0x1100
>> +#define PCIE_RC_DL_MDIO_WR_DATA                              0x1104
>> +#define PCIE_RC_DL_MDIO_RD_DATA                              0x1108
>> +#define PCIE_MISC_MISC_CTRL                          0x4008
>> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO             0x400c
>> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI             0x4010
>> +#define PCIE_MISC_RC_BAR1_CONFIG_LO                  0x402c
>> +#define PCIE_MISC_RC_BAR2_CONFIG_LO                  0x4034
>> +#define PCIE_MISC_RC_BAR2_CONFIG_HI                  0x4038
>> +#define PCIE_MISC_RC_BAR3_CONFIG_LO                  0x403c
>> +#define PCIE_MISC_PCIE_CTRL                          0x4064
>> +#define PCIE_MISC_PCIE_STATUS                                0x4068
>> +#define PCIE_MISC_REVISION                           0x406c
>> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT     0x4070
>> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI                0x4080
>> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI               0x4084
>> +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG                       0x4204
>> +#define PCIE_INTR2_CPU_BASE                          0x4300
>> +
>> +/*
>> + * Broadcom Settop Box PCIE Register Field shift and mask info. The
>> + * names are from the chip's RDB and we use them here so that a script
>> + * can correlate this code and the RDB to prevent discrepancies.
>> + */
>> +#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK        0xc
>> +#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_SHIFT       0x2
>> +#define PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK            0xffffff
>> +#define PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_SHIFT           0x0
>> +#define PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK                       0x1000
>> +#define PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_SHIFT                      0xc
>> +#define PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK            0x2000
>> +#define PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_SHIFT           0xd
>> +#define PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK                      0x300000
>> +#define PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_SHIFT             0x14
>> +#define PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK                   0xf8000000
>> +#define PCIE_MISC_MISC_CTRL_SCB0_SIZE_SHIFT                  0x1b
>> +#define PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK                   0x7c00000
>> +#define PCIE_MISC_MISC_CTRL_SCB1_SIZE_SHIFT                  0x16
>> +#define PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK                   0x1f
>> +#define PCIE_MISC_MISC_CTRL_SCB2_SIZE_SHIFT                  0x0
>> +#define PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK                        0x1f
>> +#define PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_SHIFT                       0x0
>> +#define PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK                        0x1f
>> +#define PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_SHIFT                       0x0
>> +#define PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK                        0x1f
>> +#define PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_SHIFT                       0x0
>> +#define PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK                 0x4
>> +#define PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_SHIFT                        0x2
>> +#define PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_MASK            0x1
>> +#define PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_SHIFT           0x0
>> +#define PCIE_MISC_PCIE_STATUS_PCIE_PORT_MASK                 0x80
>> +#define PCIE_MISC_PCIE_STATUS_PCIE_PORT_SHIFT                        0x7
>> +#define PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK            0x20
>> +#define PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_SHIFT           0x5
>> +#define PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK            0x10
>> +#define PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_SHIFT           0x4
>> +#define PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_MASK          0x40
>> +#define PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_SHIFT         0x6
>> +#define PCIE_MISC_REVISION_MAJMIN_MASK                               0xffff
>> +#define PCIE_MISC_REVISION_MAJMIN_SHIFT                              0
>> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK  0xfff00000
>> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_SHIFT 0x14
>> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_MASK   0xfff0
>> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_SHIFT  0x4
>> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_NUM_MASK_BITS       0xc
>> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI_BASE_MASK              0xff
>> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI_BASE_SHIFT     0x0
>> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI_LIMIT_MASK    0xff
>> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI_LIMIT_SHIFT   0x0
>> +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK      0x2
>> +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_SHIFT 0x1
>> +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK              0x08000000
>> +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_SHIFT     0x1b
>> +#define PCIE_RGR1_SW_INIT_1_PERST_MASK                               0x1
>> +#define PCIE_RGR1_SW_INIT_1_PERST_SHIFT                              0x0
>> +
>> +#define BRCM_NUM_PCIE_OUT_WINS               0x4
>> +#define BRCM_MAX_SCB                 0x4
>> +
>> +#define BRCM_MSI_TARGET_ADDR_LT_4GB  0x0fffffffcULL
>> +#define BRCM_MSI_TARGET_ADDR_GT_4GB  0xffffffffcULL
>> +
>> +#define BURST_SIZE_128                       0
>> +#define BURST_SIZE_256                       1
>> +#define BURST_SIZE_512                       2
>> +
>> +/* Offsets from PCIE_INTR2_CPU_BASE */
>> +#define STATUS                               0x0
>> +#define SET                          0x4
>> +#define CLR                          0x8
>> +#define MASK_STATUS                  0xc
>> +#define MASK_SET                     0x10
>> +#define MASK_CLR                     0x14
>> +
>> +#define PCIE_BUSNUM_SHIFT            20
>> +#define PCIE_SLOT_SHIFT                      15
>> +#define PCIE_FUNC_SHIFT                      12
>> +
>> +#if defined(__BIG_ENDIAN)
>> +#define      DATA_ENDIAN             2       /* PCIe->DDR inbound accesses */
>> +#define MMIO_ENDIAN          2       /* CPU->PCIe outbound accesses */
>> +#else
>> +#define      DATA_ENDIAN             0
>> +#define MMIO_ENDIAN          0
>> +#endif
>> +
>> +#define MDIO_PORT0           0x0
>> +#define MDIO_DATA_MASK               0x7fffffff
>> +#define MDIO_DATA_SHIFT              0x0
>> +#define MDIO_PORT_MASK               0xf0000
>> +#define MDIO_PORT_SHIFT              0x16
>> +#define MDIO_REGAD_MASK              0xffff
>> +#define MDIO_REGAD_SHIFT     0x0
>> +#define MDIO_CMD_MASK                0xfff00000
>> +#define MDIO_CMD_SHIFT               0x14
>> +#define MDIO_CMD_READ                0x1
>> +#define MDIO_CMD_WRITE               0x0
>> +#define MDIO_DATA_DONE_MASK  0x80000000
>> +#define MDIO_RD_DONE(x)              (((x) & MDIO_DATA_DONE_MASK) ? 1 : 0)
>> +#define MDIO_WT_DONE(x)              (((x) & MDIO_DATA_DONE_MASK) ? 0 : 1)
>> +#define SSC_REGS_ADDR                0x1100
>> +#define SET_ADDR_OFFSET              0x1f
>> +#define SSC_CNTL_OFFSET              0x2
>> +#define SSC_CNTL_OVRD_EN_MASK        0x8000
>> +#define SSC_CNTL_OVRD_EN_SHIFT       0xf
>> +#define SSC_CNTL_OVRD_VAL_MASK       0x4000
>> +#define SSC_CNTL_OVRD_VAL_SHIFT      0xe
>> +#define SSC_STATUS_OFFSET    0x1
>> +#define SSC_STATUS_SSC_MASK  0x400
>> +#define SSC_STATUS_SSC_SHIFT 0xa
>> +#define SSC_STATUS_PLL_LOCK_MASK     0x800
>> +#define SSC_STATUS_PLL_LOCK_SHIFT    0xb
>> +
>> +#define IDX_ADDR(pcie)       \
>> +     ((pcie)->reg_offsets[EXT_CFG_INDEX])
>> +#define DATA_ADDR(pcie)      \
>> +     ((pcie)->reg_offsets[EXT_CFG_DATA])
>> +#define PCIE_RGR1_SW_INIT_1(pcie) \
>> +     ((pcie)->reg_offsets[RGR1_SW_INIT_1])
>> +
>> +enum {
>> +     RGR1_SW_INIT_1,
>> +     EXT_CFG_INDEX,
>> +     EXT_CFG_DATA,
>> +};
>> +
>> +enum {
>> +     RGR1_SW_INIT_1_INIT_MASK,
>> +     RGR1_SW_INIT_1_INIT_SHIFT,
>> +     RGR1_SW_INIT_1_PERST_MASK,
>> +     RGR1_SW_INIT_1_PERST_SHIFT,
>> +};
>> +
>> +enum pcie_type {
>> +     BCM7425,
>> +     BCM7435,
>> +     GENERIC,
>> +     BCM7278,
>> +};
>> +
>> +struct brcm_window {
>> +     dma_addr_t pcie_addr;
>> +     phys_addr_t cpu_addr;
>> +     dma_addr_t size;
>> +};
>> +
>> +/* Internal PCIe Host Controller Information.*/
>> +struct brcm_pcie {
>> +     struct list_head        list;
>> +     struct device           *dev;
>> +     void __iomem            *base;
>> +     struct list_head        resources;
>> +     int                     irq;
>> +     struct clk              *clk;
>> +     struct pci_bus          *root_bus;
>> +     struct device_node      *dn;
>> +     int                     id;
>> +     bool                    suspended;
>> +     int                     num_out_wins;
>> +     bool                    ssc;
>> +     int                     gen;
>> +     struct brcm_window      out_wins[BRCM_NUM_PCIE_OUT_WINS];
>> +     unsigned int            rev;
>> +     const int               *reg_offsets;
>> +     const int               *reg_field_info;
>> +     enum pcie_type          type;
>> +};
>> +
>> +struct pcie_cfg_data {
>> +     const int *reg_field_info;
>> +     const int *offsets;
>> +     const enum pcie_type type;
>> +};
>> +
>> +static const int pcie_reg_field_info[] = {
>> +     [RGR1_SW_INIT_1_INIT_MASK] = 0x2,
>> +     [RGR1_SW_INIT_1_INIT_SHIFT] = 0x1,
>> +};
>> +
>> +static const int pcie_reg_field_info_bcm7278[] = {
>> +     [RGR1_SW_INIT_1_INIT_MASK] = 0x1,
>> +     [RGR1_SW_INIT_1_INIT_SHIFT] = 0x0,
>> +};
>> +
>> +static const int pcie_offset_bcm7425[] = {
>> +     [RGR1_SW_INIT_1] = 0x8010,
>> +     [EXT_CFG_INDEX]  = 0x8300,
>> +     [EXT_CFG_DATA]   = 0x8304,
>> +};
>> +
>> +static const struct pcie_cfg_data bcm7425_cfg = {
>> +     .reg_field_info = pcie_reg_field_info,
>> +     .offsets        = pcie_offset_bcm7425,
>> +     .type           = BCM7425,
>> +};
>> +
>> +static const int pcie_offsets[] = {
>> +     [RGR1_SW_INIT_1] = 0x9210,
>> +     [EXT_CFG_INDEX]  = 0x9000,
>> +     [EXT_CFG_DATA]   = 0x9004,
>> +};
>> +
>> +static const struct pcie_cfg_data bcm7435_cfg = {
>> +     .reg_field_info = pcie_reg_field_info,
>> +     .offsets        = pcie_offsets,
>> +     .type           = BCM7435,
>> +};
>> +
>> +static const struct pcie_cfg_data generic_cfg = {
>> +     .reg_field_info = pcie_reg_field_info,
>> +     .offsets        = pcie_offsets,
>> +     .type           = GENERIC,
>> +};
>> +
>> +static const int pcie_offset_bcm7278[] = {
>> +     [RGR1_SW_INIT_1] = 0xc010,
>> +     [EXT_CFG_INDEX] = 0x9000,
>> +     [EXT_CFG_DATA] = 0x9004,
>> +};
>> +
>> +static const struct pcie_cfg_data bcm7278_cfg = {
>> +     .reg_field_info = pcie_reg_field_info_bcm7278,
>> +     .offsets        = pcie_offset_bcm7278,
>> +     .type           = BCM7278,
>> +};
>> +
>> +static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
>> +                                     int where);
>> +
>> +static struct pci_ops brcm_pcie_ops = {
>> +     .map_bus = brcm_pcie_map_conf,
>> +     .read = pci_generic_config_read,
>> +     .write = pci_generic_config_write,
>> +};
>> +
>> +#if defined(CONFIG_MIPS)
>> +/* Broadcom MIPs HW implicitly does the swapping if necessary */
>> +#define bcm_readl(a)         __raw_readl(a)
>> +#define bcm_writel(d, a)     __raw_writel(d, a)
>> +#define bcm_readw(a)         __raw_readw(a)
>> +#define bcm_writew(d, a)     __raw_writew(d, a)
>> +#else
>> +#define bcm_readl(a)         readl(a)
>> +#define bcm_writel(d, a)     writel(d, a)
>> +#define bcm_readw(a)         readw(a)
>> +#define bcm_writew(d, a)     writew(d, a)
>> +#endif
>> +
>> +/*
>> + * These macros are designed to sxtract/insert fields to host controller's
>> + * register set.
>
> s/are designed to s/ e/  (I assume they actually *do* extract/insert)
>
>> + */
>> +#define RD_FLD(base, reg, field) \
>> +     rd_fld(base + reg, reg##_##field##_MASK, reg##_##field##_SHIFT)
>> +#define WR_FLD(base, reg, field, val) \
>> +     wr_fld(base + reg, reg##_##field##_MASK, reg##_##field##_SHIFT, val)
>> +#define WR_FLD_RB(base, reg, field, val) \
>> +     wr_fld_rb(base + reg, reg##_##field##_MASK, reg##_##field##_SHIFT, val)
>> +#define WR_FLD_WITH_OFFSET(base, off, reg, field, val) \
>> +     wr_fld(base + reg + off, reg##_##field##_MASK, \
>> +            reg##_##field##_SHIFT, val)
>> +#define EXTRACT_FIELD(val, reg, field) \
>> +     ((val & reg##_##field##_MASK) >> reg##_##field##_SHIFT)
>> +#define INSERT_FIELD(val, reg, field, field_val) \
>> +     ((val & ~reg##_##field##_MASK) | \
>> +      (reg##_##field##_MASK & (field_val << reg##_##field##_SHIFT)))
>> +
>> +static struct list_head brcm_pcie = LIST_HEAD_INIT(brcm_pcie);
>> +static phys_addr_t scb_size[BRCM_MAX_SCB];
>> +static int num_memc;
>> +static DEFINE_MUTEX(brcm_pcie_lock);
>> +
>> +static u32 rd_fld(void __iomem *p, u32 mask, int shift)
>> +{
>> +     return (bcm_readl(p) & mask) >> shift;
>> +}
>> +
>> +static void wr_fld(void __iomem *p, u32 mask, int shift, u32 val)
>> +{
>> +     u32 reg = bcm_readl(p);
>> +
>> +     reg = (reg & ~mask) | ((val << shift) & mask);
>> +     bcm_writel(reg, p);
>> +}
>> +
>> +static void wr_fld_rb(void __iomem *p, u32 mask, int shift, u32 val)
>> +{
>> +     wr_fld(p, mask, shift, val);
>> +     (void)bcm_readl(p);
>> +}
>> +
>> +static const char *link_speed_to_str(int s)
>> +{
>> +     switch (s) {
>> +     case 1:
>> +             return "2.5";
>> +     case 2:
>> +             return "5.0";
>> +     case 3:
>> +             return "8.0";
>> +     default:
>> +             break;
>> +     }
>> +     return "???";
>> +}
>> +
>> +/*
>> + * The roundup_pow_of_two() from log2.h invokes
>> + * __roundup_pow_of_two(unsigned long), but we really need a
>> + * such a function to take a native u64 since unsigned long
>> + * is 32 bits on some configurations.  So we provide this helper
>> + * function below.
>> + */
>> +static u64 roundup_pow_of_two_64(u64 n)
>> +{
>> +     return 1ULL << fls64(n - 1);
>> +}
>> +
>> +/*
>> + * This is to convert the size of the inbound bar region to the
>> + * non-liniear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
>
> s/bar/BAR/  (This doesn't sound like a BAR in the PCI spec sense, but if
> that's what you call it, might as well spell it as the acronym)
>
> s/non-liniear/non-linear/
>
>> + */
>> +int encode_ibar_size(u64 size)
>> +{
>> +     int log2_in = ilog2(size);
>> +
>> +     if (log2_in >= 12 && log2_in <= 15)
>> +             /* Covers 4KB to 32KB (inclusive) */
>> +             return (log2_in - 12) + 0x1c;
>> +     else if (log2_in >= 16 && log2_in <= 37)
>> +             /* Covers 64KB to 32GB, (inclusive) */
>> +             return log2_in - 15;
>> +     /* Something is awry so disable */
>> +     return 0;
>> +}
>> +
>> +static u32 mdio_form_pkt(int port, int regad, int cmd)
>> +{
>> +     u32 pkt = 0;
>> +
>> +     pkt |= (port << MDIO_PORT_SHIFT) & MDIO_PORT_MASK;
>> +     pkt |= (regad << MDIO_REGAD_SHIFT) & MDIO_REGAD_MASK;
>> +     pkt |= (cmd << MDIO_CMD_SHIFT) & MDIO_CMD_MASK;
>> +
>> +     return pkt;
>> +}
>> +
>> +/* negative return value indicates error */
>> +static int mdio_read(void __iomem *base, u8 port, u8 regad)
>> +{
>> +     int tries;
>> +     u32 data;
>> +
>> +     bcm_writel(mdio_form_pkt(port, regad, MDIO_CMD_READ),
>> +                base + PCIE_RC_DL_MDIO_ADDR);
>> +     bcm_readl(base + PCIE_RC_DL_MDIO_ADDR);
>> +
>> +     data = bcm_readl(base + PCIE_RC_DL_MDIO_RD_DATA);
>> +     for (tries = 0; !MDIO_RD_DONE(data) && tries < 10; tries++) {
>> +             udelay(10);
>> +             data = bcm_readl(base + PCIE_RC_DL_MDIO_RD_DATA);
>> +     }
>> +
>> +     return MDIO_RD_DONE(data)
>> +             ? (data & MDIO_DATA_MASK) >> MDIO_DATA_SHIFT
>> +             : -EIO;
>> +}
>> +
>> +/* negative return value indicates error */
>> +static int mdio_write(void __iomem *base, u8 port, u8 regad, u16 wrdata)
>> +{
>> +     int tries;
>> +     u32 data;
>> +
>> +     bcm_writel(mdio_form_pkt(port, regad, MDIO_CMD_WRITE),
>> +                base + PCIE_RC_DL_MDIO_ADDR);
>> +     bcm_readl(base + PCIE_RC_DL_MDIO_ADDR);
>> +     bcm_writel(MDIO_DATA_DONE_MASK | wrdata,
>> +                base + PCIE_RC_DL_MDIO_WR_DATA);
>> +
>> +     data = bcm_readl(base + PCIE_RC_DL_MDIO_WR_DATA);
>> +     for (tries = 0; !MDIO_WT_DONE(data) && tries < 10; tries++) {
>> +             udelay(10);
>> +             data = bcm_readl(base + PCIE_RC_DL_MDIO_WR_DATA);
>> +     }
>> +
>> +     return MDIO_WT_DONE(data) ? 0 : -EIO;
>> +}
>> +
>> +/* configures device for ssc mode; negative return value indicates error */
>
> I guess "ssc" means Spread Spectrum Clocking?  Maybe spell out the
> first occurrence and spell as acronym in English text?
>
>> +static int set_ssc(void __iomem *base)
>> +{
>> +     int tmp;
>> +     u16 wrdata;
>> +     int pll, ssc;
>> +
>> +     tmp = mdio_write(base, MDIO_PORT0, SET_ADDR_OFFSET, SSC_REGS_ADDR);
>> +     if (tmp < 0)
>> +             return tmp;
>> +
>> +     tmp = mdio_read(base, MDIO_PORT0, SSC_CNTL_OFFSET);
>> +     if (tmp < 0)
>> +             return tmp;
>> +
>> +     wrdata = INSERT_FIELD(tmp, SSC_CNTL_OVRD, EN, 1);
>> +     wrdata = INSERT_FIELD(wrdata, SSC_CNTL_OVRD, VAL, 1);
>> +     tmp = mdio_write(base, MDIO_PORT0, SSC_CNTL_OFFSET, wrdata);
>> +     if (tmp < 0)
>> +             return tmp;
>> +
>> +     usleep_range(1000, 2000);
>> +     tmp = mdio_read(base, MDIO_PORT0, SSC_STATUS_OFFSET);
>> +     if (tmp < 0)
>> +             return tmp;
>> +
>> +     ssc = EXTRACT_FIELD(tmp, SSC_STATUS, SSC);
>> +     pll = EXTRACT_FIELD(tmp, SSC_STATUS, PLL_LOCK);
>> +
>> +     return (ssc && pll) ? 0 : -EIO;
>> +}
>> +
>> +/* limits operation to a specific generation (1, 2, or 3) */
>> +static void set_gen(void __iomem *base, int gen)
>> +{
>> +     u32 lnkcap = bcm_readl(base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
>> +     u16 lnkctl2 = bcm_readw(base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
>> +
>> +     lnkcap = (lnkcap & ~PCI_EXP_LNKCAP_SLS) | gen;
>> +     bcm_writel(lnkcap, base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
>> +
>> +     lnkctl2 = (lnkctl2 & ~0xf) | gen;
>> +     bcm_writew(lnkctl2, base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
>> +}
>> +
>> +static void brcm_pcie_set_outbound_win(struct brcm_pcie *pcie,
>> +                                    unsigned int win, phys_addr_t cpu_addr,
>> +                                    dma_addr_t  pcie_addr, dma_addr_t size)
>> +{
>> +     void __iomem *base = pcie->base;
>> +     phys_addr_t cpu_addr_mb, limit_addr_mb;
>> +     u32 tmp;
>> +
>> +     /* Set the base of the pcie_addr window */
>> +     bcm_writel(lower_32_bits(pcie_addr) + MMIO_ENDIAN,
>> +                base + PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + (win * 8));
>> +     bcm_writel(upper_32_bits(pcie_addr),
>> +                base + PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + (win * 8));
>> +
>> +     cpu_addr_mb = cpu_addr >> 20;
>> +     limit_addr_mb = (cpu_addr + size - 1) >> 20;
>> +
>> +     /* Write the addr base low register */
>> +     WR_FLD_WITH_OFFSET(base, (win * 4),
>> +                        PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT,
>> +                        BASE, cpu_addr_mb);
>> +     /* Write the addr limit low register */
>> +     WR_FLD_WITH_OFFSET(base, (win * 4),
>> +                        PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT,
>> +                        LIMIT, limit_addr_mb);
>> +
>> +     if (pcie->type != BCM7435 && pcie->type != BCM7425) {
>> +             /* Write the cpu addr high register */
>> +             tmp = (u32)(cpu_addr_mb >>
>> +                     PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_NUM_MASK_BITS);
>> +             WR_FLD_WITH_OFFSET(base, (win * 8),
>> +                                PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI,
>> +                                BASE, tmp);
>> +             /* Write the cpu limit high register */
>> +             tmp = (u32)(limit_addr_mb >>
>> +                     PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_NUM_MASK_BITS);
>> +             WR_FLD_WITH_OFFSET(base, (win * 8),
>> +                                PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI,
>> +                                LIMIT, tmp);
>> +     }
>> +}
>> +
>> +/* Configuration space read/write support */
>> +static int cfg_index(int busnr, int devfn, int reg)
>> +{
>> +     return ((PCI_SLOT(devfn) & 0x1f) << PCIE_SLOT_SHIFT)
>> +             | ((PCI_FUNC(devfn) & 0x07) << PCIE_FUNC_SHIFT)
>> +             | (busnr << PCIE_BUSNUM_SHIFT)
>> +             | (reg & ~3);
>> +}
>> +
>> +static bool brcm_pcie_rc_mode(struct brcm_pcie *pcie)
>> +{
>> +     void __iomem *base = pcie->base;
>> +     u32 val = bcm_readl(base + PCIE_MISC_PCIE_STATUS);
>> +
>> +     return !!EXTRACT_FIELD(val, PCIE_MISC_PCIE_STATUS, PCIE_PORT);
>> +}
>> +
>> +static bool brcm_pcie_link_up(struct brcm_pcie *pcie)
>> +{
>> +     void __iomem *base = pcie->base;
>> +     u32 val = bcm_readl(base + PCIE_MISC_PCIE_STATUS);
>> +     u32 dla = EXTRACT_FIELD(val, PCIE_MISC_PCIE_STATUS, PCIE_DL_ACTIVE);
>> +     u32 plu = EXTRACT_FIELD(val, PCIE_MISC_PCIE_STATUS, PCIE_PHYLINKUP);
>> +
>> +     return  (dla && plu) ? true : false;
>> +}
>> +
>> +static bool brcm_pcie_valid_device(struct brcm_pcie *pcie, struct pci_bus *bus,
>> +                                int dev)
>> +{
>> +     if (pci_is_root_bus(bus)) {
>> +             if (dev > 0)
>> +                     return false;
>> +     } else {
>> +             /* If there is no link, then there is no device */
>> +             if (!brcm_pcie_link_up(pcie))
>> +                     return false;
>
> This is racy, since the link can go down after you check but before
> you do the config access.  I assume your hardware can deal with a
> config access that targets a link that is down?

Yes, that can happen but there is really nothing that can be done if
the link goes down in that vulnerability window.  What do you suggest
doing?

>
>> +     }
>> +
>> +     return true;
>> +}
>> +
>> +static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
>> +                                     int where)
>> +{
>> +     struct brcm_pcie *pcie = bus->sysdata;
>> +     void __iomem *base = pcie->base;
>> +     int idx;
>> +
>> +     if (!brcm_pcie_valid_device(pcie, bus, PCI_SLOT(devfn)))
>> +             return NULL;
>> +
>> +     /* Accesses to the RC go right to the RC registers */
>> +     if (pci_is_root_bus(bus))
>> +             return base + where;
>> +
>> +     /* For devices, write to the config space index register */
>> +     idx = cfg_index(bus->number, devfn, where);
>> +     bcm_writel(idx, pcie->base + IDX_ADDR(pcie));
>> +     return base + DATA_ADDR(pcie) + (where & 0x3);
>
> I guess this is protected by a higher-level config access lock?
>
>> +}
>> +
>> +static inline void brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie,
>> +                                             unsigned int val)
>> +{
>> +     unsigned int offset;
>> +     unsigned int shift = pcie->reg_field_info[RGR1_SW_INIT_1_INIT_SHIFT];
>> +     u32 mask =  pcie->reg_field_info[RGR1_SW_INIT_1_INIT_MASK];
>> +
>> +     if (pcie->type != BCM7278) {
>> +             wr_fld_rb(pcie->base + PCIE_RGR1_SW_INIT_1(pcie), mask, shift,
>> +                       val);
>> +     } else if (of_machine_is_compatible("brcm,bcm7278a0")) {
>> +             /*
>> +              * The two PCIe instances on 7278a0 are not even consistent with
>> +              * respect to each other for internal offsets, here we offset
>> +              * by 0x14000 + RGR1_SW_INIT_1's relative offset to account for
>> +              * that.
>> +              */
>> +             offset = pcie->id ? 0x14010 : pcie->reg_offsets[RGR1_SW_INIT_1];
>> +             wr_fld_rb(pcie->base + offset, mask, shift, val);
>> +     } else {
>> +             wr_fld_rb(pcie->base + PCIE_RGR1_SW_INIT_1(pcie), mask, shift,
>> +                       val);
>> +     }
>> +}
>> +
>> +static inline void brcm_pcie_perst_set(struct brcm_pcie *pcie,
>> +                                    unsigned int val)
>> +{
>> +     if (pcie->type != BCM7278)
>> +             wr_fld_rb(pcie->base + PCIE_RGR1_SW_INIT_1(pcie),
>> +                       PCIE_RGR1_SW_INIT_1_PERST_MASK,
>> +                       PCIE_RGR1_SW_INIT_1_PERST_SHIFT, val);
>> +     else
>> +             /* Assert = 0, de-assert = 1 on 7278 */
>> +             WR_FLD_RB(pcie->base, PCIE_MISC_PCIE_CTRL, PCIE_PERSTB, !val);
>> +}
>> +
>> +static int brcm_pcie_add_controller(struct brcm_pcie *pcie)
>> +{
>> +     mutex_lock(&brcm_pcie_lock);
>> +     list_add_tail(&pcie->list, &brcm_pcie);
>> +     mutex_unlock(&brcm_pcie_lock);
>> +
>> +     return 0;
>> +}
>> +
>> +static void brcm_pcie_remove_controller(struct brcm_pcie *pcie)
>> +{
>> +     struct list_head *pos, *q;
>> +     struct brcm_pcie *tmp;
>> +
>> +     mutex_lock(&brcm_pcie_lock);
>> +     list_for_each_safe(pos, q, &brcm_pcie) {
>> +             tmp = list_entry(pos, struct brcm_pcie, list);
>> +             if (tmp == pcie) {
>> +                     list_del(pos);
>> +                     if (list_empty(&brcm_pcie))
>> +                             num_memc = 0;
>> +                     break;
>> +             }
>> +     }
>> +     mutex_unlock(&brcm_pcie_lock);
>
> I'm missing something.  I don't see that num_memc is ever set to
> anything *other* than zero.
The num_memc is set and used in the dma commit.  I will remove its
declaration from this commit.
> This pattern of keeping a list of controllers is highly unusual and
> needs some explanation.
I think I can remove the list but still need brcm_pcie_lock.
>
>> +}
>> +
>> +static int brcm_pcie_parse_request_of_pci_ranges(struct brcm_pcie *pcie)
>> +{
>> +     struct resource_entry *win;
>> +     int ret;
>> +
>> +     ret = of_pci_get_host_bridge_resources(pcie->dn, 0, 0xff,
>> +                                            &pcie->resources, NULL);
>> +     if (ret) {
>> +             dev_err(pcie->dev, "failed to get host resources\n");
>> +             return ret;
>> +     }
>> +
>> +     resource_list_for_each_entry(win, &pcie->resources) {
>> +             struct resource *parent, *res = win->res;
>> +             dma_addr_t offset = (dma_addr_t)win->offset;
>> +
>> +             if (resource_type(res) == IORESOURCE_IO) {
>> +                     parent = &ioport_resource;
>> +             } else if (resource_type(res) == IORESOURCE_MEM) {
>> +                     if (pcie->num_out_wins >= BRCM_NUM_PCIE_OUT_WINS) {
>> +                             dev_err(pcie->dev, "too many outbound wins\n");
>> +                             return -EINVAL;
>> +                     }
>> +                     pcie->out_wins[pcie->num_out_wins].cpu_addr
>> +                             = (phys_addr_t)res->start;
>> +                     pcie->out_wins[pcie->num_out_wins].pcie_addr
>> +                             = (dma_addr_t)(res->start
>> +                                            - (phys_addr_t)offset);
>> +                     pcie->out_wins[pcie->num_out_wins].size
>> +                             = (dma_addr_t)(res->end - res->start + 1);
>> +                     pcie->num_out_wins++;
>> +                     parent = &iomem_resource;
>> +             } else {
>> +                     continue;
>> +             }
>> +
>> +             ret = devm_request_resource(pcie->dev, parent, res);
>> +             if (ret) {
>> +                     dev_err(pcie->dev, "failed to get res %pR\n", res);
>> +                     return ret;
>> +             }
>> +     }
>> +     return 0;
>> +}
>> +
>> +static int brcm_pcie_setup(struct brcm_pcie *pcie)
>> +{
>> +     void __iomem *base = pcie->base;
>> +     unsigned int scb_size_val;
>> +     u64 rc_bar2_size = 0, rc_bar2_offset = 0, total_mem_size = 0;
>
> Unnecessary initializations (at least of rc_bar2_size, I didn't check
> the rest).
>
> Add
>
>   struct device *dev = pcie->dev;
>
> then use it below.
>
>> +     u32 tmp, burst;
>> +     int i, j, ret, limit;
>> +     u16 nlw, cls, lnksta;
>> +     bool ssc_good = false;
>> +
>> +     /* reset the bridge and the endpoint device */
>> +     /* field: PCIE_BRIDGE_SW_INIT = 1 */
>
> Not sure what these "field: ..." comments mean.  Are they for some
> automated tool?  To a human, it looks like they repeat what the code
> does.
>
>> +     brcm_pcie_bridge_sw_init_set(pcie, 1);
>> +
>> +     /* field: PCIE_SW_PERST = 1, on 7278, we start de-asserted already */
>> +     if (pcie->type != BCM7278)
>> +             brcm_pcie_perst_set(pcie, 1);
>> +
>> +     usleep_range(100, 200);
>> +
>> +     /* take the bridge out of reset */
>> +     /* field: PCIE_BRIDGE_SW_INIT = 0 */
>> +     brcm_pcie_bridge_sw_init_set(pcie, 0);
>> +
>> +     WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, SERDES_IDDQ, 0);
>> +     /* wait for serdes to be stable */
>> +     usleep_range(100, 200);
>> +
>> +     /* Grab the PCIe hw revision number */
>> +     tmp = bcm_readl(base + PCIE_MISC_REVISION);
>> +     pcie->rev = EXTRACT_FIELD(tmp, PCIE_MISC_REVISION, MAJMIN);
>> +
>> +     /* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
>> +     tmp = INSERT_FIELD(0, PCIE_MISC_MISC_CTRL, SCB_ACCESS_EN, 1);
>> +     tmp = INSERT_FIELD(tmp, PCIE_MISC_MISC_CTRL, CFG_READ_UR_MODE, 1);
>> +     burst = (pcie->type == GENERIC || pcie->type == BCM7278)
>> +             ? BURST_SIZE_512 : BURST_SIZE_256;
>> +     tmp = INSERT_FIELD(tmp, PCIE_MISC_MISC_CTRL, MAX_BURST_SIZE, burst);
>> +     bcm_writel(tmp, base + PCIE_MISC_MISC_CTRL);
>> +
>> +     /*
>> +      * Set up inbound memory view for the EP (called RC_BAR2,
>> +      * not to be confused with the BARs that are advertised by
>> +      * the EP).
>> +      */
>> +     for (i = 0; i < num_memc; i++)
>> +             total_mem_size += scb_size[i];
>> +
>> +     /*
>> +      * The PCIe host controller by design must set the inbound
>> +      * viewport to be a contiguous arrangement of all of the
>> +      * system's memory.  In addition, its size mut be a power of
>> +      * two.  To further complicate matters, the viewport must
>> +      * start on a pcie-address that is aligned on a multiple of its
>> +      * size.  If a portion of the viewport does not represent
>> +      * system memory -- e.g. 3GB of memory requires a 4GB viewport
>> +      * -- we can map the outbound memory in or after 3GB and even
>> +      * though the viewport will overlap the outbound memory the
>> +      * controller will know to send outbound memory downstream and
>> +      * everything else upstream.
>> +      */
>> +     rc_bar2_size = roundup_pow_of_two_64(total_mem_size);
>> +
>> +     /*
>> +      * Set simple configuration based on memory sizes
>> +      * only.  We always start the viewport at address 0.
>> +      */
>> +     rc_bar2_offset = 0;
>> +
>> +     tmp = lower_32_bits(rc_bar2_offset);
>> +     tmp = INSERT_FIELD(tmp, PCIE_MISC_RC_BAR2_CONFIG_LO, SIZE,
>> +                        encode_ibar_size(rc_bar2_size));
>> +     bcm_writel(tmp, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
>> +     bcm_writel(upper_32_bits(rc_bar2_offset),
>> +                base + PCIE_MISC_RC_BAR2_CONFIG_HI);
>> +
>> +     /* field: SCB0_SIZE, default = 0xf (1 GB) */
>> +     scb_size_val = scb_size[0]
>> +             ? ilog2(scb_size[0]) - 15 : 0xf;
>> +     WR_FLD(base, PCIE_MISC_MISC_CTRL, SCB0_SIZE, scb_size_val);
>> +
>> +     /* field: SCB1_SIZE, default = 0xf (1 GB) */
>> +     if (num_memc > 1) {
>> +             scb_size_val = scb_size[1]
>> +                     ? ilog2(scb_size[1]) - 15 : 0xf;
>> +             WR_FLD(base, PCIE_MISC_MISC_CTRL, SCB1_SIZE, scb_size_val);
>> +     }
>> +
>> +     /* field: SCB2_SIZE, default = 0xf (1 GB) */
>> +     if (num_memc > 2) {
>> +             scb_size_val = scb_size[2]
>> +                     ? ilog2(scb_size[2]) - 15 : 0xf;
>> +             WR_FLD(base, PCIE_MISC_MISC_CTRL, SCB2_SIZE, scb_size_val);
>> +     }
>> +
>> +     /* disable the PCIe->GISB memory window (RC_BAR1) */
>> +     WR_FLD(base, PCIE_MISC_RC_BAR1_CONFIG_LO, SIZE, 0);
>> +
>> +     /* disable the PCIe->SCB memory window (RC_BAR3) */
>> +     WR_FLD(base, PCIE_MISC_RC_BAR3_CONFIG_LO, SIZE, 0);
>> +
>> +     if (!pcie->suspended) {
>> +             /* clear any interrupts we find on boot */
>> +             bcm_writel(0xffffffff, base + PCIE_INTR2_CPU_BASE + CLR);
>> +             (void)bcm_readl(base + PCIE_INTR2_CPU_BASE + CLR);
>> +     }
>> +
>> +     /* Mask all interrupts since we are not handling any yet */
>> +     bcm_writel(0xffffffff, base + PCIE_INTR2_CPU_BASE + MASK_SET);
>> +     (void)bcm_readl(base + PCIE_INTR2_CPU_BASE + MASK_SET);
>> +
>> +     if (pcie->gen)
>> +             set_gen(base, pcie->gen);
>> +
>> +     /* take the EP device out of reset */
>> +     /* field: PCIE_SW_PERST = 0 */
>> +     brcm_pcie_perst_set(pcie, 0);
>
> <raises eyebrows>  Take the *EP* out of reset?  The host controller
> driver shouldn't be touching an EP directly.  Maybe the comment
> doesn't match what the code actually does.
>
>> +
>> +     /*
>> +      * Give the RC/EP time to wake up, before trying to configure RC.
>> +      * Intermittently check status for link-up, up to a total of 100ms
>> +      * when we don't know if the device is there, and up to 1000ms if
>> +      * we do know the device is there.
>> +      */
>> +     limit = pcie->suspended ? 1000 : 100;
>> +     for (i = 1, j = 0; j < limit && !brcm_pcie_link_up(pcie);
>> +          j += i, i = i * 2)
>> +             msleep(i + j > limit ? limit - j : i);
>> +
>> +     if (!brcm_pcie_link_up(pcie)) {
>> +             dev_info(pcie->dev, "link down\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     if (!brcm_pcie_rc_mode(pcie)) {
>> +             dev_err(pcie->dev, "PCIe misconfigured; is in EP mode\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     for (i = 0; i < pcie->num_out_wins; i++)
>> +             brcm_pcie_set_outbound_win(pcie, i, pcie->out_wins[i].cpu_addr,
>> +                                        pcie->out_wins[i].pcie_addr,
>> +                                        pcie->out_wins[i].size);
>> +
>> +     /*
>> +      * For config space accesses on the RC, show the right class for
>> +      * a PCIe-PCIe bridge (the default setting is to be EP mode).
>> +      */
>> +     WR_FLD_RB(base, PCIE_RC_CFG_PRIV1_ID_VAL3, CLASS_CODE, 0x060400);
>> +
>> +     if (pcie->ssc) {
>> +             ret = set_ssc(base);
>> +             if (ret == 0)
>> +                     ssc_good = true;
>> +             else
>> +                     dev_err(pcie->dev,
>> +                             "failed attempt to enter ssc mode\n");
>> +     }
>> +
>> +     lnksta = bcm_readw(base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKSTA);
>> +     cls = lnksta & PCI_EXP_LNKSTA_CLS;
>> +     nlw = (lnksta & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
>> +     dev_info(pcie->dev, "link up, %s Gbps x%u %s\n", link_speed_to_str(cls),
>> +              nlw, ssc_good ? "(SSC)" : "(!SSC)");
>> +
>> +     /* PCIe->SCB endian mode for BAR */
>> +     /* field ENDIAN_MODE_BAR2 = DATA_ENDIAN */
>> +     WR_FLD_RB(base, PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1,
>> +               ENDIAN_MODE_BAR2, DATA_ENDIAN);
>> +
>> +     /*
>> +      * Refclk from RC should be gated with CLKREQ# input when ASPM L0s,L1
>> +      * is enabled =>  setting the CLKREQ_DEBUG_ENABLE field to 1.
>> +      */
>> +     WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, CLKREQ_DEBUG_ENABLE, 1);
>> +
>> +     return 0;
>> +}
>> +
>> +static void enter_l23(struct brcm_pcie *pcie)
>> +{
>> +     void __iomem *base = pcie->base;
>> +     int tries, l23;
>> +
>> +     /* assert request for L23 */
>> +     WR_FLD_RB(base, PCIE_MISC_PCIE_CTRL, PCIE_L23_REQUEST, 1);
>> +     /* poll L23 status */
>> +     for (tries = 0, l23 = 0; tries < 1000 && !l23; tries++)
>> +             l23 = RD_FLD(base, PCIE_MISC_PCIE_STATUS, PCIE_LINK_IN_L23);
>> +     if (!l23)
>> +             dev_err(pcie->dev, "failed to enter L23\n");
>
> What does "L23" mean?  Some power management thing?
>
Yes, it is a low power link state.  I will add a comment.
>> +}
>> +
>> +static void turn_off(struct brcm_pcie *pcie)
>> +{
>> +     void __iomem *base = pcie->base;
>> +
>> +     if (brcm_pcie_link_up(pcie))
>> +             enter_l23(pcie);
>> +     /* Reset endpoint device */
>> +     brcm_pcie_perst_set(pcie, 1);
>> +     /* deassert request for L23 in case it was asserted */
>> +     WR_FLD_RB(base, PCIE_MISC_PCIE_CTRL, PCIE_L23_REQUEST, 0);
>> +     /* SERDES_IDDQ = 1 */
>> +     WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, SERDES_IDDQ, 1);
>> +     /* Shutdown PCIe bridge */
>> +     brcm_pcie_bridge_sw_init_set(pcie, 1);
>> +}
>> +
>> +static int brcm_pcie_suspend(struct device *dev)
>> +{
>> +     struct brcm_pcie *pcie = dev_get_drvdata(dev);
>> +
>> +     turn_off(pcie);
>> +     clk_disable_unprepare(pcie->clk);
>> +     pcie->suspended = true;
>> +
>> +     return 0;
>> +}
>> +
>> +static int brcm_pcie_resume(struct device *dev)
>> +{
>> +     struct brcm_pcie *pcie = dev_get_drvdata(dev);
>> +     void __iomem *base;
>> +     int ret;
>> +
>> +     base = pcie->base;
>> +     clk_prepare_enable(pcie->clk);
>> +
>> +     /* Take bridge out of reset so we can access the SERDES reg */
>
> Some comments above and below spell it "serdes"; here you spell it
> "SERDES".
>
>> +     brcm_pcie_bridge_sw_init_set(pcie, 0);
>> +
>> +     /* SERDES_IDDQ = 0 */
>> +     WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, SERDES_IDDQ, 0);
>> +     /* wait for serdes to be stable */
>> +     usleep_range(100, 200);
>> +
>> +     ret = brcm_pcie_setup(pcie);
>> +     if (ret)
>> +             return ret;
>> +
>> +     pcie->suspended = false;
>> +
>> +     return 0;
>> +}
>> +
>> +static void _brcm_pcie_remove(struct brcm_pcie *pcie)
>> +{
>> +     turn_off(pcie);
>> +     clk_disable_unprepare(pcie->clk);
>> +     clk_put(pcie->clk);
>> +     brcm_pcie_remove_controller(pcie);
>> +}
>> +
>> +static int brcm_pcie_remove(struct platform_device *pdev)
>> +{
>> +     struct brcm_pcie *pcie = platform_get_drvdata(pdev);
>> +
>> +     pci_stop_root_bus(pcie->root_bus);
>> +     pci_remove_root_bus(pcie->root_bus);
>> +     _brcm_pcie_remove(pcie);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id brcm_pcie_match[] = {
>> +     { .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
>> +     { .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
>> +     { .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
>> +     { .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, brcm_pcie_match);
>> +
>> +static int brcm_pcie_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *dn = pdev->dev.of_node;
>> +     const struct of_device_id *of_id;
>> +     const struct pcie_cfg_data *data;
>> +     int ret;
>> +     struct brcm_pcie *pcie;
>> +     struct resource *res;
>> +     void __iomem *base;
>> +     u32 tmp;
>> +     struct pci_host_bridge *bridge;
>> +     struct pci_bus *child;
>> +
>> +     bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
>> +     if (!bridge)
>> +             return -ENOMEM;
>> +
>> +     pcie = pci_host_bridge_priv(bridge);
>> +     INIT_LIST_HEAD(&pcie->resources);
>> +
>> +     of_id = of_match_node(brcm_pcie_match, dn);
>> +     if (!of_id) {
>> +             dev_err(&pdev->dev, "failed to look up compatible string\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (of_property_read_u32(dn, "dma-ranges", &tmp) == 0) {
>> +             dev_err(&pdev->dev, "cannot yet handle dma-ranges\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     data = of_id->data;
>> +     pcie->reg_offsets = data->offsets;
>> +     pcie->reg_field_info = data->reg_field_info;
>> +     pcie->type = data->type;
>> +     pcie->dn = dn;
>> +     pcie->dev = &pdev->dev;
>> +
>> +     pcie->id = of_get_pci_domain_nr(dn);
>
> Why do you call of_get_pci_domain_nr() directly?  No other driver
> does.

We use the domain as the controller number (id).  We use the id to
identify and fix a HW bug that only affects the 2nd controller; see
the clause
" } else if (of_machine_is_compatible("brcm,bcm7278a0")) {".

>
>> +     if (pcie->id < 0)
>> +             return pcie->id;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (!res)
>> +             return -EINVAL;
>> +
>> +     base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(base))
>> +             return PTR_ERR(base);
>> +
>> +     pcie->clk = of_clk_get_by_name(dn, "sw_pcie");
>> +     if (IS_ERR(pcie->clk)) {
>> +             dev_err(&pdev->dev, "could not get clock\n");
>> +             pcie->clk = NULL;
>> +     }
>> +     pcie->base = base;
>> +
>> +     ret = of_pci_get_max_link_speed(dn);
>> +     pcie->gen = (ret < 0) ? 0 : ret;
>> +
>> +     pcie->ssc = of_property_read_bool(dn, "brcm,enable-ssc");
>> +
>> +     ret = irq_of_parse_and_map(pdev->dev.of_node, 0);
>> +     if (ret == 0)
>> +             /* keep going, as we don't use this intr yet */
>> +             dev_warn(pcie->dev, "cannot get pcie interrupt\n");
>> +     else
>> +             pcie->irq = ret;
>> +
>> +     ret = brcm_pcie_parse_request_of_pci_ranges(pcie);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = clk_prepare_enable(pcie->clk);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "could not enable clock\n");
>> +             return ret;
>> +     }
>> +
>> +     ret = brcm_pcie_add_controller(pcie);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = brcm_pcie_setup(pcie);
>> +     if (ret)
>> +             goto fail;
>> +
>> +     list_splice_init(&pcie->resources, &bridge->windows);
>> +     bridge->dev.parent = &pdev->dev;
>> +     bridge->busnr = 0;
>> +     bridge->ops = &brcm_pcie_ops;
>> +     bridge->sysdata = pcie;
>> +     bridge->map_irq = of_irq_parse_and_map_pci;
>> +     bridge->swizzle_irq = pci_common_swizzle;
>> +
>> +     ret = pci_scan_root_bus_bridge(bridge);
>> +     if (ret < 0) {
>> +             dev_err(pcie->dev, "Scanning root bridge failed");
>> +             goto fail;
>> +     }
>> +
>> +     pci_assign_unassigned_bus_resources(bridge->bus);
>> +     list_for_each_entry(child, &bridge->bus->children, node)
>> +             pcie_bus_configure_settings(child);
>> +     pci_bus_add_devices(bridge->bus);
>> +     platform_set_drvdata(pdev, pcie);
>> +     pcie->root_bus = bridge->bus;
>> +
>> +     return 0;
>> +
>> +fail:
>> +     _brcm_pcie_remove(pcie);
>> +     return ret;
>> +}
>> +
>> +static const struct dev_pm_ops brcm_pcie_pm_ops = {
>> +     .suspend_noirq = brcm_pcie_suspend,
>> +     .resume_noirq = brcm_pcie_resume,
>> +};
>> +
>> +static struct platform_driver __refdata brcm_pcie_driver = {
>
> Why do you need __refdata?  There's only only other occurrence in
> drivers/pci, and I'm dubious about that one as well.
>
>> +     .probe = brcm_pcie_probe,
>> +     .remove = brcm_pcie_remove,
>> +     .driver = {
>> +             .name = "brcm-pcie",
>> +             .owner = THIS_MODULE,
>> +             .of_match_table = brcm_pcie_match,
>> +             .pm = &brcm_pcie_pm_ops,
>> +     },
>> +};
>> +
>> +module_platform_driver(brcm_pcie_driver);
>> +
>> +MODULE_LICENSE("GPL");
>
> Copyright notice above says "GPL v2", which is not the same as the
> "GPL" here.
>
>> +MODULE_DESCRIPTION("Broadcom STB PCIE RC driver");
>> +MODULE_AUTHOR("Broadcom");
>> --
>> 1.9.0.138.g2de3478
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
