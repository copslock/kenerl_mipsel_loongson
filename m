Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 12:32:14 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:14507 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225201AbTBUMcN>; Fri, 21 Feb 2003 12:32:13 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA14256;
	Fri, 21 Feb 2003 13:32:30 +0100 (MET)
Date: Fri, 21 Feb 2003 13:32:30 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: kwalker@linux-mips.org
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20030220194640Z8225262-1272+600@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030221132402.13836K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 20 Feb 2003 kwalker@linux-mips.org wrote:

> Modified files:
> 	include/asm-mips64: Tag: linux_2_4 a.out.h elf.h processor.h 
> 	arch/mips64/kernel: Tag: linux_2_4 process.c signal.c 
> 
> Log message:
> 	Represent ABI (o32,n32,n64) in thread mflags using 2 bits:
> 	MF_32BIT_REGS, MF_32BIT_ADDR.

 Why do you assume no ABI set for ELF32 means n32?  Historically it means
o32 and arch/mips64/kernel/binfmt_elfo32.c treats it as such.  Also a
brief study of binutils reveals the interpretation is the same for IRIX
which does not handle the EF_MIPS_ABI mask. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
