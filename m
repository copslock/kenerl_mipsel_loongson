Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Feb 2011 21:38:37 +0100 (CET)
Received: from postler.einfach.org ([86.59.21.14]:47200 "EHLO home.einfach.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491083Ab1BUUie (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Feb 2011 21:38:34 +0100
Received: from home.einfach.org (localhost [127.0.0.1])
        by home.einfach.org (Postfix) with ESMTP id 78EF3A2513;
        Mon, 21 Feb 2011 21:38:27 +0100 (CET)
Received: from webmail.einfach.org (localhost [127.0.0.1])
        by home.einfach.org (Postfix) with ESMTP id 5F8B17A577;
        Mon, 21 Feb 2011 21:38:27 +0100 (CET)
Received: from 186.42.233.164
        (SquirrelMail authenticated user br1@einfach.org)
        by webmail.einfach.org with HTTP;
        Mon, 21 Feb 2011 21:38:27 +0100
Message-ID: <02e6152682aed8348b84dac4508bef70.squirrel@webmail.einfach.org>
In-Reply-To: <201102211428.02125.florian@openwrt.org>
References: <201102211428.02125.florian@openwrt.org>
Date:   Mon, 21 Feb 2011 21:38:27 +0100
Subject: Re: [PATCH] Alchemy: fix reset for MTX-1 and XXS1500
From:   br1@einfach.org
To:     "Florian Fainelli" <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, br1@einfach.org
User-Agent: SquirrelMail/1.4.21
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <br1@einfach.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: br1@einfach.org
Precedence: bulk
X-list: linux-mips

> Since commit 32fd6901 (MIPS: Alchemy: get rid of common/reset.c)
> Alchemy-based boards use their own reset function. For MTX-1 and XXS1500,
> the reset function pokes at the BCSR.SYSTEM_RESET register, but this does
> not work. According to Bruno Randolf, this was not tested when written.

Well, I don&#180;t know wether it was tested or not, but since it
doesn&#180;t work i think we can assume it wasn&#180;t.

> Previously, the generic au1000_restart() routine called the board specific
> reset function, which for MTX-1 and XXS1500 did not work, but finally made
> a jump to the reset vector, which really triggers a system restart. Fix
> reboot for both targets by jumping to the reset vector.
>
> CC: Bruno Randolf <br1@einfach.org>
> CC: stable@kernel.org
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> Stable: 2.6.34+
>
> diff --git a/arch/mips/alchemy/mtx-1/board_setup.c
> b/arch/mips/alchemy/mtx-1/board_setup.c
> index 6398fa9..40b84b9 100644
> --- a/arch/mips/alchemy/mtx-1/board_setup.c
> +++ b/arch/mips/alchemy/mtx-1/board_setup.c
> @@ -54,8 +54,8 @@ int mtx1_pci_idsel(unsigned int devsel, int assert);
>
>  static void mtx1_reset(char *c)
>  {
> -	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
> -	au_writel(0x00000000, 0xAE00001C);
> +	/* Jump to the reset vector */
> +	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
>  }
>
>  static void mtx1_power_off(void)
> diff --git a/arch/mips/alchemy/xxs1500/board_setup.c
> b/arch/mips/alchemy/xxs1500/board_setup.c
> index b43c918..80c521e 100644
> --- a/arch/mips/alchemy/xxs1500/board_setup.c
> +++ b/arch/mips/alchemy/xxs1500/board_setup.c
> @@ -36,8 +36,8 @@
>
>  static void xxs1500_reset(char *c)
>  {
> -	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
> -	au_writel(0x00000000, 0xAE00001C);
> +	/* Jump to the reset vector */
> +	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
>  }
>
>  static void xxs1500_power_off(void)
> --
> 1.7.1
>
>

Acked-by: Bruno Randolf <br1@einfach.org>
