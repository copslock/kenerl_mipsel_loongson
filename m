Received:  by oss.sgi.com id <S553692AbRBGSWQ>;
	Wed, 7 Feb 2001 10:22:16 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:43668 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553671AbRBGSVz>;
	Wed, 7 Feb 2001 10:21:55 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA07258;
	Wed, 7 Feb 2001 19:19:46 +0100 (MET)
Date:   Wed, 7 Feb 2001 19:19:45 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux-mips@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
In-Reply-To: <20010207175935.J26479@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010207190614.1418F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 7 Feb 2001, Florian Lohoff wrote:

> The problem with not compiling in the FPU Emulator at all means some
> of your FPU instructions (even on FPU hardware) will fail as on some
> specific operators the hardware decides to handle it in software. So
> usually you would need an FPU Emulator even on FPU enabled CPUs.

 I mean a full emulator.  I know that for simplicity certain actions
required by the IEEE spec are handled in software (Alpha does it as well). 
These bits have to be always included, of course.  I would like to save
wasted bits for hardware that always has an FPU, though.

> This isnt true if you decide to compile your complete userland with
> fpu emulation.

 I'm not sure if that approach has any advantages when using an operating
system such as Linux.  It might certainly be beneficial for firmware or
similar dedicated software.

> I dont know if this is a generic way to go - I saw complete "full-stops"
> on an R3912 using the ctc/cfc instructions - I'll try the autodection
> when i come home.

 We might work around pathological cases as usual -- such a behaviour
should count as a bug (I hope IDT did have a clue here -- is there any
original MIPS statement on how to handle FPU presence detection?).  You
might use the i386 setup code for a reference as a large mine of bug
workarounds. 

 Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
