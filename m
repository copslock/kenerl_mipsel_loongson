Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 20:02:21 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:37758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993938AbdF0SCNs7nB0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Jun 2017 20:02:13 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E0ED80D;
        Tue, 27 Jun 2017 11:02:07 -0700 (PDT)
Received: from leverpostej (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43EA73F557;
        Tue, 27 Jun 2017 11:02:04 -0700 (PDT)
Date:   Tue, 27 Jun 2017 19:01:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Gareth Powell <gpowell@broadcom.com>,
        Doug Berger <opendmb@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM BCM47XX MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>, linux-pm@vger.kernerl.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/4] soc: bcm: brcmstb: Add support for S2/S3/S5
 suspend states (ARM)
Message-ID: <20170627180113.GB5189@leverpostej>
References: <20170626223248.14199-1-f.fainelli@gmail.com>
 <20170626223248.14199-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170626223248.14199-5-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <mark.rutland@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.rutland@arm.com
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

On Mon, Jun 26, 2017 at 03:32:44PM -0700, Florian Fainelli wrote:
> From: Brian Norris <computersforpeace@gmail.com>
> 
> This commit adds support for the Broadcom STB S2/S3/S5 suspend states on
> ARM based SoCs.
> 
> This requires quite a lot of code in order to deal with the different HW
> blocks that need to be quiesced during suspend:
> 
> - DDR PHY SHIM
> - DDR memory controller and sequencer
> - control processor
> 
> The final steps of the suspend execute in an on-chip SRAM and there is a
> little bit of assembly code in order to shut down the DDR PHY PLL and
> then go into a wfi loop until a wake-up even occurs. Conversely the
> resume part involves waiting for the DDR PHY PLL to come back up and
> resume executions where we left.
> 
> For S3, because of our memory hashing (actual hashing code not included
> for simplicity, and is bypassed) we need to relocate the writable
> variables (stack) into SRAM shortly before suspending in order to leave
> the DRAM untouched and create a reliable hash of its contents.
> 
> This code has been contributed by Brian Norris initially and has been
> incrementally fixed and updated to support new chips by a lot of people.

[...]

> +static int (*brcmstb_pm_do_s2_sram)(void __iomem *aon_ctrl_base,
> +		void __iomem *ddr_phy_pll_status);
> +
> +static int brcmstb_init_sram(struct device_node *dn)
> +{
> +	void __iomem *sram;
> +	struct resource res;
> +	int ret;
> +
> +	ret = of_address_to_resource(dn, 0, &res);
> +	if (ret)
> +		return ret;
> +
> +	/* Cached, executable remapping of SRAM */
> +#ifdef CONFIG_ARM
> +	sram = __arm_ioremap_exec(res.start, resource_size(&res), true);
> +#else
> +	sram = __ioremap(res.start, resource_size(&res), PAGE_KERNEL_EXEC);
> +#endif

... so we're mapping the SRAM as executable via the page tables (which
themselves live in memory, and are accessed asynchronously by the MMU) ...

> +static void *brcmstb_pm_copy_to_sram(void *fn, size_t len)
> +{
> +	unsigned int size = ALIGN(len, FNCPY_ALIGN);
> +
> +	if (ctrl.boot_sram_len < size) {
> +		pr_err("standby code will not fit in SRAM\n");
> +		return NULL;
> +	}
> +
> +	return fncpy(ctrl.boot_sram, fn, size);
> +}
> +
> +/*
> + * S2 suspend/resume picks up where we left off, so we must execute carefully
> + * from SRAM, in order to allow DDR to come back up safely before we continue.
> + */
> +static int brcmstb_pm_s2(void)
> +{
> +	/* A previous S3 can set a value hazardous to S2, so make sure. */
> +	if (ctrl.s3entry_method == 1) {
> +		shimphy_set((PWRDWN_SEQ_NO_SEQUENCING <<
> +			    SHIMPHY_PAD_S3_PWRDWN_SEQ_SHIFT),
> +			    ~SHIMPHY_PAD_S3_PWRDWN_SEQ_MASK);
> +		ddr_ctrl_set(false);
> +	}
> +
> +	brcmstb_pm_do_s2_sram = brcmstb_pm_copy_to_sram(&brcmstb_pm_do_s2,
> +			brcmstb_pm_do_s2_sz);
> +	if (!brcmstb_pm_do_s2_sram)
> +		return -EINVAL;
> +
> +	return brcmstb_pm_do_s2_sram(ctrl.aon_ctrl_base,
> +			ctrl.memcs[0].ddr_phy_base +
> +			ctrl.pll_status_offset);
> +}

... here we copy the function into that executable SRAM, and then try to
execute it, with the MMU on ... 

> +#define SWAP_STACK(new_sp, saved_sp) \
> +	__asm__ __volatile__ ( \
> +		 "mov	%[save], sp\n" \
> +		 "mov	sp, %[new]\n" \
> +		 : [save] "=&r" (saved_sp) \
> +		 : [new] "r" (new_sp) \
> +		)
> +
> +/*
> + * S3 mode resume to the bootloader before jumping back to Linux, so we can be
> + * a little less careful about running from DRAM.
> + */
> +static int brcmstb_pm_do_s3(unsigned long sp)
> +{
> +	unsigned long save_sp;
> +	int ret;
> +
> +	/* Move to a new stack */
> +	SWAP_STACK(sp, save_sp);
> +
> +	/* should not return */
> +	ret = brcmstb_pm_s3_finish();
> +
> +	SWAP_STACK(save_sp, sp);
> +
> +	pr_err("Could not enter S3\n");
> +
> +	return ret;
> +}

The compiler can, and almost certainly will spill stack variables. You
cannot swap the stack safely with inline asm like this. If you need to
do this, you need to perform the whole swap-call-swap sequence in a
single inline asm block.

[...]

> +ENTRY(brcmstb_pm_do_s2)
> +	stmfd	sp!, {r4-r11, lr}
> +	mov	AON_CTRL_REG, r0
> +	mov	DDR_PHY_STATUS_REG, r1
> +
> +	/* Flush memory transactions */
> +	dsb
> +
> +	/* Cache DDR_PHY_STATUS_REG translation */
> +	ldr	r0, [DDR_PHY_STATUS_REG]
> +
> +	/* power down request */
> +	ldr	r0, =PM_S2_COMMAND
> +	ldr	r1, =0
> +	str	r1, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
> +	ldr	r1, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
> +	str	r0, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
> +	ldr	r0, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
> +
> +	/* Wait for interrupt */
> +	wfi
> +	nop
> +
> +	/* Bring MEMC back up */
> +1:	ldr	r0, [DDR_PHY_STATUS_REG]
> +	ands	r0, #1
> +	beq	1b
> +
> +	/* Power-up handshake */
> +	ldr	r0, =1
> +	str	r0, [AON_CTRL_REG, #AON_CTRL_HOST_MISC_CMDS]
> +	ldr	r0, [AON_CTRL_REG, #AON_CTRL_HOST_MISC_CMDS]
> +
> +	ldr	r0, =0
> +	str	r0, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
> +	ldr	r0, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
> +
> +	/* Return to caller */
> +	ldr	r0, =0
> +	ldmfd	sp!, {r4-r11, pc}
> +
> +	ENDPROC(brcmstb_pm_do_s2)

What happens to any page table walks or speculative fetches that occur
in the window where the DDR is off?

If the former can be stalled, the CPU can deadlock. If you can any sort
of external abort as a result of either, the core will go into nowhere
land trying to handle it.

I do not think this is safe.

Thanks,
Mark.
