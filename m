Received:  by oss.sgi.com id <S553691AbRBGQwP>;
	Wed, 7 Feb 2001 08:52:15 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:18323 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553659AbRBGQvy>;
	Wed, 7 Feb 2001 08:51:54 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA03801;
	Wed, 7 Feb 2001 17:36:33 +0100 (MET)
Date:   Wed, 7 Feb 2001 17:36:33 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux-mips@oss.sgi.com, ralf@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
In-Reply-To: <20010207144857.B24485@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010207171821.1418B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 7 Feb 2001, Florian Lohoff wrote:

> i would like to know the way to go for NON-FPU cpus - Currently its
> partly an Compile Time thing and partly run time config. 

 The i386 way seems reasonable, IMHO.  Have a configure option to enable
an FPU emulator.  Panic upon boot if no FP hardware is available and no
emulator is compiled in. 

> A question here - Which way to go - Compile or Run time config for
> CPUs and is 
> 
> if(!(mips_cpu.options & MIPS_CPU_FPU))
> 
> this also valid for R3k CPU cores ? From my reading it is not as it doesnt
> get initialized for R3000 ? As a lot architectures have the R3010
> so this should get detected. The R3081 definitly has an FPU from
> what i found on the web so this should be correct.

 Hmm, I see MIPS_CPU_FPU is hand-coded all over arch/mips/kernel/setup.c.
It's too fragile, I believe.  Why not just use the way IDT recommends in
their "IDT MIPS Microprocessor Family Software Reference Manual" in
Chapter 8 "Floating Point Co-Processor?"  Quoting:


FLOATING-POINT IMPLEMENTATION/REVISION REGISTER

  This read-only registers fields are shown in Figure 8.2, "FPA
implementation/revision register".

 31                           16 15            8 7             0
+-------------------------------+---------------+---------------+
|0                              |Imp            |Rev            |
+-------------------------------+---------------+---------------+

  This register is co-processor 1 control register 0 (mnemonic FCR0),
and is accessed by ctc1 and cfc1 instructions.
  Unlike the CPUcs field, the "Imp" field is useful.  In the R30xx
family it will contain one of two values:

    0   No FPA is available.  Reading this register is the recommended
        way of sensing the presence of an FPA.  Note that software must
        enable "coprocessor 1" instructions before trying to read this
        register.
    3   The FPA is compatible with that used for the R3000 CPU and its
        successors.

  In the R4xxx family the "Imp" field is 0x20 for R4600, 0x21 for R4700
and 0x22 for the R4650.
  The "Rev" field contains no relevant software data.  The "Rev" field
is a value of the form y.x, where y is the major revision number (bits
7:4) and x is a minor revision number (bits 3:0).  Do not rely on this
field.


End of the quote.

 Is there any problem in a particular configuration which makes the FCR0
non-zero Imp field dependency unreliable? 

 The book covers R3081 and it states it contains the 3010A FPA device,
indeed. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
