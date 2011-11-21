Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 11:18:58 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:34973 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903711Ab1KUKSw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 11:18:52 +0100
Received: by bkat2 with SMTP id t2so8394708bka.36
        for <multiple recipients>; Mon, 21 Nov 2011 02:18:46 -0800 (PST)
Received: by 10.205.117.134 with SMTP id fm6mr10291445bkc.93.1321870726019;
        Mon, 21 Nov 2011 02:18:46 -0800 (PST)
Received: from [192.168.2.2] (ppp85-141-190-27.pppoe.mtu-net.ru. [85.141.190.27])
        by mx.google.com with ESMTPS id cc2sm6866047bkb.8.2011.11.21.02.18.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 02:18:43 -0800 (PST)
Message-ID: <4ECA254E.4040509@mvista.com>
Date:   Mon, 21 Nov 2011 14:17:50 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Rene Bolldorf <xsecute@googlemail.com>
Subject: Re: [PATCH v3 4/7] MIPS: ath79: add a common PCI registration function
References: <1321825151-16053-1-git-send-email-juhosg@openwrt.org> <1321825151-16053-5-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1321825151-16053-5-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17091

Hello.

On 21-11-2011 1:39, Gabor Juhos wrote:

> The current code unconditionally registers the AR724X
> specific PCI controller, even if the kernel is running
> on a different SoC.

> Add a common function for PCI controller registration,
> and only register the AR724X PCI controller if the kernel
> is running on an AR724X SoC.

> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>
> ---
> v3: - fix compile error if CONFIG_PCI is not defined
>      - add __init annotation to ath79_register_pci

> v2: - no changes
[...]

> diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
> index 4957428..342363b 100644
> --- a/arch/mips/ath79/pci.c
> +++ b/arch/mips/ath79/pci.c

> @@ -44,3 +46,15 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
>
>   	return PCIBIOS_SUCCESSFUL;
>   }
> +
> +int __init ath79_register_pci(void)
> +{
> +	int ret;
> +
> +	if (soc_is_ar724x())
> +		ret = ath724x_pcibios_init();
> +	else
> +		ret = -ENODEV;

    Why not return right away and save 4 lines of code?

> +
> +	return ret;
> +}

WBR, Sergei
