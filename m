Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2003 22:56:15 +0000 (GMT)
Received: from p508B6365.dip.t-dialin.net ([IPv6:::ffff:80.139.99.101]:27542
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225346AbTKPW4E>; Sun, 16 Nov 2003 22:56:04 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAGMtaA0013263;
	Sun, 16 Nov 2003 23:55:36 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAGMtZ43013262;
	Sun, 16 Nov 2003 23:55:35 +0100
Date: Sun, 16 Nov 2003 23:55:35 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-mips@linux-mips.org
Subject: Re: SNI RM200
Message-ID: <20031116225535.GB7808@linux-mips.org>
References: <20031112124519.GA6403@linux-mips.org> <20031116124400.GA1263@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031116124400.GA1263@deprecation.cyrius.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 16, 2003 at 11:44:00PM +1100, Martin Michlmayr wrote:

> * Ralf Baechle <ralf@linux-mips.org> [2003-11-12 13:45]:
> > For those of you having a dusty RM200 in their cellar, I've
> > resurrected the RM200 port in 2.6.  Only the RM200 C aka RM200 PCI
> 
> Since you're currently cleaning up stuff, do you know the status of
> Origin 200 and 2000 support?  Will a 4 or 8 way Origin 2000 run
> stable?

IP27 doesn't even build in 2.6.  It's by far the most complex supported
machine and getting it to work takes some non-trivial changes - also
to get rid of the various hacks we used to have in device drivers to
get the Origin working.  I'll announce once I have IP27 working again -
not last because I'll also need an Origin 2000 system for testing; I only
have an Origin 200 for testing.

  Ralf
