Received:  by oss.sgi.com id <S553700AbRAEUkY>;
	Fri, 5 Jan 2001 12:40:24 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:32450 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553678AbRAEUkK>;
	Fri, 5 Jan 2001 12:40:10 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA10114;
	Fri, 5 Jan 2001 21:39:55 +0100 (MET)
Date:   Fri, 5 Jan 2001 21:39:54 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Nicu Popovici <octavp@isratech.ro>
cc:     linux-mips@oss.sgi.com
Subject: Re: Kernel compile error.
In-Reply-To: <3A56483D.17B57BD5@isratech.ro>
Message-ID: <Pine.GSO.3.96.1010105213325.9384F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 5 Jan 2001, Nicu Popovici wrote:

> /home/nicu/JUNGO/linux/include/asm/bugs.h:137: internal error--insn does
> not satisfy its constraints:
> (insn 244 241 250 (set (reg:SI 66 accum)
>         (reg:SI 6 a2)) 170 {movsi_internal2} (insn_list 241
> (insn_list:REG_DEP_ANTI 98 (insn_list:REG_DEP_OUTPUT 138
> (insn_list:REG_DEP_ANTI 247 (insn_list:REG_DEP_ANTI 150 (nil))))))
>             (nil))
>             mips-linux-gcc: Internal compiler error: program cc1 got
> fatal signal 6
>             make: *** [init/main.o] Error 1
>             [nicu@ares linux]$ {standard input}: Assembler messages:
>             {standard input}:47: Error: unrecognized opcode `movl
> %cr0,$2'

 You are trying to assemble i386 instructions -- probably your include/asm
symlink is incorrect.  Make sure the ARCH make variable is set to "mips",
i.e. either run `make ARCH=mips <whatever>' or modify the top-level
Makefile (the one from our CVS appears to have ARCH hardcoded to "mips"
already). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
