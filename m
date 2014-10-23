Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 07:18:43 +0200 (CEST)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:56794 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011437AbaJWFSmALQR- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 07:18:42 +0200
Received: by mail-ig0-f182.google.com with SMTP id hn18so782792igb.9
        for <linux-mips@linux-mips.org>; Wed, 22 Oct 2014 22:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Mrs5Z5fRsWI5dyjNAmPaoFO56v1HlCSVSUBlYYG+pnQ=;
        b=bBtKCpHtOXUPK8hy1kjq0yGyOvBEUen2HdBLar72o6xwg1TlaaOyx1MOnB44uTeXtB
         npB3jfH2WeJPT+Zzv8slNiZ0RYCnaeJWpx4Fysu1/QzDh7BNnxReLAErRS4nnlmYkL8K
         IGItl+jBOu1feq1mgfsh23fzVvRSDqZUEQGiBbCWFRhpG9bqyLUDcIdrgXe2oHtGuOsn
         KcoY1G1/W9UH20ZiRLxLq/bSnc4DYuxvfmzSwRxMcvoOiEVlgit/Q8/qNO+dwFRD+UXR
         p7dCA5wS25gH9vLlALdtSBtX8w/0+5isljVbV/pBehFdYUbGDxPHwAK7FUnxFuIW3CbR
         kaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Mrs5Z5fRsWI5dyjNAmPaoFO56v1HlCSVSUBlYYG+pnQ=;
        b=e1wLgKpzp06CvLi201Sbub/TPGRDWuWFoL45jR5qDlKvVYrjewKQGcLDd84/6240QS
         xSrIO9CH9vXs3PZ7KyY2fD2sBOq2KQs0IZZxUWCzIY8a4uDTQcmDOO6Xv/lHuAVsCIh9
         faXfn/Xs3kzhM6/MfyyGst6O5r9KsIfJ/bvuFR5fLWh2roYIq4A4yo46SeGMzHNjBbbM
         VGwUGFaeceF38HUcIzFIMUnhRugNmjaPe3u3/mz79Nz2EJWmUTj7ynElAOyV6Xee1+sQ
         Veij5WEJeNA/wUIA4tU5/yj6iwp6gJq+GIh07QEe2/+6p05GPv6rq5S1jNAootCamx0F
         cOKw==
X-Gm-Message-State: ALoCoQkNhVmtnlP58uTqdQKi8FSgMsWe6Rh4VdRSRZgHafWd4UuxoGzT3BiNm+bbGruYUg+/WAAS
X-Received: by 10.50.128.163 with SMTP id np3mr39053588igb.28.1414041514650;
        Wed, 22 Oct 2014 22:18:34 -0700 (PDT)
Received: from google.com ([172.16.51.27])
        by mx.google.com with ESMTPSA id n12sm1788089igk.12.2014.10.22.22.18.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Oct 2014 22:18:34 -0700 (PDT)
Date:   Wed, 22 Oct 2014 23:18:31 -0600
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
Subject: Re: [PATCH v3 05/27] PCI: tegra: Save msi chip in pci_sys_data
Message-ID: <20141023051831.GB11770@google.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-6-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413342435-7876-6-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43521
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

On Wed, Oct 15, 2014 at 11:06:53AM +0800, Yijing Wang wrote:
> Save msi chip in pci_sys_data instead of assign
> msi chip to every pci bus in .add_bus().
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/host/pci-tegra.c |   13 +++----------
>  1 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 3d43874..5af0525 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -694,15 +694,6 @@ static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  	return irq;
>  }
>  
> -static void tegra_pcie_add_bus(struct pci_bus *bus)
> -{
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
> -
> -		bus->msi = &pcie->msi.chip;
> -	}
> -}
> -
>  static struct pci_bus *tegra_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>  {
>  	struct tegra_pcie *pcie = sys_to_pcie(sys);
> @@ -1881,11 +1872,13 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
>  
>  	memset(&hw, 0, sizeof(hw));
>  
> +#ifdef CONFIG_PCI_MSI
> +	hw.msi_chip = &pcie->msi.chip;
> +#endif

Why did you use "#ifdef CONFIG_PCI_MSI" instead of the
"IS_ENABLED(CONFIG_PCI_MSI)" used previously?

It's true that CONFIG_PCI_MSI will never be a tristate symbol, so we don't
really *need* the extra smarts of IS_ENABLED(), but I'm fairly sympathetic
to James' argument [1] that we should just use IS_ENABLED() all the time
because it's simpler overall.

If you want to change the #ifdef to IS_ENABLED(), that should be a separate
patch from your msi_chip change, and we can debate the merits of that by
itself.

[1] http://lkml.iu.edu//hypermail/linux/kernel/1204.3/00081.html

>  	hw.nr_controllers = 1;
>  	hw.private_data = (void **)&pcie;
>  	hw.setup = tegra_pcie_setup;
>  	hw.map_irq = tegra_pcie_map_irq;
> -	hw.add_bus = tegra_pcie_add_bus;
>  	hw.scan = tegra_pcie_scan_bus;
>  	hw.ops = &tegra_pcie_ops;
>  
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
