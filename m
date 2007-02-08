Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 13:38:04 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:49858 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038573AbXBHNh6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Feb 2007 13:37:58 +0000
Received: from localhost (p4240-ipad301funabasi.chiba.ocn.ne.jp [122.17.254.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 66522B649; Thu,  8 Feb 2007 22:36:38 +0900 (JST)
Date:	Thu, 08 Feb 2007 22:36:37 +0900 (JST)
Message-Id: <20070208.223637.108120499.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 9/10] signal: do not use save_static_function() anymore
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80702080053m6f22dc15td3b8c447e2abbda1@mail.gmail.com>
References: <11706854703880-git-send-email-fbuihuu@gmail.com>
	<20070208.004049.51866970.anemo@mba.ocn.ne.jp>
	<cda58cb80702080053m6f22dc15td3b8c447e2abbda1@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 8 Feb 2007 09:53:18 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> I tried the following patch:
> 
> diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
> index 229276a..046fb1b 100644
> --- a/arch/mips/kernel/signal.c
> +++ b/arch/mips/kernel/signal.c
> @@ -68,7 +68,9 @@ int setup_sigcontext(struct pt_regs *regs, struct
> sigcontext __user *sc)
>  	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
> 
>  	err |= __put_user(0, &sc->sc_regs[0]);
> -	for (i = 1; i < 32; i++)
> +	for (i = 1; i < 16; i++)
> +		err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
> +	for (i = 24; i < 32; i++)
>  		err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
> 
>  	err |= __put_user(regs->hi, &sc->sc_mdhi);
> @@ -126,7 +128,9 @@ int restore_sigcontext(struct pt_regs *regs,
> struct sigcontext __user *sc)
>  		err |= __get_user(treg, &sc->sc_dsp); wrdsp(treg, DSP_MASK);
>  	}
> 
> -	for (i = 1; i < 32; i++)
> +	for (i = 1; i < 16; i++)
> +		err |= __get_user(regs->regs[i], &sc->sc_regs[i]);
> +	for (i = 24; i < 32; i++)
>  		err |= __get_user(regs->regs[i], &sc->sc_regs[i]);
> 
>  	err |= __get_user(used_math, &sc->sc_used_math);
> 
> ...and it still passes LTP tests.
> 
> Someone reported that not saving/restoring static registers may break
> user tools but the gain is important I think.

NO!  This change might silently corrupt static registers!

If you did not restore static registers in kernel stack on
restore_sigcontext(), succeeding RESTORE_STATIC in restore_all will
load garbages to static registers.

Note that any hardware interrupts in middle of signal handler
overwrite pt_regs area in kernel stack.

I can still remember random static register corruption bug and how
hard to debug ...

---
Atsushi Nemoto
