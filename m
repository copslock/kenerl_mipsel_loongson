Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 23:42:45 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994792AbdEXVmbAOQJu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 May 2017 23:42:31 +0200
Received: from localhost (unknown [69.71.4.159])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0836B239E9;
        Wed, 24 May 2017 21:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0836B239E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date:   Wed, 24 May 2017 16:42:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
        Joshua Kinard <kumba@gentoo.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] MIPS: PCI: Remove unused busn_offset
Message-ID: <20170524214227.GC2794@bhelgaas-glaptop.roam.corp.google.com>
References: <20170519195559.25338.30891.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170519195606.25338.73798.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170519195606.25338.73798.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57997
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

On Fri, May 19, 2017 at 02:56:06PM -0500, Bjorn Helgaas wrote:
> pci_add_resource_offset() is for host bridge windows where the bridge
> translates CPU addresses to PCI bus addresses by adding an offset.  To my
> knowledge, no host bridge translates bus numbers, so this is only useful
> for MEM and IO windows.  In any event, host->busn_offset is never set to
> anything other than zero, so pci_add_resource() is sufficient.
> 
> a2e50f53d535 ("MIPS: PCI: Add a hook for IORESOURCE_BUS in
> pci_controller/bridge_controller") also added busn_resource itself.  This
> is currently unused but may be used by future SGI IP27 fixes, so I left it
> there.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Joshua Kinard <kumba@gentoo.org>

I applied both of these to pci/misc for v4.13.

> ---
>  arch/mips/include/asm/pci.h |    1 -
>  arch/mips/pci/pci-legacy.c  |    3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> index 1000c1b4c875..52f551ee492d 100644
> --- a/arch/mips/include/asm/pci.h
> +++ b/arch/mips/include/asm/pci.h
> @@ -39,7 +39,6 @@ struct pci_controller {
>  	unsigned long io_offset;
>  	unsigned long io_map_base;
>  	struct resource *busn_resource;
> -	unsigned long busn_offset;
>  
>  #ifndef CONFIG_PCI_DOMAINS_GENERIC
>  	unsigned int index;
> diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
> index 3a84f6c0c840..174575a9a112 100644
> --- a/arch/mips/pci/pci-legacy.c
> +++ b/arch/mips/pci/pci-legacy.c
> @@ -86,8 +86,7 @@ static void pcibios_scanbus(struct pci_controller *hose)
>  				hose->mem_resource, hose->mem_offset);
>  	pci_add_resource_offset(&resources,
>  				hose->io_resource, hose->io_offset);
> -	pci_add_resource_offset(&resources,
> -				hose->busn_resource, hose->busn_offset);
> +	pci_add_resource(&resources, hose->busn_resource);
>  	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
>  				&resources);
>  	hose->bus = bus;
> 
