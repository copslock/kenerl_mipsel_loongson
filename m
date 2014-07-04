Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 10:57:32 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:15485 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816503AbaGDI50U-jRL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Jul 2014 10:57:26 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s648vHVf005989
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jul 2014 04:57:17 -0400
Received: from dhcp-26-207.brq.redhat.com (dhcp-26-192.brq.redhat.com [10.34.26.192])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s648vCIM002744
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 4 Jul 2014 04:57:15 -0400
Date:   Fri, 4 Jul 2014 10:58:17 +0200
From:   Alexander Gordeev <agordeev@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/3] PCI/MSI: Add pci_enable_msi_partial()
Message-ID: <20140704085816.GB12247@dhcp-26-207.brq.redhat.com>
References: <cover.1402405331.git.agordeev@redhat.com>
 <4fef62a2e647a7c38e9f2a1ea4244b3506a85e2b.1402405331.git.agordeev@redhat.com>
 <20140702202201.GA28852@google.com>
 <063D6719AE5E284EB5DD2968C1650D6D1726BF4E@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1726BF4E@AcuExch.aculab.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <agordeev@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agordeev@redhat.com
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

On Thu, Jul 03, 2014 at 09:20:52AM +0000, David Laight wrote:
> From: Bjorn Helgaas
> > On Tue, Jun 10, 2014 at 03:10:30PM +0200, Alexander Gordeev wrote:
> > > There are PCI devices that require a particular value written
> > > to the Multiple Message Enable (MME) register while aligned on
> > > power of 2 boundary value of actually used MSI vectors 'nvec'
> > > is a lesser of that MME value:
> > >
> > > 	roundup_pow_of_two(nvec) < 'Multiple Message Enable'
> > >
> > > However the existing pci_enable_msi_block() interface is not
> > > able to configure such devices, since the value written to the
> > > MME register is calculated from the number of requested MSIs
> > > 'nvec':
> > >
> > > 	'Multiple Message Enable' = roundup_pow_of_two(nvec)
> > 
> > For MSI, software learns how many vectors a device requests by reading
> > the Multiple Message Capable (MMC) field.  This field is encoded, so a
> > device can only request 1, 2, 4, 8, etc., vectors.  It's impossible
> > for a device to request 3 vectors; it would have to round up that up
> > to a power of two and request 4 vectors.
> > 
> > Software writes similarly encoded values to MME to tell the device how
> > many vectors have been allocated for its use.  For example, it's
> > impossible to tell the device that it can use 3 vectors; the OS has to
> > round that up and tell the device it can use 4 vectors.
> > 
> > So if I understand correctly, the point of this series is to take
> > advantage of device-specific knowledge, e.g., the device requests 4
> > vectors via MMC, but we "know" the device is only capable of using 3.
> > Moreover, we tell the device via MME that 4 vectors are available, but
> > we've only actually set up 3 of them.
> ...
> 
> Even if you do that, you ought to write valid interrupt information
> into the 4th slot (maybe replicating one of the earlier interrupts).
> Then, if the device does raise the 'unexpected' interrupt you don't
> get a write to a random kernel location.

I might be missing something, but we are talking of MSI address space
here, aren't we? I am not getting how we could end up with a 'write'
to a random kernel location when a unclaimed MSI vector sent. We could
only expect a spurious interrupt at worst, which is handled and reported.

Anyway, as I described in my reply to Bjorn, this is not a concern IMO.

> Plausibly something similar should be done when a smaller number of
> interrupts is assigned.
> 
> 	David
> 

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
