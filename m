Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2012 23:40:26 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:46636 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903706Ab2HMVkU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2012 23:40:20 +0200
Received: by ggnm2 with SMTP id m2so3942705ggn.36
        for <multiple recipients>; Mon, 13 Aug 2012 14:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8HgvZo1bQaSyW6Ns7LAZRB3wlNzf30w7xZMc/pQJ/DI=;
        b=ywCO2j59ZE8YALJhbFp8JJ8KtbpBPUNPcG/BPutQ/GaGJMTiUoCGrNk3RbWKVHMprZ
         ETPb/llwG5o9f+KtK5NUAgLZaV0bLz/wXVl9HZggpI83fJAZnef5tITyFL1cC5cHBAcZ
         l6x5CyJXXUDLYNlUhFTfikkJ1iTT0JuG4XTSh46eOQX6iMWQNRLO0FgcfFHTJni0jo/e
         ur/k+hMHWX6OdBLqdatEYagW7Y/wlrpXovuEXdOuAvsVxMvxNIuUUZcQBw6C1c7/W/tn
         SWKzdrJNGJtgAci9rPy4swGf5Dnrw+cbVsTic5N5RYjJckUhjYSu8CaEZ39/Gs6SaIQl
         5nSw==
Received: by 10.50.85.230 with SMTP id k6mr7392156igz.49.1344894014200;
        Mon, 13 Aug 2012 14:40:14 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id bp8sm16513887igb.12.2012.08.13.14.40.05
        (version=SSLv3 cipher=OTHER);
        Mon, 13 Aug 2012 14:40:13 -0700 (PDT)
Message-ID: <50297434.8090806@gmail.com>
Date:   Mon, 13 Aug 2012 14:40:04 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Jiang Liu <liuj97@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Don Dutile <ddutile@redhat.com>,
        Jiang Liu <jiang.liu@huawei.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        Yijing Wang <wangyijing@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 13/32] PCI/MIPS: use PCIe capabilities access functions
 to simplify implementation
References: <1343836477-7287-1-git-send-email-jiang.liu@huawei.com> <1343836477-7287-14-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1343836477-7287-14-git-send-email-jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 08/01/2012 08:54 AM, Jiang Liu wrote:
> From: Jiang Liu<jiang.liu@huawei.com>
>
> Use PCIe capabilities access functions to simplify PCIe MIPS implementation.
>
> Signed-off-by: Jiang Liu<liuj97@gmail.com>

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/pci/pci-octeon.c |   15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
> index 52a1ba7..aaed2ad 100644
> --- a/arch/mips/pci/pci-octeon.c
> +++ b/arch/mips/pci/pci-octeon.c
> @@ -117,16 +117,11 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
>   	}
>
>   	/* Enable the PCIe normal error reporting */
> -	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
> -	if (pos) {
> -		/* Update Device Control */
> -		pci_read_config_word(dev, pos + PCI_EXP_DEVCTL,&config);
> -		config |= PCI_EXP_DEVCTL_CERE; /* Correctable Error Reporting */
> -		config |= PCI_EXP_DEVCTL_NFERE; /* Non-Fatal Error Reporting */
> -		config |= PCI_EXP_DEVCTL_FERE;  /* Fatal Error Reporting */
> -		config |= PCI_EXP_DEVCTL_URRE;  /* Unsupported Request */
> -		pci_write_config_word(dev, pos + PCI_EXP_DEVCTL, config);
> -	}
> +	config = PCI_EXP_DEVCTL_CERE; /* Correctable Error Reporting */
> +	config |= PCI_EXP_DEVCTL_NFERE; /* Non-Fatal Error Reporting */
> +	config |= PCI_EXP_DEVCTL_FERE;  /* Fatal Error Reporting */
> +	config |= PCI_EXP_DEVCTL_URRE;  /* Unsupported Request */
> +	pci_pcie_capability_change_word(dev, PCI_EXP_DEVCTL, config, 0);
>
>   	/* Find the Advanced Error Reporting capability */
>   	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
