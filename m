Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Mar 2004 12:45:08 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:63883 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225400AbUC2LpH>; Mon, 29 Mar 2004 12:45:07 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 6F05C4794B; Mon, 29 Mar 2004 13:44:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 5EB52477ED; Mon, 29 Mar 2004 13:44:59 +0200 (CEST)
Date: Mon, 29 Mar 2004 13:44:59 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: larryhl@comcast.net
Cc: linux-mips@linux-mips.org
Subject: Re: gcc 3.4 and kernel 2.6 for 64bit on sb1250
In-Reply-To: <032820041541.18245.4066F2450005255E000047452200750330FF9397868D8D9E@comcast.net>
Message-ID: <Pine.LNX.4.55.0403291313291.19096@jurand.ds.pg.gda.pl>
References: <032820041541.18245.4066F2450005255E000047452200750330FF9397868D8D9E@comcast.net>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sun, 28 Mar 2004 larryhl@comcast.net wrote:

> I am wondering where gcc 3.4 cross-compiler for mips with little-endian
> hosted on red-hat/intel could be downloaded. I tried to build them by
> myself, but the compilation always failed because of pthread.h missing.

 There are a few RPM packages at my site:  
"ftp://ftp.ds2.pg.gda.pl/pub/macro/" (you'd need to use a mirror at:  
"ftp://ftp.rfc822.org/pub/mirror/ftp.ds2.pg.gda.pl/pub/macro/" as we have
temporary connectivity problems here).  I'm not sure if they'd work with
an arbitrary version of RH, but they are not much demanding about
libraries -- just shared glibc 2.2.4 or newer.  The Java frontend
additionally requires zlib 1.1.x (1.1.4 is recommended due to a security
fix).  An Ada (GNAT) frontend is included as well, which I suppose to be
nice as it's not necessarily the easiest item to be built.

 No warranty these work at all, although they've performed reasonably for
me so far.  Expect updates once the original FTP site is resurrected, but 
I don't plan to make a set of packages for the released version of 3.4 as 
I'm already working on 3.5.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
