Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64JqNRw016631
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 12:52:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64JqNfo016630
	for linux-mips-outgoing; Thu, 4 Jul 2002 12:52:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (dialinpool.tiscali.de [62.246.30.48] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64JqFRw016619
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 12:52:17 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g64JuEo01591;
	Thu, 4 Jul 2002 21:56:14 +0200
Date: Thu, 4 Jul 2002 21:56:14 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: LTP testing (shmat01)
Message-ID: <20020704215614.B29422@dea.linux-mips.net>
References: <3D246924.542682B2@mips.com> <20020704193414.A29570@dea.linux-mips.net> <3D249181.D9147AAE@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D249181.D9147AAE@mips.com>; from carstenl@mips.com on Thu, Jul 04, 2002 at 08:18:41PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.1 required=5.0 tests=IN_REP_TO,MAY_BE_FORGED version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 04, 2002 at 08:18:41PM +0200, Carsten Langgaard wrote:

> > any power of 2 > PAGE_SIZE.
> 
> Ok, I see, but is there any reason for us to be different than the
> rest of the world ?

Imho the your question already wrong :-)  Any assumption about the
constant's value in a piece of code is wrong.

The reason why the constant's value was choosen are virtually indexed
caches.  The value allows attaching of shared memory segment without
any cache flushes.

Other architectures also use different values from PAGE_SIZE like IA64 1MB,
SH 16kB and Sparc not even a constant value accross all architectures
variants, so unlike what your posting implicates we're not that unusual.

  Ralf
