Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Sep 2002 21:15:59 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:13326 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122961AbSIOTP6>;
	Sun, 15 Sep 2002 21:15:58 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17qfo7-0000ps-00; Sun, 15 Sep 2002 15:15:51 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17qesP-0005kN-00; Sun, 15 Sep 2002 15:16:13 -0400
Date: Sun, 15 Sep 2002 15:16:13 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Ryan Murray <rmurray@debian.org>, linux-mips@linux-mips.org,
	libc-alpha@sources.redhat.com
Subject: Re: [patch] userspace mcontext_t doesn't match what kernel returns
Message-ID: <20020915191613.GA21794@nevyn.them.org>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
	Ryan Murray <rmurray@debian.org>, linux-mips@linux-mips.org,
	libc-alpha@sources.redhat.com
References: <20020911032832.GA1500@cyberhqz.com> <20020915210601.A24588@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020915210601.A24588@linux-mips.org>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sun, Sep 15, 2002 at 09:06:01PM +0200, Ralf Baechle wrote:
> On Tue, Sep 10, 2002 at 08:28:32PM -0700, Ryan Murray wrote:
> 
> > The definition of mcontext_t in sysdeps/unix/sysv/linux/mips/sys/ucontext.h
> > does not match what the kernel copies to userspace (struct sigcontext).
> > alpha, ia64, and hppa have fixed this by typedefing one to the other in
> > sys/ucontext.h  The following patch accomplishes the same thing for mips.
> 
> I choose to fix the kernel instead which will keep as closer to the MIPS
> ABI and also prevent having to recompile zillions of user apps.  Below my
> working version of <asm/ucontext.h>.

What are the gregset_t/fpregset_t types in your working tree?  There
aren't any definitions of them in the only copy of the MIPS code that I
have here, and they've had various bad definitions in glibc until
recently.  They also recently changed...

[Although I think your kernel change is the right way to go, here. 
Just being cautious.]

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
