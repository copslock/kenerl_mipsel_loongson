Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 14:27:43 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:38532 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20030091AbYANO1d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 14:27:33 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 4E244513B9;
	Mon, 14 Jan 2008 15:27:27 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1JEQI9-0002eA-Ba; Mon, 14 Jan 2008 14:27:57 +0000
Date:	Mon, 14 Jan 2008 14:27:57 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] prom_free_prom_memory for QEMU
Message-ID: <20080114142757.GB9693@networkno.de>
References: <20080114.212253.126142719.anemo@mba.ocn.ne.jp> <20080114133701.GA16555@linux-mips.org> <20080114.225318.63132741.anemo@mba.ocn.ne.jp> <478B6BBD.90005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478B6BBD.90005@gmail.com>
User-Agent: Mutt/1.5.17 (2007-12-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Dmitri Vorobiev wrote:
> Atsushi Nemoto wrote:
> > On Mon, 14 Jan 2008 13:37:01 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> >> I was actually planning to remove the Qemu platform for 2.6.25.  The
> >> Malta emulation has become so good that there is no more point in having
> >> the underfeatured synthetic platform that CONFIG_QEMU is.
> >>
> >> Objections?
> > 
> > The Qemu platform is one of officially supported platforms by Debian.
> > If Debian did not support the Malta yet, I hope qemu alive.
> 
> Would you like me to try following the instructions given at
> 
> http://www.aurel32.net/info/debian_mips_qemu.php
> 
> with QEMU emulating a Malta board? I haven't tried this yet, but I
> feel that the possibility exists that this would work out of the box.

Combining a self-compiled Malta kernel with the Qemu initrd from Debian
works with some minor glitches (like unusable kernel modules in the
installed image). Adding proper support in the Debian installer is
currently ongoing.


Thiemo
