Received:  by oss.sgi.com id <S42310AbQJFPUa>;
	Fri, 6 Oct 2000 08:20:30 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:27269 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42302AbQJFPUJ>;
	Fri, 6 Oct 2000 08:20:09 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA05896;
	Fri, 6 Oct 2000 17:14:16 +0200 (MET DST)
Date:   Fri, 6 Oct 2000 17:14:16 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Keith Owens <kaos@ocs.com.au>
cc:     Gordon McNutt <gmcnutt@ridgerun.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: insmod hates RELA? 
In-Reply-To: <23467.970840312@ocs3.ocs-net>
Message-ID: <Pine.GSO.3.96.1001006170346.5524A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 7 Oct 2000, Keith Owens wrote:

> >I've looked a little more since writing the above. The relocation errors are
> >occurring in the .bss section, where it appears insmod is iterating over all
> >references to a symbol and doing a relocation. The type of relocation done
> >for all symbols is associated with the 'R_MIPS_26' #define (see linux/elf.h).
> >Is this a bug in insmod?
> 
> Don't think so, rather it is appears to be gcc assuming that some
> symbols can be accessed via $GP+26 bits.  I don't have a MIPS ELF
> manual handy at the moment so I am guessing that you need -mlong-calls
> for modules.

 The kernel is compiled with -fno-PIC, so it's quite likely that there are
R_MIPS_26 relocations.  They are used for all of the 'j* label'
instructions (with the target address encoded in the 26 LSBs of the
opcode).  There is no $reg+26 bits addressing mode for MIPS (but there is
$reg+16 and thus there is the R_MIPS_GPREL16 relocation).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
