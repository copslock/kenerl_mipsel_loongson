Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 13:31:30 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:63120 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224850AbUAONb3>; Thu, 15 Jan 2004 13:31:29 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id B8A574C175; Thu, 15 Jan 2004 14:31:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id A76AC474E9; Thu, 15 Jan 2004 14:31:26 +0100 (CET)
Date: Thu, 15 Jan 2004 14:31:26 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: karthikeyan natarajan <karthik_96cse@yahoo.com>,
	linux-mips@linux-mips.org
Subject: Re: How to configure the cache size in r4000
In-Reply-To: <20040115094849.GC11029@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0401151414080.17864@jurand.ds.pg.gda.pl>
References: <20040111124828.71884.qmail@web10103.mail.yahoo.com>
 <Pine.LNX.4.55.0401121345490.21851@jurand.ds.pg.gda.pl>
 <20040113163543.GA31459@linux-mips.org> <Pine.LNX.4.55.0401131741390.3158@jurand.ds.pg.gda.pl>
 <20040115094849.GC11029@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 15 Jan 2004, Ralf Baechle wrote:

> >  BTW, the DECstation uses 16-byte lines for the D-cache and the I-Cache
> > and 32-byte lines for the S-cache.  With the S-cache size at 1MB and up to
> > 480MB of RAM does it qualify as a tiny system? ;-)
> 
> Does it run on two AAA batteries ;-)

 Well, not even on three ones... ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
