Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2003 16:15:55 +0100 (BST)
Received: from web10106.mail.yahoo.com ([IPv6:::ffff:216.136.130.56]:20389
	"HELO web10106.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225541AbTIXPPx>; Wed, 24 Sep 2003 16:15:53 +0100
Message-ID: <20030924151549.47132.qmail@web10106.mail.yahoo.com>
Received: from [128.107.253.43] by web10106.mail.yahoo.com via HTTP; Wed, 24 Sep 2003 16:15:49 BST
Date: Wed, 24 Sep 2003 16:15:49 +0100 (BST)
From: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Subject: Re: How to translate Little to Big endian ?
To: "prabhakark@contechsoftware.com" <prabhakark@contechsoftware.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <01C382AE.A6330DF0.prabhakark@contechsoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <karthik_96cse@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karthik_96cse@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi Prabhakar,

> I'm trying to port linux-2.4.21 on CSB250 , which is
> Au1500 processor based board,
> the processor is a Big endian, I have taken PB1500
> board as my prototype, but it's used Au1500 Little
> endian.
> anybody could help me out, what are the changes do i
> need to change to make a Little endian souce into
> Big endian source.

   Guess you are looking for a library call to do
this.
If i am correct, then htonl function will serve the
purpose.

My $0.02

Thanks,
-karthi
 
> Is anybody worked on Cogent's CSB250 board till.
> 
> Thanks in advance
> Prabhakar
> 
>  

________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://mail.messenger.yahoo.co.uk
