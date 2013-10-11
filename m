Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Oct 2013 10:39:24 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:58595 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824283Ab3JKIjU32UND (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Oct 2013 10:39:20 +0200
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9B8d6oU029473
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 11 Oct 2013 04:39:06 -0400
Received: from dhcp-26-207.brq.redhat.com (dhcp-26-163.brq.redhat.com [10.34.26.163])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r9B8csAu000802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 11 Oct 2013 04:38:57 -0400
Date:   Fri, 11 Oct 2013 10:41:09 +0200
From:   Alexander Gordeev <agordeev@redhat.com>
To:     Mark Lord <kernel@start.ca>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Message-ID: <20131011084108.GA25702@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <5254D397.9030307@zytor.com>
 <1381292648.645.259.camel@pasglop>
 <20131010101704.GC11874@dhcp-26-207.brq.redhat.com>
 <5256D5AB.4050105@zytor.com>
 <20131010180704.GA15719@dhcp-26-207.brq.redhat.com>
 <5257357E.8080506@start.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5257357E.8080506@start.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Return-Path: <agordeev@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38307
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

On Thu, Oct 10, 2013 at 07:17:18PM -0400, Mark Lord wrote:
> Just to help us all understand "the loop" issue..
> 
> Here's an example of driver code which uses the existing MSI-X interfaces,
> for a device which can work with either 16, 8, 4, 2, or 1 MSI-X interrupt.
> This is from a new driver I'm working on right now:
> 
> 
> static int xx_alloc_msix_irqs (struct xx_dev *dev, int nvec)
> {
>         xx_disable_all_irqs(dev);
>         do {
>                 if (nvec < 2)
>                         xx_prep_for_1_msix_vector(dev);
>                 else if (nvec < 4)
>                         xx_prep_for_2_msix_vectors(dev);
>                 else if (nvec < 8)
>                         xx_prep_for_4_msix_vectors(dev);
>                 else if (nvec < 16)
>                         xx_prep_for_8_msix_vectors(dev);
>                 else
>                         xx_prep_for_16_msix_vectors(dev);
>                 nvec = pci_enable_msix(dev->pdev, dev->irqs, dev->num_vectors);
>         } while (nvec > 0);
> 
>         if (nvec) {
>                 kerr(dev->name, "pci_enable_msix() failed, err=%d", nvec);
>                 dev->num_vectors = 0;
>                 return nvec;
>         }
>         return 0;       /* success */
> }

Yeah, that is a very good example.

I would move all xx_prep_for_<pow2>_msix_vector() functions to a single
helper i.e. xx_prep_msix_vectors(dev, ndev).

Considering also (a) we do not want to waste unused platform resources
associated with MSI-Xs and pull more quota than needed and (b) fixing
couple of bugs, this function could look like this:

static int xx_alloc_msix_irqs(struct xx_dev *dev, int nvec_in)
{
	int nvec = roundup_pow_of_two(nvec_in);	/* assume 0 > nvec_in <= 16 */
	int rc;

	xx_disable_all_irqs(dev);

retry:
       	xx_prep_for_msix_vectors(dev, nvec);

	rc = pci_enable_msix(dev->pdev, dev->irqs, nvec);	/* (b) */
	if (rc > 0) {
		nvec = rounddown_pow_of_two(nvec);		/* (a) */
		goto retry;
	}

	if (rc) {
		kerr(dev->name, "pci_enable_msix() failed, err=%d", rc);
		dev->num_vectors = 0;
		return rc;
	}

	dev->num_vectors = nvec;				/* (b) */
	return 0;       /* success */
}

Now, this is a loop-free alternative:

static int xx_alloc_msix_irqs(struct xx_dev *dev, int nvec)
{
	nvec = roundup_pow_of_two(nvec);	/* assume 0 > nvec <= 16 */

	xx_disable_all_irqs(dev);

	pci_lock_msi(dev->pdev);

	rc = pci_get_msix_limit(dev->pdev, nvec);
	if (rc < 0)
		goto err;

	nvec = min(nvec, rc);		/* if limit is more than requested */
	nvec = rounddown_pow_of_two(nvec);	/* (a) */

	xx_prep_for_msix_vectors(dev, nvec);

	rc = pci_enable_msix(dev->pdev, dev->irqs, nvec);	/* (b)	*/
	if (rc < 0)
		goto err;

	pci_unlock_msi(dev->pdev);

	dev->num_vectors = nvec;		/* (b) */
	return 0;

err:
	pci_unlock_msi(dev->pdev);

        kerr(dev->name, "pci_enable_msix() failed, err=%d", rc);
        dev->num_vectors = 0;
        return rc;
}

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
