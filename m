Received:  by oss.sgi.com id <S553793AbRAHQYS>;
	Mon, 8 Jan 2001 08:24:18 -0800
Received: from mx.mips.com ([206.31.31.226]:57545 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553781AbRAHQYD>;
	Mon, 8 Jan 2001 08:24:03 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA18989;
	Mon, 8 Jan 2001 08:23:59 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id IAA26782;
	Mon, 8 Jan 2001 08:23:56 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id RAA29505;
	Mon, 8 Jan 2001 17:23:21 +0100 (MET)
Message-ID: <3A59E978.873182CB@mips.com>
Date:   Mon, 08 Jan 2001 17:23:20 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
References: <00d801c0797d$5cc410c0$0deca8c0@Ulysses> <Pine.GSO.3.96.1010108151854.23234G-100000@delta.ds2.pg.gda.pl> <20010108140506.B886@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:

> On Mon, Jan 08, 2001 at 04:07:31PM +0100, Maciej W. Rozycki wrote:
>
> >  The only case caches need to be synchronized is modifying some code.  The
> > ptrace syscall does it automatically for text writes -- it's needed and
> > used by gdb to set breakpoints, for example.  For other code there is
> > cacheflush() which allows you to flush a cache range relevant to a given
> > virtual address (I see it's not implemented very well at the moment).
> >
> >  Obviously, you don't want to allow unprivileged users to flush caches as
> > a whole as it could lead to a DoS.
>
> You obviously want to allow partial cache flushes or trampolines don't work
> and flushing the entire cache can be constructed from that.
>

What we need is a mechanism to partial invalidate the I-cache and a mechanism
to write-back and/or invalidate the D-cache.

/Carsten

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
