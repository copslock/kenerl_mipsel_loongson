Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 May 2012 20:14:18 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:54622 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903759Ab2EBSOK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 May 2012 20:14:10 +0200
Received: by lagy4 with SMTP id y4so805402lag.36
        for <linux-mips@linux-mips.org>; Wed, 02 May 2012 11:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=eJnJs3tqnIa+0D9q2zdjebwo9/Da3FBaSlLUzIUbKlI=;
        b=cCHCK7sHTyZFmO60x8ZE9jFmuGFRVWFOucAIUylNLPf8HLeKSzCkOyj5jc2TidB8wS
         AfwnXYG0YbNijCvaf4OImjaGCY2J7caABAMw9b6nG75P3bvQVaiZaqqbLdBAhkFd51ZZ
         jIQJllywS4tEP2Kov+GrPCRJqhXdQHE+ZLo1H1FuoqEk25TQ/aLVYx3lxviyD50o+wEk
         Aqr3s8NzYwZbl0plIFHmYY2giC/LZ+q9qNH7FUhEji/ay8735GFPgc4gUGnx+ITRPcRP
         zedSHjhvMvS8zKYhu2cw5dvraCYVJHduX9ZxcgyJteBHBN8WEY8ct8MqPflcgIX6ktMW
         Eh2A==
Received: by 10.112.47.228 with SMTP id g4mr5921610lbn.92.1335982444094;
        Wed, 02 May 2012 11:14:04 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id tb4sm2711916lab.14.2012.05.02.11.14.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 11:14:02 -0700 (PDT)
Message-ID: <4FA17925.6080707@mvista.com>
Date:   Wed, 02 May 2012 22:12:53 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2 02/14] MIPS: pci: parse memory ranges from devicetree
References: <1335961659-21358-1-git-send-email-blogic@openwrt.org> <1335961659-21358-2-git-send-email-blogic@openwrt.org>
In-Reply-To: <1335961659-21358-2-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlKegDWshnQrDGn2JiADIonxWGgVdKg1vXmj/MIj2nziRUAtCG07l+knuqI/LOGO1oo75Mt
X-archive-position: 33125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 05/02/2012 04:27 PM, John Crispin wrote:

> Implement pci_load_of_ranges on MIPS. Due to lack of test hardware only 32bit
> bus width is supported. This function is based on the implementation found on
> powerpc.

> Signed-off-by: John Crispin<blogic@openwrt.org>

> ---
> Changes in V2
> * remove some #ifdefs
> * rename to pci_load_of_ranges

>   arch/mips/include/asm/pci.h |    6 ++++
>   arch/mips/pci/pci.c         |   55 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+), 0 deletions(-)

[...]
> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> index 0514866..4d8a1b6 100644
> --- a/arch/mips/pci/pci.c
> +++ b/arch/mips/pci/pci.c
[...]
> @@ -114,9 +115,63 @@ static void __devinit pcibios_scanbus(struct pci_controller *hose)
[...]
> +#ifdef CONFIG_OF
> +void __devinit pci_load_of_ranges(struct pci_controller *hose,
> +				struct device_node *node)
> +{
> +	const __be32 *ranges;
> +	int rlen;
> +	int pna = of_n_addr_cells(node);
> +	int np = pna + 5;
> +
> +	pr_info("PCI host bridge %s ranges:\n", node->full_name);
> +	ranges = of_get_property(node, "ranges",&rlen);
> +	if (ranges == NULL)
> +		return;
> +	hose->of_node = node;
> +
> +	while ((rlen -= np * 4)>= 0) {
> +		u32 pci_space;
> +		struct resource *res = 0;

    s/0/NULL/ to avoid the warning (from sparse?).

WBR, Sergei
