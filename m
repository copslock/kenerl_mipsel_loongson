Received:  by oss.sgi.com id <S553848AbRAHQpi>;
	Mon, 8 Jan 2001 08:45:38 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:56805 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553685AbRAHQpc>;
	Mon, 8 Jan 2001 08:45:32 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA06739;
	Mon, 8 Jan 2001 17:43:26 +0100 (MET)
Date:   Mon, 8 Jan 2001 17:43:24 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        Carsten Langgaard <carstenl@mips.com>,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
In-Reply-To: <20010108142729.D886@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010108174155.23234M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 8 Jan 2001, Ralf Baechle wrote:

> >  What's wrong with cacheflush(addr, count, which) that actually checks if
> > <addr; addr+count> lies within the caller's address space before
> > performing the flush and returns -EPERM otherwise?  It would make the
> > caller crawl like a turtle if it wished to but it would leave other
> > processes alone. 
> 
> cacheflush(2) actually is supposed to handle things that way.

 Didn't I write it clearly-enough? ;-) 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
