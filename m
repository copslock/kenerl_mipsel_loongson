Received:  by oss.sgi.com id <S553839AbRALVkA>;
	Fri, 12 Jan 2001 13:40:00 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:4089 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553834AbRALVjt>;
	Fri, 12 Jan 2001 13:39:49 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0CLbAC06403;
	Fri, 12 Jan 2001 13:37:10 -0800
Message-ID: <3A5F79A7.1D5B36B@mvista.com>
Date:   Fri, 12 Jan 2001 13:39:51 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     carlson@sibyte.com
CC:     linux-mips@oss.sgi.com
Subject: Re: broken RM7000 in CVS ...
References: <3A5E7FFB.79925DF9@mvista.com> <0101121116201G.07691@plugh.sibyte.com> <3A5F68CB.78D693B3@mvista.com> <0101121237071J.07691@plugh.sibyte.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Justin Carlson wrote:
> 
> On Fri, 12 Jan 2001, you wrote:
> > > If I'm understanding your idea correctly, this table would require you to
> > > always compile in all the mmu routines for all processors, just to fill in the
> > > table entries.  Doesn't seem like a particularly good idea to me, even if we
> > > could use generic mips32 routines for most parts.
> > >
> >
> > Each table entry can be surrounded by something like #if
> > defined(CONFIG_CPU_RM7000) and #endif.  That should take care of the problem.
> >
> 
> Not if you want to have constant-defined offsets into the table.  Which is just
> about the only reason to use a table for this...Either:
> 

No, I am thinking to have constant-defined offset into the table.  Instead, I
am thinking to do a linear search of the table and find a matching entry based
on the PRID.

Without table, I can see two alternatives, 1) switch/case statement to fill in
the data by statements (which is the current case) or 2) for each CPU
(protected by #ifdef CONFIG_) we define a mips_cpu struct.

I guess I just like table better than switch/case statements.  Table seems
cleaner to me.

I like table over option 2) because it is possible to build a kernel that
supports multiple CPUs.

> 1)  You've got multiple entries in the table for different cpus, which you're
> indexing by some hash of PRID fields.  This requires a full table.  (Or a really
> ugly hash function that's adaptive depending on which which cpu support is
> compiled in)
> 
> 2)  You've got a single entry table.
> 

In practice most tables probably only have single entry (due to the config),
but I guess that is OK.


Jun
