Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jul 2010 20:57:01 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:60416 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492843Ab0G2S44 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Jul 2010 20:56:56 +0200
Received: by yxj4 with SMTP id 4so298512yxj.36
        for <multiple recipients>; Thu, 29 Jul 2010 11:56:49 -0700 (PDT)
Received: by 10.150.179.1 with SMTP id b1mr1484483ybf.439.1280429803285; Thu, 
        29 Jul 2010 11:56:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.84.4 with HTTP; Thu, 29 Jul 2010 11:56:23 -0700 (PDT)
In-Reply-To: <20100727215337.GA29365@dediao-lnx2.corp.sa.net>
References: <20100727215337.GA29365@dediao-lnx2.corp.sa.net>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Thu, 29 Jul 2010 12:56:23 -0600
X-Google-Sender-Auth: zr_SO9vw3AjY15ShQ4Cq_wA3dlg
Message-ID: <AANLkTim7MEyGFiedDrbWiNiZb18Qy3a5ZZ=aYBh4Jj7L@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] MIPS: PowerTV: Add device tree support
To:     Dezhong Diao <dediao@cisco.com>
Cc:     devicetree-discuss@lists.ozlabs.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, dvomlehn@cisco.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

Just noticed something....

On Tue, Jul 27, 2010 at 3:53 PM, Dezhong Diao <dediao@cisco.com> wrote:
> V2:
>    Synchronize with test-devicetree branch of device tree.
>
> V1:
>    Add device tree support for PowerTV.
>    Customize user-defined memory scan function.
>
> Signed-off-by: Dezhong Diao <dediao@cisco.com>
> ---
>  arch/mips/configs/powertv_defconfig        |  293 +++++++++++++++++++++-------
>  arch/mips/include/asm/mach-powertv/asic.h  |    8 +-
>  arch/mips/include/asm/mach-powertv/mdesc.h |   51 +++++
>  arch/mips/powertv/Makefile                 |    2 +-
>  arch/mips/powertv/asic/asic_devices.c      |   22 --
>  arch/mips/powertv/mdesc.c                  |  224 +++++++++++++++++++++
>  arch/mips/powertv/memory.c                 |  242 ++++++++++++++---------
>  7 files changed, 649 insertions(+), 193 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-powertv/mdesc.h
>  create mode 100644 arch/mips/powertv/mdesc.c
>
> diff --git a/arch/mips/powertv/mdesc.c b/arch/mips/powertv/mdesc.c
> new file mode 100644
> index 0000000..8a7b972
> --- /dev/null
> +++ b/arch/mips/powertv/mdesc.c
[...]
> +static int __init early_init_dt_scan_extent(unsigned long node,
> +               const char *uname, int depth, void *data)
> +{
> +       char buf[8 + log10_extent(MEM_EXTENT_MAX)];
> +       unsigned long l;
> +       char *memory_type;
> +       enum Memory_Type type;
> +       cell_t *reg, *endp;
> +       unsigned long phys_base, bus_base;
> +       unsigned long size;
> +
> +       snprintf(buf, sizeof(buf), "memory@%d", num_extent);
> +
> +       if (strcmp(uname, buf) != 0)
> +               return 0;
> +
> +       memory_type = of_get_flat_dt_prop(node, "memory_type", &l);
> +       if (memory_type == NULL || l <= 0)
> +               return 0;
> +
> +       if (strcmp(memory_type, "low") == 0)
> +               type = MEM_EXTENT_LOW;
> +       else if (strcmp(memory_type, "high") == 0)
> +               type = MEM_EXTENT_HIGH;
> +       else
> +               type = MEM_EXTENT_OTHER;
> +
> +       reg = (cell_t *)of_get_flat_dt_prop(node, "reg", &l);
> +       if (reg == NULL)
> +               return 0;
> +
> +       endp = reg + (l / sizeof(cell_t));
> +
> +       pr_info("memory scan node %s, reg size %ld, data: %x %x %x\n",
> +               uname, l, reg[0], reg[1], reg[2]);
> +
> +       while ((endp - reg) >= (num_addr_cells + num_size_cells)) {
> +               phys_base = dt_mem_next_cell(1, &reg);
> +               bus_base = dt_mem_next_cell(1, &reg);
> +               size = dt_mem_next_cell(1, &reg);
> +               if (size == 0)
> +                       continue;
> +               mem_desc_add(phys_base, bus_base, size, type);
> +       }
> +
> +       return 1;
> +}

What is the purpose of this function.  Why doesn't the normal memory
binding work for MIPS?

> +int __init early_init_dt_scan_memory_arch(unsigned long node,
> +               const char *uname, int depth, void *data)
> +{
> +       u32 *prop;
> +
> +       prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
> +       num_addr_cells = (prop == NULL) ? 2 : *prop;
> +
> +       prop = of_get_flat_dt_prop(node, "#size-cells", NULL);
> +       num_size_cells = (prop == NULL) ? 1 : *prop;

Nack.  Fix your device tree data.  :-)

g.
