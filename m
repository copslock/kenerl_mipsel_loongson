Received:  by oss.sgi.com id <S42210AbQGLQ1s>;
	Wed, 12 Jul 2000 09:27:48 -0700
Received: from u-132.karlsruhe.ipdial.viaginterkom.de ([62.180.10.132]:47367
        "EHLO u-132.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42209AbQGLQ1h>; Wed, 12 Jul 2000 09:27:37 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S639471AbQGLQIA>;
        Wed, 12 Jul 2000 18:08:00 +0200
Date:   Wed, 12 Jul 2000 18:08:00 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Hiroo HAYASHI <hiroo.hayashi@toshiba.co.jp>
Cc:     linux-mips@oss.sgi.com, linux-mips@vger.rutgers.edu,
        linux-mips@fnet.fr
Subject: Re: div overflow
Message-ID: <20000712180800.C32169@bacchus.dhis.org>
References: <200007111258.VAA23473@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200007111258.VAA23473@toshiba.co.jp>; from hiroo.hayashi@toshiba.co.jp on Tue, Jul 11, 2000 at 09:58:47PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jul 11, 2000 at 09:58:47PM +0900, Hiroo HAYASHI wrote:

> In MIPS architecture, is the result of 0x80000000/-1 undefined?
> 
> The operands of DIV instruction 32bit signed int.
> 
> 	 0x7fff_ffff =  2,147,483,647 (INT_MAX)
> 	 0x8000_0000 = -2,147,483,648 (INT_MIN)
> 
> limits.h defines them as;
> 
> > /* Minimum and maximum values a `signed int' can hold.  */
> > #  define INT_MIN       (- INT_MAX - 1)
> > #  define INT_MAX       2147483647
> 
> 0x8000_0000 / 0xffff_ffff = -2,147,483,648 / -1 = 2,147,483,648 > INT_MAX

Worse - you're using signed numbers, so 2,147,483,648 is actually
-2,147,483,648 which is smaller than INT_MAX.  The death trap in two's
complement arithmetic.

> But the description of the DIV instruction of MIPS RISC Architecture
> (Kane and Heinrich) says;
> 
> 	No overflow exception occurs under any circumstances, and the
> 	result of this operation is undefined when the divisor is zero.

Correct.  Note that sometimes it's somewhat confusing which instructions
are macro instructions and which the pure machine instruction on MIPS.
In this particular case

> According to 'See MIPS Run', P.186, MIPS assembler expands a div
> instruction to an instruction sequence in which these condition are
> checked.  Do all MIPS assemblers do this?

At least I don't know any exceptions.  This is how the GNU assembler
expands div $2, $3, $4 when assembled with -O3 -mips4 --trap:

   0:	0064001a 	div	$zero,$v1,$a0
   4:	00800034 	teq	$a0,$zero
   8:	2401ffff 	li	$at,-1
   c:	14810002 	bne	$a0,$at,18
  10:	3c018000 	lui	$at,0x8000
  14:	00610034 	teq	$v1,$at
  18:	00001012 	mflo	$v0
  1c:	00000000 	nop

As you see the code tries to handle the special cases division by zero
and division of 0x80000000 / -1.  Also fairly bulky macro expansion - and
the MIPS I macro is even heavier.  If you want to disable this you have to
use the div / divu / ddiv / ddivu instructions with $0 as the first
argument and do the mflo yourself.

Which reminds me that I intend to use --trap as an optimization since a
long time.

Compiling the default Origin kernel with and without --trap

   text	   data	    bss	    dec	    hex	filename
1276100	 321624	 204396	1802120	 1b7f88	vmlinux
1274404	 321624	 204396	1800424	 1b78e8	vmlinux.trap

Quite impressive difference for all most zero effort to implement ...

  Ralf
