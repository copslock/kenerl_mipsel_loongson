Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2017 20:57:22 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:57294
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991978AbdJXS5PKGHy5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Oct 2017 20:57:15 +0200
Received: by mail-qt0-x243.google.com with SMTP id z28so31762228qtz.13;
        Tue, 24 Oct 2017 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ek3I1D5IFRMbk0vzqgPVlPmPkszHA6g0OMwHK+/sqCs=;
        b=m/6UCHO2InXaATiwTM9fDgaiXXhfgjvHzCOXCbgmvC7uqtVsuyx9fXEREDPWM0NIkz
         8If4x/0OKiMWXzCEJgloSxPsZnDebFbc8Pq9RWB4PrT+AzVCixafT8lunqyfZxgt1Z6C
         KtVZpPD+EMQmpYrppq+kJGgQElNTt21NNGxnb5ATLpYvun2DD+pOofpJXmE4Mte/RF9C
         LFoVjQ27BuY6ZH60MZVhiFb9WRLfQ9Gj/D+l534OBLx4cXps5ZA+xJtIXlIRRvOBe3JD
         c2q2V6v2qsVW5dpxQyiCscfFYGvbRaCETVSVok88HmEG4VIKY3mjey8IojP9vYS94huv
         d0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ek3I1D5IFRMbk0vzqgPVlPmPkszHA6g0OMwHK+/sqCs=;
        b=BIRUnI5x6gVHJRE+VuXZKTAYJcA/bsRkknGb0e8Z/iiY/McXZOVcHTSHLs+HELnSIP
         oUItqn2binxc2w2ZUrLJZWy8scaAdcAvYTTNxTuEqdbSl4mL5hUorJCHED6XojzVvWSm
         iEsY7ENHUgQwI67WIcWSSo/WtpnzGeH06zgd0+zJCX8aZjdnty/qmb1VG95oqE/bzS3W
         DuMJ/LeNP0dSnJbBlLPf0xpiF3+BdG8GUQ65Rw7tudq6oxvug+p2P/bC0Fu7qzgsgZyM
         gRxFSR9Nk+kcY9MgB1l1dD8dFVhXO8BtRAAOjgqSImEMDlnBDh09Igpd3GQ+8kIbULv4
         6wJg==
X-Gm-Message-State: AMCzsaVRPqzBn16y1U2bvUlF7+zKiuNkf3GSa5T45fLm66UVZ+DWTofY
        m+fekWX2sJqGeQbWiIpXrWxIRf2w
X-Google-Smtp-Source: ABhQp+RlQlvtxHtoZKWPZjUCIeIIHwdGLnwYHwFKOCZd2IjmOt9skF7BOUc1Tt2x7C7OWxoo+5Fqbw==
X-Received: by 10.237.61.49 with SMTP id g46mr26931909qtf.233.1508871428500;
        Tue, 24 Oct 2017 11:57:08 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id p6sm653154qke.64.2017.10.24.11.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Oct 2017 11:57:07 -0700 (PDT)
Subject: Re: [PATCH 6/8] PCI: host: brcmstb: add MSI capability
To:     Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-7-git-send-email-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5406ab92-c1da-f6fa-083d-82d1027130ea@gmail.com>
Date:   Tue, 24 Oct 2017 11:57:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1508868949-16652-7-git-send-email-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hi Jim,

On 10/24/2017 11:15 AM, Jim Quinlan wrote:
> This commit adds MSI to the Broadcom STB PCIe host controller. It does
> not add MSIX since that functionality is not in the HW.  The MSI
> controller is physically located within the PCIe block, however, there
> is no reason why the MSI controller could not be moved elsewhere in
> the future.
> 
> Since the internal Brcmstb MSI controller is intertwined with the PCIe
> controller, it is not its own platform device but rather part of the
> PCIe platform device.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/host/Kconfig           |  12 ++
>  drivers/pci/host/Makefile          |   1 +
>  drivers/pci/host/pci-brcmstb-msi.c | 318 +++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pci-brcmstb.c     |  72 +++++++--
>  drivers/pci/host/pci-brcmstb.h     |  26 +++
>  5 files changed, 419 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/pci/host/pci-brcmstb-msi.c
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index b9b4f11..54aa5d2 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -228,4 +228,16 @@ config PCI_BRCMSTB
>  	default ARCH_BRCMSTB || BMIPS_GENERIC
>  	help
>  	  Adds support for Broadcom Settop Box PCIe host controller.
> +	  To compile this driver as a module, choose m here.
> +
> +config PCI_BRCMSTB_MSI
> +	bool "Broadcom Brcmstb PCIe MSI support"
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC

This could probably be depends on PCI_BRCMSTB, which would imply these
two conditions. PCI_BRCMSTB_MSI on its own is probably not very useful
without the parent RC driver.

> +	depends on OF
> +	depends on PCI_MSI
> +	default PCI_BRCMSTB
> +	help
> +	  Say Y here if you want to enable MSI support for Broadcom's iProc
> +	  PCIe controller
> +
>  endmenu
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index c283321..1026d6f 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
>  obj-$(CONFIG_VMD) += vmd.o
>  obj-$(CONFIG_PCI_BRCMSTB) += brcmstb-pci.o
>  brcmstb-pci-objs := pci-brcmstb.o pci-brcmstb-dma.o
> +obj-$(CONFIG_PCI_BRCMSTB_MSI) += pci-brcmstb-msi.o

Should we combine this file with the brcmstb-pci.o? There is probably no
functional difference, except that pci-brcmstb-msi.ko needs to be loaded
first, right?
-- 
Florian
