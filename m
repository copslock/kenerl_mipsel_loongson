Received:  by oss.sgi.com id <S554055AbRBBPH1>;
	Fri, 2 Feb 2001 07:07:27 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:33733 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S554045AbRBBPHK>;
	Fri, 2 Feb 2001 07:07:10 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA09450;
	Fri, 2 Feb 2001 16:04:04 +0100 (MET)
Date:   Fri, 2 Feb 2001 16:04:04 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Carsten Langgaard <carstenl@mips.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Cross build applications
In-Reply-To: <3A7AC901.4BD0F4E0@mips.com>
Message-ID: <Pine.GSO.3.96.1010202160104.28509I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 2 Feb 2001, Carsten Langgaard wrote:

> I'm trying to cross build a small test program on a linux PC, but it
> fails.
> 
> mips-linux-gcc -o test test.c
> /usr/mips-linux/bin/ld: cannot open crt1.o: No such file or directory

 The file is supposed to come with glibc.  Do you have glibc for
mips-linux installed?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
