Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7G7WCA16182
	for linux-mips-outgoing; Thu, 16 Aug 2001 00:32:12 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7G7WBj16178
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 00:32:11 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA28852;
	Thu, 16 Aug 2001 00:31:30 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA14018;
	Thu, 16 Aug 2001 00:31:29 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f7G7U8a06305;
	Thu, 16 Aug 2001 09:30:08 +0200 (MEST)
Message-ID: <3B7B767F.C29A25A9@mips.com>
Date: Thu, 16 Aug 2001 09:30:07 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Brandon Barker <bebarker@meginc.com>
CC: swang@mmc.atmel.com, linux-mips@oss.sgi.com
Subject: Re: About booting malta board.
References: <20010810153944.89482.qmail@web13906.mail.yahoo.com> <3B7AFD6B.C0891B97@mmc.atmel.com> <01081522093400.14676@dell.meginc.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Brandon Barker wrote:

> On a slightly related note, is it possible to have more than 64MB of memory
> on a Malta board?

I have a Malta board with 128MB.
Currently we have a problem in our bootloader (YAMON), it only see up till
128MB, which mean that we only use up till 128MB of the RAM module, even though
the RAM module contain more than 128MB.
That will be fix in a later release.


>  If so, I may get a Malta - it would be a little more
> exciting to work with than my Indy.
>
> On Wednesday 15 August 2001 06:53 pm, you wrote:
> > I try to install the Linux on the Malta board. In the big-endian mode, it
> > works fine. But in the little-endian mode, the kernel just displayed
> > "LINUX started..." and then deadlock.  Does anybody can help  me solve the
> > problem ?
> >
> > I guess the system maybe failed to create an initial console for displaying
> > messages to me?
> >
> > Thanks,
> >
> > --Shuanglin

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
