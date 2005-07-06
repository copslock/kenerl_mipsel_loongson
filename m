Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2005 17:21:23 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.203]:15625 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226345AbVGFQVG> convert rfc822-to-8bit;
	Wed, 6 Jul 2005 17:21:06 +0100
Received: by wproxy.gmail.com with SMTP id i22so1087068wra
        for <linux-mips@linux-mips.org>; Wed, 06 Jul 2005 09:21:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kEXoemsOFANWsPAiGNbGsujYpc7cZwMB9wkUFoJxk5lBokLFOX/Mo9kaTOafgFMQ0Oq7cc4qLpyO/LNIliymzZDKy3FkPIGO0cW99pxB4odrywH/PpyZNN+y2Uu57m09PCpxG0ClNevOJUoMog5L4deEmnq9elKk/7FcQDrPeIY=
Received: by 10.54.80.7 with SMTP id d7mr412528wrb;
        Wed, 06 Jul 2005 09:21:20 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Wed, 6 Jul 2005 09:21:20 -0700 (PDT)
Message-ID: <2db32b7205070609215b750fea@mail.gmail.com>
Date:	Wed, 6 Jul 2005 09:21:20 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	ppopov@embeddedalley.com
Subject: Re: possible serial driver fixup for au1x00 in 2.6?
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <1120633817.5724.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b720507011756247735d6@mail.gmail.com>
	 <1120266383.5987.46.camel@localhost.localdomain>
	 <2db32b72050705124078a48aed@mail.gmail.com>
	 <1120633817.5724.26.camel@localhost.localdomain>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Pete,
I just give 8250.c a dirty hack, letting it just manage the additional
serial ports. So there are two serial driver in the system at the same
time :(  Sound funny.

thanks for your comments. I will give the feadback when I get more :)


On 7/6/05, Pete Popov <ppopov@embeddedalley.com> wrote:
> On Tue, 2005-07-05 at 12:40 -0700, rolf liu wrote:
> > Pete,
> > To try if 8250.c can work under db1550/linux 2.6.12, I turn off the
> > au1x00_uart.c config and just compiled in the 8250 support. When I
> > boot the kernel, nothing comes up through the console, which should be
> > provided by 8250 support, by 8250_early.c?
> >
> > Any idea?
> 
> Yes. The 8250.c won't work with the au1x uart. I know I said in a
> previous email that the 8250 "basically" does the same thing as the au1x
> uart driver, but if the 8250 worked with the Au1x SoCs, why would we
> even have the au1x serial driver in place?
> 
> Pete
> 
> >
> > On 7/1/05, Pete Popov <ppopov@embeddedalley.com> wrote:
> > > On Fri, 2005-07-01 at 17:56 -0700, rolf liu wrote:
> > > > Basically, au1x00_uart.c is doing the same thing as 8250.c.
> > >
> > > Basically.
> > >
> > > > If I want
> > > > to add extra serial port support by 8250.c. There could be some
> > > > problem. Any idea?
> > >
> > > Don't know, haven't tried it. In general, the au1x00 serial driver needs
> > > to be rewritten.
> > >
> > > Pete
> > >
> > >
> >
> 
>
