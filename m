Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Sep 2002 14:30:04 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:20100 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122960AbSITMaD>; Fri, 20 Sep 2002 14:30:03 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA00176;
	Fri, 20 Sep 2002 14:30:25 +0200 (MET DST)
Date: Fri, 20 Sep 2002 14:30:25 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Kip Walker <kwalker@broadcom.com>
cc: linux-mips@linux-mips.org
Subject: Re: ELF32 problem in mips64 kernel
In-Reply-To: <3D88F022.E414C40F@broadcom.com>
Message-ID: <Pine.GSO.3.96.1020920141548.28010G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 18 Sep 2002, Kip Walker wrote:

> in elf_check_arch, the following access to the "e_flags" field is
> non-sensical if the binary is ELFCLASS32, because "__h" is typed as an
> elf64_hdr (through the elfhdr #define), whose e_flags is in a different
> location from an elf32_hdr.

 Thanks for pointing it out.

>         if ((__h->e_ident[EI_CLASS] == ELFCLASS32) &&     \
>             ((__h->e_flags & EF_MIPS_ABI2) == 0))         \
>                 __res = 0;                                \
> 
> Should the n32 check (is this what the EF_MIPS_ABI2 check is about?) be
> punted to another binary format handler?  The attached patch removed the
> ABI2 check.

 Since the layout of the ELF32 header much differs from the ELF64 one it
doesn't really make sense to handle both formats together.  The change
looks OK. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
