Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2013 11:19:24 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:10529 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822318Ab3JDJTRiZW0v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Oct 2013 11:19:17 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r949J0bp021482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 4 Oct 2013 05:19:00 -0400
Received: from dhcp-26-207.brq.redhat.com (dhcp-26-122.brq.redhat.com [10.34.26.122])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r949Ip8Y009272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 4 Oct 2013 05:18:54 -0400
Date:   Fri, 4 Oct 2013 11:21:09 +0200
From:   Alexander Gordeev <agordeev@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Ben Hutchings <bhutchings@solarflare.com>,
        linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
        linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
        linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-pci@vger.kernel.org, iss_storagedev@hp.com,
        linux-driver@qlogic.com, Tejun Heo <tj@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jon Mason <jon.mason@intel.com>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        e1000-devel@lists.sourceforge.net,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131004092108.GB4536@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7371@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7371@saturn3.aculab.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <agordeev@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38202
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

On Fri, Oct 04, 2013 at 09:31:49AM +0100, David Laight wrote:
> > Mmmm.. I am not sure I am getting it. Could you please rephrase?
> 
> One possibility is for drivers than can use a lot of interrupts to
> request a minimum number initially and then request the additional
> ones much later on.
> That would make it less likely that none will be available for
> devices/drivers that need them but are initialised later.

It sounds as a whole new topic for me. Isn't it?

Anyway, what prevents the above from being done with pci_enable_msix(nvec1) -
pci_disable_msix() - pci_enable_msix(nvec2) where nvec1 < nvec2?

> 	David

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
