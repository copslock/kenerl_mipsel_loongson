Received:  by oss.sgi.com id <S553934AbRAPTrI>;
	Tue, 16 Jan 2001 11:47:08 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:65241 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553929AbRAPTq6>;
	Tue, 16 Jan 2001 11:46:58 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA25942;
	Tue, 16 Jan 2001 20:47:20 +0100 (MET)
Date:   Tue, 16 Jan 2001 20:47:20 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
In-Reply-To: <20010116172351.B1379@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010116204113.5546X-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 16 Jan 2001, Ralf Baechle wrote:

> Indy kernels are linked to 0x88002000.

 Oh well, why can't it be done consistently in our linker script.  The
script does ". = 0x80000000;" -- it's at least confusing, even if the
"-Ttext" option has a priority (does it?).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
