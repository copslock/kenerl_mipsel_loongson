Received:  by oss.sgi.com id <S553813AbRBAMlO>;
	Thu, 1 Feb 2001 04:41:14 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:2745 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553801AbRBAMk5>;
	Thu, 1 Feb 2001 04:40:57 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA21934;
	Thu, 1 Feb 2001 13:38:24 +0100 (MET)
Date:   Thu, 1 Feb 2001 13:38:24 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc:     Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: glibc 2.2 on MIPS
In-Reply-To: <Pine.GSO.4.10.10102011022400.1855-100000@escobaria.sonytel.be>
Message-ID: <Pine.GSO.3.96.1010201122250.17657C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 1 Feb 2001, Geert Uytterhoeven wrote:

> I tried to compile mipsel-binutils using the sources/patches in
> mipsel-linux-binutils-2.10.1-3.src.rpm and got the following result:
[...]
> | section.c: In function `bfd_make_section_anyway':
> | section.c:712: structure has no member named `kept_section'
> | make[3]: *** [section.lo] Error 1
> | make[3]: Leaving directory `/usr/people/geert.nba/mipsel-linux-binutils-2.10.1-3/binutils-2.10.1/bfd'

 Did you run `make -C bfd headers' after `./configure'?  It llok like you
didn't.

> Should we try mipsel-linux-binutils-2.10.91-1.src.rpm instead?

 It should not matter apart from this one is newer. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
