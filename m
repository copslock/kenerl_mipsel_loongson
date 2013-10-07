Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 22:46:25 +0200 (CEST)
Received: from webmail.solarflare.com ([12.187.104.25]:64593 "EHLO
        webmail.solarflare.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868733Ab3JGUqW0OP11 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Oct 2013 22:46:22 +0200
Received: from [10.17.20.137] (10.17.20.137) by ocex02.SolarFlarecom.com
 (10.20.40.31) with Microsoft SMTP Server (TLS) id 14.3.158.1; Mon, 7 Oct 2013
 13:45:14 -0700
Message-ID: <1381178766.1536.26.camel@bwh-desktop.uk.level5networks.com>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
From:   Ben Hutchings <bhutchings@solarflare.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Tejun Heo <tj@kernel.org>, Alexander Gordeev <agordeev@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>,
        "Jon Mason" <jon.mason@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux390@de.ibm.com>,
        <linux-s390@vger.kernel.org>, <x86@kernel.org>,
        <linux-ide@vger.kernel.org>, <iss_storagedev@hp.com>,
        <linux-nvme@lists.infradead.org>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>, <e1000-devel@lists.sourceforge.net>,
        <linux-driver@qlogic.com>,
        "Solarflare linux maintainers" <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        <linux-scsi@vger.kernel.org>
Date:   Mon, 7 Oct 2013 21:46:06 +0100
In-Reply-To: <1381176656.645.171.camel@pasglop>
References: <cover.1380703262.git.agordeev@redhat.com>
         <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
         <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
         <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
         <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
         <1381009586.645.141.camel@pasglop>
         <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
         <1381040386.645.143.camel@pasglop>
         <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
         <20131007180111.GC2481@htj.dyndns.org> <1381176656.645.171.camel@pasglop>
Organization: Solarflare
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.6.4 (3.6.4-3.fc18) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.137]
X-TM-AS-Product-Ver: SMEX-10.0.0.1412-7.000.1014-20202.000
X-TM-AS-Result: No--28.111100-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
Return-Path: <bhutchings@solarflare.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhutchings@solarflare.com
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

On Tue, 2013-10-08 at 07:10 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2013-10-07 at 14:01 -0400, Tejun Heo wrote:
> > I don't think the same race condition would happen with the loop.  The
> > problem case is where multiple msi(x) allocation fails completely
> > because the global limit went down before inquiry and allocation.  In
> > the loop based interface, it'd retry with the lower number.
> > 
> > As long as the number of drivers which need this sort of adaptive
> > allocation isn't too high and the common cases can be made simple, I
> > don't think the "complex" part of interface is all that important.
> > Maybe we can have reserve / cancel type interface or just keep the
> > loop with more explicit function names (ie. try_enable or something
> > like that).
> 
> I'm thinking a better API overall might just have been to request
> individual MSI-X one by one :-)
> 
> We want to be able to request an MSI-X at runtime anyway ... if I want
> to dynamically add a queue to my network interface, I want it to be able
> to pop a new arbitrary MSI-X.

Yes, this would be very useful.

> And we don't want to lock drivers into contiguous MSI-X sets either.

I don't think there's any such limitation now.  The entries array passed
to pci_enable_msix() specifies which MSI-X vectors the driver wants to
enable.  It's usually filled with 0..nvec-1 in order, but not always.
And the IRQ numbers returned aren't usually contiguous either, on x86.

Ben.

> And for the cleanup ... well that's what the "pcim" functions are for,
> we can just make MSI-X variants.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
