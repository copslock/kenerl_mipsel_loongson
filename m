Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Jun 2004 01:03:54 +0100 (BST)
Received: from p508B79F9.dip.t-dialin.net ([IPv6:::ffff:80.139.121.249]:55394
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225363AbUFTADu>; Sun, 20 Jun 2004 01:03:50 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i5K03nIZ028093
	for <linux-mips@linux-mips.org>; Sun, 20 Jun 2004 02:03:49 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i5K03m84028092
	for linux-mips@linux-mips.org; Sun, 20 Jun 2004 02:03:48 +0200
Date: Sun, 20 Jun 2004 02:03:48 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: Dummy keyboard driver
Message-ID: <20040620000348.GB23498@linux-mips.org>
References: <20040619200923.GA22409@linux-mips.org> <20040619223829.GD20632@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619223829.GD20632@lug-owl.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jun 20, 2004 at 12:38:30AM +0200, Jan-Benedict Glaw wrote:

> On Sat, 2004-06-19 22:09:23 +0200, Ralf Baechle <ralf@linux-mips.org>
> wrote in message <20040619200923.GA22409@linux-mips.org>:
> > Is there still a need for the dummy keyboard driver?  Right now DUMMY_KEYB
> > is being set for a bunch of platforms without having any effect so I take
> > to mean we can remove dummy_keyb.c.
> 
> I (vax 2.6.x tree) don't even have that file, and there shouldn't be no
> need for any kind of dummy keyboard. Either there's at least one
> keyboard attached (multiple are fine, though), you get input. No
> keyboard (driver), no input. Simple.
> 
> Just drop it.

I don't think the original reason for it still exists and even if it
was it'd need to be rewritten and moved so I'm removing it now.

  Ralf
