Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA31770 for <linux-archive@neteng.engr.sgi.com>; Tue, 18 Aug 1998 17:44:40 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA65616
	for linux-list;
	Tue, 18 Aug 1998 17:44:00 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA94972
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 18 Aug 1998 17:43:56 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA26720
	for <linux@cthulhu.engr.sgi.com>; Tue, 18 Aug 1998 17:43:54 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-26.uni-koblenz.de [141.26.249.26])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA28421
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Aug 1998 02:43:38 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA05697;
	Tue, 18 Aug 1998 02:13:16 +0200
Message-ID: <19980818021316.J3345@uni-koblenz.de>
Date: Tue, 18 Aug 1998 02:13:16 +0200
To: Ulf Carlsson <grim@zigzegv.ml.org>, linux@cthulhu.engr.sgi.com
Subject: Re: bus error IRQ
References: <199808171845.UAA29545@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199808171845.UAA29545@calypso.saturn>; from Ulf Carlsson on Mon, Aug 17, 1998 at 08:45:00PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Aug 17, 1998 at 08:45:00PM +0200, Ulf Carlsson wrote:

> Got this little message which crashed the machine:
> 
> Got a bus error IRQ, shouldn't happen yet
> $0 : 00000000 1004fc01 88008048 00000000
> $4 : 88008000 88008000 fffffc18 00000001
> $8 : 88009fe0 3004fc01 8803d2f8 00000003
> $12: 00000038 000003e2 88350a08 89f5be18
> $16: 00000000 00000000 8800a16c 00000f00
> $20: a8747310 9fc45da0 00000000 9fc45da0
> $24: 00000001 2ab0c110
> $28: 88008000 88009e90 9fc45f0c 88013650
> epc   : 880262b8
> Status: 1004fc03
> Cause : 00004000
> Spinning...
> 
> That's in 'schedule'
> 
>     88026298:   03c0e821        move    $sp,$s8
>     8802629c:   8fbf0040        lw      $ra,64($sp)
>     880262a0:   8fbe003c        lw      $s8,60($sp)
>     880262a4:   8fb40038        lw      $s4,56($sp)
>     880262a8:   8fb30034        lw      $s3,52($sp)
>     880262ac:   8fb20030        lw      $s2,48($sp)
>     880262b0:   8fb1002c        lw      $s1,44($sp)
>     880262b4:   8fb00028        lw      $s0,40($sp)
>     880262b8:   03e00008        jr      $ra
>     880262bc:   27bd0048        addiu   $sp,$sp,72
> 
> 00000000880262c0 <__wake_up>:
>     880262c0:   27bdfff8        addiu   $sp,$sp,-8
>     880262c4:   afbe0000        sw      $s8,0($sp)
> 
> Do you know anything about this Ralf? Maybe it's fixed in some version I don't
> have yet?

No, I have no idea what might be causing this.  I myself got bus errors
now and then but for me they have disappeared.  Looks like I fixed them
en passer.

The bad thing with a bus error is that it may be delayed for a very long
time thus resulting in a useless program counter.  What happens is that
the CPU writes to some invalid address but the write access over the
system bus is delayed because the writeback cache policy is being used.
Later, maybe even much later, when the cacheline gets written back to
memory for some reason the system board signals a bus error interrupt.
At this point the program counter may already be completly useless.

I'm shure this has happened in your case as well.

  Ralf
