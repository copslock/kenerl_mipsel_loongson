Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2004 20:13:01 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:16563 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225937AbUFKTM5>; Fri, 11 Jun 2004 20:12:57 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id F11A647889; Fri, 11 Jun 2004 21:12:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 3CEAB47833; Fri, 11 Jun 2004 21:12:49 +0200 (CEST)
Date: Fri, 11 Jun 2004 21:12:49 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: David Daney <ddaney@avtrex.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
In-Reply-To: <40C9F7F0.50501@avtrex.com>
Message-ID: <Pine.LNX.4.55.0406112039040.13062@jurand.ds.pg.gda.pl>
References: <40C9F5A4.2050606@avtrex.com> <40C9F5FE.8030607@avtrex.com>
 <40C9F7F0.50501@avtrex.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 11 Jun 2004, David Daney wrote:

> I guess I didn't fully read the comment above this section of code.
> 
>     /*
>      * There is the ancient bug in the MIPS assemblers that the break
>      * code starts left to bit 16 instead to bit 6 in the opcode.
>      * Gas is bug-compatible ...
>      */
> 
> I am using gcc-3.3.1/binutils-2.15.  With this toolchain, I get break 
> instructions that comply with the MIPS documentation for break instructions:

 Well, I did some research and I'm afraid it dates back to a commit from
2000-12-01, when a different interpretation of "break" was introduced for
the MIPS32/64 ISA.  So the interpretation of the "break" instruction
depends on the "-march" setting and moreover, only for instructions
requested explicitly.  For ones emitted implicitly as a result of division
and multiplication macros, the interpretation is always the "traditional"
one (the "c" vs the "B" code).

> 00000000 <do_div>:
>    0:   3c1c0000        lui     gp,0x0
>    4:   279c0000        addiu   gp,gp,0
>    8:   0399e021        addu    gp,gp,t9
>    c:   0085001a        div     zero,a0,a1
>   10:   14a00002        bnez    a1,1c <do_div+0x1c>
>   14:   00000000        nop
>   18:   000001cd        break   0x7
>   1c:   00001012        mflo    v0
>   20:   03e00008        jr      ra
>   24:   00000000        nop
>  
> 
> What to do?

1. I think Linux can intercept both the "traditional" and MIPS32/64 values
-- break codes are not used that extensively this would risk running out
of them.  The set of known ones can be seen in <asm/break.h>.  However,
this won't aid userland trying to interpret code (there may be none such, 
though).

2. Gas should definitely use the codes consistently.  And it's a pity the
ABI got broken -- I think another mnemonic should have been chosen for the
correct implementation of "break", available to any ISA.

3. GCC should probably use traps for anything above MIPS I, anyway.  
Perhaps with an option, like for gas, to select the alternative.

4. Perhaps something else.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
