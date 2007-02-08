Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 08:54:25 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.237]:28223 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038340AbXBHIyU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Feb 2007 08:54:20 +0000
Received: by qb-out-0506.google.com with SMTP id e12so43244qba
        for <linux-mips@linux-mips.org>; Thu, 08 Feb 2007 00:53:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NvlNjizpA+1/Xe+yd+OqlNSA8H7z/25t25Fevyt3zgmVMz6jRodkctoLvJLWpCb1HFZv4zg7TNOw3jQ5/97c6+hCSXMxsTes3HGjl4tnzUG3eGbaXexVa/oVKRUCChH055yvEG0bg6hGW0pfNiqnYT+pRuNmAFKz07JVi7pjClg=
Received: by 10.115.54.1 with SMTP id g1mr2466742wak.1170924798222;
        Thu, 08 Feb 2007 00:53:18 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Thu, 8 Feb 2007 00:53:18 -0800 (PST)
Message-ID: <cda58cb80702080053m6f22dc15td3b8c447e2abbda1@mail.gmail.com>
Date:	Thu, 8 Feb 2007 09:53:18 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 9/10] signal: do not use save_static_function() anymore
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20070208.004049.51866970.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11706854683935-git-send-email-fbuihuu@gmail.com>
	 <11706854703880-git-send-email-fbuihuu@gmail.com>
	 <20070208.004049.51866970.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

On 2/7/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Mon,  5 Feb 2007 15:24:27 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > For the sys_sigsuspend() case, I don't see any reasons...
>
> Maybe that was needed before commit
> 7b3e2fc847c8325a7b35185fa1fc2f1729ed9c5b.  At that time
> sys_sigsuspend() called do_signal() (which includes
> setup_sigcontext()) directly.  So all registers must be saved to
> kernel stack.
>

Well, I haven't look at the old code you pointed out. So I dunno, but
I still really think we currently don't need to save/restore static
registers at all...

I tried the following patch:

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 229276a..046fb1b 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -68,7 +68,9 @@ int setup_sigcontext(struct pt_regs *regs, struct
sigcontext __user *sc)
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);

 	err |= __put_user(0, &sc->sc_regs[0]);
-	for (i = 1; i < 32; i++)
+	for (i = 1; i < 16; i++)
+		err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
+	for (i = 24; i < 32; i++)
 		err |= __put_user(regs->regs[i], &sc->sc_regs[i]);

 	err |= __put_user(regs->hi, &sc->sc_mdhi);
@@ -126,7 +128,9 @@ int restore_sigcontext(struct pt_regs *regs,
struct sigcontext __user *sc)
 		err |= __get_user(treg, &sc->sc_dsp); wrdsp(treg, DSP_MASK);
 	}

-	for (i = 1; i < 32; i++)
+	for (i = 1; i < 16; i++)
+		err |= __get_user(regs->regs[i], &sc->sc_regs[i]);
+	for (i = 24; i < 32; i++)
 		err |= __get_user(regs->regs[i], &sc->sc_regs[i]);

 	err |= __get_user(used_math, &sc->sc_used_math);

...and it still passes LTP tests.

Someone reported that not saving/restoring static registers may break
user tools but the gain is important I think. If you interested,
please take a look to the following thread:

http://marc.theaimsgroup.com/?l=linux-mips&m=117032669701164&w=2

Thanks
-- 
               Franck
