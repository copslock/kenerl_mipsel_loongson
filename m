Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2003 22:10:46 +0100 (BST)
Received: from p508B58EB.dip.t-dialin.net ([IPv6:::ffff:80.139.88.235]:45997
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225234AbTFXVKn>; Tue, 24 Jun 2003 22:10:43 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h5OLAfML019165;
	Tue, 24 Jun 2003 23:10:41 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h5OLAeOt019164;
	Tue, 24 Jun 2003 23:10:40 +0200
Date: Tue, 24 Jun 2003 23:10:40 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Pete Popov <ppopov@mvista.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030624211040.GA19034@linux-mips.org>
References: <20030624033916Z8224827-1272+2821@linux-mips.org> <20030624093157.GA25367@linux-mips.org> <1056477065.10455.225.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056477065.10455.225.camel@zeus.mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 24, 2003 at 10:51:05AM -0700, Pete Popov wrote:

> > > CVSROOT:	/home/cvs
> > > Module name:	linux
> > > Changes by:	ppopov@ftp.linux-mips.org	03/06/24 04:39:11
> > > 
> > > Modified files:
> > > 	drivers/char   : Tag: linux_2_4 Makefile 
> > > 
> > > Log message:
> > > 	Added au1x00-serial.o to the exports list.
> > 
> > There doesn't seem to be a good reason to.  Only the register_serial and
> > unregister_serial are exported and they don't seem to be called from
> > anywhere outside.
> 
> Strange, the kernel wouldn't compile without this. I'll try locally to
> build it again and see what the problem is and if we can fix it without
> modifying the Makefile.

Of course it'll build once you remove the unnecessary symbol exports :-)

  Ralf
