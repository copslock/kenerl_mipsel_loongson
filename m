Received:  by oss.sgi.com id <S553865AbRAHRpt>;
	Mon, 8 Jan 2001 09:45:49 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:48358 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553857AbRAHRpd>;
	Mon, 8 Jan 2001 09:45:33 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA06652;
	Mon, 8 Jan 2001 17:40:24 +0100 (MET)
Date:   Mon, 8 Jan 2001 17:40:23 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Carsten Langgaard <carstenl@mips.com>
cc:     Ralf Baechle <ralf@oss.sgi.com>,
        "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
In-Reply-To: <3A59E978.873182CB@mips.com>
Message-ID: <Pine.GSO.3.96.1010108173437.23234L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 8 Jan 2001, Carsten Langgaard wrote:

> What we need is a mechanism to partial invalidate the I-cache and a mechanism
> to write-back and/or invalidate the D-cache.

 What's wrong with the already mentioned cachectl?

$ mipsel-linux-objdump -T /usr/mipsel-linux/lib/libc-2.2.so | grep cachectl
00000000600ca0a0  w   DF *ABS*  0000000000000000  GLIBC_2.0   cachectl
$ ls /usr/mipsel-linux/include/sys/cachectl.h
/usr/mipsel-linux/include/sys/cachectl.h

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
