Received:  by oss.sgi.com id <S553871AbRAHSAi>;
	Mon, 8 Jan 2001 10:00:38 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:61926 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553869AbRAHSAX>;
	Mon, 8 Jan 2001 10:00:23 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA09825;
	Mon, 8 Jan 2001 18:58:57 +0100 (MET)
Date:   Mon, 8 Jan 2001 18:58:57 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Carsten Langgaard <carstenl@mips.com>,
        "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
In-Reply-To: <20010108154232.A4436@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010108185713.23234R-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 8 Jan 2001, Ralf Baechle wrote:

> > $ mipsel-linux-objdump -T /usr/mipsel-linux/lib/libc-2.2.so | grep cachectl
> > 00000000600ca0a0  w   DF *ABS*  0000000000000000  GLIBC_2.0   cachectl
> > $ ls /usr/mipsel-linux/include/sys/cachectl.h
> > /usr/mipsel-linux/include/sys/cachectl.h
> 
> cachectl(2) is a syscall that is manipulates the cachability of a memory
> area.  And not yet implemented ...

 s/cachectl$/cacheflush/, of course (but the header is still valid).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
