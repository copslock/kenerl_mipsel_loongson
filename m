Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 14:20:42 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:45461 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832655Ab3JHMUgN-pK5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 14:20:36 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r98CKDeW003949
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 8 Oct 2013 08:20:20 -0400
Received: from dhcp-26-207.brq.redhat.com (dhcp-26-163.brq.redhat.com [10.34.26.163])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r98CK0d4024961
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 8 Oct 2013 08:20:03 -0400
Date:   Tue, 8 Oct 2013 14:22:16 +0200
From:   Alexander Gordeev <agordeev@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ben Hutchings <bhutchings@solarflare.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>, Jon Mason <jon.mason@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux390@de.ibm.com,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-ide@vger.kernel.org, iss_storagedev@hp.com,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, e1000-devel@lists.sourceforge.net,
        linux-driver@qlogic.com,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131008122215.GA14389@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
 <1381040386.645.143.camel@pasglop>
 <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
 <20131007180111.GC2481@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131007180111.GC2481@htj.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <agordeev@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38265
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

On Mon, Oct 07, 2013 at 02:01:11PM -0400, Tejun Heo wrote:
> > What about introducing pci_lock_msi() and pci_unlock_msi() and let device
> > drivers care about their ranges and specifics in race-safe manner?
> > I do not call to introduce it right now (since it appears pSeries has not
> > been hitting the race for years) just as a possible alternative to Ben's
> > proposal.
> 
> I don't think the same race condition would happen with the loop.

We need to distinguish the contexts we're discussing.

If we talk about pSeries quota, then the current pSeries pci_enable_msix()
implementation is racy internally and could fail if the quota went down
*while* pci_enable_msix() is executing. In this case the loop will have to
exit rather than retry with a lower number (what number?).

In this regard the new scheme does not bring anything new and relies on
the fact this race does not hit and therefore does not worry.

If we talk about quota as it has to be, then yes - the loop scheme seems
more preferable.

Overall, looks like we just need to fix the pSeries implementation,
if the guys want it, he-he :)

> The problem case is where multiple msi(x) allocation fails completely
> because the global limit went down before inquiry and allocation.  In
> the loop based interface, it'd retry with the lower number.

I am probably missing something here. If the global limit went down before
inquiry then the inquiry will get what is available and try to allocate with
than number.

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
