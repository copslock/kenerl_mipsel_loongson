Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 15:14:06 +0000 (GMT)
Received: from web10106.mail.yahoo.com ([IPv6:::ffff:216.136.130.56]:4015 "HELO
	web10106.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225222AbUASPOF>; Mon, 19 Jan 2004 15:14:05 +0000
Message-ID: <20040119151403.71569.qmail@web10106.mail.yahoo.com>
Received: from [128.107.253.43] by web10106.mail.yahoo.com via HTTP; Mon, 19 Jan 2004 15:14:03 GMT
Date: Mon, 19 Jan 2004 15:14:03 +0000 (GMT)
From: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Subject: Re: In r4k, where does PC point to?
To: Dominic Sweetman <dom@mips.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
In-Reply-To: <16395.61512.498041.811385@gladsmuir.mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <karthik_96cse@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karthik_96cse@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi Dominic Sweetman,

> > >     Basically, the PC points to the next
> instruction
> > > to
> > > be executed. But, in R4k, there are 8
> instructions
> > > getting executed in parallel. Where does the PC
> point
> > > to? My understanding is that PC points to the
> next 
> > > instruction that will be entered into the
> pipeline.
> > >     Please correct me if i am wrong..
> 
> Ralf Baechle (ralf@linux-mips.org) writes:
>  
> > The fact that instructions are issued in a
> pipeline is not visible in
> > the EPC value.
> 
> Which is true, but perhaps a bit cryptic given the
> question.
> 
> A MIPS CPU does not have a register called "PC".  In

In the r4k user manual, it is mentioned that there is
a special register PC in the core CPU (other than the 
HI & LO special registers). Could you please let me 
know the purpose of this register?

Thanks,
-karthi

> the MIPS
> architecture, "PC" is just slang meaning "the
> address of this
> instruction" - and only makes any sense if you're
> prepared to say
> WHICH instruction you mean.
> 
> There IS a register called "EPC" (for "exception
> PC").  When you
> take any kind of exception, it's the address of the
> first instruction
> which didn't get run because the CPU took the
> exception instead.  So
> EPC tells you where to jump back to after the
> exception handler runs.
> 
> Did any of that make any sense?
> 
> --
> Dominic Sweetman
> MIPS Technologies.
> 
> 
> 
>  

=====
The expert at anything was once a beginner
                  ______________________________
                 /                              \
             O  /      Karthikeyan.N             \
           O   |       Chennai, India.            |
    `\|||/'     \    Mobile: +919884104346       /
     (o o)       \                              /
_ ooO (_) Ooo____________________________________
_____|_____|_____|_____|_____|_____|_____|_____|_
__|_____|_____|_____|_____|_____|_____|_____|____
_____|_____|_____|_____|_____|_____|_____|_____|_

________________________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
