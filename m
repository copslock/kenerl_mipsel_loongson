Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 21:31:56 +0200 (CEST)
Received: from e7.ny.us.ibm.com ([32.97.182.137]:53020 "EHLO e7.ny.us.ibm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868569Ab3JBTbxizdl0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Oct 2013 21:31:53 +0200
Received: from /spool/local
        by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <brking@linux.vnet.ibm.com>;
        Wed, 2 Oct 2013 15:31:46 -0400
Received: from d01dlp02.pok.ibm.com (9.56.250.167)
        by e7.ny.us.ibm.com (192.168.1.107) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 2 Oct 2013 15:31:43 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E7F4B6E8062;
        Wed,  2 Oct 2013 15:31:38 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
        by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r92JVdn17537104;
        Wed, 2 Oct 2013 19:31:39 GMT
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
        by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r92JVa1h025858;
        Wed, 2 Oct 2013 16:31:39 -0300
Received: from [9.10.86.16] (dhcp-9-10-86-16.rchland.ibm.com [9.10.86.16])
        by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id r92JVPVR024907;
        Wed, 2 Oct 2013 16:31:25 -0300
Message-ID: <524C748D.8080803@linux.vnet.ibm.com>
Date:   Wed, 02 Oct 2013 14:31:25 -0500
From:   Brian King <brking@linux.vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To:     Alexander Gordeev <agordeev@redhat.com>
CC:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        "VMware, Inc." <pv-drivers@vmware.com>,
        linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
        stable@vger.kernel.org, linux-s390@vger.kernel.org,
        Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
        linux-rdma@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org, iss_storagedev@hp.com,
        linux-driver@qlogic.com, Tejun Heo <tj@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jon Mason <jon.mason@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        netdev@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        e1000-devel@lists.sourceforge.net,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
        Wendy Xiong <wenxiong@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 36/77] ipr: Enable MSI-X when IPR_USE_MSIX type is
 set, not IPR_USE_MSI
References: <cover.1380703262.git.agordeev@redhat.com> <2d4272136269f3cb3b1a5ac53b12aa45c7ea65c0.1380703263.git.agordeev@redhat.com>
In-Reply-To: <2d4272136269f3cb3b1a5ac53b12aa45c7ea65c0.1380703263.git.agordeev@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: No
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 13100219-5806-0000-0000-000022EF307B
Return-Path: <brking@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brking@linux.vnet.ibm.com
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

On 10/02/2013 05:48 AM, Alexander Gordeev wrote:
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  drivers/scsi/ipr.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
> index fb57e21..762a93e 100644
> --- a/drivers/scsi/ipr.c
> +++ b/drivers/scsi/ipr.c
> @@ -9527,7 +9527,7 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
>  		ipr_number_of_msix = IPR_MAX_MSIX_VECTORS;
>  	}
> 
> -	if (ioa_cfg->ipr_chip->intr_type == IPR_USE_MSI &&
> +	if (ioa_cfg->ipr_chip->intr_type == IPR_USE_MSIX &&
>  			ipr_enable_msix(ioa_cfg) == 0)
>  		ioa_cfg->intr_flag = IPR_USE_MSIX;
>  	else if (ioa_cfg->ipr_chip->intr_type == IPR_USE_MSI &&
> 

Nack. ioa_cfg->ipr_chip->intr_type gets initialized from the ipr_chip table
at the top of the driver which never sets intr_type to IPR_USE_MSIX, so this
will break MSI-X support for ipr. 

We indicate at the chip level only whether we want to force LSI or whether
we want to enable MSI / MSI-X and then try enabling MSI-X and fall back to
MSI if MSI-X is not available or does not work. We then set intr_flag to indicate
what we are actually using on the specific adapter.

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
