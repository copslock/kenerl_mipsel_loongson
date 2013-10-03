Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 02:49:42 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:17558 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868567Ab3JCAtjUzBU5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Oct 2013 02:49:39 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 02 Oct 2013 17:49:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1022,1371106800"; 
   d="scan'208";a="413257834"
Received: from jonmason-lab.ch.intel.com (HELO jonmason-lab) ([143.182.51.14])
  by orsmga002.jf.intel.com with ESMTP; 02 Oct 2013 17:49:28 -0700
Date:   Wed, 2 Oct 2013 17:49:28 -0700
From:   Jon Mason <jon.mason@intel.com>
To:     Alexander Gordeev <agordeev@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        stable@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux390@de.ibm.com, linux-s390@vger.kernel.org, x86@kernel.org,
        linux-ide@vger.kernel.org, iss_storagedev@hp.com,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, e1000-devel@lists.sourceforge.net,
        linux-driver@qlogic.com,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 53/77] ntb: Fix missed call to pci_enable_msix()
Message-ID: <20131003004928.GM6768@jonmason-lab>
References: <cover.1380703262.git.agordeev@redhat.com>
 <0590d63c3432229a3824bada71e07a08fb955498.1380703263.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0590d63c3432229a3824bada71e07a08fb955498.1380703263.git.agordeev@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jon.mason@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jon.mason@intel.com
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

On Wed, Oct 02, 2013 at 12:49:09PM +0200, Alexander Gordeev wrote:
> Current MSI-X enablement code assumes MSI-Xs were successfully
> allocated in case less than requested vectors were available.
> That assumption is wrong, since MSI-Xs should be enabled with
> a repeated call to pci_enable_msix(). This update fixes this.

Good catch, I'll pull it in for my next NTB release.

Thanks,
Jon

> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  drivers/ntb/ntb_hw.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_hw.c b/drivers/ntb/ntb_hw.c
> index 1cb6e51..de2062c 100644
> --- a/drivers/ntb/ntb_hw.c
> +++ b/drivers/ntb/ntb_hw.c
> @@ -1075,6 +1075,10 @@ static int ntb_setup_msix(struct ntb_device *ndev)
>  			 "Only %d MSI-X vectors.  Limiting the number of queues to that number.\n",
>  			 rc);
>  		msix_entries = rc;
> +
> +		rc = pci_enable_msix(pdev, ndev->msix_entries, msix_entries);
> +		if (rc)
> +			goto err1;
>  	}
>  
>  	for (i = 0; i < msix_entries; i++) {
> -- 
> 1.7.7.6
> 
