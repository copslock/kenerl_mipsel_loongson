Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PEdInC022458
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 07:39:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PEdITl022457
	for linux-mips-outgoing; Tue, 25 Jun 2002 07:39:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-147.ka.dial.de.ignite.net [62.180.196.147])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PEdCnC022454
	for <linux-mips@oss.sgi.com>; Tue, 25 Jun 2002 07:39:14 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5PEdf619590;
	Tue, 25 Jun 2002 16:39:41 +0200
Date: Tue, 25 Jun 2002 16:39:41 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: LTP testing
Message-ID: <20020625163941.A19360@dea.linux-mips.net>
References: <3D186E76.63B33B0E@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D186E76.63B33B0E@mips.com>; from carstenl@mips.com on Tue, Jun 25, 2002 at 03:21:58PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 25, 2002 at 03:21:58PM +0200, Carsten Langgaard wrote:

> The problem is that the code is called with $a0 = 0. So the 'sw v0,
> 0(a0)' after the syscall generates a segmentation fault.
> Why are the pipe syscall implemented this way, where we return the two
> descriptors in v0 and v1 ?
> Why doesn't the kernel do these stores (this way we can do an access
> check, like i386 does) ?

Because the interface we're using here is even lighter, even faster.  Note
that by the time when I decieded to use this interface this was potencially
a huge difference as verify_area() was searching the mm AVL trees, so this
interface was potenciall much faster by that time.

  Ralf
