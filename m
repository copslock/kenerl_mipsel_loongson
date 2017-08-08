Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 22:45:21 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994870AbdHHUpM2n72S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Aug 2017 22:45:12 +0200
Received: from localhost (unknown [69.71.4.159])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81D6323695;
        Tue,  8 Aug 2017 20:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D6323695
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date:   Tue, 8 Aug 2017 15:45:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v6 1/6] PCI: Move enum pci_interrupt_pin to a new common
 header
Message-ID: <20170808204506.GA21796@bhelgaas-glaptop.roam.corp.google.com>
References: <20170806000351.17952-1-paul.burton@imgtec.com>
 <20170806000351.17952-2-paul.burton@imgtec.com>
 <20170808202745.GL16580@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170808202745.GL16580@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59430
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

On Tue, Aug 08, 2017 at 03:27:45PM -0500, Bjorn Helgaas wrote:
> On Sat, Aug 05, 2017 at 05:03:46PM -0700, Paul Burton wrote:
> > We currently have a definition of enum pci_interrupt_pin in a header
> > specific to PCI endpoints - pci-epf.h. In order to allow for use of this
> > enum from PCI host code in a future commit, move its definition to a new
> > pci-common.h header which we'll include from both host & endpoint code.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > 
> > ---
> > 
> > Changes in v6:
> > - New patch.
> > 
> >  include/linux/pci-common.h | 31 +++++++++++++++++++++++++++++++
> >  include/linux/pci-epf.h    |  9 +--------
> >  2 files changed, 32 insertions(+), 8 deletions(-)
> >  create mode 100644 include/linux/pci-common.h
> > 
> > diff --git a/include/linux/pci-common.h b/include/linux/pci-common.h
> > new file mode 100644
> > index 000000000000..6a69a2c95ac7
> > --- /dev/null
> > +++ b/include/linux/pci-common.h
> > @@ -0,0 +1,31 @@
> > +/**
> > + * Common PCI definitions
> > + *
> > + * This program is free software: you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 of
> > + * the License as published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef __LINUX_PCI_COMMON_H__
> > +#define __LINUX_PCI_COMMON_H__
> > +
> > +/**
> > + * enum pci_interrupt_pin - PCI INTx interrupt values
> > + * @PCI_INTERRUPT_UNKNOWN: Unknown or unassigned interrupt
> > + * @PCI_INTERRUPT_INTA: PCI INTA pin
> > + * @PCI_INTERRUPT_INTB: PCI INTB pin
> > + * @PCI_INTERRUPT_INTC: PCI INTC pin
> > + * @PCI_INTERRUPT_INTD: PCI INTD pin
> > + *
> > + * Corresponds to values for legacy PCI INTx interrupts, as can be found in the
> > + * PCI_INTERRUPT_PIN register.
> > + */
> > +enum pci_interrupt_pin {
> > +	PCI_INTERRUPT_UNKNOWN,
> > +	PCI_INTERRUPT_INTA,
> > +	PCI_INTERRUPT_INTB,
> > +	PCI_INTERRUPT_INTC,
> > +	PCI_INTERRUPT_INTD,
> > +};
> 
> Could this (and the new pci_irqd_intx_xlate() added in the next patch)
> go in drivers/pci/pci.h instead?
> 
> If pci_irqd_intx_xlate() needs to be in include/linux/pci.h, is there
> a reason this enum couldn't go there as well?

Also, I'd kind of like to have a PCI_NUM_INTX or similar that all the
drivers could use instead of defining their own.
