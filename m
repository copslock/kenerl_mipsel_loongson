Received:  by oss.sgi.com id <S553691AbRBGSyZ>;
	Wed, 7 Feb 2001 10:54:25 -0800
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28421 "EHLO
        the-village.bc.nu") by oss.sgi.com with ESMTP id <S553659AbRBGSyC>;
	Wed, 7 Feb 2001 10:54:02 -0800
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 14QZie-00011I-00; Wed, 7 Feb 2001 18:53:32 +0000
Subject: Re: NON FPU cpus - way to go
To:     macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date:   Wed, 7 Feb 2001 18:53:29 +0000 (GMT)
Cc:     flo@rfc822.org (Florian Lohoff), linux-mips@oss.sgi.com,
        ralf@oss.sgi.com
In-Reply-To: <Pine.GSO.3.96.1010207171821.1418B-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Feb 07, 2001 05:36:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QZie-00011I-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>  The i386 way seems reasonable, IMHO.  Have a configure option to enable
> an FPU emulator.  Panic upon boot if no FP hardware is available and no
> emulator is compiled in. 

Its an interesting question whether it belongs in the kernel or libc. 
Discuss ;)

Also we missed a trick on the x86 and I want to fix that one day, which is
to have an __fpu ELF segment so if you boot an FPU emu kernel on an fpu
box you regain 47K
