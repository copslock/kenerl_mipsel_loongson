Received:  by oss.sgi.com id <S553858AbRAHQvh>;
	Mon, 8 Jan 2001 08:51:37 -0800
Received: from mx.mips.com ([206.31.31.226]:18890 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553685AbRAHQve>;
	Mon, 8 Jan 2001 08:51:34 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA19265;
	Mon, 8 Jan 2001 08:51:29 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id IAA27482;
	Mon, 8 Jan 2001 08:51:26 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id RAA00674;
	Mon, 8 Jan 2001 17:50:51 +0100 (MET)
Message-ID: <3A59EFEB.9D35514E@mips.com>
Date:   Mon, 08 Jan 2001 17:50:51 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
References: <00d801c0797d$5cc410c0$0deca8c0@Ulysses> <Pine.GSO.3.96.1010108151854.23234G-100000@delta.ds2.pg.gda.pl> <20010108140506.B886@bacchus.dhis.org> <3A59E978.873182CB@mips.com> <20010108143014.E886@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Exactly that I need, but I don't think it is implemented properly for mips.
It simply flushes all the caches, no matter what options you gives it.

/Carsten

Ralf Baechle wrote:

> On Mon, Jan 08, 2001 at 05:23:20PM +0100, Carsten Langgaard wrote:
>
> > What we need is a mechanism to partial invalidate the I-cache and a mechanism
> > to write-back and/or invalidate the D-cache.
>
> There is this nice little man page which should even be installed on your
> Linux/Inhell box:
>
> CACHEFLUSH(2)       Linux Programmer's Manual       CACHEFLUSH(2)
>
> NAME
>        cacheflush  -  flush  contents  of instruction and/or data
>        cache
>
> SYNOPSIS
>        #include <asm/cachectl.h>
>
>        int cacheflush(char *addr, int nbytes, int cache);
>
> DESCRIPTION
>        cacheflush flushes contents of indicated cache(s) for user
>        addresses  in the range addr to (addr+nbytes-1). Cache may
>        be one of:
>
>        ICACHE Flush the instruction cache.
>
>        DCACHE Write back to memory and  invalidate  the  affected
>               valid cache lines.
>
>        BCACHE Same as (ICACHE|DCACHE).
>
> RETURN VALUE
>        cacheflush  returns 0 on success or -1 on error. If errors
>        are detected, errno will indicate the error.
>
> ERRORS
>        EINVAL cache parameter is not one of  ICACHE,  DCACHE,  or
>               BCACHE.
>
>        EFAULT Some   or   all   of  the  address  range  addr  to
>               (addr+nbytes-1) is not accessible.
>
> BUGS
>        The current implementation ignores  the  addr  and  nbytes
>        parameters.   Therefore always the whole cache is flushed.
>
> NOTE
>        This system call is only available on MIPS based  systems.
>        It should not be used in programs intended to be portable.
>
> Linux 2.0.32                27 June 95                          1

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
