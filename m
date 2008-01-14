Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 14:30:17 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:54157 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20030063AbYANOaI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 14:30:08 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 3A39C513B9;
	Mon, 14 Jan 2008 15:30:03 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1JEQKf-0002fG-8R; Mon, 14 Jan 2008 14:30:33 +0000
Date:	Mon, 14 Jan 2008 14:30:33 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] prom_free_prom_memory for QEMU
Message-ID: <20080114143033.GC9693@networkno.de>
References: <20080114.212253.126142719.anemo@mba.ocn.ne.jp> <20080114133701.GA16555@linux-mips.org> <20080114.225318.63132741.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080114.225318.63132741.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-12-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 14 Jan 2008 13:37:01 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > I was actually planning to remove the Qemu platform for 2.6.25.  The
> > Malta emulation has become so good that there is no more point in having
> > the underfeatured synthetic platform that CONFIG_QEMU is.
> > 
> > Objections?
> 
> The Qemu platform is one of officially supported platforms by Debian.
> If Debian did not support the Malta yet, I hope qemu alive.

Debian/unstable had Malta kernels for a while now, installer support
is currently in the works.


Thiemo
