Received:  by oss.sgi.com id <S553831AbRALUhU>;
	Fri, 12 Jan 2001 12:37:20 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:22289 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S553827AbRALUhO>;
	Fri, 12 Jan 2001 12:37:14 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP
	id 123D5205FC; Fri, 12 Jan 2001 12:37:09 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Fri, 12 Jan 2001 12:31:43 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP
	id F21991595F; Fri, 12 Jan 2001 12:37:08 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 3C3DB686D; Fri, 12 Jan 2001 12:37:07 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     Jun Sun <jsun@mvista.com>
Subject: Re: broken RM7000 in CVS ...
Date:   Fri, 12 Jan 2001 12:29:39 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
References: <3A5E7FFB.79925DF9@mvista.com> <0101121116201G.07691@plugh.sibyte.com> <3A5F68CB.78D693B3@mvista.com>
In-Reply-To: <3A5F68CB.78D693B3@mvista.com>
Cc:     linux-mips@oss.sgi.com
MIME-Version: 1.0
Message-Id: <0101121237071J.07691@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 12 Jan 2001, you wrote:
> Justin Carlson wrote:
> > 
> > This is sort of true.  Mips32 does do a pretty good job of defining how to
> > probe for L1 caches and the like, but other things, such as L2 caches, are not
> > going to be so easily probed.  
> 
> My understanding is that we don't have a standard way to probe for external
> cache (L2 or L3).  So this problem is not only for MIPS32 cpus.
> 

It's not specific to mips32 processors, no.  My point was, the mips32 spec
doesn't (and probably shouldn't, IMHO) solve this problem completely.

> > If I'm understanding your idea correctly, this table would require you to
> > always compile in all the mmu routines for all processors, just to fill in the
> > table entries.  Doesn't seem like a particularly good idea to me, even if we
> > could use generic mips32 routines for most parts.
> >
> 
> Each table entry can be surrounded by something like #if
> defined(CONFIG_CPU_RM7000) and #endif.  That should take care of the problem.
> 

Not if you want to have constant-defined offsets into the table.  Which is just
about the only reason to use a table for this...Either:

1)  You've got multiple entries in the table for different cpus, which you're
indexing by some hash of PRID fields.  This requires a full table.  (Or a really
ugly hash function that's adaptive depending on which which cpu support is
compiled in)

2)  You've got a single entry table.  

Unless I'm really misunderstanding what you're proposing...

-Justin
