Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64HVGRw012331
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 10:31:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64HVG00012330
	for linux-mips-outgoing; Thu, 4 Jul 2002 10:31:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (dialinpool.tiscali.de [62.246.30.48] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64HUoRw012321
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 10:31:09 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g64HYEq29590;
	Thu, 4 Jul 2002 19:34:14 +0200
Date: Thu, 4 Jul 2002 19:34:14 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: LTP testing (shmat01)
Message-ID: <20020704193414.A29570@dea.linux-mips.net>
References: <3D246924.542682B2@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D246924.542682B2@mips.com>; from carstenl@mips.com on Thu, Jul 04, 2002 at 05:26:28PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.1 required=5.0 tests=IN_REP_TO,MAY_BE_FORGED version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 04, 2002 at 05:26:28PM +0200, Carsten Langgaard wrote:

> The LTP test shmat01 fails on MIPS, because SHMLBA is defined to 0x40000
> (in include/asm-mips/shmparam.h).
> For all other architectures SHMLBA is defined to PAGE_SIZE, does anyone
> know why we are different ?

Sounds like a broken test.  The value of SHMLBA is ABI mandated.  Technically
we could use any power of 2 >= 32kB easily and with plenty of headache
any power of 2 > PAGE_SIZE.

  Ralf
