Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11LrOg18966
	for linux-mips-outgoing; Fri, 1 Feb 2002 13:53:24 -0800
Received: from outboundx.mv.meer.net (outboundx.mv.meer.net [209.157.152.12])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11LrLd18960
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 13:53:21 -0800
Received: from meer.meer.net (mail.meer.net [209.157.152.14])
	by outboundx.mv.meer.net (8.11.6/8.11.6) with ESMTP id g11KrCh99062;
	Fri, 1 Feb 2002 12:53:12 -0800 (PST)
	(envelope-from weasel@meer.net)
Received: from localhost.meer.net (bob.sonicblue.com [209.10.223.219])
	by meer.meer.net (8.9.3/8.9.3/meer) with ESMTP id MAA4669480;
	Fri, 1 Feb 2002 12:52:59 -0800 (PST)
To: binutils@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: me vs gas mips64 relocation
References: <m2vgdh5n9s.fsf@meer.net>
Reply-To: weasel@cs.stanford.edu
From: d p chang <weasel@meer.net>
Date: 01 Feb 2002 12:52:59 -0800
In-Reply-To: <m2vgdh5n9s.fsf@meer.net>
Message-ID: <m2pu3o6i1g.fsf@meer.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

d p chang <weasel@meer.net> writes:

> i compile this w/ (i only just added all the verbosity flags).
> 
>     mips64-linux-gcc  -I /Volumes/Homey/dpc/Devel/linux-2.4.17/include/asm/gcc -D__KERNEL__ -I/Volumes/Homey/dpc/Devel/linux-2.4.17/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe -mips4 -mmad -Wa,-march=r5231 -mlong64 -mgp64 -mfp64 -ffreestanding -mabi=n32 reloc.S -c -o reloc.o -Wa,-acdhls -v -Wa,-v -Wa,-O0 

Looking at this some more I realize that my problem is probably that
I'm lying to the compiler/assembler by claiming n32 and long64. We
would like to have 64 bit registers available to us in user space, but
enabling -mabi=64 gives an assertion in ld when it is trying to output
relocations for a .pdr section.

ideas? (other than for me to take the crack pipe out of my ass)

\p
---
I feel discomfort, therefore I am alive. --- Graham Greene
