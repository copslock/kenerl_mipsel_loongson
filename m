Received:  by oss.sgi.com id <S42321AbQHAIoi>;
	Tue, 1 Aug 2000 01:44:38 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:912 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42236AbQHAIoK>;
	Tue, 1 Aug 2000 01:44:10 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id KAA08460;
	Tue, 1 Aug 2000 10:43:02 +0200 (MET DST)
Date:   Tue, 1 Aug 2000 10:42:59 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Dan Aizenstros <dan@vcubed.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Binutils-2.10
In-Reply-To: <3985FC8A.70E449C6@vcubed.com>
Message-ID: <Pine.GSO.3.96.1000801103259.7120A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 31 Jul 2000, Dan Aizenstros wrote:

> Thanks for the help.  I was able to build binutils-2.10 after
> generating the headers as you described.

 Good.

> The reason I expect the patch to change generated files is
> because the normal make does not generate them and the files
> are included in the binutils-2.10.tar.bz2 file.  They are also
> in CVS.  Why are generated files in CVS or the binary distribution
> if you have to generate them?

 To save people the trouble many generated files are included by default. 
There is no need to regenerate them if respective sources remain unchanged
and they may need special tools.  They include Makefile.in, config.h.in,
aclocal.m4, Makefile, configure files, as well as .info files and sources
built by lex and yacc.

> I thought all I would have to do is a ./configure; make; make install

 All built sources are usually regenerated if needed during build (that's
true for most automake-generated Makefiles; for others, the maintainer has
to take care to place appropriate rules inti Makefiles himself).  You
might need to enable the maintainer mode for certain programs, though, as
someone already pointed out.

> after I applied the patches.  Maybe you could add the need to generate
> files on your binutils-2.10 web page.

 I am planning to release RPM packages -- all necessary bits are in spec
files.  I might add a separate note, though.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
