Received:  by oss.sgi.com id <S42272AbQJFJ4F>;
	Fri, 6 Oct 2000 02:56:05 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:57986 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42255AbQJFJzo>;
	Fri, 6 Oct 2000 02:55:44 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA27447;
	Fri, 6 Oct 2000 11:54:18 +0200 (MET DST)
Date:   Fri, 6 Oct 2000 11:54:18 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Jun Sun <jsun@mvista.com>, "Kevin D. Kissell" <kevink@mips.com>,
        Dominic Sweetman <dom@algor.co.uk>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: load_unaligned() and "uld" instruction
In-Reply-To: <20001006024337.A3429@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1001006113602.26752A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 6 Oct 2000, Ralf Baechle wrote:

> That's all very nice and guess what - I tried it when I originally wrote
> ualigned.h for Linux.  Try building the mentioed Alpha code with and older
> compiler like egcs 1.0.3a and take a look at it [1].  23 instructions for
> loading a double world - that's just mindboggling.

 Have you actually looked at the code?  They fall back to an inline asm
for pre-egcs 1.1.2 for exactly that reason for now.  It's surprising,
OTOH, as I am sure native egcs 1.0.3 did build a proper lwl/lwr sequence
for me on Ultrix a few years ago...  Maybe it's just a MIPS backend
configuration problem for other targets? 

 I vote for dual code for now and then we may remove the egcs 1.0.3
compatibility cruft one day (for 2.6, for example). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
