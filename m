Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 09:27:44 +0000 (GMT)
Received: from web10105.mail.yahoo.com ([IPv6:::ffff:216.136.130.55]:52827
	"HELO web10105.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225254AbUAVJ1n>; Thu, 22 Jan 2004 09:27:43 +0000
Message-ID: <20040122092738.52844.qmail@web10105.mail.yahoo.com>
Received: from [128.107.253.43] by web10105.mail.yahoo.com via HTTP; Thu, 22 Jan 2004 09:27:38 GMT
Date: Thu, 22 Jan 2004 09:27:38 +0000 (GMT)
From: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Subject: Re: Doubt in timer interrupt
To: Dominic Sweetman <dom@mips.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <16399.36167.575161.386963@doms-laptop.algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <karthik_96cse@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karthik_96cse@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi Dominic Sweetman,

    Thanks much for your inputs..

> >   In R4000 & descendent processors, interrupt
> number 7
> > is being used for internal timer interrupt. From
> this
> > i understand that the timer interrupt is also
> maskable
> > when the IE bit in status register is cleared. If 
> > somebody mask this interrupt for a long time 
> > erroneously, then won't there be a problem in 
> > maintaining the system time?
> 
> Yes, there may be a long delay.  So the standard way
> of using the
> onchip counter to generate a periodic interrupt is
> that the counter
> itself is allowed to free-run, keeping accurate
> time.
> 
> The 'Compare' register is then incremented by a
> fixed amount.
> 
> So long as the interrupt is not delayed by a whole
> tick, this keeps
> perfect time.
> 
> I'm sure this is described in "See MIPS Run" - do
> you have a copy?

    Yes, i have a copy. Have just started reading
this book.. I yet to get into the deep waters of the
MIPS..

    May i know the purpose of the NMI interrupt and
in what way it differ from the timer interrupt.

Thanks much,
-karthi
 
> --
> Dominic Sweetman
> MIPS Technologies Inc
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
