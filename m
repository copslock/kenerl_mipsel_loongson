Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 01:47:22 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:33154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992214AbdFSXrOfXC9Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Jun 2017 01:47:14 +0200
Received: from localhost (unknown [69.71.4.159])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B334235E1;
        Mon, 19 Jun 2017 23:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B334235E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date:   Mon, 19 Jun 2017 18:47:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
        Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v5 1/4] PCI: xilinx: Create legacy IRQ domain with size 5
Message-ID: <20170619234708.GG554@bhelgaas-glaptop.roam.corp.google.com>
References: <20170617195741.12757-1-paul.burton@imgtec.com>
 <20170617195741.12757-2-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170617195741.12757-2-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: helgaas@kernel.org
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

[+cc Thomas, Ley Foon]

On Sat, Jun 17, 2017 at 12:57:38PM -0700, Paul Burton wrote:
> The driver expects to use hardware IRQ numbers 1 through 4 for INTX
> interrupts, but only creates an IRQ domain of size 4 (ie. IRQ numbers 0
> through 3). This results in a warning from irq_domain_associate when it
> is called with hwirq=4:
> 
>      WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:365
>          irq_domain_associate+0x170/0x220
>      error: hwirq 0x4 is too large for dummy
>      Modules linked in:
>      CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
>          4.12.0-rc5-00126-g19e1b3a10aad-dirty #427
>      Stack : 0000000000000000 0000000000000004 0000000000000006 ffffffff8092c78a
>              0000000000000061 ffffffff8018bf60 0000000000000000 0000000000000000
>              ffffffff8088c287 ffffffff80811d18 a8000000ffc60000 ffffffff80926678
>              0000000000000001 0000000000000000 ffffffff80887880 ffffffff80960000
>              ffffffff80920000 ffffffff801e6744 ffffffff80887880 a8000000ffc4f8f8
>              000000000000089c ffffffff8018d260 0000000000010000 ffffffff80811d18
>              0000000000000000 0000000000000001 0000000000000000 0000000000000000
>              0000000000000000 a8000000ffc4f840 0000000000000000 ffffffff8042cf34
>              0000000000000000 0000000000000000 0000000000000000 0000000000040c00
>              0000000000000000 ffffffff8010d1c8 0000000000000000 ffffffff8042cf34
>              ...
>      Call Trace:
>      [<ffffffff8010d1c8>] show_stack+0x80/0xa0
>      [<ffffffff8042cf34>] dump_stack+0xd4/0x110
>      [<ffffffff8013ea98>] __warn+0xf0/0x108
>      [<ffffffff8013eb14>] warn_slowpath_fmt+0x3c/0x48
>      [<ffffffff80196528>] irq_domain_associate+0x170/0x220
>      [<ffffffff80196bf0>] irq_create_mapping+0x88/0x118
>      [<ffffffff801976a8>] irq_create_fwspec_mapping+0xb8/0x320
>      [<ffffffff80197970>] irq_create_of_mapping+0x60/0x70
>      [<ffffffff805d1318>] of_irq_parse_and_map_pci+0x20/0x38
>      [<ffffffff8049c210>] pci_fixup_irqs+0x60/0xe0
>      [<ffffffff8049cd64>] xilinx_pcie_probe+0x28c/0x478
>      [<ffffffff804e8ca8>] platform_drv_probe+0x50/0xd0
>      [<ffffffff804e73a4>] driver_probe_device+0x2c4/0x3a0
>      [<ffffffff804e7544>] __driver_attach+0xc4/0xd0
>      [<ffffffff804e5254>] bus_for_each_dev+0x64/0xa8
>      [<ffffffff804e5e40>] bus_add_driver+0x1f0/0x268
>      [<ffffffff804e8000>] driver_register+0x68/0x118
>      [<ffffffff801001a4>] do_one_initcall+0x4c/0x178
>      [<ffffffff808d3ca8>] kernel_init_freeable+0x204/0x2b0
>      [<ffffffff80730b68>] kernel_init+0x10/0xf8
>      [<ffffffff80106218>] ret_from_kernel_thread+0x14/0x1c
> 
> This patch avoids that warning by creating the legacy IRQ domain with
> size 5 rather than 4, allowing it to cover the hwirq=4/INTD case.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Ravikiran Gummaluri <rgummal@xilinx.com>
> Cc: linux-pci@vger.kernel.org
> 
> ---
> 
> Changes in v5:
> - New patch; replacing "PCI: xilinx: Fix INTX irq dispatch".
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/pci/host/pcie-xilinx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index 2fe2df51f9f8..94c71fb91648 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -524,7 +524,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  		return -ENODEV;
>  	}
>  
> -	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 4,
> +	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 1 + 4,

I don't understand this.  Several drivers call irq_domain_add_linear() with
a size of 4:

  dra7xx_pcie_init_irq_domain
  ks_dw_pcie_host_init
  advk_pcie_init_irq_domain
  faraday_pci_setup_cascaded_irq
  rockchip_pcie_init_irq_domain
  nwl_pcie_init_irq_domain

Only one other in drivers/pci uses a size of 5:

  altera_pcie_init_irq_domain

Why can't we use a size of 4 for all of them?  We only have INTA-INTD.  Are
altera and xilinx missing something to apply an offset from the 0-3 space
to the 1-4 space?

>  						 &intx_domain_ops,
>  						 port);
>  	if (!port->leg_domain) {
> -- 
> 2.13.1
> 
