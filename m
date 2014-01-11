Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Jan 2014 11:45:11 +0100 (CET)
Received: from 0.mx.nanl.de ([217.115.11.12]:50007 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825378AbaAKKpIlCit1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 11 Jan 2014 11:45:08 +0100
Received: from mail-qe0-f47.google.com (mail-qe0-f47.google.com [209.85.128.47])
        by mail.nanl.de (Postfix) with ESMTPSA id DAA3645E5F;
        Sat, 11 Jan 2014 10:43:34 +0000 (UTC)
Received: by mail-qe0-f47.google.com with SMTP id 5so5326919qeb.6
        for <multiple recipients>; Sat, 11 Jan 2014 02:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LXCy6LsmlPN3B/cBxHCs4ojB/fif6VDQZw161Vf8EdQ=;
        b=WCkmiMeuWQhKmkX4JKVN1+TI46j22b2PcYtwzh77JJpRRzMekl6Hl9DkAj2mmaBIN6
         74WreqLZpqBKS2M+wVA4OhLJZ/3pULMSnyoX46QdkrV/ezti9y8AuDNM1aDR02lura/f
         Ur55RQAVjNRpOhlbldgnr/qTUcW+q0g0qZAwKZe2G948LmLdWUeVoLkl75Z7a6z72ChG
         vrYNJj8JRKWqmNZw3Bvkf5fJzwgXV6trKdF19MGT5iyVXntfwYFLvf6ELuo6AxhR0RG8
         2bHSTCRr5gweTlOVO4myA5wbnu8GBGL5eBJpvaeaTUSiXLVU4umrf4r5JNb4BO9QByvB
         YVDQ==
X-Received: by 10.224.128.134 with SMTP id k6mr17550496qas.68.1389437101638;
 Sat, 11 Jan 2014 02:45:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.27.117 with HTTP; Sat, 11 Jan 2014 02:44:41 -0800 (PST)
In-Reply-To: <1389386114-31834-2-git-send-email-florian@openwrt.org>
References: <1389386114-31834-1-git-send-email-florian@openwrt.org> <1389386114-31834-2-git-send-email-florian@openwrt.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sat, 11 Jan 2014 11:44:41 +0100
Message-ID: <CAOiHx=nHQQyKNxXuxNXgGYftwQ=dTRvyytUNfaj0O-_xOmysiw@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: introduce MIPS_L1_CACHE_SHIFT_<N>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>,
        "Daniel G.C." <dgcbueu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Fri, Jan 10, 2014 at 9:35 PM, Florian Fainelli <florian@openwrt.org> wrote:
> In order to avoid keeping an ever growing list of chips which need to
> select a specific MIPS_L1_CACHE_SHIFT value introduce multiple internal
> and non-exposed Kconfig symbols for the various MIPS_L1_CACHE_SHIFT
> values out there and update the relevant Kconfig symbols to select them.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/mips/Kconfig              | 18 ++++++++++++++++++
>  arch/mips/pmcs-msp71xx/Kconfig |  1 +
>  arch/mips/ralink/Kconfig       |  1 +
>  3 files changed, 20 insertions(+)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 17cc7ff..753c5a3 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -183,6 +183,7 @@ config MACH_DECSTATION
>         select SYS_SUPPORTS_128HZ
>         select SYS_SUPPORTS_256HZ
>         select SYS_SUPPORTS_1024HZ
> +       select MIPS_L1_CACHE_SHIFT_4
>         help
>           This enables support for DEC's MIPS based workstations.  For details
>           see the Linux/MIPS FAQ on <http://www.linux-mips.org/> and the
> @@ -468,6 +469,7 @@ config SGI_IP22
>         select SYS_SUPPORTS_32BIT_KERNEL
>         select SYS_SUPPORTS_64BIT_KERNEL
>         select SYS_SUPPORTS_BIG_ENDIAN
> +       select MIPS_L1_CACHE_SHIFT_7
>         help
>           This are the SGI Indy, Challenge S and Indigo2, as well as certain
>           OEM variants like the Tandem CMN B006S. To compile a Linux kernel
> @@ -488,6 +490,7 @@ config SGI_IP27
>         select SYS_SUPPORTS_BIG_ENDIAN
>         select SYS_SUPPORTS_NUMA
>         select SYS_SUPPORTS_SMP
> +       select MIPS_L1_CACHE_SHIFT_7
>         help
>           This are the SGI Origin 200, Origin 2000 and Onyx 2 Graphics
>           workstations.  To compile a Linux kernel that runs on these, say Y
> @@ -694,6 +697,7 @@ config MIKROTIK_RB532
>         select SWAP_IO_SPACE
>         select BOOT_RAW
>         select ARCH_REQUIRE_GPIOLIB
> +       select MIPS_L1_CACHE_SHIFT_4
>         help
>           Support the Mikrotik(tm) RouterBoard 532 series,
>           based on the IDT RC32434 SoC.
> @@ -1088,6 +1092,18 @@ config FW_SNIPROM
>  config BOOT_ELF32
>         bool
>
> +config MIPS_L1_CACHE_SHIFT_4
> +       bool
> +
> +config MIPS_L1_CACHE_SHIFT_5
> +       def_bool y

Won't this cause two CACHE_SHIFT_X to be y for anyone selecting one
different from 5? Making this default to n and "5" the default default
is I think the better way.


Jonas
