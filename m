Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2009 14:12:10 +0000 (GMT)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:4359 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S21367011AbZCIOMI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Mar 2009 14:12:08 +0000
Received: from [127.0.0.1] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id NAA12849;
	Sun, 8 Mar 2009 13:49:56 -0600
Message-ID: <49B523B6.6090006@paralogos.com>
Date:	Mon, 09 Mar 2009 15:12:06 +0100
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	Nils Faerber <nils.faerber@kernelconcepts.de>
CC:	linux-mips@linux-mips.org
Subject: Re: Ingenic JZ4730 - illegal instruction
References: <49B1510B.8020606@kernelconcepts.de> <49B4D5BC.5020203@paralogos.com> <49B4E8BB.8080704@kernelconcepts.de>
In-Reply-To: <49B4E8BB.8080704@kernelconcepts.de>
X-Enigmail-Version: 0.95.7
Content-Type: multipart/alternative;
 boundary="------------070104040208070002010004"
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070104040208070002010004
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I don't have time to go chasing this stuff any further on your behalf,
but it *does* smell to me like an icache management problem.  Remember,
MIPS processors almost universally have split I/D caches and no
coherence support between them, so if you either (a) forget to do an
explicit D-cache write-back operation after copying to a page mapped
write-back that's going to be used as instructions/text, or (b) forget
to do an explicit I-cache invalidate when you re-use a page for
instructions that has been previously used for a different instruction
page, you will have problems, even without going into DMA I/O coherence
issues.  If your problem were (b), though, you'd be seeing bad answers,
segmentation violations, bus errors, etc., at least as often as you'd be
seeing illegal instruction exceptions.  So my money would be on (a).

The need for cache management is so fundamental to Linux for MIPS that
all the necessary general hooks have been there for years.  If I were
you, I'd focus on the definitions of the primitives that you spotted in
c-r4k.c.  Does the stuff in the JZ_RISC section correspond to the
assembly language flush sequence done in the Ingenic patch to head.S? 
Are you sure that the JZ_RISC section is in fact the version of those
functions that's being built into your kernel?

          Regards,

          Kevin K.

Nils Faerber wrote:
> Hi Kevin!
>
> Kevin D. Kissell schrieb:
>   
>> The only thing that you've mentioned below that really makes me think
>> that you're looking at a kernel bug is the comment about things not
>> failing under GDB.  But if *any* of the programs that are failing fail
>> under gdb, I'd want to know just what instruction is at the place where
>> they're taking a SIGILL. If gdb heisenbergs things too much, then the
>> basic brute force thing to do would be to instrument the kernel itself
>> to report on what happened, and what it sees at the "bad instruction"
>> address, using printk.  If the memory value actually looks like a legit
>> instruction, it would confirm the hypothesis that you've got an icache
>> maintenance problem.  I note that the Ingenic patch has a "flushcaches"
>> routine that has hardwired assumptions about the cache organization. 
>> Could those be incorrect on the chip you're using?
>>     
>
> Thanks for having a thought about the issue!
>
> By now I pitily have to admit that my GDB assumption was not all that
> correct :( After *a*lot* more tries I found an application that actually
> also fails inside GDB. But with some more tries I can now confirm that
> applications fail at random points - it is not a single instruction that
> causes the fault but rather random points.
> So I think your memory/cache issue theory sounds pretty interesting...
> I just had a look at the JZ4730 code (in arch/mips/jz4730/) and the only
>  mention of a cache flush is in pm.c which will only be executed in case
> of going to sleep (i.e. CPU deep sleep aka s2ram).
> arch/mips/mm/c-r4k.c also contains a JZ_RISC section for setting up
> cache options and arch/mips/mm/tlbex.c a TLB case special for the JZ.
>
> Those look promising!
> I could very well think of cases where a wrong cache flush could cause
> such or similar problems.
>
>   
>>          Regards, and happy hunting,
>>     
>
> Happy? When I found it maybe. The annoying thing about this is that
> Ingenic is not very helpful. I emailed them several times already asking
> for the full datasheet of the CPU with no replay at all yet. The
> datasheet they hae on their webpage is just the brief with about 60
> pages and not very helpful when you ar elooking for details like cache
> handling etc.
>
> So I will have to resort to experiments - trial an error.
>
> Thank you very much for your thoughts and idea!
>
>   
>>          Kevin K.
>>     
> Cheers
>   nils faerber
>
>   

--------------070104040208070002010004
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
I don't have time to go chasing this stuff any further on your behalf,
but it *does* smell to me like an icache management problem.  Remember,
MIPS processors almost universally have split I/D caches and no
coherence support between them, so if you either (a) forget to do an
explicit D-cache write-back operation after copying to a page mapped
write-back that's going to be used as instructions/text, or (b) forget
to do an explicit I-cache invalidate when you re-use a page for
instructions that has been previously used for a different instruction
page, you will have problems, even without going into DMA I/O coherence
issues.  If your problem were (b), though, you'd be seeing bad answers,
segmentation violations, bus errors, etc., at least as often as you'd
be seeing illegal instruction exceptions.  So my money would be on (a).<br>
<br>
The need for cache management is so fundamental to Linux for MIPS that
all the necessary general hooks have been there for years.  If I were
you, I'd focus on the definitions of the primitives that you spotted in
c-r4k.c.  Does the stuff in the JZ_RISC section correspond to the
assembly language flush sequence done in the Ingenic patch to head.S? 
Are you sure that the JZ_RISC section is in fact the version of those
functions that's being built into your kernel?<br>
<br>
          Regards,<br>
<br>
          Kevin K.<br>
<br>
Nils Faerber wrote:
<blockquote cite="mid:49B4E8BB.8080704@kernelconcepts.de" type="cite">
  <pre wrap="">Hi Kevin!

Kevin D. Kissell schrieb:
  </pre>
  <blockquote type="cite">
    <pre wrap="">The only thing that you've mentioned below that really makes me think
that you're looking at a kernel bug is the comment about things not
failing under GDB.  But if *any* of the programs that are failing fail
under gdb, I'd want to know just what instruction is at the place where
they're taking a SIGILL. If gdb heisenbergs things too much, then the
basic brute force thing to do would be to instrument the kernel itself
to report on what happened, and what it sees at the "bad instruction"
address, using printk.  If the memory value actually looks like a legit
instruction, it would confirm the hypothesis that you've got an icache
maintenance problem.  I note that the Ingenic patch has a "flushcaches"
routine that has hardwired assumptions about the cache organization. 
Could those be incorrect on the chip you're using?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Thanks for having a thought about the issue!

By now I pitily have to admit that my GDB assumption was not all that
correct :( After *a*lot* more tries I found an application that actually
also fails inside GDB. But with some more tries I can now confirm that
applications fail at random points - it is not a single instruction that
causes the fault but rather random points.
So I think your memory/cache issue theory sounds pretty interesting...
I just had a look at the JZ4730 code (in arch/mips/jz4730/) and the only
 mention of a cache flush is in pm.c which will only be executed in case
of going to sleep (i.e. CPU deep sleep aka s2ram).
arch/mips/mm/c-r4k.c also contains a JZ_RISC section for setting up
cache options and arch/mips/mm/tlbex.c a TLB case special for the JZ.

Those look promising!
I could very well think of cases where a wrong cache flush could cause
such or similar problems.

  </pre>
  <blockquote type="cite">
    <pre wrap="">         Regards, and happy hunting,
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Happy? When I found it maybe. The annoying thing about this is that
Ingenic is not very helpful. I emailed them several times already asking
for the full datasheet of the CPU with no replay at all yet. The
datasheet they hae on their webpage is just the brief with about 60
pages and not very helpful when you ar elooking for details like cache
handling etc.

So I will have to resort to experiments - trial an error.

Thank you very much for your thoughts and idea!

  </pre>
  <blockquote type="cite">
    <pre wrap="">         Kevin K.
    </pre>
  </blockquote>
  <pre wrap=""><!---->Cheers
  nils faerber

  </pre>
</blockquote>
</body>
</html>

--------------070104040208070002010004--
