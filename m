Received:  by oss.sgi.com id <S553748AbRB1Mx7>;
	Wed, 28 Feb 2001 04:53:59 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:63118 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553679AbRB1Mxs>;
	Wed, 28 Feb 2001 04:53:48 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA08338;
	Wed, 28 Feb 2001 13:47:27 +0100 (MET)
Date:   Wed, 28 Feb 2001 13:47:27 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Fabrice Bellard <bellard@email.enst.fr>,
        Ralf Baechle <ralf@uni-koblenz.de>
cc:     linux-mips@oss.sgi.com
Subject: Re: Serious bug in uaccess.h
In-Reply-To: <20010227232227.B384@email.enst.fr>
Message-ID: <Pine.GSO.3.96.1010228130945.6646A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 27 Feb 2001, Fabrice Bellard wrote:

> I mean the code in arch/mips/lib/memcpy.S. It is possible to modify
> __copy_user so that it has exactly the same calling convention of a C
> function. Then, no asm is necessary in uaccess.h. It costs us a
> supplementary jump.

 You mean the supplementary return value in a2?  Hmm, it is always set to
zero!  Also "addu $1, %2, %3" makes no sense.

 Ralf, the code is weird.  The header implies you are the author.  Could
you please elaborate what you meant in copy_*_user()? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
