Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2005 09:34:19 +0100 (BST)
Received: from deliver-1.mx.triera.net ([IPv6:::ffff:213.161.0.31]:56979 "HELO
	deliver-1.mx.triera.net") by linux-mips.org with SMTP
	id <S8224834AbVIHIeC>; Thu, 8 Sep 2005 09:34:02 +0100
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id A2777BFE2;
	Thu,  8 Sep 2005 10:41:00 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 31E2D1BC085;
	Thu,  8 Sep 2005 10:41:03 +0200 (CEST)
Received: from orionlinux.starfleet.com (cmb58-52.dial-up.arnes.si [153.5.49.52])
	by smtp.triera.net (Postfix) with ESMTP id 6E61B1A18AA;
	Thu,  8 Sep 2005 10:41:02 +0200 (CEST)
Subject: Re: MIPS SF toolchain
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	David Daney <ddaney@avtrex.com>
Cc:	crossgcc@sources.redhat.com, linux-mips@linux-mips.org
In-Reply-To: <431F0850.8090804@avtrex.com>
References: <1126098584.12696.19.camel@localhost.localdomain>
	 <431F0850.8090804@avtrex.com>
Content-Type: text/plain
Organization: Ultra d.o.o.
Date:	Thu, 08 Sep 2005 10:41:06 +0200
Message-Id: <1126168866.25388.11.camel@orionlinux.starfleet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> On gcc 3.3.x --with-float=soft does nothing.  If you are using a MIPS32 
> ISA processor you can configure it with --target=mipsisa32[el]-linux to 
> get soft float and MIPS32 ISA by default.

O.K.
Thank you for the explanation.

> But even better would be to use gcc 3.4.x or 4.0.x where 
> --with-float=soft works.  I would also recommend binutils 2.16.1 or 
> above as there are some severe bugs in the mips linker in earlier versions.

O.K.
Yesterday I tried with the gcc 3.4.3, glibc 2.3.5 and binutils 2.16.1.
libgcc.a looks O.K, because I did not find any FP instruction, however
if I do objdump on libc.so.6, I get:

0002ff70 <__sigsetjmp_aux>:
   2ff70:       3c1c0017        lui     gp,0x17
   2ff74:       279cce30        addiu   gp,gp,-12752
   2ff78:       0399e021        addu    gp,gp,t9
   2ff7c:       00801021        move    v0,a0
   2ff80:       e4940038        swc1    $f20,56(a0)
   2ff84:       e495003c        swc1    $f21,60(a0)
   2ff88:       e4960040        swc1    $f22,64(a0)
   2ff8c:       e4970044        swc1    $f23,68(a0)
   2ff90:       e4980048        swc1    $f24,72(a0)
   2ff94:       e499004c        swc1    $f25,76(a0)
   2ff98:       e49a0050        swc1    $f26,80(a0)
   2ff9c:       e49b0054        swc1    $f27,84(a0)
   2ffa0:       e49c0058        swc1    $f28,88(a0)
   2ffa4:       e49d005c        swc1    $f29,92(a0)
   2ffa8:       e49e0060        swc1    $f30,96(a0)
   2ffac:       e49f0064        swc1    $f31,100(a0)
   2ffb0:       ac9f0000        sw      ra,0(a0)
   2ffb4:       ac860004        sw      a2,4(a0)
   2ffb8:       ac870028        sw      a3,40(a0)

Again, FP instructions! I don't know what is wrong :-(

Now I am trying with the:
GCC: 4.1.0
GLIBC: 2.3.5
BINUTILS: 2.16.1
Linux Headers: 2.6.11

Will let you know, when the toolchain is built.

BR,
Matej

P.S.: I am cc-ing crosstool mailing list too.
