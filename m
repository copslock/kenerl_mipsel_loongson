Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 15:29:30 +0000 (GMT)
Received: from NaN.false.org ([208.75.86.248]:26517 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S21103021AbZA0P31 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Jan 2009 15:29:27 +0000
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 440A810A3F;
	Tue, 27 Jan 2009 15:29:25 +0000 (GMT)
Received: from caradoc.them.org (209.195.188.212.nauticom.net [209.195.188.212])
	by nan.false.org (Postfix) with ESMTP id 02F1410A2F;
	Tue, 27 Jan 2009 15:29:25 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.69)
	(envelope-from <drow@caradoc.them.org>)
	id 1LRpsS-0006Vw-94; Tue, 27 Jan 2009 10:29:24 -0500
Date:	Tue, 27 Jan 2009 10:29:24 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Kumba <kumba@gentoo.org>
Cc:	libc-ports@sources.redhat.com,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Glibc
Message-ID: <20090127152924.GA16379@caradoc.them.org>
References: <490A912A.8030901@gentoo.org> <490C907A.40005@loowit.net> <4928D912.4050103@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4928D912.4050103@gentoo.org>
User-Agent: Mutt/1.5.17 (2008-05-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sat, Nov 22, 2008 at 11:16:18PM -0500, Kumba wrote:
> Here's try #2.  The gcc-side is already sent in and accepted.  If I'm 
> still missing anything, please let me know!
>
> Joshua Kinard
> Gentoo/MIPS
> kumba@gentoo.org
>
>
> 2008-11-22  Joshua Kinard  <kumba@gentoo.org>
>
>         * ports/sysdeps/mips/bits/atomic.h
> 	(R10K_BEQZ_INSN, R10K_NOPS_INSN): Define depending on ISA.
>         (__arch_compare_and_exchange_xxx_32_int): Replace 'beqz' insn with
> 	R10K_BEQZ_INSN and add R10K_NOPS_INSN.
>         (__arch_compare_and_exchange_xxx_64_int): Likewise
>         (__arch_exchange_xxx_32_int): Likewise
> 	(__arch_exchange_xxx_64_int): Likewise
>         (__arch_exchange_and_add_32_int): Likewise
> 	(__arch_exchange_and_add_64_int): Likewise

Thinking about this...

MIPS I: 28 NOPs is really horrid.  Not so much on this processor if
the code is all in cache, but I guess that older/simpler processors
are going to sit for a number of cycles chewing through those NOPs.
Are distributions still building MIPS I code?  Can we assume that
people who want to run glibc on an R10K can at least get something
for MIPS II?

MIPS II, MIPS III, MIPS IV: Using beqzl does not seem particularly
horrid - although it's still a shame since this branch is in fact
anti-likely.  It will almost never be taken.

Other platforms: !(MIPS II or MIPS III or MIPS IV) is not the same as
(MIPS I)!  Please don't activate this workaround on builds that won't
run on an R10K, like MIPS32.

-- 
Daniel Jacobowitz
CodeSourcery
