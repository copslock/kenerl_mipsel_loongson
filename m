Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 14:07:54 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:43476 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225737AbUDWNHu>; Fri, 23 Apr 2004 14:07:50 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id B93BD4C002; Fri, 23 Apr 2004 15:07:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id A876C47855; Fri, 23 Apr 2004 15:07:43 +0200 (CEST)
Date: Fri, 23 Apr 2004 15:07:43 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Bradley D. LaRonde" <brad@laronde.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: inconsistent operand constraints in 'asm' in unaligned.h:66
 using gcc 3.4
In-Reply-To: <06d601c428e2$3ba1dcc0$8d01010a@prefect>
Message-ID: <Pine.LNX.4.55.0404231454120.14494@jurand.ds.pg.gda.pl>
References: <06d601c428e2$3ba1dcc0$8d01010a@prefect>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 22 Apr 2004, Bradley D. LaRonde wrote:

> gcc 3.4 complians about:
> 
> include/asm/unaligned.h:66: error: inconsistent operand constraints in an
> `asm'
> 
> from linux CVS 2.4 branch.  That's:
> 
> /*
>  * Store doubleword ununaligned.
>  */
> static inline void __stq_u(unsigned long __val, unsigned long long * __addr)
> {
>         __asm__("usw\t%1, %0\n\t"
>                 "usw\t%D1, 4+%0"
>                 : "=m" (*__addr)
>                 : "r" (__val));
> }

 As usually recent gcc is invaluable in finding dubious constructs. ;-)

> I finally decided to punt and write:
> 
> static inline void __stq_u(unsigned long long __val, unsigned long long *
> __addr)
> {
>         *__addr = __val;
> }
> 
> Is this OK?  Is there a better solution?

 No.  Yes.

 Reviving old tricks about unaligned data I've come with the following
implementation:

void __stq_u(unsigned long long __val, unsigned long long *__addr)
{
	typedef struct {
		unsigned long long v __attribute__((packed));
	} ull_u_t;
	ull_u_t *a = (ull_u_t *)__addr;

        a->v = __val;
}

which yields a nice and desirable code:

unaligned.o:     file format elf32-tradlittlemips

Disassembly of section .text:

00000000 <__stq_u>:
   0:	a8c40003 	swl	a0,3(a2)
   4:	b8c40000 	swr	a0,0(a2)
   8:	a8c50007 	swl	a1,7(a2)
   c:	03e00008 	jr	ra
  10:	b8c50004 	swr	a1,4(a2)
	...

I'm pretty sure it works fine with gcc 2.95.x as well -- for Alpha it used
to, even with such antiques as egcs 1.1.2.

 Ralf, I can see 2.6 already does the right thing -- I suppose you won't
mind me backporting (copying?) it?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
