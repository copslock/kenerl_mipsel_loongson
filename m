Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2018 15:49:04 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:42054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992521AbeEWNszmUy0L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 May 2018 15:48:55 +0200
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB05720870;
        Wed, 23 May 2018 13:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527083328;
        bh=7ZfPDd4vPE+T5qEKDqL9+sAWueWTPWkflYowYJ2a3nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=17pABcOfWhtE5IC+yvTA95RFN3YQn/1yU8xavEKS36ZAO2C5ItnPZQrsrrCK7eXuB
         xTcJnHbiEyM+y3QQrWlWsdP6YN+hoD/D6wS1H4kLRm38uw7g2FU3xo2woxz3biCtmT
         5np5QsOD745ttOh7IwaiVMsMLFKsgxyz7djjBX5E=
Date:   Wed, 23 May 2018 08:48:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     linux-pci@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] MIPS: PCI: Use dev_printk() when possible
Message-ID: <20180523134847.GB150632@bhelgaas-glaptop.roam.corp.google.com>
References: <152699466671.162686.1029992586935534102.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152699470263.162686.16975145205315900817.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180523081447.GA15645@jamesdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523081447.GA15645@jamesdev>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64003
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

On Wed, May 23, 2018 at 09:14:48AM +0100, James Hogan wrote:
> On Tue, May 22, 2018 at 08:11:42AM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Use the pci_info() and pci_err() wrappers for dev_printk() when possible.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  arch/mips/pci/pci-legacy.c |    7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
> > index 0c65c38e05d6..73643e80f02d 100644
> > --- a/arch/mips/pci/pci-legacy.c
> > +++ b/arch/mips/pci/pci-legacy.c
> > @@ -263,9 +263,7 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
> >  				(!(r->flags & IORESOURCE_ROM_ENABLE)))
> >  			continue;
> >  		if (!r->start && r->end) {
> > -			printk(KERN_ERR "PCI: Device %s not available "
> > -			       "because of resource collisions\n",
> > -			       pci_name(dev));
> > +			pci_err(dev, "can't enable device: resource collisions\n");
> 
> The pedantic side of me wants to point out that you could wrap that line
> after the comma to keep it within 80 columns.

Done, thanks!

> Either way though:
> Acked-by: James Hogan <jhogan@kernel.org>
> 
> Cheers
> James
