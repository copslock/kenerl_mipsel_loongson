Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 06:08:16 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:36262 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224858AbUAMGIO>; Tue, 13 Jan 2004 06:08:14 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id CFAE54C3A9; Mon, 12 Jan 2004 13:51:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id BF42847B90; Mon, 12 Jan 2004 13:51:55 +0100 (CET)
Date: Mon, 12 Jan 2004 13:51:55 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: How to configure the cache size in r4000
In-Reply-To: <20040111124828.71884.qmail@web10103.mail.yahoo.com>
Message-ID: <Pine.LNX.4.55.0401121345490.21851@jurand.ds.pg.gda.pl>
References: <20040111124828.71884.qmail@web10103.mail.yahoo.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sun, 11 Jan 2004, [iso-8859-1] karthikeyan natarajan wrote:

>     The cache size is modified by setting the IC/DC
> bits in the 'config' register. Seems they are set only
> by the hardware during the processor reset. And also,
> those bits are mentioned as read only bits..

 You cannot modify the size of the primary caches -- the values are
hardwired to the amount of cache available in the processor (8kB+8kB for
the original R4000).  However, if you take appropriate precautions, you
can alter the line sizes of the caches by modifying appropriate bits of
cp0.config.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
