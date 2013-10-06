Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Oct 2013 08:01:04 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:49838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816383Ab3JFGBBxfZ-z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 6 Oct 2013 08:01:01 +0200
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9660eDi021632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sun, 6 Oct 2013 02:00:40 -0400
Received: from dhcp-26-207.brq.redhat.com (vpn-56-47.rdu2.redhat.com [10.10.56.47])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r9660Sb4016871
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Sun, 6 Oct 2013 02:00:31 -0400
Date:   Sun, 6 Oct 2013 08:02:44 +0200
From:   Alexander Gordeev <agordeev@redhat.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Ben Hutchings <bhutchings@solarflare.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
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
Message-ID: <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1381009586.645.141.camel@pasglop>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <agordeev@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38208
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

On Sun, Oct 06, 2013 at 08:46:26AM +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2013-10-05 at 16:20 +0200, Alexander Gordeev wrote:
> > So my point is - drivers should first obtain a number of MSIs they *can*
> > get, then *derive* a number of MSIs the device is fine with and only then
> > request that number. Not terribly different from memory or any other type
> > of resource allocation ;)
> 
> What if the limit is for a group of devices ? Your interface is racy in
> that case, another driver could have eaten into the limit in between the
> calls.

Well, the another driver has had a better karma ;) But seriously, the
current scheme with a loop is not race-safe wrt to any other type of
resource which might exhaust. What makes the quota so special so we
should care about it and should not care i.e. about lack of msi_desc's?

Yeah, I know the quota might hit more likely. But why it is not addressed
right now then? Not a single function in chains...
  rtas_msi_check_device() -> msi_quota_for_device() -> traverse_pci_devices()
  rtas_setup_msi_irqs() -> msi_quota_for_device() -> traverse_pci_devices()
...is race-safe. So if it has not been bothering anyone until now then
no reason to start worrying now :)

In fact, in the current design to address the quota race decently the
drivers would have to protect the *loop* to prevent the quota change
between a pci_enable_msix() returned a positive number and the the next
call to pci_enable_msix() with that number. Is it doable?

> Ben.
> 
> 

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
