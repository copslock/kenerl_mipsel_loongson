Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jan 2003 02:30:07 +0000 (GMT)
Received: from p508B6FCB.dip.t-dialin.net ([IPv6:::ffff:80.139.111.203]:5101
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225240AbTAYCaH>; Sat, 25 Jan 2003 02:30:07 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0P2Tu024450;
	Sat, 25 Jan 2003 03:29:56 +0100
Date: Sat, 25 Jan 2003 03:29:56 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Tibor Polgar <tpolgar@freehandsystems.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Is the CVS server down?
Message-ID: <20030125032956.A23962@linux-mips.org>
References: <3E2C518B.E1596B8B@freehandsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E2C518B.E1596B8B@freehandsystems.com>; from tpolgar@freehandsystems.com on Mon, Jan 20, 2003 at 11:44:11AM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 20, 2003 at 11:44:11AM -0800, Tibor Polgar wrote:

> > cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs login
> Logging in to :pserver:cvs@ftp.linux-mips.org:2401/home/cvs
> CVS password: 
> cvs [login aborted]: connect to ftp.linux-mips.org(62.254.210.162):2401
> failed: Connection refused
> > 
> 
> Per the website i'm using the password of "cvs" (without quotes).  Is it just
> our site/firewall?

No.  A remote exploitable security hole has been discovered in the cvs
server code so I had to shutdown the server temporarily.  The service is
back since the whole hole has been plugged.

As for firewalls I'd like to mention that linux-mips.org is running with
ECN enabled.  That means sites still running broken firewalls such as
certain versions of the Cisco PIX may experience problems when using
certain linux-mips.org services such as active mode ftp and email.  Time
to upgrade the firewall, fixed versions are out since long and ECN has
become the law ...

  Ralf
