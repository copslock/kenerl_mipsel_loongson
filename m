Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 01:12:36 +0100 (BST)
Received: from p508B7EE4.dip.t-dialin.net ([IPv6:::ffff:80.139.126.228]:50654
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225241AbTFEAMe>; Thu, 5 Jun 2003 01:12:34 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h550CXbY006014;
	Wed, 4 Jun 2003 17:12:33 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h550CW2O006013;
	Thu, 5 Jun 2003 02:12:33 +0200
Date: Thu, 5 Jun 2003 02:12:32 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [RFC] synchronized CPU count registers on SMP machines
Message-ID: <20030605001232.GA5626@linux-mips.org>
References: <20030604153930.H19122@mvista.com> <20030604231547.GA22410@linux-mips.org> <20030604164652.J19122@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030604164652.J19122@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 04, 2003 at 04:46:52PM -0700, Jun Sun wrote:

> Assuming SGI systems represent the past of MIPS, we are still ok
> future-wise. :)

You loose.  The reasons why SGI did construct their systems that way are
still valid.  It can be quite tricky to distribute the clock in large
systems - even for a moderate definition of large.  And for ccNUMAs which
are going to show up on the embedded market sooner or later it's easy
for the lazy designer to use several clock sources anyway.  Note our
current time code for will not work properly if clocks diverge on the
slightest bit - among other things the standards mandate time to
monotonically increase.

  Ralf
