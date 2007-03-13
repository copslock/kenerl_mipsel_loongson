Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 00:46:08 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:19903 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021838AbXCMApm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Mar 2007 00:45:42 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2D0hTFf027097;
	Tue, 13 Mar 2007 00:43:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2D0hFTV027084;
	Tue, 13 Mar 2007 00:43:15 GMT
Date:	Tue, 13 Mar 2007 00:43:15 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Marco Braga <marco.braga@gmail.com>,
	Domen Puncer <domen.puncer@telargo.com>,
	linux-mips@linux-mips.org
Subject: Re: Trouble with sound/mips/au1x00.c AC97 driver
Message-ID: <20070313004315.GA26119@linux-mips.org>
References: <20070307104930.GD25248@dusktilldawn.nl> <d459bb380703082322r18879381ma4c57149a8b7adfe@mail.gmail.com> <45F350E9.3020208@cooper-street.com> <d459bb380703120157wb3dde00p4c232e300e82fd3d@mail.gmail.com> <d459bb380703120259r53889966xd8af623ff01ef297@mail.gmail.com> <20070312103927.GC14658@moe.telargo.com> <d459bb380703120609i7d3a9e1dwf7f4fa431a9631e5@mail.gmail.com> <45F57328.8000606@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45F57328.8000606@ru.mvista.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 12, 2007 at 06:35:04PM +0300, Sergei Shtylyov wrote:

> >>It might be ignorance on my part, but aren't au_sync()'s needed here?
> 
> >My ignorance too.. What's au_sync()? Something to writeback/invalidate the
> >cache?
> 
>    It's "memory barrier" (SYNC instruction).

For the general MIPS case (Alchemy may provide guarantees I don't know of)
a SYNC instruction is not sufficient to ensure that a write has actually
been reached by the device.  It may just like on PCI take a read from the
same device again:

   au1000->ac97_ioport->config = AC97C_SG | AC97C_SYNC;
   au1000->ac97_ioport->config;
   udelay(100);
   au1000->ac97_ioport->config = 0x0;

to ensure that all preceding write have actually made it.  That also means
that any use of the SYNC instruction may well be just an attempt to paper
over a bug.

  Ralf
