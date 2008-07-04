Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2008 12:56:33 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:59308 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20177455AbYGDL4Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 Jul 2008 12:56:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m64BsZvR019412;
	Fri, 4 Jul 2008 13:55:00 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m64BsRO8019405;
	Fri, 4 Jul 2008 12:54:27 +0100
Date:	Fri, 4 Jul 2008 12:54:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ths@networkno.de, mlarsen@broadcom.com, linux-mips@linux-mips.org
Subject: Re: Bug in atomic_sub_if_positive
Message-ID: <20080704115427.GA992@linux-mips.org>
References: <20080702095955.GA7007@networkno.de> <20080702.193133.211490377.nemoto@toshiba-tops.co.jp> <20080702105155.GC7007@networkno.de> <20080704.000426.39153587.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080704.000426.39153587.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 04, 2008 at 12:04:26AM +0900, Atsushi Nemoto wrote:

> On Wed, 2 Jul 2008 11:51:55 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > > The patch looks correct.
> > 
> > Agreed.
> 
> Ralf, too late for 2.6.26?

Pull request to Linus is out.

> Anyway I think it should go into -stable tree too.

It is.  This one is important.  Heck, I don't get how a kernel can be as
reliable as it was with an elefant like this :-)

  Ralf
