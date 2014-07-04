Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 11:53:46 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:61618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816005AbaGDJxnt1U9s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Jul 2014 11:53:43 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s649rZDT019439
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jul 2014 05:53:35 -0400
Received: from dhcp-26-207.brq.redhat.com (dhcp-26-192.brq.redhat.com [10.34.26.192])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s649rU3i013233
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 4 Jul 2014 05:53:32 -0400
Date:   Fri, 4 Jul 2014 11:54:34 +0200
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
Message-ID: <20140704095434.GC12247@dhcp-26-207.brq.redhat.com>
References: <cover.1402405331.git.agordeev@redhat.com>
 <4fef62a2e647a7c38e9f2a1ea4244b3506a85e2b.1402405331.git.agordeev@redhat.com>
 <20140702202201.GA28852@google.com>
 <063D6719AE5E284EB5DD2968C1650D6D1726BF4E@AcuExch.aculab.com>
 <20140704085816.GB12247@dhcp-26-207.brq.redhat.com>
 <063D6719AE5E284EB5DD2968C1650D6D1726C717@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1726C717@AcuExch.aculab.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <agordeev@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41021
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

On Fri, Jul 04, 2014 at 09:11:50AM +0000, David Laight wrote:
> > I might be missing something, but we are talking of MSI address space
> > here, aren't we? I am not getting how we could end up with a 'write'
> > to a random kernel location when a unclaimed MSI vector sent. We could
> > only expect a spurious interrupt at worst, which is handled and reported.
> > 
> > Anyway, as I described in my reply to Bjorn, this is not a concern IMO.
> 
> I'm thinking of the following - which might be MSI-X ?
> 1) Hardware requests some interrupts and tells the host the BAR (and offset)
>    where the 'vectors' should be written.
> 2) To raise an interrupt the hardware uses the 'vector' as the address
>    of a normal PCIe write cycle.
> 
> So if the hardware requests 4 interrupts, but the driver (believing it
> will only use 3) only write 3 vectors, and then the hardware uses the
> 4th vector it can write to a random location.
> 
> Debugging that would be hard!

MSI base address is kind of hardcoded for a platform. A combination of
MSI base address, PCI function number and MSI vector makes a PCI host to
raise interrupt on a CPU. I might be inaccurate in details, but the scenario
you described is impossible AFAICT.

> 	David
> 
> 
> 

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
