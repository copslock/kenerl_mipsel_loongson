Received:  by oss.sgi.com id <S553843AbRAHQkS>;
	Mon, 8 Jan 2001 08:40:18 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:55797 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553838AbRAHQkR>; Mon, 8 Jan 2001 08:40:17 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870733AbRAHQaO>; Mon, 8 Jan 2001 14:30:14 -0200
Date:	Mon, 8 Jan 2001 14:30:14 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Carsten Langgaard <carstenl@mips.com>
Cc:	Ralf Baechle <ralf@oss.sgi.com>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
Message-ID: <20010108143014.E886@bacchus.dhis.org>
References: <00d801c0797d$5cc410c0$0deca8c0@Ulysses> <Pine.GSO.3.96.1010108151854.23234G-100000@delta.ds2.pg.gda.pl> <20010108140506.B886@bacchus.dhis.org> <3A59E978.873182CB@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A59E978.873182CB@mips.com>; from carstenl@mips.com on Mon, Jan 08, 2001 at 05:23:20PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jan 08, 2001 at 05:23:20PM +0100, Carsten Langgaard wrote:

> What we need is a mechanism to partial invalidate the I-cache and a mechanism
> to write-back and/or invalidate the D-cache.

There is this nice little man page which should even be installed on your
Linux/Inhell box:


CACHEFLUSH(2)       Linux Programmer's Manual       CACHEFLUSH(2)


NAME
       cacheflush  -  flush  contents  of instruction and/or data
       cache

SYNOPSIS
       #include <asm/cachectl.h>

       int cacheflush(char *addr, int nbytes, int cache);

DESCRIPTION
       cacheflush flushes contents of indicated cache(s) for user
       addresses  in the range addr to (addr+nbytes-1). Cache may
       be one of:

       ICACHE Flush the instruction cache.

       DCACHE Write back to memory and  invalidate  the  affected
              valid cache lines.

       BCACHE Same as (ICACHE|DCACHE).


RETURN VALUE
       cacheflush  returns 0 on success or -1 on error. If errors
       are detected, errno will indicate the error.

ERRORS
       EINVAL cache parameter is not one of  ICACHE,  DCACHE,  or
              BCACHE.

       EFAULT Some   or   all   of  the  address  range  addr  to
              (addr+nbytes-1) is not accessible.


BUGS
       The current implementation ignores  the  addr  and  nbytes
       parameters.   Therefore always the whole cache is flushed.

NOTE
       This system call is only available on MIPS based  systems.
       It should not be used in programs intended to be portable.
















Linux 2.0.32                27 June 95                          1
