Received:  by oss.sgi.com id <S553918AbRA1Cze>;
	Sat, 27 Jan 2001 18:55:34 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:55302 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S553957AbRA1CzK>;
	Sat, 27 Jan 2001 18:55:10 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com ([163.154.5.240]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA07033
	for <linux-mips@oss.sgi.com>; Sat, 27 Jan 2001 18:55:10 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870785AbRA0TmL>; Sat, 27 Jan 2001 11:42:11 -0800
Date: 	Sat, 27 Jan 2001 11:42:11 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Joe deBlaquiere <jadb@redhat.com>, Florian Lohoff <flo@rfc822.org>,
        linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
Message-ID: <20010127114211.L867@bacchus.dhis.org>
References: <20010126131503.H869@bacchus.dhis.org> <Pine.GSO.3.96.1010127082028.29150B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010127082028.29150B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Sat, Jan 27, 2001 at 08:28:05AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Jan 27, 2001 at 08:28:05AM +0100, Maciej W. Rozycki wrote:

> > Afaik the only user of MIPS_ATOMIC_SET ever running on Linux/MIPS is the
> > Linuxthreads code you wrote, so no.  Aside of that the semantics of this
> > syscall were defined by older MIPS operating systems such as Risc/OS and
> > I think we should follow their example.
> 
>  I still haven't seen a definite spec for the call.

Sorry, the specs is code and docs I have access to here inside SGI and which
I cannot pass on ...

>  Since you suggest the Linuxthreads code is the only user of the code
> (also remember the _test_and_set library function as specified by the ABI),
> we might abandon MIPS_ATOMIC_SET and write a _test_and_set syscall
> instead.  No compatibility issues would be involved and the definition is
> clear in the ABI (the library function would become a simple wrapper). 

We have an IRIX 5 emulation and if I remember right for IRIX 5
MIPS_ATOMIC_SET is still supported, so we need to also.  So I fear we'll
have to keep sysmips.  Which still doesn't mean we should come up with
something better.

>  I'm still uncertain if wasting a syscall number is that great idea, but
> we would be free from any compatibility problems.  And yes, I still think
> an ll/sc emulation could be done independently anyway. 

  Ralf
