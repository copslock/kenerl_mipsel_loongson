Received:  by oss.sgi.com id <S553738AbRAEWmQ>;
	Fri, 5 Jan 2001 14:42:16 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:35011 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553712AbRAEWl4>;
	Fri, 5 Jan 2001 14:41:56 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id XAA14271;
	Fri, 5 Jan 2001 23:41:35 +0100 (MET)
Date:   Fri, 5 Jan 2001 23:41:34 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     Lisa.Hsu@taec.toshiba.com, linux-mips@oss.sgi.com
Subject: Re: questions on the cross-compiler
In-Reply-To: <006c01c07765$fdd26440$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010105232935.9384I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 5 Jan 2001, Kevin D. Kissell wrote:

> Lisa's underlying problem may be that there isn't a Config
> option for the R39xx CPUs, and she's ended up getting an
> R4000 (or whatever) configuration by default.

 It's easy to add right options for yet another CPU -- see
arch/mips/Makefile.  Anyway, for the mips port (as opposed to mips64)
you'll never get anything beyond "-mips2" passed to the toolchain. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
