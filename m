Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 13:40:57 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:2747 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20038732AbWHVMkz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 13:40:55 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7LKdUGx026247;
	Mon, 21 Aug 2006 21:39:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7LKdTV7026245;
	Mon, 21 Aug 2006 21:39:29 +0100
Date:	Mon, 21 Aug 2006 21:39:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] qemu does not have dcache aliases
Message-ID: <20060821203929.GA25617@linux-mips.org>
References: <20060820.003338.25478178.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl> <20060821.225910.108307053.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0608211612090.17504@blysk.ds.pg.gda.pl> <20060821152657.GB19600@linux-mips.org> <20060821153616.GC20395@networkno.de> <Pine.LNX.4.62.0608211741580.6328@pademelon.sonytel.be> <20060821181216.GD20395@networkno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821181216.GD20395@networkno.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 21, 2006 at 07:12:16PM +0100, Thiemo Seufer wrote:

> > It depends. If you just want to run MIPS Linux, yes.
> > If you want to debug the kernel on a MIPS core with cache aliasing[*], no.
> 
> I wrote about qemu upstream's priorities.

Considering that maybe we just change Qemu's c0_config to pretend it
emulates a cacheless CPU - which matches what it actually does.  We can
still change that once upstream priorities and Qemu's actual capabilities
have changed.

  Ralf
