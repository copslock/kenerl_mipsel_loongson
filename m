Received:  by oss.sgi.com id <S42276AbQIYVh6>;
	Mon, 25 Sep 2000 14:37:58 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:15602 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42201AbQIYVha>;
	Mon, 25 Sep 2000 14:37:30 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e8PLa9x24119;
	Mon, 25 Sep 2000 14:36:09 -0700
Message-ID: <39CFC567.DD66BC56@mvista.com>
Date:   Mon, 25 Sep 2000 14:36:39 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Dominic Sweetman <dom@algor.co.uk>
CC:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: load_unaligned() and "uld" instruction
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Dominic Sweetman wrote:
> 
> Jun Sun (jsun@mvista.com) writes:
> 
> > The USB sub-system uses "unaligned.h" file to access unaligned data.
> > All the unaligned data access functions depend on "uld" and "usw"
> > instructions, which are not available on many CPUs.
> 
> You won't find the instruction 'uld' in *any* MIPS CPU.
> 
> uld is an assembler macro-instruction translating into a
> 
>   ldl
>   ldr
> 
> pair (the instructions are called load-double-left and
> load-double-right).  The exact translation depends on whether you're
> running big-endian or little-endian... but the 32-bit version on a
> big-endian CPU is that
> 
>   ulw $1, <address>
> 
> is assembled as
> 
>   lwl $1, <address>
>   lwr $1, <address+3>
> 
> The way that the load-left and load-right work together is kind of
> tricky to get your head round.
> 
> So far as I know, all 64-bit MIPS CPUs implement ldl/ldr and the store
> equivalents.  MIPS patented these instructions, so clones like Lexra's
> don't implement the 32-bit versions (lwl, lwr etc).
> 
> --
> Dominic Sweetman
> Algorithmics Ltd
> The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
> phone: +44 1223 706200 / fax: +44 1223 706250 / http://www.algor.co.uk

Dominic,

Thanks for the clarification.

I looked at my problem again, and it turns out that it was caused by
"-mips2" compiler option.  If I use "-mips3", the complain goes away,
which seems to make sense - assuming "uld" and "usw" are introduced in
mips III.

This actually brings another question (which I thought I have posted
before).  Take a look of arch/mips/Makefile, you will find most CPUS
uses -mips2 compiler option.  While -mips2 is safe, it cannot take
advantages of "uld" etc.  Is there any reason that we don't want to use
-mips3, at least for some of the later CPUs?

If we have to use "-mips2" option, is there a clean way which allows us
to "uld/usw" instructions (instead of manually twicking the compilation
for each file that uses them)?

Another question is that in the same file most CPUs will take another
compiler option such as "-mcpu=r8000", in which case the cpu model
usually does NOT correspond to the actual CPU.  Why is that?

Thanks.

Jun
