Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Mar 2004 13:05:51 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:22162 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225400AbUC2MFu>; Mon, 29 Mar 2004 13:05:50 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id BD323477ED; Mon, 29 Mar 2004 14:05:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id B18D847775; Mon, 29 Mar 2004 14:05:44 +0200 (CEST)
Date: Mon, 29 Mar 2004 14:05:44 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Shantanu Gogate <sagogate@yahoo.com>
Cc: Chris Dearman <chris@mips.com>, linux-mips@linux-mips.org
Subject: Re: mips gcc compile error : unrecognized opcode errors
In-Reply-To: <20040329062101.84127.qmail@web60701.mail.yahoo.com>
Message-ID: <Pine.LNX.4.55.0403291351300.19096@jurand.ds.pg.gda.pl>
References: <20040329062101.84127.qmail@web60701.mail.yahoo.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sun, 28 Mar 2004, Shantanu Gogate wrote:

> 1. I started getting some pretty weird unresolved symbol messages, which
> i figured was happening because it was not taking in libc.a and
> libgcc.a. This was happening although I had placed the libc.a and
> libgcc.a dir in the libsearch dir using the '-L' flag to gcc.

 You should have your libgcc.a in the directory gcc installation put it.  
And you should have libc.a and other libraries in a library directory
recognized by gcc -- `gcc -print-search-dirs' should help.  Other setups 
are possible, but this one should be the least troublesome.

> 2. So I gave the libc.a and libgcc.a path directly on the command prompt
> and it did build the binary file but gave warning that 'cannot find
> entry symbol __start; defaulting to 0000000000400090' I guess this is
> because it cannot find crt1.o or the other crt*.o files ?

 The symbol is defined by crt1.o for normal programs.  For MIPS this
startup file comes with glibc, so it should be in the same directory as 
libc.a.

> So, maybe even though I have got the binary file, it won run properly
> since it 'defaulted' the start address to something.

 It won't run as it misses startup code.

> 3. My situation is like this : I have got the 'usr' directory from
> 'glibc-devel-2.2.5-42.1.mips.rpm' placed in a directory called
> '/work/GLIBC/' and I have 'sdelinux 5.03eb installed' on my redhat 7.3
> host machine. Can you guys tell me how I need to setup the Makefiles for
> that app so as to get a clean build ? If this is out of your domain can
> you point me to some resources (other than gcc man pages ;) ) which
> talks about setting up cross-compile environments ?

 If the Makefiles are sane as well as your development environment, then
all you need to do is to define CC to your cross-compiler.  This is
especially true if the program uses autoconf -- but you need to set the
host properly on the `./configure' invocation.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
