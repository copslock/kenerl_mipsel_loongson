Received:  by oss.sgi.com id <S553826AbRALU2A>;
	Fri, 12 Jan 2001 12:28:00 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:46329 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553667AbRALU15>;
	Fri, 12 Jan 2001 12:27:57 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0CKPEC03326;
	Fri, 12 Jan 2001 12:25:14 -0800
Message-ID: <3A5F68CB.78D693B3@mvista.com>
Date:   Fri, 12 Jan 2001 12:27:55 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     carlson@sibyte.com
CC:     linux-mips@oss.sgi.com
Subject: Re: broken RM7000 in CVS ...
References: <3A5E7FFB.79925DF9@mvista.com> <001e01c07c68$96155f80$0deca8c0@Ulysses> <3A5F53CB.F8EC3947@mvista.com> <0101121116201G.07691@plugh.sibyte.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Justin Carlson wrote:
> 
> This is sort of true.  Mips32 does do a pretty good job of defining how to
> probe for L1 caches and the like, but other things, such as L2 caches, are not
> going to be so easily probed.  

My understanding is that we don't have a standard way to probe for external
cache (L2 or L3).  So this problem is not only for MIPS32 cpus.

One possible fix is to have board-specific setup routine fill in the needed
data in the mipc_cpu structure, although I am not sure if that is a little too
late in the startup process.  (I think at least one flush_cache call is made
before we reach board_setup() routine).

Jun

> >
> > Along this line, it probably makes sense to have another pointer to
> > mips_cpu_config() function, where for MIPS32 it is the standard MIPS32 config
> > probing function and for most others it is NULL.
> >
> > Now the mips_cpu_table looks like :
> >
> > struct mips_cpu mips_cpu_table[]={
> >       { PRID_IMP_4KC, mips32_cpu_config},
> >       { PRID_IMP_RM7K, null, 0xaaa, {...}}
> >       .....
> > };
> 
> If I'm understanding your idea correctly, this table would require you to
> always compile in all the mmu routines for all processors, just to fill in the
> table entries.  Doesn't seem like a particularly good idea to me, even if we
> could use generic mips32 routines for most parts.
>

Each table entry can be surrounded by something like #if
defined(CONFIG_CPU_RM7000) and #endif.  That should take care of the problem.

 
Jun
