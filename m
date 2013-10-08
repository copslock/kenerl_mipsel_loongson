Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 09:46:37 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:9689 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832655Ab3JHHqfQ05L0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 09:46:35 +0200
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r987kK8n000386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 8 Oct 2013 03:46:20 -0400
Received: from dhcp-26-207.brq.redhat.com (vpn-57-75.rdu2.redhat.com [10.10.57.75])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r987kBV2019903
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 8 Oct 2013 03:46:13 -0400
Date:   Tue, 8 Oct 2013 09:48:26 +0200
From:   Alexander Gordeev <agordeev@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>, Jon Mason <jon.mason@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux390@de.ibm.com, linux-s390@vger.kernel.org, x86@kernel.org,
        linux-ide@vger.kernel.org, iss_storagedev@hp.com,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, e1000-devel@lists.sourceforge.net,
        linux-driver@qlogic.com,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 07/77] PCI/MSI: Re-design MSI/MSI-X interrupts
 enablement pattern
Message-ID: <20131008074826.GD10669@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <d8c36203ada6efbfa9f7ce92c2f713ee3b6d6b8d.1380703262.git.agordeev@redhat.com>
 <20131007181749.GB27396@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131007181749.GB27396@htj.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Return-Path: <agordeev@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38255
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

On Mon, Oct 07, 2013 at 02:17:49PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Wed, Oct 02, 2013 at 12:48:23PM +0200, Alexander Gordeev wrote:
> > +static int foo_driver_enable_msi(struct foo_adapter *adapter, int nvec)
> > +{
> > +	rc = pci_get_msi_cap(adapter->pdev);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	nvec = min(nvec, rc);
> > +	if (nvec < FOO_DRIVER_MINIMUM_NVEC) {
> > +		return -ENOSPC;
> > +
> > +	rc = pci_enable_msi_block(adapter->pdev, nvec);
> > +	return rc;
> > +}
> 
> If there are many which duplicate the above pattern, it'd probably be
> worthwhile to provide a helper?  It's usually a good idea to reduce
> the amount of boilerplate code in drivers.

I wanted to limit discussion in v1 to as little changes as possible.
I 'planned' those helper(s) for a separate effort if/when the most
important change is accepted and soaked a bit.

> > @@ -975,7 +951,7 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
> >  	if (nr_entries < 0)
> >  		return nr_entries;
> >  	if (nvec > nr_entries)
> > -		return nr_entries;
> > +		return -EINVAL;
> >  
> >  	/* Check for any invalid entries */
> >  	for (i = 0; i < nvec; i++) {
> 
> If we do things this way, it breaks all drivers using this interface
> until they're converted, right?

Right. And the rest of the series does it.

> Also, it probably isn't the best idea
> to flip the behavior like this as this can go completely unnoticed (no
> compiler warning or anything, the same function just behaves
> differently).  Maybe it'd be a better idea to introduce a simpler
> interface that most can be converted to?

Well, an *other* interface is a good idea. What do you mean with the
simpler here?

> tejun

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
