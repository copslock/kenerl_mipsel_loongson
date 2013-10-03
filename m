Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 02:30:13 +0200 (CEST)
Received: from mga14.intel.com ([143.182.124.37]:38389 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815749Ab3JCAaKuFuvx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Oct 2013 02:30:10 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by azsmga102.ch.intel.com with ESMTP; 02 Oct 2013 17:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1022,1371106800"; 
   d="scan'208";a="404515001"
Received: from jonmason-lab.ch.intel.com (HELO jonmason-lab) ([143.182.51.14])
  by fmsmga001.fm.intel.com with ESMTP; 02 Oct 2013 17:29:42 -0700
Date:   Wed, 2 Oct 2013 17:29:42 -0700
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
        linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux390@de.ibm.com,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-ide@vger.kernel.org, iss_storagedev@hp.com,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, e1000-devel@lists.sourceforge.net,
        linux-driver@qlogic.com,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 77/77] vxge: Update MSI/MSI-X interrupts enablement
 code
Message-ID: <20131003002941.GJ6768@jonmason-lab>
References: <cover.1380703262.git.agordeev@redhat.com>
 <467ce10b1df795edf80ed222816ab739fee7b0ea.1380703263.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <467ce10b1df795edf80ed222816ab739fee7b0ea.1380703263.git.agordeev@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jon.mason@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38172
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

On Wed, Oct 02, 2013 at 12:49:33PM +0200, Alexander Gordeev wrote:
> As result of recent re-design of the MSI/MSI-X interrupts enabling
> pattern this driver has to be updated to use the new technique to
> obtain a optimal number of MSI/MSI-X interrupts required.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  drivers/net/ethernet/neterion/vxge/vxge-main.c |   36 ++++++++++-------------
>  1 files changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/neterion/vxge/vxge-main.c b/drivers/net/ethernet/neterion/vxge/vxge-main.c
> index b81ff8b..b4d40dd 100644
> --- a/drivers/net/ethernet/neterion/vxge/vxge-main.c
> +++ b/drivers/net/ethernet/neterion/vxge/vxge-main.c
> @@ -2297,7 +2297,21 @@ static int vxge_alloc_msix(struct vxgedev *vdev)
>  	int msix_intr_vect = 0, temp;
>  	vdev->intr_cnt = 0;
>  
> -start:
> +	ret = pci_msix_table_size(vdev->pdev);
> +	if (ret < 0)
> +		goto alloc_entries_failed;
> +
> +	if (ret < (vdev->no_of_vpath * 2 + 1)) {
> +		if ((max_config_vpath != VXGE_USE_DEFAULT) || (ret < 3)) {
> +			ret = -ENOSPC;
> +			goto alloc_entries_failed;
> +		}
> +		/* Try with less no of vector by reducing no of vpaths count */
> +		temp = (ret - 1)/2;
> +		vxge_close_vpaths(vdev, temp);
> +		vdev->no_of_vpath = temp;
> +	}

The original code was ugly (not my code, so I can say that).  I'd like
to see it a little stream lined.  Something like:


        vdev->intr_cnt = pci_msix_table_size(vdev->pdev);

        if (vdev->intr_cnt % 2 == 0)
                vdev->intr_cnt--;

        if (vdev->intr_cnt < 3 || max_config_vpath != VXGE_USE_DEFAULT)
                goto alloc_entries_failed;

        if (vdev->intr_cnt != vdev->no_of_vpath * 2 + 1) {
                vxge_close_vpaths(vdev, vdev->intr_cnt / 2);
                vdev->no_of_vpath = vdev->intr_cnt / 2;
        }


> +
>  	/* Tx/Rx MSIX Vectors count */
>  	vdev->intr_cnt = vdev->no_of_vpath * 2;
>  
> @@ -2347,25 +2361,7 @@ start:
>  	vdev->vxge_entries[j].in_use = 0;
>  
>  	ret = pci_enable_msix(vdev->pdev, vdev->entries, vdev->intr_cnt);
> -	if (ret > 0) {
> -		vxge_debug_init(VXGE_ERR,
> -			"%s: MSI-X enable failed for %d vectors, ret: %d",
> -			VXGE_DRIVER_NAME, vdev->intr_cnt, ret);
> -		if ((max_config_vpath != VXGE_USE_DEFAULT) || (ret < 3)) {
> -			ret = -ENOSPC;
> -			goto enable_msix_failed;
> -		}
> -
> -		kfree(vdev->entries);
> -		kfree(vdev->vxge_entries);
> -		vdev->entries = NULL;
> -		vdev->vxge_entries = NULL;
> -		/* Try with less no of vector by reducing no of vpaths count */
> -		temp = (ret - 1)/2;
> -		vxge_close_vpaths(vdev, temp);
> -		vdev->no_of_vpath = temp;
> -		goto start;
> -	} else if (ret < 0)
> +	if (ret)
>  		goto enable_msix_failed;

Nit, space here please.

>  	return 0;
>  
> -- 
> 1.7.7.6
> 
