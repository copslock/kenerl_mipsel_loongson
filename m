Received:  by oss.sgi.com id <S554377AbRB0R6m>;
	Tue, 27 Feb 2001 09:58:42 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:21379 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S554373AbRB0R6f>;
	Tue, 27 Feb 2001 09:58:35 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA10066;
	Tue, 27 Feb 2001 18:54:22 +0100 (MET)
Date:   Tue, 27 Feb 2001 18:54:22 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Fabrice Bellard <bellard@email.enst.fr>
cc:     linux-mips@oss.sgi.com
Subject: Re: Serious bug in uaccess.h
In-Reply-To: <Pine.GSO.4.02.10102271629230.22188-100000@donjuan.enst.fr>
Message-ID: <Pine.GSO.3.96.1010227185131.9765A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 27 Feb 2001, Fabrice Bellard wrote:

> I read the gcc docs and you are right, so it seems to be a gcc bug. I am
> using gcc 2.95.2. Which version of gcc is OK to compile a linux mips
> kernel ?

 Patched 2.95.2 should be fine; RPM packages of what I use are available
at 'ftp://ftp.ds2.pg.gda.pl/pub/macro/'. 

> BTW, the kernel would be smaller by moving all the asm around __copy_user
> in __copy_user itself. I am currently doing that. The cost is an added
> 'jr' to jump to __memcpy. Do you think it is worthwhile to do that ?

 What asm do you mean?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
