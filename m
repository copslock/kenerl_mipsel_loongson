Received:  by oss.sgi.com id <S553760AbRBHKrX>;
	Thu, 8 Feb 2001 02:47:23 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:4253 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553756AbRBHKrH>;
	Thu, 8 Feb 2001 02:47:07 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA00370;
	Thu, 8 Feb 2001 11:42:46 +0100 (MET)
Date:   Thu, 8 Feb 2001 11:42:45 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Alan Cox <alan@lxorguk.ukuu.org.uk>
cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        ralf@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
In-Reply-To: <E14QZie-00011I-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1010208112520.29177C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 7 Feb 2001, Alan Cox wrote:

> Its an interesting question whether it belongs in the kernel or libc. 
> Discuss ;)

 Hmm, emulating a missing part of CPU seems more natural in the kernel
mode.  It's completely transparent -- no difference to userland software
whether there is a real part or an emulator.

 The libc approach has the advantage of being unprivileged -- a fault in
an emulator cannot itself bring a system down.  It's non-transparent,
though -- it may give interesting effects when debugging. 

> Also we missed a trick on the x86 and I want to fix that one day, which is
> to have an __fpu ELF segment so if you boot an FPU emu kernel on an fpu
> box you regain 47K

 A good idea, even though hardly anyone needs the emulator for i386 these
days. ;-) 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
