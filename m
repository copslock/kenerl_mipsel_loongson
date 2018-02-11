Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2018 12:17:09 +0100 (CET)
Received: from mout.gmx.net ([212.227.15.15]:34327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990435AbeBKLRC5tzC6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Feb 2018 12:17:02 +0100
Received: from [79.235.153.113] ([79.235.153.113]) by
 3c-app-gmx-bs58.server.lan (via HTTP); Sun, 11 Feb 2018 12:16:52 +0100
MIME-Version: 1.0
Message-ID: <trinity-48dbde08-290c-4df2-964b-45b5a1b9312e-1518347812124@3c-app-gmx-bs58>
From:   =?UTF-8?Q?=22J=C3=BCrgen_Urban=22?= <JuergenUrban@gmx.de>
To:     "Fredrik Noring" <noring@nocrew.org>
Cc:     "Maciej W. Rozycki" <macro@mips.com>, linux-mips@linux-mips.org
Subject: Aw: [RFC] MIPS: R5900: Workaround for CACHE instruction near branch
 delay slot
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Feb 2018 12:16:52 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20180211080132.GD2222@localhost.localdomain>
References: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180211080132.GD2222@localhost.localdomain>
Content-Transfer-Encoding: 8BIT
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:E/YoRB6eEOOiEcB1yoqAS395fFFaE7NAeodHT9naUTg
 Wz/sqGP2vFfS1dBwXKY6MCJr8wsE6KWZvkZjlxKfeT39OLgXfl
 incTUfNZisu9vlFnmO8NBNl4hHbWeluZUKGiTKnNbsfPdmp6vw
 Q8ppUM/OuZSqz8LweNDx4zwknAHFHKE3r7lBMZhG6vUHeAqyhp
 tWIz3JEEU16+ufq6UsVCkSRuP+jR5CK5TtUc/q0leyCPOoAlCt
 mGCc8edEBnKFwr1qRF9qqW8aytEjj1F57SmWlmnX+an5iDKlKl 69Te1I=
X-UI-Out-Filterresults: notjunk:1;V01:K0:KdHLD/KeKZ4=:rQ8MPsUHCfHYLT2jeSznfQ
 nQwmo9GjwIa4DjAb0xR0rmCF5eOD8bFvt63ggMb0wwjIUFuz1cj/Qd1uF6KwSfUKI+0W6dBdI
 +OmwV4ss3OUvS4BwhyMSDGb32P/oY1fETWoHbqudlPDwXMs7KU2unHmiULOqDqwcUXh4/PULx
 udLMREscYhi6savaJbv64KSRgSkrWrME7vFfnzf9wAkQy7URYnOFLJDzY6F0EoGmi2Ud5TU4/
 F0rXDd1a7hYLZdvCVSObKaQO5hh2dHnPJR3n2WjOaicTFTlppNOczyIHlbKaoVims+LUDn/na
 A2+jMqhFR9TkXqE8Kz+0xqd0kClVNTTCT+M0LQkw1G4EioCH1yE+YhsZjpPQrM/z3DWikZ37B
 w91gfuqby9T8nvzDLFqgin08cjSXgJbadsOqipFDbJVvwMvJZpAo1HsMHAio25xB16tVqDn/t
 dxBUaTXk6AE0j/hUCZTCHRRLfPQxc7eM3zYrXZRyenMikFOsv1sR
Return-Path: <JuergenUrban@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: JuergenUrban@gmx.de
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

Hello Fredrik,

> Gesendet: Sonntag, 11. Februar 2018 um 09:01 Uhr
> Von: "Fredrik Noring" <noring@nocrew.org>
> An: "Maciej W. Rozycki" <macro@mips.com>, "Jürgen Urban" <JuergenUrban@gmx.de>
> Cc: linux-mips@linux-mips.org
> Betreff: [RFC] MIPS: R5900: Workaround for CACHE instruction near branch delay slot
>
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---
> This change has been ported from v2.6 patches. I have not found any note
> describing this in the TX79 manual.

The 5 NOPs are because of restri_e.pdf (2) Arrangement of Program Code and Data.

> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index 4008298c1880..a0b0fbedad8c 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -52,6 +52,14 @@ NESTED(except_vec3_generic, 0, sp)
>  #endif
>  	PTR_L	k0, exception_handlers(k1)
>  	jr	k0
> +#ifdef CONFIG_CPU_R5900
> +	/* There should be nothing which looks like a cache instruction. */
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +#endif
>  	.set	pop
>  	END(except_vec3_generic)
>  
> @@ -709,6 +717,14 @@ isrdhwr:
>  	.set	arch=r4000
>  	eret
>  	.set	mips0
> +#ifdef CONFIG_CPU_R5900
> +	/* There should be nothing which looks like cache instruction. */
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +#endif
>  #endif
>  	.set	pop
>  	END(handle_ri_rdhwr)
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 761b6c369321..795c490a429f 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1950,12 +1950,36 @@ void __init *set_except_vector(int n, void *addr)
>  		u32 *buf = (u32 *)(ebase + 0x200);
>  		unsigned int k0 = 26;
>  		if ((handler & jump_mask) == ((ebase + 0x200) & jump_mask)) {
> +#ifdef CONFIG_CPU_R5900
> +			uasm_i_nop(&buf);
> +			uasm_i_nop(&buf);
> +#endif

The 2 nops are because of FLX05 in tx79architecture.pdf.

>  			uasm_i_j(&buf, handler & ~jump_mask);
>  			uasm_i_nop(&buf);
> +#ifdef CONFIG_CPU_R5900
> +			/* There are no data allowed which could be interpreted as cache instruction. */
> +			uasm_i_nop(&buf);
> +			uasm_i_nop(&buf);
> +			uasm_i_nop(&buf);
> +			uasm_i_nop(&buf);
> +			uasm_i_nop(&buf);
> +#endif
>  		} else {
> +#ifdef CONFIG_CPU_R5900
> +			uasm_i_nop(&buf);
> +			uasm_i_nop(&buf);
> +#endif

Same here.

Best regards
Jürgen

>  			UASM_i_LA(&buf, k0, handler);
>  			uasm_i_jr(&buf, k0);
>  			uasm_i_nop(&buf);
> +#ifdef CONFIG_CPU_R5900
> +			/* There are no data allowed which could be interpreted as cache instruction. */
> +			uasm_i_nop(&buf);
> +			uasm_i_nop(&buf);
> +			uasm_i_nop(&buf);
> +			uasm_i_nop(&buf);
> +			uasm_i_nop(&buf);
> +#endif
>  		}
>  		local_flush_icache_range(ebase + 0x200, (unsigned long)buf);
>  	}
>
