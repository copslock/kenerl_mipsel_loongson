Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 20:18:03 +0200 (CEST)
Received: from mail-qe0-f50.google.com ([209.85.128.50]:47056 "EHLO
        mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868730Ab3JGSR7c2fX0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Oct 2013 20:17:59 +0200
Received: by mail-qe0-f50.google.com with SMTP id a11so5549816qen.37
        for <multiple recipients>; Mon, 07 Oct 2013 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=V+HB3QFap+BuynYsg1U35oi2ncVxqTbSgS0ZbIJ6HQs=;
        b=gEVK1XHFp8+LFi74Y9s0Ei5ocsudJJi6JqIHCPZaOmGLLeeYAhMO0oSfyy3PdrNnDh
         SFNgbx2GY3y8cc6FcJSL69zV5WagS3mXokrhQ/v09GNlIiEqn//sopu9FvCcaCf+xZs8
         MlgE1g2K12eCr7XitRgita8OJQ/n1BqEcjdRrTGUBLm7cP263s7O+n9/nHRBIY2pRi1r
         xXuLn38GfFKDHMVbN2+FLr+JDwidWA2MLVFmh90SfLNxk6ThUJBjm19sAYTzYcgHKu2o
         Yj7teUnIjC2/QB7CJJDfhKJd+fC8a4HSS/ZO0FZ558qhUSOb8/mp+vp+D/6u5ZUexJKu
         BnQQ==
X-Received: by 10.224.7.194 with SMTP id e2mr39632816qae.46.1381169873382;
        Mon, 07 Oct 2013 11:17:53 -0700 (PDT)
Received: from htj.dyndns.org (207-38-225-25.c3-0.43d-ubr1.qens-43d.ny.cable.rcn.com. [207.38.225.25])
        by mx.google.com with ESMTPSA id og1sm29139507qeb.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 07 Oct 2013 11:17:52 -0700 (PDT)
Date:   Mon, 7 Oct 2013 14:17:49 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Alexander Gordeev <agordeev@redhat.com>
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
Message-ID: <20131007181749.GB27396@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <d8c36203ada6efbfa9f7ce92c2f713ee3b6d6b8d.1380703262.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c36203ada6efbfa9f7ce92c2f713ee3b6d6b8d.1380703262.git.agordeev@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
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

Hello,

On Wed, Oct 02, 2013 at 12:48:23PM +0200, Alexander Gordeev wrote:
> +static int foo_driver_enable_msi(struct foo_adapter *adapter, int nvec)
> +{
> +	rc = pci_get_msi_cap(adapter->pdev);
> +	if (rc < 0)
> +		return rc;
> +
> +	nvec = min(nvec, rc);
> +	if (nvec < FOO_DRIVER_MINIMUM_NVEC) {
> +		return -ENOSPC;
> +
> +	rc = pci_enable_msi_block(adapter->pdev, nvec);
> +	return rc;
> +}

If there are many which duplicate the above pattern, it'd probably be
worthwhile to provide a helper?  It's usually a good idea to reduce
the amount of boilerplate code in drivers.

>  static int foo_driver_enable_msix(struct foo_adapter *adapter, int nvec)
>  {
> +	rc = pci_msix_table_size(adapter->pdev);
> +	if (rc < 0)
> +		return rc;
> +
> +	nvec = min(nvec, rc);
> +	if (nvec < FOO_DRIVER_MINIMUM_NVEC) {
> +		return -ENOSPC;
> +
> +	for (i = 0; i < nvec; i++)
> +		adapter->msix_entries[i].entry = i;
> +
> +	rc = pci_enable_msix(adapter->pdev, adapter->msix_entries, nvec);
> +	return rc;
>  }

Ditto.

> @@ -975,7 +951,7 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
>  	if (nr_entries < 0)
>  		return nr_entries;
>  	if (nvec > nr_entries)
> -		return nr_entries;
> +		return -EINVAL;
>  
>  	/* Check for any invalid entries */
>  	for (i = 0; i < nvec; i++) {

If we do things this way, it breaks all drivers using this interface
until they're converted, right?  Also, it probably isn't the best idea
to flip the behavior like this as this can go completely unnoticed (no
compiler warning or anything, the same function just behaves
differently).  Maybe it'd be a better idea to introduce a simpler
interface that most can be converted to?

Thanks.

-- 
tejun
