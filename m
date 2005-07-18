Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2005 15:26:42 +0100 (BST)
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([IPv6:::ffff:82.235.130.100]:40422
	"EHLO lexbox.fr") by linux-mips.org with ESMTP id <S8226827AbVGRO0Z> convert rfc822-to-8bit;
	Mon, 18 Jul 2005 15:26:25 +0100
Subject: undefined symbol '__divdi3' & '__moddi3' on linux kernel 2.6.10  (toolchain Linuxi386/Mips32)
Date:	Mon, 18 Jul 2005 16:25:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <17AB476A04B7C842887E0EB1F268111E01551B@xpserver.intra.lexbox.org>
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-TNEF-Correlator: 
Thread-Topic: undefined symbol '__divdi3' & '__moddi3' on linux kernel 2.6.10  (toolchain Linuxi386/Mips32)
thread-index: AcWLpJW1Crzv+XqMRBKcfve/GxMtrQ==
From:	"David Sanchez" <david.sanchez@lexbox.fr>
To:	<linux-mips@linux-mips.org>
Return-Path: <david.sanchez@lexbox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.sanchez@lexbox.fr
Precedence: bulk
X-list: linux-mips

Hi,

I'm a newby on Linux/Mips more my English is very poor so sorry...
But I have a big problem (for me):

I want to cross-compile my linux kernel 2.6.10 on my PC i386 for mips32
(alchemy AU1550) CPU.
I developed a module that contains some operations on types loff_t (i.e
long long) such as div and mod. The code is in a foo.c file.

I successfully built a cross toolchain using:
The bin utils (Bintuils-2.15), the glibc headers (glibc-2.3.5) and the
gcc core (gcc-3.4.4).

The compilation of the kernel works but unfortunately the link generates
two error messages on the file foo.c:
Undefined reference to '__divdi3'
Undefined reference to '__moddi3'

What I'm doing wrong ? 
Why the gcc doesn't embed the symbol implementation ? 
And so where can I found an implementation ? 

Thanks for all your help
