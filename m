Received:  by oss.sgi.com id <S553941AbQKAJJ6>;
	Wed, 1 Nov 2000 01:09:58 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:9229 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553937AbQKAJJg>;
	Wed, 1 Nov 2000 01:09:36 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id BDCA8900; Wed,  1 Nov 2000 10:09:33 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 6C2D28FE1; Wed,  1 Nov 2000 10:09:28 +0100 (CET)
Date:   Wed, 1 Nov 2000 10:09:28 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: userspace spinlocks
Message-ID: <20001101100928.D3539@paradigm.rfc822.org>
References: <20001030151736.C2687@paradigm.rfc822.org> <39FDB50A.4919D84E@mvista.com> <20001031211431.C28909@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001031211431.C28909@bacchus.dhis.org>; from ralf@oss.sgi.com on Tue, Oct 31, 2000 at 09:14:31PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 31, 2000 at 09:14:31PM +0100, Ralf Baechle wrote:
> But what is the better alternative?  Emulating ll/sc is a generic facility.
> Aside of making that more efficient the only idea I have is putting entire
> atomic operations into the kernel such that the standard case should result
> in at most one exception to be handled in the kernel.

Its just that i fell over db-2.7.7 which told me on configure that
it cant find "spinlocks" for this architecture - I had a closer look
now and it seems they have asm files for each cpu type on how to 
implement the atomic "test and set" logic. But nothing for mips.
There is a long README stating that there is no real portable way
on how to do locking and if no architecture atomic "test and set" logic
would be available they would use some complicated fnctl semantics.

> Btw, could somebody put a counter into the ll/sc emulator and test how
> often it gets called on a R3000 machine?

I hope never Sir

arch/mips/kernel/traps.c

    466         /*
    467          * TODO: compute physical address from vaddr
    468          */
    469         panic("ll: emulation not yet finished!");
    470

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
