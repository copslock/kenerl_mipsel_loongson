Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 11:39:59 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:59751 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903649Ab2BXKjy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 11:39:54 +0100
Received: by bkcjk13 with SMTP id jk13so2431468bkc.36
        for <linux-mips@linux-mips.org>; Fri, 24 Feb 2012 02:39:48 -0800 (PST)
Received-SPF: pass (google.com: domain of sshtylyov@mvista.com designates 10.204.151.3 as permitted sender) client-ip=10.204.151.3;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sshtylyov@mvista.com designates 10.204.151.3 as permitted sender) smtp.mail=sshtylyov@mvista.com
Received: from mr.google.com ([10.204.151.3])
        by 10.204.151.3 with SMTP id a3mr842938bkw.34.1330079988792 (num_hops = 1);
        Fri, 24 Feb 2012 02:39:48 -0800 (PST)
Received: by 10.204.151.3 with SMTP id a3mr699775bkw.34.1330079988594;
        Fri, 24 Feb 2012 02:39:48 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-85-203.pppoe.mtu-net.ru. [91.79.85.203])
        by mx.google.com with ESMTPS id d5sm7874037bkb.3.2012.02.24.02.39.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 02:39:47 -0800 (PST)
Message-ID: <4F4768A9.5040502@mvista.com>
Date:   Fri, 24 Feb 2012 14:38:33 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 5/6] MIPS: lantiq: convert pci to managed gpio
References: <1330012913-13293-1-git-send-email-blogic@openwrt.org> <1330012913-13293-5-git-send-email-blogic@openwrt.org>
In-Reply-To: <1330012913-13293-5-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmW4G7VafBU4Fd71ucX6qbnmy4u+Mey4Omzn1asLpCxME9ew1uJvDo5HNLg2QaF1z3xLmtf
X-archive-position: 32540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 23-02-2012 20:01, John Crispin wrote:

> ltq_gpio_request() now uses devres to manage the gpios. We need to pass a
> struct device pointer to make it work.

> Signed-off-by: John Crispin<blogic@openwrt.org>
[...]

> diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
> index 3bf42c8..47b5d8e 100644
> --- a/arch/mips/pci/pci-lantiq.c
> +++ b/arch/mips/pci/pci-lantiq.c
> @@ -150,24 +150,26 @@ static u32 ltq_calc_bar11mask(void)
>   	return bar11mask;
>   }
>
> -static void ltq_pci_setup_gpio(int gpio)
> +static void ltq_pci_setup_gpio(struct device *dev)
>   {
> +	struct ltq_pci_data *conf = (struct ltq_pci_data *) dev->platform_data;
>   	int i;
>   	for (i = 0; i<  ARRAY_SIZE(ltq_pci_gpio_map); i++) {
> -		if (gpio & (1 << i)) {
> -			ltq_gpio_request(ltq_pci_gpio_map[i].pin,
> +		if (conf->gpio & (1 << i)) {
> +			ltq_gpio_request(dev, ltq_pci_gpio_map[i].pin,
>   				ltq_pci_gpio_map[i].mux,
>   				ltq_pci_gpio_map[i].dir,
>   				ltq_pci_gpio_map[i].name);
>   		}
>   	}
> -	ltq_gpio_request(21, 0, 1, "pci-reset");
> -	ltq_pci_req_mask = (gpio>>  PCI_REQ_SHIFT)&  PCI_REQ_MASK;
> +	ltq_gpio_request(dev, 21, 0, 1, "pci-reset");

    This needs to be merged with patch 1.

WBR, Sergei
