Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2013 09:41:18 +0200 (CEST)
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:41458 "EHLO
        e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822429Ab3JDHlPGMDFV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Oct 2013 09:41:15 +0200
Received: from /spool/local
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <schwidefsky@de.ibm.com>;
        Fri, 4 Oct 2013 08:41:08 +0100
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp11.uk.ibm.com (192.168.101.141) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Fri, 4 Oct 2013 08:41:06 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id DC0912190059;
        Fri,  4 Oct 2013 08:41:05 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com [9.149.37.251])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r947ernv21168256;
        Fri, 4 Oct 2013 07:40:53 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r947f43Q015368;
        Fri, 4 Oct 2013 01:41:05 -0600
Received: from mschwide (icon-9-167-244-96.megacenter.de.ibm.com [9.167.244.96])
        by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id r947f0JC015239;
        Fri, 4 Oct 2013 01:41:00 -0600
Date:   Fri, 4 Oct 2013 09:40:53 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Alexander Gordeev <agordeev@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>, Jon Mason <jon.mason@intel.com>,
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
Subject: Re: [PATCH RFC 04/77] PCI/MSI/s390: Remove superfluous check of MSI
 type
Message-ID: <20131004094053.5e846a29@mschwide>
In-Reply-To: <bae65aa3e30dfd23bd5ed47add7310cfbb96243a.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
        <bae65aa3e30dfd23bd5ed47add7310cfbb96243a.1380703262.git.agordeev@redhat.com>
Organization: IBM Corporation
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: No
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 13100407-5024-0000-0000-000007686540
Return-Path: <schwidefsky@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwidefsky@de.ibm.com
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

On Wed,  2 Oct 2013 12:48:20 +0200
Alexander Gordeev <agordeev@redhat.com> wrote:

> arch_setup_msi_irqs() hook can only be called from the generic
> MSI code which ensures correct MSI type parameter.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  arch/s390/pci/pci.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index c79c6e4..61a3c2c 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -425,8 +425,6 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  	int rc;
> 
>  	pr_debug("%s: requesting %d MSI-X interrupts...", __func__, nvec);
> -	if (type != PCI_CAP_ID_MSIX && type != PCI_CAP_ID_MSI)
> -		return -EINVAL;
>  	if (type == PCI_CAP_ID_MSI && nvec > 1)
>  		return 1;
>  	msi_vecs = min(nvec, ZPCI_MSI_VEC_MAX);

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
