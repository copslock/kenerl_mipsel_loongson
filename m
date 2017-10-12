Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 16:32:58 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:59775 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992544AbdJLOcwA8SRk convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Oct 2017 16:32:52 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id E0E203B297AB;
        Thu, 12 Oct 2017 15:32:39 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 12 Oct 2017
 15:32:43 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::1092:c22e:588e:c561]) by
 bamail02.ba.imgtec.org ([fe80::5efe:10.20.40.28%12]) with mapi id
 14.03.0266.001; Thu, 12 Oct 2017 07:32:39 -0700
From:   Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>
To:     James Hogan <james.hogan@mips.com>
CC:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "Petar Jovanovic" <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: [PATCH 1/2] MIPS: math-emu: Update debugfs FP exception stats
 for certain instructions
Thread-Topic: [PATCH 1/2] MIPS: math-emu: Update debugfs FP exception stats
 for certain instructions
Thread-Index: AQHTPsi6p5g0lpfKgEir0jCOJ2oqB6LcfYsAgAHzPlSAAg25AP//0QrB
Date:   Thu, 12 Oct 2017 14:32:38 +0000
Message-ID: <EF5FA6C3467F85449672C3E735957B85015DA0B50E@badag02.ba.imgtec.org>
References: <1507310955-3525-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1507310955-3525-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <20171009210923.GA20378@jhogan-linux>
 <EF5FA6C3467F85449672C3E735957B85015DA0AF13@badag02.ba.imgtec.org>,<20171012101753.GB15235@jhogan-linux>
In-Reply-To: <20171012101753.GB15235@jhogan-linux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Aleksandar.Markovic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@imgtec.com
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


(resending since the previous mail was rejected by the mailing list because of html format)

> Subject: Re: [PATCH 1/2] MIPS: math-emu: Update debugfs FP exception stats for certain instructions
> Date: Thursday, October 12, 2017 12:17 CEST
> From: James Hogan <james.hogan@mips.com>>
> > ...
> > if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E)
> > ...
>
> But just before that condition it does:
>
> ctx->fcr31 = (ctx->fcr31 & ~FPU_CSR_ALL_X) | rcsr;
> I.e. it clears the X bits used in the condition, and overrides them,
> based on rcsr, which is initialised to 0 and is only set after the
> copcsr label and in a couple of other cases I don't think we'd be
> hitting for MADDF.
>

The code is odd and deceiving here. Let's see the whole "copcsr label"
code segment:
 
copcsr:
if (ieee754_cxtest(IEEE754_INEXACT)) {
    MIPS_FPU_EMU_INC_STATS(ieee754_inexact);
    rcsr |= FPU_CSR_INE_X | FPU_CSR_INE_S;
}
if (ieee754_cxtest(IEEE754_UNDERFLOW)) {
    MIPS_FPU_EMU_INC_STATS(ieee754_underflow);
    rcsr |= FPU_CSR_UDF_X | FPU_CSR_UDF_S;
}
if (ieee754_cxtest(IEEE754_OVERFLOW)) {
    MIPS_FPU_EMU_INC_STATS(ieee754_overflow);
    rcsr |= FPU_CSR_OVF_X | FPU_CSR_OVF_S;
}
if (ieee754_cxtest(IEEE754_INVALID_OPERATION)) {
    MIPS_FPU_EMU_INC_STATS(ieee754_invalidop);
    rcsr |= FPU_CSR_INV_X | FPU_CSR_INV_S;
}
 
ctx->fcr31 = (ctx->fcr31 & ~FPU_CSR_ALL_X) | rcsr;
if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
    /*printk ("SIGFPE: FPU csr = %08x\n",
    ctx->fcr31); */
    return SIGFPE;
}


Value of rcsr will be dictated by series of invocations to ieee754_cxtest(),
which, in fact, means that exception bits will be copied from fcr31 to rcsr.

Then, fcr31 exception bits are cleared and set to the values they had just
before clearing.

Obviously, this will not do anything in our scenarios.

However, the patch is about correct setting of debugfs stats, and this code
segment correctly does this.

May I suggest that we accept my patch as is, and if anybody for any reason
wants to deal further with related code, this should be done in a separate
fix/patch?

Regards,
Aleksandar
From julien.thierry@arm.com Thu Oct 12 16:41:55 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 16:42:02 +0200 (CEST)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52410 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993035AbdJLOlzXHWhk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2017 16:41:55 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A59D31529;
        Thu, 12 Oct 2017 07:41:47 -0700 (PDT)
Received: from [10.1.207.56] (e112298-lin.cambridge.arm.com [10.1.207.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACAB53F236;
        Thu, 12 Oct 2017 07:41:44 -0700 (PDT)
Subject: Re: [PATCH 1/9] SOC: brcmstb: add memory API
To:     Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-2-git-send-email-jim2101024@gmail.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <b6be2073-7a90-f83f-4e25-79ef04827bd7@arm.com>
Date:   Thu, 12 Oct 2017 15:41:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1507761269-7017-2-git-send-email-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <julien.thierry@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julien.thierry@arm.com
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

Hi Jim,

On 11/10/17 23:34, Jim Quinlan wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> This commit adds a memory API suitable for ascertaining the sizes of
> each of the N memory controllers in a Broadcom STB chip.  Its first
> user will be the Broadcom STB PCIe root complex driver, which needs
> to know these sizes to properly set up DMA mappings for inbound
> regions.
> 
> We cannot use memblock here or anything like what Linux provides
> because it collapses adjacent regions within a larger block, and here
> we actually need per-memory controller addresses and sizes, which is
> why we resort to manual DT parsing.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>   drivers/soc/bcm/brcmstb/Makefile |   2 +-
>   drivers/soc/bcm/brcmstb/memory.c | 183 +++++++++++++++++++++++++++++++++++++++
>   include/soc/brcmstb/memory_api.h |  25 ++++++
>   3 files changed, 209 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/soc/bcm/brcmstb/memory.c
>   create mode 100644 include/soc/brcmstb/memory_api.h
> 
> diff --git a/drivers/soc/bcm/brcmstb/Makefile b/drivers/soc/bcm/brcmstb/Makefile
> index 9120b27..4cea7b6 100644
> --- a/drivers/soc/bcm/brcmstb/Makefile
> +++ b/drivers/soc/bcm/brcmstb/Makefile
> @@ -1 +1 @@
> -obj-y				+= common.o biuctrl.o
> +obj-y				+= common.o biuctrl.o memory.o
> diff --git a/drivers/soc/bcm/brcmstb/memory.c b/drivers/soc/bcm/brcmstb/memory.c
> new file mode 100644
> index 0000000..cb6bf73
> --- /dev/null
> +++ b/drivers/soc/bcm/brcmstb/memory.c
> @@ -0,0 +1,183 @@
> +/*
> + * Copyright © 2015-2017 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * A copy of the GPL is available at
> + * http://www.broadcom.com/licenses/GPLv2.php or from the Free Software
> + * Foundation at https://www.gnu.org/licenses/ .
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/libfdt.h>
> +#include <linux/of_address.h>
> +#include <linux/of_fdt.h>
> +#include <linux/sizes.h>
> +#include <soc/brcmstb/memory_api.h>
> +
> +/* -------------------- Constants -------------------- */
> +
> +/* Macros to help extract property data */
> +#define U8TOU32(b, offs) \
> +	((((u32)b[0 + offs] << 0)  & 0x000000ff) | \
> +	 (((u32)b[1 + offs] << 8)  & 0x0000ff00) | \
> +	 (((u32)b[2 + offs] << 16) & 0x00ff0000) | \
> +	 (((u32)b[3 + offs] << 24) & 0xff000000))
> +
> +#define DT_PROP_DATA_TO_U32(b, offs) (fdt32_to_cpu(U8TOU32(b, offs)))
> +

I fail to understand why this is not:

#define DT_PROP_DATA_TO_U32(b, offs) (fdt32_to_cpu(*(u32*)(b + offs)))


If I understand correctly, fdt data is in big endian, the macro U8TOU32 
reads it as little endian. My guess is that this won't work on big 
endian kernels but should work on little endian since fdt32_to_cpu will 
revert the bytes again.

Am I missing something?

Cheers,

> +/* Constants used when retrieving memc info */
> +#define NUM_BUS_RANGES 10
> +#define BUS_RANGE_ULIMIT_SHIFT 4
> +#define BUS_RANGE_LLIMIT_SHIFT 4
> +#define BUS_RANGE_PA_SHIFT 12
> +
> +enum {
> +	BUSNUM_MCP0 = 0x4,
> +	BUSNUM_MCP1 = 0x5,
> +	BUSNUM_MCP2 = 0x6,
> +};
> +
> +/* -------------------- Functions -------------------- */
> +
> +/*
> + * If the DT nodes are handy, determine which MEMC holds the specified
> + * physical address.
> + */
> +#ifdef CONFIG_ARCH_BRCMSTB
> +int __brcmstb_memory_phys_addr_to_memc(phys_addr_t pa, void __iomem *base)
> +{
> +	int memc = -1;
> +	int i;
> +
> +	for (i = 0; i < NUM_BUS_RANGES; i++, base += 8) {
> +		const u64 ulimit_raw = readl(base);
> +		const u64 llimit_raw = readl(base + 4);
> +		const u64 ulimit =
> +			((ulimit_raw >> BUS_RANGE_ULIMIT_SHIFT)
> +			 << BUS_RANGE_PA_SHIFT) | 0xfff;
> +		const u64 llimit = (llimit_raw >> BUS_RANGE_LLIMIT_SHIFT)
> +				   << BUS_RANGE_PA_SHIFT;
> +		const u32 busnum = (u32)(ulimit_raw & 0xf);
> +
> +		if (pa >= llimit && pa <= ulimit) {
> +			if (busnum >= BUSNUM_MCP0 && busnum <= BUSNUM_MCP2) {
> +				memc = busnum - BUSNUM_MCP0;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return memc;
> +}
> +
> +int brcmstb_memory_phys_addr_to_memc(phys_addr_t pa)
> +{
> +	int memc = -1;
> +	struct device_node *np;
> +	void __iomem *cpubiuctrl;
> +
> +	np = of_find_compatible_node(NULL, NULL, "brcm,brcmstb-cpu-biu-ctrl");
> +	if (!np)
> +		return memc;
> +
> +	cpubiuctrl = of_iomap(np, 0);
> +	if (!cpubiuctrl)
> +		goto cleanup;
> +
> +	memc = __brcmstb_memory_phys_addr_to_memc(pa, cpubiuctrl);
> +	iounmap(cpubiuctrl);
> +
> +cleanup:
> +	of_node_put(np);
> +
> +	return memc;
> +}
> +
> +#elif defined(CONFIG_MIPS)
> +int brcmstb_memory_phys_addr_to_memc(phys_addr_t pa)
> +{
> +	/* The logic here is fairly simple and hardcoded: if pa <= 0x5000_0000,
> +	 * then this is MEMC0, else MEMC1.
> +	 *
> +	 * For systems with 2GB on MEMC0, MEMC1 starts at 9000_0000, with 1GB
> +	 * on MEMC0, MEMC1 starts at 6000_0000.
> +	 */
> +	if (pa >= 0x50000000ULL)
> +		return 1;
> +	else
> +		return 0;
> +}
> +#endif
> +EXPORT_SYMBOL(brcmstb_memory_phys_addr_to_memc);
> +
> +u64 brcmstb_memory_memc_size(int memc)
> +{
> +	const void *fdt = initial_boot_params;
> +	const int mem_offset = fdt_path_offset(fdt, "/memory");
> +	int addr_cells = 1, size_cells = 1;
> +	const struct fdt_property *prop;
> +	int proplen, cellslen;
> +	u64 memc_size = 0;
> +	int i;
> +
> +	/* Get root size and address cells if specified */
> +	prop = fdt_get_property(fdt, 0, "#size-cells", &proplen);
> +	if (prop)
> +		size_cells = DT_PROP_DATA_TO_U32(prop->data, 0);
> +
> +	prop = fdt_get_property(fdt, 0, "#address-cells", &proplen);
> +	if (prop)
> +		addr_cells = DT_PROP_DATA_TO_U32(prop->data, 0);
> +
> +	if (mem_offset < 0)
> +		return -1;
> +
> +	prop = fdt_get_property(fdt, mem_offset, "reg", &proplen);
> +	cellslen = (int)sizeof(u32) * (addr_cells + size_cells);
> +	if ((proplen % cellslen) != 0)
> +		return -1;
> +
> +	for (i = 0; i < proplen / cellslen; ++i) {
> +		u64 addr = 0;
> +		u64 size = 0;
> +		int memc_idx;
> +		int j;
> +
> +		for (j = 0; j < addr_cells; ++j) {
> +			int offset = (cellslen * i) + (sizeof(u32) * j);
> +
> +			addr |= (u64)DT_PROP_DATA_TO_U32(prop->data, offset) <<
> +				((addr_cells - j - 1) * 32);
> +		}
> +		for (j = 0; j < size_cells; ++j) {
> +			int offset = (cellslen * i) +
> +				(sizeof(u32) * (j + addr_cells));
> +
> +			size |= (u64)DT_PROP_DATA_TO_U32(prop->data, offset) <<
> +				((size_cells - j - 1) * 32);
> +		}
> +
> +		if ((phys_addr_t)addr != addr) {
> +			pr_err("phys_addr_t is smaller than provided address 0x%llx!\n",
> +			       addr);
> +			return -1;
> +		}
> +
> +		memc_idx = brcmstb_memory_phys_addr_to_memc((phys_addr_t)addr);
> +		if (memc_idx == memc)
> +			memc_size += size;
> +	}
> +
> +	return memc_size;
> +}
> +EXPORT_SYMBOL(brcmstb_memory_memc_size);
> +
> diff --git a/include/soc/brcmstb/memory_api.h b/include/soc/brcmstb/memory_api.h
> new file mode 100644
> index 0000000..d922906
> --- /dev/null
> +++ b/include/soc/brcmstb/memory_api.h
> @@ -0,0 +1,25 @@
> +#ifndef __MEMORY_API_H
> +#define __MEMORY_API_H
> +
> +/*
> + * Bus Interface Unit control register setup, must happen early during boot,
> + * before SMP is brought up, called by machine entry point.
> + */
> +void brcmstb_biuctrl_init(void);
> +
> +#ifdef CONFIG_SOC_BRCMSTB
> +int brcmstb_memory_phys_addr_to_memc(phys_addr_t pa);
> +u64 brcmstb_memory_memc_size(int memc);
> +#else
> +static inline int brcmstb_memory_phys_addr_to_memc(phys_addr_t pa)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline u64 brcmstb_memory_memc_size(int memc)
> +{
> +	return -1;
> +}
> +#endif
> +
> +#endif /* __MEMORY_API_H */
> 

-- 
Julien Thierry
