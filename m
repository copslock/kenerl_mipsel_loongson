Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 19:16:46 +0200 (CEST)
Received: from dliviu.plus.com ([80.229.23.120]:42177 "EHLO smtp.dudau.co.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009663AbaIYRQoS0swZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Sep 2014 19:16:44 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp.dudau.co.uk (Postfix) with SMTP id 16303FFDBD
        for <linux-mips@linux-mips.org>; Thu, 25 Sep 2014 18:16:43 +0100 (BST)
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id 86D12FFD85;
        Thu, 25 Sep 2014 18:16:12 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Thu, 25 Sep 2014 18:16:12 +0100
Date:   Thu, 25 Sep 2014 18:16:12 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Yijing Wang <wangyijing@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
        Wuyun <wuyun.wu@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arch@vger.kernel.org, arnab.basu@freescale.com,
        Bharat.Bhushan@freescale.com, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Vrabel <david.vrabel@citrix.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
Message-ID: <20140925171612.GC31157@bart.dudau.co.uk>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <20140925074235.GN12423@ulmo>
 <20140925144855.GB31157@bart.dudau.co.uk>
 <20140925164937.GB30382@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140925164937.GB30382@ulmo>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-DSPAM-Result: Innocent
X-DSPAM-Processed: Thu Sep 25 18:16:42 2014
X-DSPAM-Confidence: 1.0000
X-DSPAM-Probability: 0.0023
X-DSPAM-Signature: 100,54244dfa3111023813005
Return-Path: <liviu@dudau.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liviu@dudau.co.uk
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

On Thu, Sep 25, 2014 at 06:49:38PM +0200, Thierry Reding wrote:
> On Thu, Sep 25, 2014 at 03:48:55PM +0100, Liviu Dudau wrote:
> > On Thu, Sep 25, 2014 at 09:42:36AM +0200, Thierry Reding wrote:
> > > On Thu, Sep 25, 2014 at 11:14:10AM +0800, Yijing Wang wrote:
> > > > This series is based Bjorn's pci/msi branch
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/msi
> > > > 
> > > > Currently, there are a lot of weak arch functions in MSI code.
> > > > Thierry Reding Introduced MSI chip framework to configure MSI/MSI-X in arm.
> > > > This series use MSI chip framework to refactor MSI code across all platforms
> > > > to eliminate weak arch functions. Then all MSI irqs will be managed in a 
> > > > unified framework. Because this series changed a lot of ARCH MSI code,
> > > > so tests in the platforms which MSI code modified are warmly welcomed!
> > > 
> > > Apart from the comments to the individual patches I very much like where
> > > this is going. Thanks for taking care of this.
> > > 
> > > Thierry
> > 
> > I am actually in disagreement with you, Thierry. I don't like the general direction
> > of the patches, or at least I don't like the fact that we don't have a portable
> > way of setting up the msi_chip without having to rely on weak architectural hooks.
> 
> Oh, good. That's actually one of the things I said I wasn't happy with
> either. =)
> 
> > I'm surprised no one considers the case of a platform having more than one host
> > bridge and possibly more than one MSI unit. With the current proposed patchset I
> > can't see how that would work.
> 
> The PCI core can already deal with that. An MSI chip can be set per bus
> and the weak pcibios_add_bus() can be used to set that. Often it might
> not even be necessary to do it via pcibios_add_bus() if you create the
> root bus directly, since you can attach the MSI chip at that time.

But I'm thinking that we need to move away from pcibios_add_bus() interface to do
something that should be generic. You don't need to be called for every bus when all
you want is just the root bus in order to add the MSI chip. Also, from looking at
the current patchset, a lot of architectures would set the MSI chip to a global
variable, which means you don't have an option to choose the MSI chip based on the
bus.

> 
> > What I would like to see is a way of creating the pci_host_bridge structure outside
> > the pci_create_root_bus(). That would then allow us to pass this sort of platform
> > details like associated msi_chip into the host bridge and the child busses will
> > have an easy way of finding the information needed by finding the root bus and then
> > the host bridge structure. Then the generic pci_scan_root_bus() can be used by (mostly)
> > everyone and the drivers can remove their kludges that try to work around the
> > current limitations.
> 
> I think both issues are orthogonal. Last time I checked a lot of work
> was still necessary to unify host bridges enough so that it could be
> shared across architectures. But perhaps some of that work has
> happened in the meantime.

Breaking out the host bridge creation from root bus creation is not difficult, just not
agree upon. That would be the first step in making the generic host brige structure
useful for sharing, specially if used as a sort of "parent" structure that you can
wrap with your actual host bridge structure.

> 
> But like I said, when you create the root bus, you can easily attach the
> MSI chip to it.

Not if you want to use the generic pci_scan_root_bus() function. One needs to copy the code
and add their own needed modifications. Which makes it hard to fix bugs and prevents code
reuse.

Best regards,
Liviu

> 
> Thierry



-- 
-------------------
   .oooO
   (   )
    \ (  Oooo.
     \_) (   )
          ) /
         (_/

 One small step
   for me ...
