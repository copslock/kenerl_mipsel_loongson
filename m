Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Sep 2004 21:42:02 +0100 (BST)
Received: from web81008.mail.yahoo.com ([IPv6:::ffff:206.190.37.153]:46736
	"HELO web81008.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224935AbUI0Ul5>; Mon, 27 Sep 2004 21:41:57 +0100
Message-ID: <20040927204150.79545.qmail@web81008.mail.yahoo.com>
Received: from [216.98.102.225] by web81008.mail.yahoo.com via HTTP; Mon, 27 Sep 2004 13:41:50 PDT
X-RocketYMMF: pvpopov@pacbell.net
Date: Mon, 27 Sep 2004 13:41:50 -0700 (PDT)
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
Subject: Re: 2.6 status for pb1100?
To: Karl Lessard <klessard@sunrisetelecom.com>,
	linux-mips@linux-mips.org
In-Reply-To: <415879BF.3060802@sunrisetelecom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips



> I'm working with a PB1100 board, and I try to run a
> linux 2.6 kernel.  I've both try the 
> kernel.org releases (2.6.8.1)and linux-mips CVS 
> head. While both fail due to many reasons, 
> I've observed that some drivers have not 
> been implemented or updated for kernel 2.6
> series (for example the au1100 framebuffer 
> driver still use some kernel 2.4 headers).
> 
> My question is: Do PB1100 boards are officially
> supported by  2.6.x kernels?

Not yet, but we're working on it. Our target is the
Db1x boards, however, updating the Pb1x will be
trivial once the Pb1x are working. I have a bunch of
patches in my queue but won't be able to push them
until I get back from vacation. The FB driver is not
one of them though -- that comes later.

Pete
