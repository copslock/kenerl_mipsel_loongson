Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 10:22:15 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:51189 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903547Ab1KWJWH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2011 10:22:07 +0100
Received: by bkat2 with SMTP id t2so1238140bka.36
        for <multiple recipients>; Wed, 23 Nov 2011 01:22:01 -0800 (PST)
Received: by 10.204.15.200 with SMTP id l8mr7961784bka.132.1322040121542;
        Wed, 23 Nov 2011 01:22:01 -0800 (PST)
Received: from [192.168.2.2] (ppp85-141-197-74.pppoe.mtu-net.ru. [85.141.197.74])
        by mx.google.com with ESMTPS id z15sm12312284bkv.4.2011.11.23.01.21.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Nov 2011 01:21:59 -0800 (PST)
Message-ID: <4ECCBB01.3070507@mvista.com>
Date:   Wed, 23 Nov 2011 13:21:05 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?ISO-8859-1?Q?Ren=E9_Bolldorf?= <xsecute@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [PATCH 08/12] MIPS: ath79: add support for the PCI host controller
 of the AR71XX SoCs
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org> <1322003670-8797-9-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1322003670-8797-9-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19682

Hello.

On 23-11-2011 3:14, Gabor Juhos wrote:

> The Atheros AR71XX SoCs have a built-in PCI Host Controller.
> This patch adds a driver for that, and modifies the relevant
> files in order to allow to register the PCI controller from
> board specific setup.

> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>
> Signed-off-by: Imre Kaloz<kaloz@openwrt.org>
[...]

> diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
> index 172277c..b1c0a1c 100644
> --- a/arch/mips/pci/Makefile
> +++ b/arch/mips/pci/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
>   obj-$(CONFIG_BCM63XX)		+= pci-bcm63xx.o fixup-bcm63xx.o \
>   					ops-bcm63xx.o
>   obj-$(CONFIG_MIPS_ALCHEMY)	+= pci-alchemy.o
> +obj-$(CONFIG_SOC_AR71XX)	+= pci-ar71xx.o

    OK, but where's pci_ar71xx.c file itself? Your whole patchset doesn't seem 
to include it...

WBR, Sergei
