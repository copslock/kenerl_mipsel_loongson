Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 22:48:17 +0200 (CEST)
Received: from webmail.solarflare.com ([12.187.104.25]:64653 "EHLO
        webmail.solarflare.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868733Ab3JGUsO6Thlc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Oct 2013 22:48:14 +0200
Received: from [10.17.20.137] (10.17.20.137) by ocex02.SolarFlarecom.com
 (10.20.40.31) with Microsoft SMTP Server (TLS) id 14.3.158.1; Mon, 7 Oct 2013
 13:46:56 -0700
Message-ID: <1381178881.1536.28.camel@bwh-desktop.uk.level5networks.com>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
From:   Ben Hutchings <bhutchings@solarflare.com>
To:     Alexander Gordeev <agordeev@redhat.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>, Jon Mason <jon.mason@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux390@de.ibm.com>,
        <linux-s390@vger.kernel.org>, <x86@kernel.org>,
        <linux-ide@vger.kernel.org>, <iss_storagedev@hp.com>,
        <linux-nvme@lists.infradead.org>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>, <e1000-devel@lists.sourceforge.net>,
        <linux-driver@qlogic.com>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        <linux-scsi@vger.kernel.org>
Date:   Mon, 7 Oct 2013 21:48:01 +0100
In-Reply-To: <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
         <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
         <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
         <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
         <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
         <1381009586.645.141.camel@pasglop>
         <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
         <1381040386.645.143.camel@pasglop>
         <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
Organization: Solarflare
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.6.4 (3.6.4-3.fc18) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.137]
X-TM-AS-Product-Ver: SMEX-10.0.0.1412-7.000.1014-20202.000
X-TM-AS-Result: No--30.044700-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
Return-Path: <bhutchings@solarflare.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38244
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

On Sun, 2013-10-06 at 09:10 +0200, Alexander Gordeev wrote:
> On Sun, Oct 06, 2013 at 05:19:46PM +1100, Benjamin Herrenschmidt wrote:
> > On Sun, 2013-10-06 at 08:02 +0200, Alexander Gordeev wrote:
> > > In fact, in the current design to address the quota race decently the
> > > drivers would have to protect the *loop* to prevent the quota change
> > > between a pci_enable_msix() returned a positive number and the the next
> > > call to pci_enable_msix() with that number. Is it doable?
> > 
> > I am not advocating for the current design, simply saying that your
> > proposal doesn't address this issue while Ben's does.
> 
> There is one major flaw in min-max approach - the generic MSI layer
> will have to take decisions on exact number of MSIs to request, not
> device drivers.
[...

No, the min-max functions should be implemented using the same loop that
drivers are expected to use now.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
