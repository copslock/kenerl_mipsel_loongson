Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Sep 2002 10:58:14 +0200 (CEST)
Received: from [64.238.111.99] ([64.238.111.99]:16651 "EHLO mail.ivivity.com")
	by linux-mips.org with ESMTP id <S1123899AbSIXI6O>;
	Tue, 24 Sep 2002 10:58:14 +0200
Received: by ATLOPS with Internet Mail Service (5.5.2653.19)
	id <S7YA8QFB>; Tue, 24 Sep 2002 04:58:06 -0400
Message-ID: <AEC4671C8179D61194DE0002B328BDD2070C47@ATLOPS>
From: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
To: 'Dominic Sweetman' <dom@algor.co.uk>,
	Dinesh Nagpure <dinesh_nagpure@ivivity.com>
Cc: linux-mips@linux-mips.org
Subject: RE: RM5231A: problems in timer using COUNT/COMPARE register.
Date: Tue, 24 Sep 2002 04:57:57 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <dinesh_nagpure@ivivity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dinesh_nagpure@ivivity.com
Precedence: bulk
X-list: linux-mips

Dominic,

For the timer to work correctly, boot mode bitstream bit 18 needs to be zero
(This in the documentation is marked as reserved) which can cause similar
problems. In our case the problem was still different, bumping the PClock to
SysClock multiplier to 9 made the timer work.

Dinesh

-----Original Message-----
From: Dominic Sweetman [mailto:dom@algor.co.uk]
Sent: Tuesday, September 24, 2002 4:41 AM
To: Dinesh Nagpure
Cc: linux-mips@linux-mips.org
Subject: Re: RM5231A: problems in timer using COUNT/COMPARE register.



Dinesh,

> I am in the process of porting Linux to our FPGA platform using RM5231A
> processor. The COUNT/COMPARE register timer is acting funny with me. When
I
> set the compare register value to something like 0x0100_0000 or less I get
> timer interrupt as expected but if I set the COMPARE register to a greater
> value timer interrupt never happens. I have verified this using our boot
> loader also and the results are the same. I am waiting for a reply from
PMC
> but would also like to know if there is anyone out there who faced similar
> problems with RM5231A. From data sheets and user manual I know the count
> register is 32 bit but apparently there is some hitch somewhere that I
need
> to discover. 

I'd be really surprised if there's a hardware bug; the RM5231A is an
old core and it always seemed to work.  Standard practice is to leave
COUNT free-running, and to get timer interrupts by setting COMPARE
ahead of it; this relies totally on being able to use the whole range
of values, and running seamlessly while COUNT overflows back to zero...

Unless you've already done a really low-level, nothing-else-running
software sanity check on this, it seems more likely that some piece of
software is periodically resetting COUNT, or changing COMPARE, behind
your back.

Dominic Sweetman
MIPS Technologies
