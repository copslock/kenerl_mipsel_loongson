Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2006 21:41:39 +0100 (BST)
Received: from web31512.mail.mud.yahoo.com ([68.142.198.141]:40077 "HELO
	web31512.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20038553AbWIAUlh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Sep 2006 21:41:37 +0100
Received: (qmail 42146 invoked by uid 60001); 1 Sep 2006 20:41:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3ZJGoq2bGO9gKnfSOAapEC+vuszhWZW2SjBbdin3X+LwIioS2B2xS6AUaZhMWS1Gq8i2kT4ShN/JgmsRAxtwySura3exGHQx8RD7+kNn37nFpN8aTSTBowlv1NWrNVTGWOtIo9VBcHlBNJn+XHOHvDmdrdFZi9OCy+kzB51mrOA=  ;
Message-ID: <20060901204131.42144.qmail@web31512.mail.mud.yahoo.com>
Received: from [70.103.67.194] by web31512.mail.mud.yahoo.com via HTTP; Fri, 01 Sep 2006 13:41:31 PDT
Date:	Fri, 1 Sep 2006 13:41:31 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: Broadcom SB1 query
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060901173730.GC4893@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

--- Thiemo Seufer <ths@networkno.de> wrote:

> Jonathan Day wrote:
> > Hi,
> > 
> > Can anyone verify that the current kernel in
> > linux-mips git archive will work on a Broadcom
> 1250
> > (SB1), specifically the "Swarm" or the "Sentosa"
> > flavours of the BCM91250.
> 
> A 2.6.18-rc4 from a one week old git checkout works
> fine on a SWARM
> here, booted via tftp. The same kernel fails to boot
> on another
> SWARM board from the onboard IDE, I guess the
> swarm-ide is currently
> broken.

That might explain it. I've included the output from
the console at the end of this message, so you can
take a squint at it and see if that confirms it.

> > I have not been able to get anything more recent
> than
> > a 2.6.17 kernel to compile and boot, the 2.6.18-rc
> > kernels seem to randomly either lock up or reboot
> very
> > early on in the kernel initialization. However, I
> am
> > undecided whether it's a kernel issue,
> 
> I presume you know that PCI devices and more than 1
> GB of RAM don't
> work under Linux.

What a peculiar bug! (I don't think that's a
limitation of PCI, but even if it were, Linux' VMM is
more than sophisticated enough to map any assortment
of pages that totalled a gigabyte or less into a blob
such that buggy drivers or hardware only saw what
memory they could handle, regardless of what physical
memory has.)

Regardless, the cards are all 1 Gb.

> > a hardware
> > issue (we've had nothing but trouble from these
> > boards) or a toolchain issue (versions: gcc 4.1.1,
> > libc 2.4, binutils 2.17.50) as I've found a few
> large
> > projects that should compile just fine are blowing
> the
> > compiler up.
> 
> Hm, libc 2.4 means NPTL, that's not yet widely
> deployed and could well
> account for some exciting failures.

Yeah. I've tried building from source as much as
possible, but merely the lack of deployment opens up
all kinds of possibilites of me hitting bugs others
haven't seen, or don't see often enough to trace. I
run some weird stuff on the Broadcom.

> > If someone can post (or e-mail me direct) on what
> the
> > latest combination of kernel and toolchain that
> works
> > on the Swarm is, I would greatly appreciate it.
> This
> > problem is driving me nuts. (Ok, more nuts than
> > usual.)
> 
> Current Debian unstable works for me.
> 

Well, my machine's already unstable, so I guess Debian
can't hurt! :) I didn't know they had a big-endian
64-bit build, though. I'll have to look that up.

Anyway, here is a logfile when trying to boot the
swarm. As soon as it passes the high precision timer
code, it jumps back into CFE.

Starting program at 0x80633000

Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
Board type: SiByte BCM91250A (SWARM)
[17179569.184000] Linux version
2.6.18-rc5-swarm-lightfleet-0.4-
gb895b669-dirty (root@10.1.3.202) (gcc version 4.1.1)
#2 SMP
PREEMPT Fri Sep 1 09:16:18 UTC 2006
[17179569.184000] CPU revision is: 01040102
[17179569.184000] FPU revision is: 000f0102
[17179569.184000] swarm setup: M41T81 RTC detected.
[17179569.184000] This kernel optimized for board runs
with CFE
[17179569.184000] Determined physical RAM map:
[17179569.184000]  memory: 000000000fe99e00 @
0000000000000000 (usable)
[17179569.184000]  memory: 000000001ffffe00 @
0000000080000000 (usable)
[17179569.184000]  memory: 000000000ffffe00 @
00000000c0000000 (usable)
[17179569.184000]  memory: 000000003ffffe00 @
0000000100000000 (usable)
[17179569.184000] Detected 1 available secondary
CPU(s)
[17179569.184000] Built 1 zonelists.  Total pages:
1310719
[17179569.184000] Kernel command line: ip=any rw
nfsroot=10.1.3.187:/home/developer root=/dev/nfs
serial=1,115200n8
[17179569.184000] Primary instruction cache 32kB,
4-way, linesize 32
bytes.
[17179569.184000] Primary data cache 32kB, 4-way,
linesize 32 bytes.
[17179569.184000] Synthesized TLB refill handler (39
instructions).
[17179569.184000] Synthesized TLB load handler
fastpath (53
instructions).
[17179569.184000] Synthesized TLB store handler
fastpath (48
instructions).
[17179569.184000] Synthesized TLB modify handler
fastpath (47
instructions).
[17179569.184000] PID hash table entries: 4096 (order:
12, 32768 bytes)
[17179569.184000] Using 512.000 MHz high precision
timer.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
