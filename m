Received:  by oss.sgi.com id <S553686AbRBJJFN>;
	Sat, 10 Feb 2001 01:05:13 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:16562 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553650AbRBJJFF>;
	Sat, 10 Feb 2001 01:05:05 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id KAA02509;
	Sat, 10 Feb 2001 10:05:28 +0100 (MET)
Date:   Sat, 10 Feb 2001 10:05:28 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: config option vs. run-time detection (the debate continues ...)
In-Reply-To: <01b001c092e5$58f6a8a0$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010210100216.2153B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 9 Feb 2001, Kevin D. Kissell wrote:

> The best method I know for post-R3000 CPUs is to
> write and read back the CU1 bit of the Status register.
> CPUs without an integrated FPU will not have a flip-flop
> for the bit, and will read back a 0 even after writing a 1.
> There was never any architectural requirement that
> this be so, however, and this cannot be absolutely
> guaranteed to work.  If anyone has a counter-example,
> however, I'd be interested in hearing about it.

 OK, then we may try to toggle CU1 and only if that succeeds check the FPU
implementation id.  Thanks for the point. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
