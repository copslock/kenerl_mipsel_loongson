Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f566N4h11969
	for linux-mips-outgoing; Tue, 5 Jun 2001 23:23:04 -0700
Received: from dea.waldorf-gmbh.de (u-228-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.228])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f566N1h11959
	for <linux-mips@oss.sgi.com>; Tue, 5 Jun 2001 23:23:02 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f566MiT30296;
	Wed, 6 Jun 2001 08:22:44 +0200
Date: Wed, 6 Jun 2001 08:22:44 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
Message-ID: <20010606082243.B29567@bacchus.dhis.org>
References: <20010605220605.A10997@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010605220605.A10997@lucon.org>; from hjl@lucon.org on Tue, Jun 05, 2001 at 10:06:05PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 05, 2001 at 10:06:05PM -0700, H . J . Lu wrote:

> My toolchain should be as capable as the x86 version in RedHat 7.1.
> But I do have 2 issues:
> 
> 1. I got quite a few C++ exception execution failures from "make check"
> in gcc 2.96. But I got more C++ exception execution failures on
> IRIX 6.5. I guess the bugs are in gcc and/or binutils.
> 2. gdb in RedHat 7.1 has yet to be ported to mips. Without a working
> gdb, it is very hard to fix 1.
> 
> I'd like to fold back my mips changes to gcc, glibc and binutils.
> Before I submit my changes, I'd like to get them checked out by the
> Linux/mips experts and users, especially on big endian mips. It will
> also be nice to have a working gdb and reliable C++ exception.
> 
> Is there anyone interested in my new mips toolchain?

Definately.

> Is there anyone interested in fixing gdb and C++ exception?

We're definately interested and are painfully aware of shortcomings in
those areas.  Alone the limitation of days to just 48h so far has prevented
us from fixing it.

  Ralf
