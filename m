Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2013 12:19:29 +0100 (CET)
Received: from mail-lb0-f179.google.com ([209.85.217.179]:50948 "EHLO
        mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819546Ab3BCLTTr-Nsu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Feb 2013 12:19:19 +0100
Received: by mail-lb0-f179.google.com with SMTP id j14so5916257lbo.38
        for <linux-mips@linux-mips.org>; Sun, 03 Feb 2013 03:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=45HgMP6NCBRX07s9NU85Ec/MMx0uK8i1Ot34WU1eXpU=;
        b=On+kySxPqrUK66DlhP1uYzog/8C/vNQeMRTiWwq5D4J60UaYDYOa+L/w4ZHN+xZlsI
         u6b0nne/WAn+bKIJZVk2T1iiDh/gOjth114OmWAt54GmZ0aUbTx9+U3PaPqdgmgv31sZ
         Sug0zfHShoLTHG4TJkOQyF1kenciDTtDNxwyr9xrdpUg8AjDNQ5qW+K4ee6Pg9PScYkM
         B+IAttJEzpQABC2q9xBpNsTK/6VG2UqufPOGO7VgleZP20xi/jYEHwBmlpps/iJVT/mI
         zIWAu13xkPOmBK8bdsE9q4U4RUrItt7q5Pdi2rlJTwv+hlXtQKPWohhPehInO7E6UU8C
         qCZg==
X-Received: by 10.152.121.212 with SMTP id lm20mr15980493lab.42.1359890354023;
        Sun, 03 Feb 2013 03:19:14 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-88-113.pppoe.mtu-net.ru. [91.79.88.113])
        by mx.google.com with ESMTPS id fh4sm4319173lbb.7.2013.02.03.03.19.12
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Feb 2013 03:19:13 -0800 (PST)
Message-ID: <510E479C.4020305@mvista.com>
Date:   Sun, 03 Feb 2013 15:18:52 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH 3/4] MIPS: pci-ar724x: remove static PCI IO/MEM resources
References: <1359889120-15699-1-git-send-email-juhosg@openwrt.org> <1359889185-15779-1-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1359889185-15779-1-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkeXMoTvkCPjp3LRNb1S6Hv3GtDCZGLGE7ytZbN3suuRxtRAh9th5A8lDcx+/q7r/+CCKZd
X-archive-position: 35693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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

Hello.

On 03-02-2013 14:59, Gabor Juhos wrote:

> Static resources become impractical when multiple
> PCI controllers are present. Move the resources
> into the platform device registration code and
> change the probe routine to get those from there
> platform device's resources.

> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
>   arch/mips/ath79/pci.c      |   21 ++++++++++++++++++++-
>   arch/mips/pci/pci-ar724x.c |   40 ++++++++++++++++++++++++----------------
>   2 files changed, 44 insertions(+), 17 deletions(-)

> diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
> index d90e071..45d1112 100644
> --- a/arch/mips/ath79/pci.c
> +++ b/arch/mips/ath79/pci.c
> @@ -139,10 +139,13 @@ static struct platform_device *
>   ath79_register_pci_ar724x(int id,
>   			  unsigned long cfg_base,
>   			  unsigned long ctrl_base,
> +			  unsigned long mem_base,
> +			  unsigned long mem_size,
> +			  unsigned long io_base,
>   			  int irq)
>   {
>   	struct platform_device *pdev;
> -	struct resource res[3];
> +	struct resource res[5];
>
>   	memset(res, 0, sizeof(res));
>
> @@ -160,6 +163,16 @@ ath79_register_pci_ar724x(int id,
>   	res[2].start = irq;
>   	res[2].end = irq;
>
> +	res[3].name = "mem_base";
> +	res[3].flags = IORESOURCE_MEM;
> +	res[3].start = mem_base;
> +	res[3].end = mem_base + mem_size - 1;
> +
> +	res[4].name = "io_base";
> +	res[4].flags = IORESOURCE_IO;
> +	res[4].start = io_base;
> +	res[4].end = io_base;

    One I/O port, hm? What is it good for?

WBR, Sergei
