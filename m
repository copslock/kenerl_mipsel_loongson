Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 15:45:50 +0000 (GMT)
Received: from web10108.mail.yahoo.com ([IPv6:::ffff:216.136.130.58]:29802
	"HELO web10108.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224914AbUASPpl>; Mon, 19 Jan 2004 15:45:41 +0000
Message-ID: <20040119154538.92376.qmail@web10108.mail.yahoo.com>
Received: from [128.107.253.43] by web10108.mail.yahoo.com via HTTP; Mon, 19 Jan 2004 15:45:38 GMT
Date: Mon, 19 Jan 2004 15:45:38 +0000 (GMT)
From: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Subject: Re: In r4k, where does PC point to?
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <20040119152214.GA9933@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <karthik_96cse@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karthik_96cse@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

> > > Which is true, but perhaps a bit cryptic given
> the
> > > question.
> > > 
> > > A MIPS CPU does not have a register called "PC".
>  In
> > 
> > In the r4k user manual, it is mentioned that there
> is
> > a special register PC in the core CPU (other than
> the 
> > HI & LO special registers). Could you please let
> me 
> > know the purpose of this register?
> 
> Obviously the CPU needs to know where to fetch the
> next instruction from

So the PC points to the next instruction to be
fetched,
but it is not visible to the programmer..

> or for computing the destination address of branch
> and jump instructions
> or the value to put into the programmer visible EPC
> and ErrorEPC registers

Am curious to know, how the PC register can be used to

locate the instruction which caused the exception as 
the exception can happen at any one of the eight 
pipeline stages..

Thanks much,
-karthi


> etc.  The PC register is an internal register that
> isn't visible to the
> programmer.

So the bottom line here is PC is internal register and

the EPC is visible to the programmer.. 


Thanks,
-karthi
 
>   Ralf
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
