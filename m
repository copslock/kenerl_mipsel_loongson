Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 02:38:39 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:27389 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225241AbTFEBih>;
	Thu, 5 Jun 2003 02:38:37 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h551caE00805;
	Wed, 4 Jun 2003 18:38:36 -0700
Date: Wed, 4 Jun 2003 18:38:36 -0700
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [RFC] synchronized CPU count registers on SMP machines
Message-ID: <20030604183836.B25414@mvista.com>
References: <20030604153930.H19122@mvista.com> <20030604231547.GA22410@linux-mips.org> <20030604164652.J19122@mvista.com> <20030605001232.GA5626@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030605001232.GA5626@linux-mips.org>; from ralf@linux-mips.org on Thu, Jun 05, 2003 at 02:12:32AM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Jun 05, 2003 at 02:12:32AM +0200, Ralf Baechle wrote:
> On Wed, Jun 04, 2003 at 04:46:52PM -0700, Jun Sun wrote:
> 
> > Assuming SGI systems represent the past of MIPS, we are still ok
> > future-wise. :)
> 
> You loose.  The reasons why SGI did construct their systems that way are
> still valid.  It can be quite tricky to distribute the clock in large
> systems - even for a moderate definition of large.  And for ccNUMAs which
> are going to show up on the embedded market sooner or later it's easy
> for the lazy designer to use several clock sources anyway.  Note our
> current time code for will not work properly if clocks diverge on the
> slightest bit - among other things the standards mandate time to
> monotonically increase.
>

Aside from aficionado of SGI legacy, do you see any value in
implementing this just for the applicable SMP systems?

Here is my take:

To implement an efficient and correct time management in SMP
is a hard problem.  I don't think there is a generic solution
here.  (Convince me if I am wrong.)

Therefore for a set of "conforming" SMP systems which don't
have the listed 3 issues, we provide a feasible solution.
I don't see how we can avoid this - unless we don't care about
getting time right.

Jun
