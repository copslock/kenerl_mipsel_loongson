Received:  by oss.sgi.com id <S554056AbRAQOcM>;
	Wed, 17 Jan 2001 06:32:12 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:20964 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S554053AbRAQOcI>;
	Wed, 17 Jan 2001 06:32:08 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA01388;
	Wed, 17 Jan 2001 15:26:04 +0100 (MET)
Date:   Wed, 17 Jan 2001 15:26:03 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Florian Lohoff <flo@rfc822.org>
cc:     Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com
Subject: Re: 2.4.0 Kernel - Summary
In-Reply-To: <20010117145034.B2517@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010117151644.29693C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 17 Jan 2001, Florian Lohoff wrote:

> Its probably a problem with console and tty output getting mixed.
> Definitly a bigger issue as one should merge driver/sbus/zs.c and
> driver/sgi/char/sgiserial.c to one driver. (And probably even
> the Decstation one)

 It's actually deep on my to do list.  We also miss zs DMA support on
DECstation (no idea if it's possible on other platforms) for decent
synchronous support.  DEC claims /240 can do up to 208kbps synchronous --
I wonder if we can achieve this one day.  HDLC support might be
problematic, though, as there is a Z8530 erratum that supposedly turns
this unreliable.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
