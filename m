Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g65EY5Rw021687
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 5 Jul 2002 07:34:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g65EY5E3021686
	for linux-mips-outgoing; Fri, 5 Jul 2002 07:34:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (dialinpool.tiscali.de [62.246.30.80] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g65EXwRw021674
	for <linux-mips@oss.sgi.com>; Fri, 5 Jul 2002 07:34:00 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g65Ebs631979;
	Fri, 5 Jul 2002 16:37:54 +0200
Date: Fri, 5 Jul 2002 16:37:54 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: LTP testing (shmat01)
Message-ID: <20020705163754.C31881@dea.linux-mips.net>
References: <3D246924.542682B2@mips.com> <20020704193414.A29570@dea.linux-mips.net> <3D249181.D9147AAE@mips.com> <20020704215614.B29422@dea.linux-mips.net> <3D253D18.3BE59AED@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D253D18.3BE59AED@mips.com>; from carstenl@mips.com on Fri, Jul 05, 2002 at 08:30:48AM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.1 required=5.0 tests=IN_REP_TO,MAY_BE_FORGED version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 05, 2002 at 08:30:48AM +0200, Carsten Langgaard wrote:

> Using PAGE_SIZE is ok, even though it may differ from different architecture,
> because SHMLBA is defined as the following in /usr/include/sys/shm.h:
> #define SHMLBA          (__getpagesize ())
> 
> So I would expect the user application and the kernel should have the same
> idea of what the size is.

Definately.  I just checked it - this is an antique bug that was already
present in glibc 2.0.6.  I'm amazed people we got away with that one for
so long ...

  Ralf
