Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Oct 2004 12:28:06 +0100 (BST)
Received: from p508B657D.dip.t-dialin.net ([IPv6:::ffff:80.139.101.125]:22316
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225005AbUJWL2C>; Sat, 23 Oct 2004 12:28:02 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9NBS1jN011610;
	Sat, 23 Oct 2004 13:28:01 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9NBS07H011609;
	Sat, 23 Oct 2004 13:28:00 +0200
Date: Sat, 23 Oct 2004 13:28:00 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: kernel_thread creation bug?
Message-ID: <20041023112800.GB10370@linux-mips.org>
References: <20041022.170758.48799763.nemoto@toshiba-tops.co.jp> <20041022121647.GA27961@linux-mips.org> <20041022.212503.39150495.nemoto@toshiba-tops.co.jp> <Pine.LNX.4.58L.0410230457000.8265@blysk.ds.pg.gda.pl> <Pine.LNX.4.58L.0410230610210.32638@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0410230610210.32638@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 23, 2004 at 06:15:25AM +0100, Maciej W. Rozycki wrote:

>  We want interrupts to be disabled until rfe, of course.  Here's an
> update.  Hopefully no more bugs here...

Go ahead ...

  Ralf
