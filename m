Return-Path: <SRS0=HQ/I=PP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47706C43387
	for <linux-mips@archiver.kernel.org>; Mon,  7 Jan 2019 18:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F822087F
	for <linux-mips@archiver.kernel.org>; Mon,  7 Jan 2019 18:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfAGSP5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:15:57 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:35844 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfAGSP5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 7 Jan 2019 13:15:57 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-103-102-nat.elisa-mobile.fi [85.76.103.102])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 05B724014A;
        Mon,  7 Jan 2019 20:15:54 +0200 (EET)
Date:   Mon, 7 Jan 2019 20:15:54 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     YunQiang Su <syq@debian.org>
Cc:     pburton@wavecomp.com, linux-mips@vger.kernel.org,
        YunQiang Su <ysu@wavecomp.com>
Subject: Re: [PATCH] Disable MSI also when pcie-octeon.pcie_disable on
Message-ID: <20190107181554.GA22416@darkstar.musicnaut.iki.fi>
References: <20190107025542.2273-1-syq@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107025542.2273-1-syq@debian.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

On Mon, Jan 07, 2019 at 10:55:42AM +0800, YunQiang Su wrote:
> From: YunQiang Su <ysu@wavecomp.com>
> 
> Octeon has an boot-time option to disable pcie.
> 
> Since MSI depends on PCI-E, we should also disable MSI also with
> this options is on.
> 
> Signed-off-by: YunQiang Su <ysu@wavecomp.com>
> ---
>  arch/mips/pci/msi-octeon.c  | 9 +++++++--
>  arch/mips/pci/pcie-octeon.c | 5 +++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
> index 2a5bb849b..ed6b2f93d 100644
> --- a/arch/mips/pci/msi-octeon.c
> +++ b/arch/mips/pci/msi-octeon.c
> @@ -45,6 +45,11 @@ static DEFINE_SPINLOCK(msi_free_irq_bitmask_lock);
>   */
>  static int msi_irq_size;
>  
> +/*
> + * whether pcie is disabled?
> + */
> +extern int octeon_pcie_disabled(void);

No need for this.

Just check if octeon_dma_bar_type is OCTEON_DMA_BAR_TYPE_INVALID
at the beginning of octeon_msi_initialize().

A.

>  /**
>   * Called when a driver request MSI interrupts instead of the
>   * legacy INT A-D. This routine will allocate multiple interrupts
> @@ -395,7 +400,7 @@ int __init octeon_msi_initialize(void)
>  	for (irq = OCTEON_IRQ_MSI_BIT0; irq <= OCTEON_IRQ_MSI_LAST; irq++)
>  		irq_set_chip_and_handler(irq, msi, handle_simple_irq);
>  
> -	if (octeon_has_feature(OCTEON_FEATURE_PCIE)) {
> +	if (octeon_has_feature(OCTEON_FEATURE_PCIE) && !octeon_pcie_disabled()) {
>  		if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt0,
>  				0, "MSI[0:63]", octeon_msi_interrupt0))
>  			panic("request_irq(OCTEON_IRQ_PCI_MSI0) failed");
> @@ -413,7 +418,7 @@ int __init octeon_msi_initialize(void)
>  			panic("request_irq(OCTEON_IRQ_PCI_MSI3) failed");
>  
>  		msi_irq_size = 256;
> -	} else if (octeon_is_pci_host()) {
> +	} else if (octeon_is_pci_host() && !octeon_pcie_disabled()) {
>  		if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt0,
>  				0, "MSI[0:15]", octeon_msi_interrupt0))
>  			panic("request_irq(OCTEON_IRQ_PCI_MSI0) failed");
> diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
> index d919a0d81..16d90290a 100644
> --- a/arch/mips/pci/pcie-octeon.c
> +++ b/arch/mips/pci/pcie-octeon.c
> @@ -34,6 +34,11 @@
>  static int pcie_disable;
>  module_param(pcie_disable, int, S_IRUGO);
>  
> +int octeon_pcie_disabled(void){
> +	return pcie_disable;
> +}
> +EXPORT_SYMBOL(octeon_pcie_disabled);
> +
>  static int enable_pcie_14459_war;
>  static int enable_pcie_bus_num_war[2];
>  
> -- 
> 2.20.1
> 
