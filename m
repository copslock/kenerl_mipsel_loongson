Received:  by oss.sgi.com id <S554127AbRA0HUA>;
	Fri, 26 Jan 2001 23:20:00 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:43005 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553804AbRA0HTj>;
	Fri, 26 Jan 2001 23:19:39 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id IAA29604;
	Sat, 27 Jan 2001 08:20:04 +0100 (MET)
Date:   Sat, 27 Jan 2001 08:20:04 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Joe deBlaquiere <jadb@redhat.com>
cc:     Ralf Baechle <ralf@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
        linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
In-Reply-To: <3A719ABD.5030206@redhat.com>
Message-ID: <Pine.GSO.3.96.1010127075830.29150A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 26 Jan 2001, Joe deBlaquiere wrote:

> Ralf gently pointed out that there was the possibility of needing to 
> fault the page for *p, which couldn't occur with ints off. So here's an 
> updated version...

 I don't think you get a page fault that would lead to an inconsistent
state.  See below:

> 		/* actually _do_ the exchange */
> 		save_and_cli(flags);
> 		errno |= __get_user(tmp, p);

 You may get a page fault on accessing *p here.  Not a problem.  When we
return to the faulting "lw" instruction, it will fetch the current value
of *p whether it changed before or not.  Also the TLB will get filled here
if needed. 

> 		errno |= __put_user(arg2, p);

 You may get a page fault on accessing *p here.  But since interrupts are
disabled since getting back from the page fault at the above "lw"
instruction, no context switch could have happened, so the page *p lies on
is already swapped in.  So the only reason of the fault might be write
protection (read protection was already checked by the fault above).  In
this case we don't care if *p changed meanwhile as we won't write it
anyway.  TLB got already filled above so no TLB fault will happen. 

> 		restore_flags(flags);

 Remember we are running UP.

 If anyone sees any other page fault scenario I would be pleased to read
it. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
