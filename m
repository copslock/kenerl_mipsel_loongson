Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 11:47:33 +0100 (BST)
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([IPv6:::ffff:213.105.254.86]:50310
	"EHLO lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8225241AbTFEKra>; Thu, 5 Jun 2003 11:47:30 +0100
Received: from dhcp22.swansea.linux.org.uk (dhcp22.swansea.linux.org.uk [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.8/8.12.5) with ESMTP id h55Aj6RQ015388;
	Thu, 5 Jun 2003 11:45:07 +0100
Received: (from alan@localhost)
	by dhcp22.swansea.linux.org.uk (8.12.8/8.12.8/Submit) id h55Aj4bE015386;
	Thu, 5 Jun 2003 11:45:04 +0100
X-Authentication-Warning: dhcp22.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [RFC] synchronized CPU count registers on SMP machines
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
In-Reply-To: <20030605001232.GA5626@linux-mips.org>
References: <20030604153930.H19122@mvista.com>
	 <20030604231547.GA22410@linux-mips.org> <20030604164652.J19122@mvista.com>
	 <20030605001232.GA5626@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054809902.15275.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jun 2003 11:45:03 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Iau, 2003-06-05 at 01:12, Ralf Baechle wrote:
> You loose.  The reasons why SGI did construct their systems that way are
> still valid.  It can be quite tricky to distribute the clock in large
> systems - even for a moderate definition of large.  And for ccNUMAs which
> are going to show up on the embedded market sooner or later it's easy
> for the lazy designer to use several clock sources anyway.  Note our
> current time code for will not work properly if clocks diverge on the
> slightest bit - among other things the standards mandate time to
> monotonically increase.

Actually the standards are suprisingly lax. I had the same assumptions
but people who went and read the spec in detail found Posix is a lot
more relaxed (except about CLOCK_MONOTONIC).

What seems to be happening in the PC and Sparc worlds is vendors are
running a seperate lower accuracy global clock source (eg the HPET on
AMD64)
