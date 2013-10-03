Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 02:39:22 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:61639 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868565Ab3JCAjSp0Yol (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Oct 2013 02:39:18 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 02 Oct 2013 17:35:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1022,1371106800"; 
   d="scan'208";a="387026724"
Received: from jonmason-lab.ch.intel.com (HELO jonmason-lab) ([143.182.51.14])
  by orsmga001.jf.intel.com with ESMTP; 02 Oct 2013 17:39:05 -0700
Date:   Wed, 2 Oct 2013 17:39:05 -0700
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
Subject: Re: [PATCH RFC 01/77] PCI/MSI: Fix return value when
 populate_msi_sysfs() failed
Message-ID: <20131003003905.GK6768@jonmason-lab>
References: <cover.1380703262.git.agordeev@redhat.com>
 <3ff5236944aae69f2cd934b5b6da7c1c269df7c1.1380703262.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ff5236944aae69f2cd934b5b6da7c1c269df7c1.1380703262.git.agordeev@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jon.mason@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38173
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

On Wed, Oct 02, 2013 at 12:48:17PM +0200, Alexander Gordeev wrote:
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

Since you are changing the behavior of the msix_capability_init
function on populate_msi_sysfs error, a comment describing why in this
commit would be nice.

> ---
>  drivers/pci/msi.c |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index d5f90d6..b43f391 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -719,7 +719,7 @@ static int msix_capability_init(struct pci_dev *dev,
>  
>  	ret = arch_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
>  	if (ret)
> -		goto error;
> +		goto out_avail;
>  
>  	/*
>  	 * Some devices require MSI-X to be enabled before we can touch the
> @@ -732,10 +732,8 @@ static int msix_capability_init(struct pci_dev *dev,
>  	msix_program_entries(dev, entries);
>  
>  	ret = populate_msi_sysfs(dev);
> -	if (ret) {
> -		ret = 0;
> -		goto error;
> -	}
> +	if (ret)
> +		goto out_free;
>  
>  	/* Set MSI-X enabled bits and unmask the function */
>  	pci_intx_for_msi(dev, 0);
> @@ -746,7 +744,7 @@ static int msix_capability_init(struct pci_dev *dev,
>  
>  	return 0;
>  
> -error:
> +out_avail:
>  	if (ret < 0) {
>  		/*
>  		 * If we had some success, report the number of irqs
> @@ -763,6 +761,7 @@ error:
>  			ret = avail;
>  	}
>  
> +out_free:
>  	free_msi_irqs(dev);
>  
>  	return ret;
> -- 
> 1.7.7.6
> 
