Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 10:03:06 +0200 (CEST)
Received: from mail-ee0-f47.google.com ([74.125.83.47]:50859 "EHLO
        mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819540Ab3JCIDDnXpxB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Oct 2013 10:03:03 +0200
Received: by mail-ee0-f47.google.com with SMTP id d49so896054eek.20
        for <linux-mips@linux-mips.org>; Thu, 03 Oct 2013 01:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-type
         :content-transfer-encoding;
        bh=K9lP+ptdyKXFDeCSWmRsk/PGpckF0vT1dyAejpdevRs=;
        b=OZ8BWzZVOXW2jDT514RY3Rt0cdM/DocCIuVD3gCJR5fSsu9a+vNVCa/QKA9IDmRQ/h
         D9ivhnb33OZgve+w9QSvJI2SgnmahCqKBujW/LvYGj6iZ67njlvWCgoCSAOO8U8vZaEJ
         aeKc55XQVRXxWcZKtmpNSheseiPyKEAJRgMH6jikDgWq0IFPbJBL5LOGI7zNwXX651YB
         17ap3kxz3KDUAWEokIm2yFH+2ehQIgsbuAnxC4Vysf1BSl2I0SsGWZVHNn1ewDdMEyuk
         hJ0XsHz4ErnzKSbPSnSo/iQRYX9l7/UEnqivzflwQmw00MeAug84anfp8cY/TaWq1MfS
         WKbg==
X-Gm-Message-State: ALoCoQlx6GzSeaVxOcXIIwunmHGCNgk9RQS5Y8A+oWqLtm8eF950VPVb54NQugPfDVy1e85EgqFR
X-Received: by 10.14.115.133 with SMTP id e5mr10797848eeh.27.1380787378085;
        Thu, 03 Oct 2013 01:02:58 -0700 (PDT)
Received: from jpm-OptiPlex-GX620 (out.voltaire.com. [193.47.165.251])
        by mx.google.com with ESMTPSA id b45sm12713094eef.4.1969.12.31.16.00.00
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 03 Oct 2013 01:02:56 -0700 (PDT)
Date:   Thu, 3 Oct 2013 11:02:54 +0300
From:   Jack Morgenstein <jackm@dev.mellanox.co.il>
To:     Alexander Gordeev <agordeev@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
        "VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org,
        ogerlitz@mellanox.com, eli@mellanox.com
Subject: Re: [PATCH RFC 46/77] mlx4: Update MSI/MSI-X interrupts enablement
 code
Message-ID: <20131003110254.5f10fbb8@jpm-OptiPlex-GX620>
In-Reply-To: <b0a9f6f455aa03b7769e6d9cc2e7fdbc06732b2f.1380703263.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
        <b0a9f6f455aa03b7769e6d9cc2e7fdbc06732b2f.1380703263.git.agordeev@redhat.com>
Organization: Mellanox
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <jackm@dev.mellanox.co.il>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jackm@dev.mellanox.co.il
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

On Wed,  2 Oct 2013 12:49:02 +0200
Alexander Gordeev <agordeev@redhat.com> wrote:

NACK.  This change does not do anything logically as far as I can tell.
pci_enable_msix in the current upstream kernel itself calls
pci_msix_table_size.  The current code yields the same results
as the code suggested below. (i.e., the suggested code has no effect on
optimality).

BTW, pci_msix_table_size never returns a value < 0 (if msix is not
enabled, it returns 0 for the table size), so the (err < 0) check here
is not correct. (I also do not like using "err" here anyway for the
value returned by pci_msix_table_size().  There is no error here, and
it is simply confusing.

-Jack

> As result of recent re-design of the MSI/MSI-X interrupts enabling
> pattern this driver has to be updated to use the new technique to
> obtain a optimal number of MSI/MSI-X interrupts required.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/main.c |   17 ++++++++---------
>  1 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c
> b/drivers/net/ethernet/mellanox/mlx4/main.c index 60c9f4f..377a5ea
> 100644 --- a/drivers/net/ethernet/mellanox/mlx4/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/main.c
> @@ -1852,8 +1852,16 @@ static void mlx4_enable_msi_x(struct mlx4_dev
> *dev) int i;
>  
>  	if (msi_x) {
> +		err = pci_msix_table_size(dev->pdev);
> +		if (err < 0)
> +			goto no_msi;
> +
> +		/* Try if at least 2 vectors are available */
>  		nreq = min_t(int, dev->caps.num_eqs -
> dev->caps.reserved_eqs, nreq);
> +		nreq = min_t(int, nreq, err);
> +		if (nreq < 2)
> +			goto no_msi;
>  
>  		entries = kcalloc(nreq, sizeof *entries, GFP_KERNEL);
>  		if (!entries)
> @@ -1862,17 +1870,8 @@ static void mlx4_enable_msi_x(struct mlx4_dev
> *dev) for (i = 0; i < nreq; ++i)
>  			entries[i].entry = i;
>  
> -	retry:
>  		err = pci_enable_msix(dev->pdev, entries, nreq);
>  		if (err) {
> -			/* Try again if at least 2 vectors are
> available */
> -			if (err > 1) {
> -				mlx4_info(dev, "Requested %d
> vectors, "
> -					  "but only %d MSI-X vectors
> available, "
> -					  "trying again\n", nreq,
> err);
> -				nreq = err;
> -				goto retry;
> -			}
>  			kfree(entries);
>  			goto no_msi;
>  		}
