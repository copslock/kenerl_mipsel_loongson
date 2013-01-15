Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2013 12:58:23 +0100 (CET)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:65217 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832189Ab3AOL6UYvV8M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2013 12:58:20 +0100
Received: by mail-lb0-f176.google.com with SMTP id k6so88392lbo.35
        for <linux-mips@linux-mips.org>; Tue, 15 Jan 2013 03:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=a7noR6qYczR2mahHcn8u1ETApKJ0N33iHwch57gc7vs=;
        b=QEVEGdL85nxnGZVDgouB34+502yF4D1ynLiip9l5OHej8qmDDieQnNukaBzWsTQIrn
         b8ipz28a/cOsz2tLq3vQRPH46Z+P7kDuhU4st+29hoZUOKvwZYQdK9S84iccWu4lAdKP
         neLp7RLr5NtXcK8bAW9HYoa2YbZYgDGVEjwI3KIuHkjhFNsDJyT+b8wVDsJRia67In3Q
         4DI/ABwcbdv1PqZa7siRrJ6t1+c/sKQtPEsZGdoaweWo3l9YbJLjrMfNtIUu01Ja69cx
         bba5TSMHZgHxnRCGOXoYnN7TdN0HIBUKWNhMnTCD4nh2Rd235sNFzChNvMgAvBDoETGJ
         JkHw==
X-Received: by 10.112.13.229 with SMTP id k5mr36168767lbc.125.1358251094613;
        Tue, 15 Jan 2013 03:58:14 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-80-168.pppoe.mtu-net.ru. [91.79.80.168])
        by mx.google.com with ESMTPS id ee5sm6658031lbb.14.2013.01.15.03.58.11
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 03:58:13 -0800 (PST)
Message-ID: <50F5444C.5020209@mvista.com>
Date:   Tue, 15 Jan 2013 15:58:04 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 03/10] MIPS: PCI: Byteswap not needed in little-endian
 mode
References: <1358179922-26663-4-git-send-email-jchandra@broadcom.com> <1358230746-13785-1-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1358230746-13785-1-git-send-email-jchandra@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlEjbOvXeeXqHoFnQXo962r3mXYTHqd7DTVdonqwufNsBxDB67DTkJtW3KU2ezyiU7WeNre
X-archive-position: 35444
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

On 15-01-2013 10:19, Jayachandran C wrote:

> Wrap the xlp_enable_pci_bswap() function and its call with
> '#ifdef __BIG_ENDIAN'. On Netlogic XLP, the PCIe initialization code
> to setup to byteswap is needed only in big-endian mode.

> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>   arch/mips/pci/pci-xlp.c |   12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)

> diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
> index 140557a..d201efa 100644
> --- a/arch/mips/pci/pci-xlp.c
> +++ b/arch/mips/pci/pci-xlp.c
> @@ -191,8 +191,14 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
>   	return 0;
>   }
>
> -static int xlp_enable_pci_bswap(void)
> +/*
> + * If big-endian, enable hardware byteswap on the PCIe bridges.
> + * This will make both the SoC and PCIe devices behave consistently with
> + * readl/writel.
> + */
> +static void xlp_config_pci_bswap(void)
>   {
> +#ifdef __BIG_ENDIAN
>   	uint64_t pciebase, sysbase;
>   	int node, i;
>   	u32 reg;
> @@ -222,7 +228,7 @@ static int xlp_enable_pci_bswap(void)
>   		reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEIO_LIMIT0 + i);
>   		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_IO_LIM, reg | 0xfff);
>   	}
> -	return 0;
> +#endif

    You misunderstood. #ifdef within functions are frowned upon. Thios patch 
is hardly better than previous then.

WBR, Sergei
