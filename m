Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Dec 2004 08:50:56 +0000 (GMT)
Received: from pc12577.Mathematik.Uni-Marburg.DE ([IPv6:::ffff:137.248.123.2]:52906
	"EHLO mailhost.Mathematik.Uni-Marburg.de") by linux-mips.org
	with ESMTP id <S8225074AbULKIuv>; Sat, 11 Dec 2004 08:50:51 +0000
Received: from www.mathematik.uni-marburg.de (durban [137.248.123.2])
	by mailhost.Mathematik.Uni-Marburg.de (8.13.1/8.13.1) with ESMTP id iBB8ojkR031811
	for <linux-mips@linux-mips.org>; Sat, 11 Dec 2004 09:50:45 +0100
Received: from 62.226.168.187
        (SquirrelMail authenticated user engel);
        by www.mathematik.uni-marburg.de with HTTP;
        Sat, 11 Dec 2004 09:50:45 +0100 (CET)
Message-ID: <57004.62.226.168.187.1102755045.squirrel@62.226.168.187>
Date: Sat, 11 Dec 2004 09:50:45 +0100 (CET)
Subject: Recommended gcc/binutils Versions for mips64 target?
From: engel@mathematik.uni-marburg.de
To: linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <engel@mathematik.uni-marburg.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: engel@mathematik.uni-marburg.de
Precedence: bulk
X-list: linux-mips


Hi,

I'm currently trying to cross-compile a kernel (2.6.10-pre3 from cvs with
the IP30 patch from Stanislaw) for my Octane (IP30) on Linux/amd64.

What versions of gcc and binutils are currently recommended
for crosscompiling? The target should simply be mips64-linux if I read the
Makefile correctly? This has caused problems as my binutils version
2.15.92.0.2 configured with mips64-linux didn't produce a linker that was
capable of using elf64btsmip, mips64-linux-gnu did work.

I'm also a bit confused as to why IP30 support is located in the arch/mips/
hierarchy and not arch/mips64/. IIRC, the Octane definitely needs a 64 bit
kernel to boot?

regards,
    Michael
