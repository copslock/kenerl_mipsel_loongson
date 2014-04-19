Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Apr 2014 17:39:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54088 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816414AbaDSPjKRlprl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Apr 2014 17:39:10 +0200
Date:   Sat, 19 Apr 2014 16:39:10 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: Malta: support powering down
In-Reply-To: <1395415232-42288-2-git-send-email-paul.burton@imgtec.com>
Message-ID: <alpine.LFD.2.11.1404191624180.11598@eddie.linux-mips.org>
References: <1395415232-42288-1-git-send-email-paul.burton@imgtec.com> <1395415232-42288-2-git-send-email-paul.burton@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 21 Mar 2014, Paul Burton wrote:

> This patch makes the mips_machine_halt function (used as _machine_halt &
> pm_power_off) actually power down the Malta via the PIIX4. It may then
> be powered back up by pressing the "ON/NMI" button (S4) on the board.
> 
> Tested-by: James Hogan <james.hogan@imgtec.com>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
[...]
> diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/malta-reset.c
> index d627d4b..ef04c8b 100644
> --- a/arch/mips/mti-malta/malta-reset.c
> +++ b/arch/mips/mti-malta/malta-reset.c
> @@ -24,10 +27,72 @@ static void mips_machine_restart(char *command)
>  
>  static void mips_machine_halt(void)
>  {

 First of all, shouldn't all of this stuff be wired into 
mips_machine_power_off rather than mips_machine_halt?  I would have 
thought mips_machine_halt is supposed to get back to the console monitor 
prompt (YAMON in this case) without restarting or powering off the system, 
and if that's impossible, then loop indefinitely (that's the -H vs -P 
action option to shutdown(8); see the details in the manual).

> -	unsigned int __iomem *softres_reg =
> -		ioremap(SOFTRES_REG, sizeof(unsigned int));
> +	struct pci_bus *bus;
> +	struct pci_dev *dev;
> +	int spec_devid, res;
> +	int io_region = PCI_BRIDGE_RESOURCES;
> +	resource_size_t io;
> +	u16 sts;
>  
> -	__raw_writel(GORESET, softres_reg);
> +	/* Find the PIIX4 PM device */
> +	dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
> +			     PCI_DEVICE_ID_INTEL_82371AB_3, PCI_ANY_ID,
> +			     PCI_ANY_ID, NULL);
> +	if (!dev) {
> +		printk("Failed to find PIIX4 PM\n");
> +		goto fail;
> +	}
> +
> +	/* Request access to the PIIX4 PM IO registers */
> +	res = pci_request_region(dev, io_region, "PIIX4 PM IO registers");
> +	if (res) {
> +		printk("Failed to request PIIX4 PM IO registers (%d)\n", res);
> +		goto fail_dev_put;
> +	}

 Shouldn't the handle on the device and the resource be requested early 
on, where mips_machine_halt (mips_machine_power_off) is installed as the 
halt (power-off) handler?  Especially requesting the resource here seems 
to make little sense to me -- we're about to kill the box, so why bother 
verifying whether it's going to interfere with a random driver?

> +
> +	/* Find the offset to the PIIX4 PM IO registers */
> +	io = pci_resource_start(dev, io_region);
> +
> +	/* Ensure the power button status is clear */
> +	while (1) {
> +		sts = inw(io + PIIX4_FUNC3IO_PMSTS);
> +		if (!(sts & PIIX4_FUNC3IO_PMSTS_PWRBTN_STS))
> +			break;
> +		outw(sts, io + PIIX4_FUNC3IO_PMSTS);
> +	}
> +
> +	/* Enable entry to suspend */
> +	outw(PIIX4_FUNC3IO_PMCNTRL_SUS_EN, io + PIIX4_FUNC3IO_PMCNTRL);
> +
> +	/* If the special cycle occurs too soon this doesn't work... */
> +	mdelay(10);
> +
> +	/* Find a reference to the PCI bus */
> +	bus = pci_find_next_bus(NULL);
> +	if (!bus) {
> +		printk("Failed to find PCI bus\n");
> +		goto fail_release_region;
> +	}
> +
> +	/*
> +	 * The PIIX4 will enter the suspend state only after seeing a special
> +	 * cycle with the correct magic data on the PCI bus. Generate that
> +	 * cycle now.
> +	 */
> +	spec_devid = PCI_DEVID(0, PCI_DEVFN(0x1f, 0x7));
> +	pci_bus_write_config_dword(bus, spec_devid, 0, PIIX4_SUSPEND_MAGIC);

 I know all the three of the GT-64120/64120A, Bonito and SOC-it system 
controllers support software generation of PCI special cycles, but is the 
method the same across them all?

  Maciej
