Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 16:41:40 +0000 (GMT)
Received: from p508B5C01.dip.t-dialin.net ([IPv6:::ffff:80.139.92.1]:52617
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225315AbUAMQlk>; Tue, 13 Jan 2004 16:41:40 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0DGdZWI005404;
	Tue, 13 Jan 2004 17:39:35 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0DGdYIf005403;
	Tue, 13 Jan 2004 17:39:34 +0100
Date: Tue, 13 Jan 2004 17:39:34 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix DECSTATION depends
Message-ID: <20040113163934.GB31459@linux-mips.org>
References: <20040113015202.GE9677@fs.tum.de> <20040113022826.GC1646@linux-mips.org> <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 13, 2004 at 02:07:54PM +0100, Maciej W. Rozycki wrote:

> 
> > > it seems the following is required in Linus' tree to get correct depends 
> > > for DECSTATION:
> > 
> > Thanks,  applied.
> 
>  The dependency was intentional: stable for 32-bit, experimental for
> 64-bit.  I'm reverting the change immediately.  Please always contact me
> before applying non-obvious changes for the DECstation.

Well, this one seemed to be obvious but sometimes things are not what
they seem to be ...

  Ralf
