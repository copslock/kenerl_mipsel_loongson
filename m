Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2007 15:01:44 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:43746 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023278AbXDPOBm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Apr 2007 15:01:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l3GE1ejI031069;
	Mon, 16 Apr 2007 15:01:40 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l3GE1ck4031068;
	Mon, 16 Apr 2007 15:01:38 +0100
Date:	Mon, 16 Apr 2007 15:01:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Zhang Fuxin <zhangfx@lemote.com>, tiansm@lemote.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/16] arch related Makefile update for lemote fulong mini-PC
Message-ID: <20070416140137.GB28217@linux-mips.org>
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <20070415222847.GA1402@networkno.de> <4623387F.3070905@lemote.com> <20070416124422.GB1402@networkno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070416124422.GB1402@networkno.de>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 16, 2007 at 01:44:22PM +0100, Thiemo Seufer wrote:

> Zhang Fuxin wrote:
> > >> +cflags-$(CONFIG_CPU_LOONGSON2)	+= -march=r4600 -Wa,--trap
> > > 
> > > I wonder why this is r4600. I heard the Loongson2 is MIPS IV compatible,
> > > so r5000 / r8000 / r10000 would be better choices.
> > 
> > Presently Loongson-2E is nearly MIPS III compatible(with some
> > self-defined extensions), next version will be mips64 release2 compatible.
> 
> I see.
> 
> > -march=r4600 is inherited from loongson-1, -march=mips3 might be a
> > better choice.
> 
> Maybe. The 'mips3' maps to -march=r4000, it would assume more memory
> latency and a slower integer divider then -march=r4600.

I don't really have an issue with that since I see it as a temporary
solution until gcc and binutils know about Loongson 2 specifics.  Given
the bit I know about the Loognson 2 processor architecture I would not
expect a significant performance boost from trying different values for
-march with current toolchains.

  Ralf
