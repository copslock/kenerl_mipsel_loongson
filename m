Received:  by oss.sgi.com id <S553867AbRAHRwi>;
	Mon, 8 Jan 2001 09:52:38 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:65266 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553861AbRAHRw1>; Mon, 8 Jan 2001 09:52:27 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870732AbRAHRmc>; Mon, 8 Jan 2001 15:42:32 -0200
Date:	Mon, 8 Jan 2001 15:42:32 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	Carsten Langgaard <carstenl@mips.com>,
        "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
Message-ID: <20010108154232.A4436@bacchus.dhis.org>
References: <3A59E978.873182CB@mips.com> <Pine.GSO.3.96.1010108173437.23234L-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010108173437.23234L-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jan 08, 2001 at 05:40:23PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jan 08, 2001 at 05:40:23PM +0100, Maciej W. Rozycki wrote:

> > What we need is a mechanism to partial invalidate the I-cache and a mechanism
> > to write-back and/or invalidate the D-cache.
> 
>  What's wrong with the already mentioned cachectl?
> 
> $ mipsel-linux-objdump -T /usr/mipsel-linux/lib/libc-2.2.so | grep cachectl
> 00000000600ca0a0  w   DF *ABS*  0000000000000000  GLIBC_2.0   cachectl
> $ ls /usr/mipsel-linux/include/sys/cachectl.h
> /usr/mipsel-linux/include/sys/cachectl.h

cachectl(2) is a syscall that is manipulates the cachability of a memory
area.  And not yet implemented ...

  Ralf
