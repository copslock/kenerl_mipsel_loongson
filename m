Received:  by oss.sgi.com id <S553661AbQKNRbS>;
	Tue, 14 Nov 2000 09:31:18 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:57543 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553655AbQKNRaz>;
	Tue, 14 Nov 2000 09:30:55 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA24854;
	Tue, 14 Nov 2000 18:24:14 +0100 (MET)
Date:   Tue, 14 Nov 2000 18:24:13 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Carsten Langgaard <carstenl@mips.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: The do_fast_gettimeoffset function
In-Reply-To: <3A0FEAB6.7117CC3C@mips.com>
Message-ID: <Pine.GSO.3.96.1001114182002.17140I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 13 Nov 2000, Carsten Langgaard wrote:

> The do_fast_gettimeoffset function below (taken from
> arch/mips/kernel/time.c) can only be used on 64-bit processors.
> I would like to be able to use this on a 32-bit processor. As I'm not
> completely sure what this function does, can someone who does please
> help me out ?

 The function performs a 64-bit division.  You may look at
do_ioasic_gettimeoffset which is almost identical (merging of these two
functions into a single one is actually on my TODO list) but it works for
32-bit processors. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
