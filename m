Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5IFGcnC017304
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 18 Jun 2002 08:16:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5IFGcZ4017303
	for linux-mips-outgoing; Tue, 18 Jun 2002 08:16:38 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sccrmhc03.attbi.com (sccrmhc03.attbi.com [204.127.202.63])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5IFGYnC017300
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 08:16:34 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by sccrmhc03.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020618151923.CPT20219.sccrmhc03.attbi.com@ocean.lucon.org>;
          Tue, 18 Jun 2002 15:19:23 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id D195A125C1; Tue, 18 Jun 2002 08:19:18 -0700 (PDT)
Date: Tue, 18 Jun 2002 08:19:18 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: Linux and the Sony Playstation 2
Message-ID: <20020618081918.A3774@lucon.org>
References: <007601c216d0$6f7f0840$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <007601c216d0$6f7f0840$10eca8c0@grendel>; from kevink@mips.com on Tue, Jun 18, 2002 at 03:59:57PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 18, 2002 at 03:59:57PM +0200, Kevin D. Kissell wrote:
> The Sony PS2 Linux kit has been shipping for nearly
> a month now, and I'm frankly astonished at how little
> I've seen on this mailing list about it.  For better or
> for worse, this changes everything for MIPS/Linux.
> The number of MIPS/Linux users worldwide has
> just gone up by at least an order of magnitude,
> and they are on a platform running a 2.2.1-derived
> kernel and using gcc 2.95.2.
> 
> It's a perfectly usable platform out of the box, but
> Carsten has thrown "crashme" at it, and it goes down
> relatively quickly.  People trying to port kaffe and
> other programs that do double-precision float are
> blocked because there's no double precision on the
> R5900, and the Sony kernel lacks the Algorithmics
> emulator.
> 

I looked at PS2 when I was looking for a mips platform for my
Linux/mips work. Unfortunately, PS2 doesn't have ll/sc, which
makes many things complicated.


H.J.
