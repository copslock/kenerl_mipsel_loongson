Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 08:16:29 +0100 (BST)
Received: from asia.telenet-ops.be ([195.130.137.74]:62634 "EHLO
	asia.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022610AbXJSHQT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 08:16:19 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by asia.telenet-ops.be (Postfix) with SMTP id EC867D41AF;
	Fri, 19 Oct 2007 09:16:08 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by asia.telenet-ops.be (Postfix) with ESMTP id AEF07D418B;
	Fri, 19 Oct 2007 09:16:08 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id l9J7G85U006289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 19 Oct 2007 09:16:08 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l9J7G8qF006286;
	Fri, 19 Oct 2007 09:16:08 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Fri, 19 Oct 2007 09:16:08 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Wolfgang Denk <wd@denx.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS Makefile not picking up CROSS_COMPILE from environment
 setting
In-Reply-To: <20071018184636.48637242E9@gemini.denx.de>
Message-ID: <Pine.LNX.4.64.0710190915130.23164@anakin>
References: <20071018184636.48637242E9@gemini.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 18 Oct 2007, Wolfgang Denk wrote:
> I noticed that, unlike for other architectures like ARM  or  PowerPC,
> the  MIPS Makefile does not pick up the settings from a CROSS_COMPILE
> environment variable, at least not with many (all?) default  configu-
> rations.
> 
> This makes no sense to me - is there an intention behind it?
> 
> Or should I submit a patch  to  use  an  environment  setting  if  it
> exists, i. e. somthing like this:

BTW, currently there's a discussion about such things on lkml under the
subject `Make m68k cross compile like every other architecture.'.

As you can probably guess, MIPS is unlike every other architecture, too ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
