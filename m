Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 18:26:56 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:39951 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904127Ab1KRR0t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Nov 2011 18:26:49 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id ABE1F23C0087;
        Fri, 18 Nov 2011 18:26:36 +0100 (CET)
Message-ID: <4EC69552.4000902@openwrt.org>
Date:   Fri, 18 Nov 2011 18:26:42 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Rene Bolldorf <xsecute@googlemail.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 7/7] MIPS: ath79: use io-accessor macros in pci-ar724x.c
References: <1321629720-29035-1-git-send-email-juhosg@openwrt.org> <1321629720-29035-7-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1321629720-29035-7-git-send-email-juhosg@openwrt.org>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-archive-position: 31798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15712

2011.11.18. 16:22 keltezéssel, Gabor Juhos írta:
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
>  arch/mips/pci/pci-ar724x.c |   43 +++++++++++++++++++++++++++++--------------
>  1 files changed, 29 insertions(+), 14 deletions(-)
> 

<...>

>  
>  int __init ar724x_pcibios_init(void)
>  {
> +	int ret;
> +
> +	ar724x_pci_devcfg_base = ioremap(AR724X_PCI_CFG_BASE,
> +					 AR724X_PCI_CFG_SIZE);
> +	if (ar724x_pci_devcfg_base == NULL)
> +		goto err;
> +
>  	register_pci_controller(&ar724x_pci_controller);
>  
>  	return PCIBIOS_SUCCESSFUL;
> +
> +err:
> +	return ret;
>  }

I have messed up this part, will send a replacement patch.

Gabor
