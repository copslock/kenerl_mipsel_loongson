Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2012 12:10:24 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:51291 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903555Ab2BTLKR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2012 12:10:17 +0100
Received: by bkcjk13 with SMTP id jk13so6371256bkc.36
        for <linux-mips@linux-mips.org>; Mon, 20 Feb 2012 03:10:11 -0800 (PST)
Received-SPF: pass (google.com: domain of sshtylyov@mvista.com designates 10.205.137.136 as permitted sender) client-ip=10.205.137.136;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sshtylyov@mvista.com designates 10.205.137.136 as permitted sender) smtp.mail=sshtylyov@mvista.com
Received: from mr.google.com ([10.205.137.136])
        by 10.205.137.136 with SMTP id io8mr11070912bkc.106.1329736211567 (num_hops = 1);
        Mon, 20 Feb 2012 03:10:11 -0800 (PST)
Received: by 10.205.137.136 with SMTP id io8mr8954532bkc.106.1329736211355;
        Mon, 20 Feb 2012 03:10:11 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-78-89.pppoe.mtu-net.ru. [91.79.78.89])
        by mx.google.com with ESMTPS id e13sm38364206bku.12.2012.02.20.03.10.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Feb 2012 03:10:10 -0800 (PST)
Message-ID: <4F4229C7.1070107@mvista.com>
Date:   Mon, 20 Feb 2012 15:08:55 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     linville@tuxdriver.com, zajec5@gmail.com,
        b43-dev@lists.infradead.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, arend@broadcom.com, m@bues.ch
Subject: Re: [PATCH 11/11] MIPS: BCM47XX: provide sprom to bcma bus
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de> <1329676345-15856-12-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1329676345-15856-12-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQntviHJXerQJjHAC5Y9tyHCenMZbE/mfd3v2iTeKyiBaEfALhWYyMdgbExAsmeRNeF4EvTT
X-archive-position: 32489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 19-02-2012 22:32, Hauke Mehrtens wrote:

> On SoCs the sprom is often stored in nvram in the flashchip. This patch
> registers a sprom fallback callback handler in bcma and provides the
> sprom needed for this device.

> Signed-off-by: Hauke Mehrtens<hauke@hauke-m.de>
> ---
>   arch/mips/bcm47xx/setup.c |   39 +++++++++++++++++++++++++++++++++++----
>   1 files changed, 35 insertions(+), 4 deletions(-)

> diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
> index 6b0dacd..6f8b073 100644
> --- a/arch/mips/bcm47xx/setup.c
> +++ b/arch/mips/bcm47xx/setup.c
[...]
> @@ -159,10 +159,41 @@ static void __init bcm47xx_register_ssb(void)
>   #endif
>
>   #ifdef CONFIG_BCM47XX_BCMA
> +static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
> +{
> +	char prefix[10];
> +	struct bcma_device *core;
> +
> +	if (bus->hosttype == BCMA_HOSTTYPE_PCI) {

    Why not *switch* statement? It seems more natural in this situation...

> +		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
> +			 bus->host_pci->bus->number + 1,
> +			 PCI_SLOT(bus->host_pci->devfn));
> +		bcm47xx_fill_sprom(out, prefix);
> +		return 0;
> +	} else if (bus->hosttype == BCMA_HOSTTYPE_SOC) {
> +		bcm47xx_fill_sprom_ethernet(out, NULL);
> +		core = bcma_find_core(bus, BCMA_CORE_80211);
> +		if (core) {
> +			snprintf(prefix, sizeof(prefix), "sb/%u/",
> +				 core->core_index);
> +			bcm47xx_fill_sprom(out, prefix);
> +		}
> +		return 0;
> +	} else {
> +		printk(KERN_WARNING "bcm47xx: unable to fill SPROM for given bustype.\n");
> +		return -EINVAL;
> +	}
> +}
> +
>   static void __init bcm47xx_register_bcma(void)
>   {
>   	int err;
>
> +	err = bcma_arch_register_fallback_sprom(&bcm47xx_get_sprom_bcma);
> +	if (err)
> +		printk(KERN_WARNING "bcm47xx: someone else already registered"

    pr_warn(). And don't break the message to help grepping.

> +			" a bcma SPROM callback handler (err %d)\n", err);
> +

WBR, Sergei
