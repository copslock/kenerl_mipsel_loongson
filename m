Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 16:13:43 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:13278 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S21103021AbZA0QNk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jan 2009 16:13:40 +0000
Date:	Tue, 27 Jan 2009 16:13:40 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
cc:	Kumba <kumba@gentoo.org>, libc-ports@sources.redhat.com,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Glibc
In-Reply-To: <20090127152924.GA16379@caradoc.them.org>
Message-ID: <alpine.LFD.1.10.0901271602360.20486@ftp.linux-mips.org>
References: <490A912A.8030901@gentoo.org> <490C907A.40005@loowit.net> <4928D912.4050103@gentoo.org> <20090127152924.GA16379@caradoc.them.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 27 Jan 2009, Daniel Jacobowitz wrote:

> > 2008-11-22  Joshua Kinard  <kumba@gentoo.org>
> >
> >         * ports/sysdeps/mips/bits/atomic.h
> > 	(R10K_BEQZ_INSN, R10K_NOPS_INSN): Define depending on ISA.
> >         (__arch_compare_and_exchange_xxx_32_int): Replace 'beqz' insn with
> > 	R10K_BEQZ_INSN and add R10K_NOPS_INSN.
> >         (__arch_compare_and_exchange_xxx_64_int): Likewise
> >         (__arch_exchange_xxx_32_int): Likewise
> > 	(__arch_exchange_xxx_64_int): Likewise
> >         (__arch_exchange_and_add_32_int): Likewise
> > 	(__arch_exchange_and_add_64_int): Likewise
> 
> Thinking about this...
> 
> MIPS I: 28 NOPs is really horrid.  Not so much on this processor if
> the code is all in cache, but I guess that older/simpler processors
> are going to sit for a number of cycles chewing through those NOPs.
> Are distributions still building MIPS I code?  Can we assume that
> people who want to run glibc on an R10K can at least get something
> for MIPS II?

 I agree this is horrible.  I would rather not have a workaround for a 
broken chip in the official sources at all than badly hit good chips 
(comprising the vast majority).  Unless this can be made a compile-time 
option, so that whoever is interested in it can use "-march=mips1 
-mfix-r10000" or suchlike to get it activated, I am against the change.

> MIPS II, MIPS III, MIPS IV: Using beqzl does not seem particularly
> horrid - although it's still a shame since this branch is in fact
> anti-likely.  It will almost never be taken.

 Again if only "-march=mips2 -mfix-r10000" etc. activates it, then I am 
fine with that, otherwise it is a no-no for me.

> Other platforms: !(MIPS II or MIPS III or MIPS IV) is not the same as
> (MIPS I)!  Please don't activate this workaround on builds that won't
> run on an R10K, like MIPS32.

 Nothing to add here. ;)

  Maciej
