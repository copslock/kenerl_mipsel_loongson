Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 21:14:15 +0100 (BST)
Received: from p508B6C80.dip.t-dialin.net ([IPv6:::ffff:80.139.108.128]:23335
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225275AbUJNUOK>; Thu, 14 Oct 2004 21:14:10 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9EKDord009884;
	Thu, 14 Oct 2004 22:13:50 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9EKDinY009872;
	Thu, 14 Oct 2004 22:13:44 +0200
Date: Thu, 14 Oct 2004 22:13:44 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjoern Riemer <riemer@fokus.fraunhofer.de>,
	ppopov@embeddedalley.com,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: meshcube patch for au1000 network driver
Message-ID: <20041014201344.GD5975@linux-mips.org>
References: <416BC4D9.2060904@fokus.fraunhofer.de> <20041013110947.GA6992@linux-mips.org> <Pine.GSO.4.61.0410131314040.2571@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0410131314040.2571@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 13, 2004 at 01:14:22PM +0200, Geert Uytterhoeven wrote:

> On Wed, 13 Oct 2004, Ralf Baechle wrote:
> > On Tue, Oct 12, 2004 at 01:49:45PM +0200, Bjoern Riemer wrote:
> > > i fixed the ioctl support in the net driver to support link detection by
> > >   ifplugd ond maybe netplugd(not tested)
> > > here my patch for
> > > drivers/net/au1000.c
> > 
> > Please never ever send ed-style patches, only unified (-u).  They're
> > totally unreadable and have several technical problems.  And preferbly
> > inline, not attachment.
> 
> And `-p' helps as wel...

True, it makes patches more readable but there seems to be some trouble
with -p and cvs diff and I certaily don't consider the non-use any kind
of reason for rejecting a patch.

  Ralf
