Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2003 07:53:59 +0000 (GMT)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:45651
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8224847AbTCFHx6>; Thu, 6 Mar 2003 07:53:58 +0000
Received: from pudding.montavista.co.jp ([10.200.0.40])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id h2682e44027035;
	Thu, 6 Mar 2003 17:02:41 +0900
Date: Thu, 6 Mar 2003 16:53:51 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [patch] simulate_ll and simulate_sc(resend)
Message-Id: <20030306165351.35ffbaa7.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <20030304213605.A17855@linux-mips.org>
References: <20030303192137.34d21352.yoichi_yuasa@montavista.co.jp>
	<20030304213605.A17855@linux-mips.org>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Tue, 4 Mar 2003 21:36:05 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Mon, Mar 03, 2003 at 07:21:37PM +0900, Yoichi Yuasa wrote:
> 
> > I found a bug in simulate_ll and simulate_sc.
> > The board that uses ll/sc emulation is not started.
> > 
> > When send_sig in these, in order not to operate the value of EPC correctly,
> > simulate_* happens continuously.
> > 
> > The previous patches were not perfect, I changed more.
> > Please apply these patches to CVS tree.
> 
> As previously mentioned there were some problems with your fix, so I
> wrote an alternative fix which is attached below.  It's untested because
> I don't have any ll/sc-less test platform.

I tested ll/sc simulate.
Furthermore, the following patch is also needed.

Thanks,

Yoichi

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- linux.orig/arch/mips/kernel/traps.c Wed Mar  5 12:05:00 2003
+++ linux/arch/mips/kernel/traps.c      Thu Mar  6 16:37:40 2003
@@ -173,6 +173,7 @@
        }
        if (ll_bit == 0 || ll_task != current) {
                regs->regs[reg] = 0;
+               compute_return_epc(regs);
                return;
        }



> 
>   Ralf
> 
> Index: arch/mips/kernel/traps.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/kernel/traps.c,v
> retrieving revision 1.99.2.41
> diff -u -r1.99.2.41 traps.c
> --- arch/mips/kernel/traps.c	10 Feb 2003 22:50:48 -0000	1.99.2.41
> +++ arch/mips/kernel/traps.c	4 Mar 2003 20:32:10 -0000
> @@ -134,13 +134,14 @@
>  		ll_bit = 0;
>  	}
>  	ll_task = current;
> +
>  	regs->regs[(opcode & RT) >> 16] = value;
>  
>  	compute_return_epc(regs);
>  	return;
>  
>  sig:
> -	send_sig(signal, current, 1);
> +	force_sig(signal, current);
>  }
>  
>  static inline void simulate_sc(struct pt_regs *regs, unsigned int opcode)
> @@ -172,19 +173,21 @@
>  	}
>  	if (ll_bit == 0 || ll_task != current) {
>  		regs->regs[reg] = 0;
> -		goto sig;
> +		return;
>  	}
>  
> -	if (put_user(regs->regs[reg], vaddr))
> +	if (put_user(regs->regs[reg], vaddr)) {
>  		signal = SIGSEGV;
> -	else
> -		regs->regs[reg] = 1;
> +		goto sig;
> +	}
> +
> +	regs->regs[reg] = 1;
>  
>  	compute_return_epc(regs);
>  	return;
>  
>  sig:
> -	send_sig(signal, current, 1);
> +	force_sig(signal, current);
>  }
>  
>  /*
> 
> 


-- 
Yoichi Yuasa
Montavista Software Japan, Inc.
e-mail: yoichi_yuasa@montavista.co.jp
http://www.montavista.co.jp
PHONE: 03-5469-8840 FAX: 03-5469-8841
