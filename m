Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7FM8FU15801
	for linux-mips-outgoing; Wed, 15 Aug 2001 15:08:15 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7FM8Ej15795
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 15:08:14 -0700
Received: from pacbell.net (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7FMCvA01074;
	Wed, 15 Aug 2001 15:12:57 -0700
Message-ID: <3B7AF3A2.4010404@pacbell.net>
Date: Wed, 15 Aug 2001 15:11:46 -0700
From: Pete Popov <ppopov@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: swang@mmc.atmel.com
CC: linux-mips@oss.sgi.com
Subject: Re: About booting malta board.
References: <20010810153944.89482.qmail@web13906.mail.yahoo.com> <3B7AFD6B.C0891B97@mmc.atmel.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Shuanglin Wang wrote:
> I try to install the Linux on the Malta board. In the big-endian mode, it
> works fine. But in the little-endian mode, the kernel just displayed
> "LINUX started..." and then deadlock.  Does anybody can help  me solve the
> problem ?
> 
> I guess the system maybe failed to create an initial console for displaying
> messages to me?

What kernel and where did you get it from? MontaVista has a Linux Support
Package (LSP) for the Malta and it's available on the Journeyman Mips CD.
I'm pretty sure it's little endian.

Pete
