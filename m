Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 10:41:27 +0100 (BST)
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([IPv6:::ffff:82.235.130.100]:62961
	"EHLO lexbox.fr") by linux-mips.org with ESMTP id <S8226859AbVGSJlI> convert rfc822-to-8bit;
	Tue, 19 Jul 2005 10:41:08 +0100
Subject: RE: undefined symbol '__divdi3' & '__moddi3' on linux kernel 2.6.10  (toolchain Linuxi386/Mips32)
Date:	Tue, 19 Jul 2005 11:40:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-ID: <17AB476A04B7C842887E0EB1F268111E015520@xpserver.intra.lexbox.org>
X-MS-Has-Attach: 
Content-class: urn:content-classes:message
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Thread-Topic: undefined symbol '__divdi3' & '__moddi3' on linux kernel 2.6.10  (toolchain Linuxi386/Mips32)
thread-index: AcWLpJW1Crzv+XqMRBKcfve/GxMtrQAoPf+g
From:	"David Sanchez" <david.sanchez@lexbox.fr>
To:	"David Sanchez" <david.sanchez@lexbox.fr>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <david.sanchez@lexbox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.sanchez@lexbox.fr
Precedence: bulk
X-list: linux-mips


As you can see I'm a real newby so I take a long time to find the macro do_div() in the linux kernel. This macro does all I want and using it will avoid gcc to emits the symbols '__divdi3' and '__moddi3'...

Thanks

-----Message d'origine-----
De : linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] De la part de David Sanchez
Envoyé : lundi 18 juillet 2005 16:30
À : linux-mips@linux-mips.org
Objet : undefined symbol '__divdi3' & '__moddi3' on linux kernel 2.6.10 (toolchain Linuxi386/Mips32)

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
