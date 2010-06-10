Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jun 2010 18:33:24 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:62365 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491796Ab0FJQdV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Jun 2010 18:33:21 +0200
Received: by vws7 with SMTP id 7so130911vws.36
        for <multiple recipients>; Thu, 10 Jun 2010 09:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e6G+WAp6BpYlk8xZ8cGGPLgar4GFV2vojsL9NX/Nx9w=;
        b=C6pMv3wuWoo7RBE1sL6uYkmQi/NZLzEVqD+tKEdrmVYKcg/bmGDXdfGyMm42j75dXO
         79aP2Ufm+uu71J6gmxB8kzDgokmSybAzRiJb2hzIHp7OAC1NHgKvmF1ZccxwLhdp0jll
         9NoBKp+ozpx5z7rY/ydCHSLh3xgl6CoRtfqiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=paUPrA5/CBX1LG2l6EIozFJz8mhT4gUpJN0xtR+huc3Uca/gpuv3ETThqKzE7pPvlq
         3cQWMTqUUUjlDuzOS6Bj3S8bp1p/1ghZh7aBrIVC1JvalAKkllFLTqUhr+1fgejVv0Jr
         ZPwAWSnNwk3Bc7aOMAo/CCqnKjMzFaGbJCrdo=
MIME-Version: 1.0
Received: by 10.224.78.4 with SMTP id i4mr424837qak.95.1276187594474; Thu, 10 
        Jun 2010 09:33:14 -0700 (PDT)
Received: by 10.220.65.11 with HTTP; Thu, 10 Jun 2010 09:33:14 -0700 (PDT)
In-Reply-To: <2f41f9174bd6ba24b5609e06e87c47d5f44446d1.1275925108.git.siccegge@cs.fau.de>
References: <cover.1275925108.git.siccegge@cs.fau.de>
        <2f41f9174bd6ba24b5609e06e87c47d5f44446d1.1275925108.git.siccegge@cs.fau.de>
Date:   Thu, 10 Jun 2010 10:33:14 -0600
Message-ID: <AANLkTilBd1ei3SYtBlpc9KQIz8vgXxa9rpA2wZCxq0qL@mail.gmail.com>
Subject: Re: [PATCH 9/9] Removing dead CONFIG_MTD_PMC_MSP_RAMROOT
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     Christoph Egger <siccegge@cs.fau.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Yoichi Yuasa <yuasa@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 27115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7440

On Wed, Jun 9, 2010 at 5:23 AM, Christoph Egger <siccegge@cs.fau.de> wrote:
>
> CONFIG_MTD_PMC_MSP_RAMROOT doesn't exist in Kconfig, therefore removing all
> references for it from the source code.
>
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  .../mips/include/asm/pmc-sierra/msp71xx/msp_prom.h |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h b/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
> index 54ef1a9..786d82d 100644
> --- a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
> +++ b/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
> @@ -124,10 +124,6 @@ extern void prom_meminit(void);
>  extern void prom_fixup_mem_map(unsigned long start_mem,
>                               unsigned long end_mem);
>
> -#ifdef CONFIG_MTD_PMC_MSP_RAMROOT
> -extern bool get_ramroot(void **start, unsigned long *size);
> -#endif
> -
>  extern int get_ethernet_addr(char *ethaddr_name, char *ethernet_addr);
>  extern unsigned long get_deviceid(void);
>  extern char identify_enet(unsigned long interface_num);
> --
> 1.6.3.3

  Good catch!  This should have been included in the patch that
removed the CONFIG_MTD_PMC_MSP_RAMROOT functionality:
http://www.linux-mips.org/archives/linux-mips/2009-05/msg00024.html

Acked-by: Shane McDonald <mcdonald.shane@gmail.com>
