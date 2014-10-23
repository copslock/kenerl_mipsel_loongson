Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 07:41:33 +0200 (CEST)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35946 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011371AbaJWFlaYb-pz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 07:41:30 +0200
Received: by mail-ig0-f170.google.com with SMTP id hn18so2226379igb.5
        for <linux-mips@linux-mips.org>; Wed, 22 Oct 2014 22:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=frC52YpGzqmAkT/CgD9O0fSDRq+DWOLOrleWgBBI0/E=;
        b=CfIS6QzSzITOsbzPOFO99u/KvyuFKB2Trex8Ejw1/cKQJl/4txQ3xmD1zwYEpyeCSN
         1AeKCcfCiSJZ2Mu2dLk7JFO0wW1YYZY7zraG7eQ+ZQ0RFdCCRJohf4GuFyw5HsRAsflj
         Av1x4PDD5sdInyAL8B0I6dYKEnODF5fIlJ9LrtyZmtzX4QbyH3EWa3MqWAFKHQOh9AJk
         wbd458BPjQBQMaxMUsGk1VwZPTYnu2vzDGT+strkFOc26JaIYBWrgbtoHP7YGrpTVbxi
         h01abrDf4KcIeW5QbRO7J4zDIOFvj1KEJrwbMkVszDSHVaTgSGZlZ/4wCC97q5zJ5JfO
         B85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=frC52YpGzqmAkT/CgD9O0fSDRq+DWOLOrleWgBBI0/E=;
        b=fv2oU4/FqgfZTjLQdEsXCFp8WueY/ZglycRMAa2OUQQpepnXQz6Oy+S20diyFvPbIl
         regEZKBfI2+Ls8gJjo2UKTNrcdBqmidTyrWup2m+HFm1+lFShj59AKkXV37TZHbHhtJM
         8TUBj2PVHSY2nBhX7/UUyi5lul1stDzdmZMpuqRq90ZIBtHsrUPdrLl2N21rSEt19QpX
         8ZdDMKDk7j7lxRYu/UNxImmD6C2AdwHp8/Bt3MhbdxrLWXtLvkTcCO1Kxs8sQtsbSF5I
         Pnv2jy+XzabKRtQdKbGdgo91RQRDBOeKUItI+alRQhxpni8EozZ2O8/nXelJxoJzWkzj
         vSIQ==
X-Gm-Message-State: ALoCoQksaEi6ArHVb7/SUb6VsR75CzIFKajciFepyWQJCuZwVygCDx/fVivwA7sYye5uS0NqYaU+
X-Received: by 10.50.70.40 with SMTP id j8mr10217467igu.31.1414042884825;
        Wed, 22 Oct 2014 22:41:24 -0700 (PDT)
Received: from google.com ([172.16.51.27])
        by mx.google.com with ESMTPSA id kj6sm1813510igb.6.2014.10.22.22.41.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Oct 2014 22:41:23 -0700 (PDT)
Date:   Wed, 22 Oct 2014 23:41:21 -0600
From:   Bjorn Helgaas <bhelgaas@google.com>
To:     Yijing Wang <wangyijing@huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arch@vger.kernel.org, arnab.basu@freescale.com,
        Bharat.Bhushan@freescale.com, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Vrabel <david.vrabel@citrix.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [PATCH v3 10/27] PCI/MSI: Remove useless bus->msi assignment
Message-ID: <20141023054121.GE11770@google.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-11-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413342435-7876-11-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Wed, Oct 15, 2014 at 11:06:58AM +0800, Yijing Wang wrote:
> Now msi chip is saved in pci_sys_data in arm,
> we could clean the bus->msi assignment in
> pci core.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> CC: Thierry Reding <thierry.reding@gmail.com>
> CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/probe.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index efa48dc..98bf4c3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -682,7 +682,6 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  
>  	child->parent = parent;
>  	child->ops = parent->ops;
> -	child->msi = parent->msi;

This needs an explanation of why ARM was the only arch to depend on this.

>  	child->sysdata = parent->sysdata;
>  	child->bus_flags = parent->bus_flags;
>  
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
