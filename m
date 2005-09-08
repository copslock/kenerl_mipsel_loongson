Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2005 13:15:15 +0100 (BST)
Received: from deliver-1.mx.triera.net ([IPv6:::ffff:213.161.0.31]:36018 "HELO
	deliver-1.mx.triera.net") by linux-mips.org with SMTP
	id <S8225072AbVIHMOz>; Thu, 8 Sep 2005 13:14:55 +0100
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id A3545C006;
	Thu,  8 Sep 2005 14:21:53 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id E4C941BC084;
	Thu,  8 Sep 2005 14:21:56 +0200 (CEST)
Received: from orionlinux.starfleet.com (cmb58-52.dial-up.arnes.si [153.5.49.52])
	by smtp.triera.net (Postfix) with ESMTP id 18A571A18A9;
	Thu,  8 Sep 2005 14:21:57 +0200 (CEST)
Subject: Re: MIPS SF toolchain
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	David Daney <ddaney@avtrex.com>
Cc:	crossgcc@sources.redhat.com, linux-mips@linux-mips.org
In-Reply-To: <1126179199.25389.20.camel@orionlinux.starfleet.com>
References: <1126098584.12696.19.camel@localhost.localdomain>
	 <431F0850.8090804@avtrex.com>
	 <1126168866.25388.11.camel@orionlinux.starfleet.com>
	 <1126179199.25389.20.camel@orionlinux.starfleet.com>
Content-Type: text/plain
Organization: Ultra d.o.o.
Date:	Thu, 08 Sep 2005 14:22:02 +0200
Message-Id: <1126182122.25393.27.camel@orionlinux.starfleet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

I think I found the problem.

> -------------------------------------------------------------
> 0002fe80 <__longjmp>:
>    2fe80:       c4940038        lwc1    $f20,56(a0)
>    2fe84:       c495003c        lwc1    $f21,60(a0)
....

This code is written in  sysdeps/mips/setjmp_aux.c in 
inline assembly.

> and
> -------------------------------------------------------------
> 0002ff70 <__sigsetjmp_aux>:
>    2ff70:       3c1c0017        lui     gp,0x17
>    2ff74:       279cce40        addiu   gp,gp,-12736

This code is written in sysdeps/mips/__longjmp.c in 
inline assembly.

> How to solve this?

Because I am using sf, there is no need to store those
registers, or is it?
Can I just #ifdef this code if compiled for sf?

BR,
Matej
