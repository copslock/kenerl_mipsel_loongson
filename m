Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 19:32:34 +0200 (CEST)
Received: from one.firstfloor.org ([213.235.205.2]:34889 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491757Ab0JHRca (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 19:32:30 +0200
Received: from basil.firstfloor.org (p5B3C926E.dip0.t-ipconnect.de [91.60.146.110])
        by one.firstfloor.org (Postfix) with ESMTP id 896F61A9804F;
        Fri,  8 Oct 2010 19:32:30 +0200 (CEST)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
        id 56472B1574; Fri,  8 Oct 2010 19:32:29 +0200 (CEST)
Date:   Fri, 8 Oct 2010 19:32:29 +0200
From:   Andi Kleen <andi@firstfloor.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Andi Kleen <andi@firstfloor.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, fengguang.wu@intel.com,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-mips@linux-mips.org, tony.luck@intel.com
Subject: Re: [PATCH 2/4] HWPOISON: Copy si_addr_lsb to user
Message-ID: <20101008173229.GH13352@basil.fritz.box>
References: <1286398141-13749-1-git-send-email-andi@firstfloor.org>
 <1286398141-13749-3-git-send-email-andi@firstfloor.org>
 <20101008170941.GA3025@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101008170941.GA3025@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <andi@firstfloor.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andi@firstfloor.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 08, 2010 at 06:09:41PM +0100, Ralf Baechle wrote:
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2215,6 +2215,14 @@ int copy_siginfo_to_user(siginfo_t __user *to, siginfo_t *from)
> >  #ifdef __ARCH_SI_TRAPNO
> >  		err |= __put_user(from->si_trapno, &to->si_trapno);
> >  #endif
> > +#ifdef BUS_MCEERR_AO
> > +		/* 
> > +		 * Other callers might not initialize the si_lsb field,
> > +	 	 * so check explicitely for the right codes here.
> > +		 */
> > +		if (from->si_code == BUS_MCEERR_AR || from->si_code == BUS_MCEERR_AO)
> > +			err |= __put_user(from->si_addr_lsb, &to->si_addr_lsb);
> > +#endif
> 
> include/asm-generic/siginfo.h defines BUS_MCEERR_AR unconditionally and is
> getting include in all <asm/siginfo.h> so that #ifdef condition is always
> true.  struct siginfo.si_addr_lsb is defined only for the generic struct
> siginfo.  The architectures that define HAVE_ARCH_SIGINFO_T (MIPS and
> IA-64) do not define this field so the build breaks.

Oops. I see two possible solutions:

#undef BUS_MCEERR_AR in the ia64 and mips siginfo.h or simply
add the si_addr_lsb field there too (it just sits over padding
and should be harmless)

What do you prefer?

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
