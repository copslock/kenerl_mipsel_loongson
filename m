Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2006 22:28:01 +0100 (BST)
Received: from web31506.mail.mud.yahoo.com ([68.142.198.135]:6781 "HELO
	web31506.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133880AbWFMV1w (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jun 2006 22:27:52 +0100
Received: (qmail 64711 invoked by uid 60001); 13 Jun 2006 21:27:43 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=F9AJ5UTpcCqAdYDwLiUL9JELWEPcxtTVycgtY06xW7LFJT1NejaykLpLscvHLQFoVFQ6SVpXtXwxVwXs2E7OQ6u8DrbSxOVwF/BqTXQ40q1YbhhKBbhPeyqPNhUa9sR9mrr32+oq9YoSv+4QgQWOlxjl2aGZyNRACUR1pa9J3YA=  ;
Message-ID: <20060613212743.64709.qmail@web31506.mail.mud.yahoo.com>
Received: from [208.187.37.98] by web31506.mail.mud.yahoo.com via HTTP; Tue, 13 Jun 2006 14:27:43 PDT
Date:	Tue, 13 Jun 2006 14:27:43 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: Performance counters and profiling on MIPS
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060612225848.GA7163@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Thank you for the valuable information.

One thing I'd like to throw open to the list: there's
one way to access the counters on the R4000-type
processors, another on the version 2 MIPS64, yet
another on the ix86, and so on.

Would it make sense to place some standardised
interface in, say, the assembly header files and hide
the implementation-specific details? In the case of
the R4000-type cores, this would need to involve some
sort of counter device in the kernel which the macro
would call to perform the priviledged instruction. (It
feels a little bit of a hack, but it's the simplest
way to provide access to resources that aren't made
public.)

What I'm thinking is that this generic interface would
then be used on all other architectures, where such
counters exist. That way, implementation-specific
stuff can be abstracted out and programs that need
access to performance counters can all be coded to a
generic interface, rather than one interface for each
version of every CPU API, which is inevitably going to
be far more prone to error.

Jonathan

--- Ralf Baechle <ralf@linux-mips.org> wrote:

> On Wed, Jun 07, 2006 at 10:22:52AM -0700, Jonathan
> Day wrote:
> 
> > Two quick and semi-related questions for the Gurus
> of
> > the MIPS. First off, it would appear that
> profiling on
> > any of the Broadcom MIPS processors is broken. I
> get
> > the following warnings when compiling the
> > platform-specific irq.c file:
> 
> This is ZBus-based profiling which also isn't
> supported by the standard
> profiling tool oprofile.  Oprofile is using the
> performance counters of
> the processor itself.
> 
> > My second question is with regards to accessing
> the
> > performance counters and timestamp counters from
> > userspace. On some architectures, this is as
> simple as
> > using a single macro.
> > 
> > In the case of the ix86 architecture (yuk!), the
> > timestamp counters can be read with nothing more
> than
> > an rdtsc() call, as follows:
> > 
> > asm volatile ("rdtsc" : "=a"(*(elg_ui4
> > *)&clock_value),
> >                 "=d"(*(((elg_ui4
> *)&clock_value)+1)));
> > 
> > What is the closest equiv. for the MIPS
> processors?
> 
> On most R4000-style processors (that includes the
> SB1 core of the Sibyte
> chips) applications can access the cycle counter
> through an
> mfc0 $reg, $c0_count instruction.  However mfc0 is a
> priviledged
> instruction, so that doesn't work for code that
> doesn't have kernel
> priviledges.
> 
> For release 2 of the MISP32 / MIPS64 architecture
> there is a new
> instruction, rdhwr which an application - so the OS
> permits it - can
> use to read c0_count.
> 
> Now there are two problems with that approach in
> your case:
> 
>  o SB1 implements release 0.95 of the MIPS64
> architecture, SB1A release 1.
>    Iow these cores don't have rdhwr.
>  o In general on a multiprocessor system you don't
> have a guarantee that
>    the count registers of all processors are running
> at the same speed or
>    were set to the same value at any time.
>       This is more of a general problem; in case of
> the BCM1250 the cores
>    are actually running at the same speed and afair
> are synchronized by
>    the reset.
> 
>   Ralf
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
