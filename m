Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f558kZ126398
	for linux-mips-outgoing; Tue, 5 Jun 2001 01:46:35 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f558kXh26388
	for <linux-mips@oss.sgi.com>; Tue, 5 Jun 2001 01:46:33 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA02128;
	Tue, 5 Jun 2001 01:46:26 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA25200;
	Tue, 5 Jun 2001 01:46:23 -0700 (PDT)
Message-ID: <005401c0ed9c$a2ce8b20$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ian Thompson" <iant@palmchip.com>
Cc: <linux-mips@oss.sgi.com>
References: <3B1BC6B8.C58758FA@palmchip.com> <02a901c0ed2b$2eac6300$0deca8c0@Ulysses> <3B1BEF48.AB0E568C@palmchip.com> <033701c0ed3c$59ccf980$0deca8c0@Ulysses> <3B1C1AAD.3A62D636@palmchip.com>
Subject: Re: dcache_blast() bug?
Date: Tue, 5 Jun 2001 10:50:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> Thanks for your help Kevin.  It may be possible that this is a hardware
> bug.  I am using one of the lead vehicle chips with 16k d$ & i$,
> although there is some custom hardware which may be causing trouble as
> well.  Oh, and this is the 2.4.1 kernel.

I'm also running a 4Kc lead vehicle, on a MIPS Malta board,
with the 2.4.1 kernel, run the system moderately hard, and have
never seen any behavior like that you describle.

> It appears that when I copy the arguments into the command line
> variable, they are 8-byte aligned, and the destination is also 8-byte
> aligned.  However, there is an inconsistency between the data in the
> cache and in memory after the blast_dcache() call.

Am I correct in taking this to mean that the contents of
memory is correct, but that the cache is in error when
you read the data back in cacheable space?  That suggests
that writes are working fine, but that either the blast_dcache()
isn't correctly clearing the tags, or the refill from memory
is getting trashed on the way to the cache.  The former
could result from misbehavior in the 4Kc lead vehicle chip
itself (possibly provoked by some kind of marginal
clock or power supply input), the later could result from
any one of several problems in the path between the RAM
array and the lead vehicle cache.  I favor the later theory.
See below.

>
Could it also be
> possible that the cache write buffer is not quite empty, and the data in
> it is being lost on the blast call?

I know of no software mechanism that will cause the contents
of the write buffer to be lost.  I think a bus error indication
from the system might cause it to be thrown away, but that's
about it.  The SYNC instruction forces its contents to be
written to memory, not discarded.

> Should some implementation of
> wbflush be called before the cache ops are done?

The write buffers are part of the BIU which is on the
"far side" of the cache.  Since the cache in write-through,
the cache operations should not result in any interaction
with the write buffer at all - the cache tags should get
invalidated, and that's all.

The reason that the 8-byte granularity of error suggests
a hardware problem at the memory interface is that, while
writes to memory will be 1, 2, or 4 bytes (byte, halfword,
and word stores), and the cache line size and write buffer
size are both 16 bytes, the 4Kc lead vehicle has a 64-bit
memory interface, and reads 8 bytes at a time when doing
cache fills.  A botched RAM cycle during a cache fill would
cause 8-byte blocks within the 16-byte cache lines to be
trashed - which seems to be exactly what you are seeing.

I strongly suggest that you double check all mechanical connections
(CPU socket and memory slots), and if that doesn't help, check your
RAM timing, your supply voltage, and the symmetry and cleanliness
of your clocks.  It sounds like the problem is highly reproducable,
so a next step might be to stick a logic analyser on the CPU/Memory
interface and watch the fill operation on the address, following the flush.

            Regards,

            Kevin K.
