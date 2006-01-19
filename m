Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 09:57:31 +0000 (GMT)
Received: from witte.sonytel.be ([80.88.33.193]:25496 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S8133659AbWASJ5N (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2006 09:57:13 +0000
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k0JA0rYL022494;
	Thu, 19 Jan 2006 11:00:53 +0100 (MET)
Date:	Thu, 19 Jan 2006 11:00:52 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	"P. Christeas" <p_christ@hol.gr>
cc:	David Daney <ddaney@avtrex.com>,
	Kishore K <hellokishore@gmail.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: gcc -3.4.4 and linux-2.4.32
In-Reply-To: <200601190035.19022.p_christ@hol.gr>
Message-ID: <Pine.LNX.4.62.0601191100001.21230@pademelon.sonytel.be>
References: <f07e6e0601160423h5ce1c0d7lcb7e38f8509c4116@mail.gmail.com>
 <43CBD91B.4020607@avtrex.com> <200601171426.10317.p_christ@hol.gr>
 <200601190035.19022.p_christ@hol.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 19 Jan 2006, P. Christeas wrote:
> On Tuesday 17 January 2006 2:26 pm, P. Christeas wrote:
> > Does that apply to gcc-4.0.2 as well? It is mentioned in linux
> > documentation that -funit-at-a-time is safe as of gcc-4.x. Is there (I'm
> > not a MIPS expert) a way to verify whether gcc produces wrong instructions?
> > I've had a similar problem (I only try with gcc 4, because I compile linux
> > 2.6) and is reduced when I use -fno-unit-at-a-time. Still, I have
> > instability, which now appears less often.
> > I've tried the '-fno-unit-at-a-time' solution (for the whole kernel) and
> > the 'pop/push' at interrupt.h fix.
> >
> Just to let you know:
> In a very interesting twist, gcc4.0.2 produces a faulty kernel with the 2.4.31 
> kernel (as the latter is provided from the hardware's manufacturer).
> I'm validating gcc and binutils at the moment.

That's why 2 days ago this one went in in 2.4.x:

| [PATCH] document that gcc 4 is not supported
| 
| gcc 4 is not supported for compiling kernel 2.4, and I don't see any
| compelling reason why kernel 2.4 should ever be adapted to gcc 4.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
