Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2005 08:10:06 +0100 (BST)
Received: from smtp008.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.74]:15192
	"HELO smtp008.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8226314AbVGFHJu>; Wed, 6 Jul 2005 08:09:50 +0100
Received: (qmail 18351 invoked from network); 6 Jul 2005 07:10:10 -0000
Received: from unknown (HELO ?192.168.1.107?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp008.bizmail.sc5.yahoo.com with SMTP; 6 Jul 2005 07:10:10 -0000
Subject: Re: possible serial driver fixup for au1x00 in 2.6?
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	rolf liu <rolfliu@gmail.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <2db32b72050705124078a48aed@mail.gmail.com>
References: <2db32b720507011756247735d6@mail.gmail.com>
	 <1120266383.5987.46.camel@localhost.localdomain>
	 <2db32b72050705124078a48aed@mail.gmail.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Wed, 06 Jul 2005 00:10:17 -0700
Message-Id: <1120633817.5724.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Tue, 2005-07-05 at 12:40 -0700, rolf liu wrote:
> Pete,
> To try if 8250.c can work under db1550/linux 2.6.12, I turn off the
> au1x00_uart.c config and just compiled in the 8250 support. When I
> boot the kernel, nothing comes up through the console, which should be
> provided by 8250 support, by 8250_early.c?
> 
> Any idea?

Yes. The 8250.c won't work with the au1x uart. I know I said in a
previous email that the 8250 "basically" does the same thing as the au1x
uart driver, but if the 8250 worked with the Au1x SoCs, why would we
even have the au1x serial driver in place?

Pete

> 
> On 7/1/05, Pete Popov <ppopov@embeddedalley.com> wrote:
> > On Fri, 2005-07-01 at 17:56 -0700, rolf liu wrote:
> > > Basically, au1x00_uart.c is doing the same thing as 8250.c.
> > 
> > Basically.
> > 
> > > If I want
> > > to add extra serial port support by 8250.c. There could be some
> > > problem. Any idea?
> > 
> > Don't know, haven't tried it. In general, the au1x00 serial driver needs
> > to be rewritten.
> > 
> > Pete
> > 
> >
> 
