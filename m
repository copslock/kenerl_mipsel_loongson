Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 22:15:18 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:33769 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225368AbSLRWPS>;
	Wed, 18 Dec 2002 22:15:18 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id BF0DFD657; Wed, 18 Dec 2002 23:21:17 +0100 (CET)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: fix compiler warnings in the math-emulator
References: <Pine.GSO.3.96.1021218194246.5977G-100000@delta.ds2.pg.gda.pl>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.GSO.3.96.1021218194246.5977G-100000@delta.ds2.pg.gda.pl>
Date: 18 Dec 2002 23:21:17 +0100
Message-ID: <m2el8fnf36.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:

maciej> On 18 Dec 2002, Juan Quintela wrote:
maciej> Is it needed?  The part that returns .mx should be optimized away by the
maciej> compiler automagically if unused. 
>> 
>> Idea was to make things compile without warnings, that way when you
>> change anything, you search for warnings :(

maciej> The idea is fine, sure.

>> With the changes that I sent, I have put the warnings levels down to
>> (for IP22) to:
>> - 7 C warnings
>> - 2 Asm warnings

maciej> A few warnings are unavoidable -- e.g. there is no way to shut up gas
maciej> complaining about macros expanding into multiple instructions in branch
maciej> delay slots.  Too bad.

I tried the 
  .set nowarn 
and found it didn't work.


maciej> How about this patch? -- it seems to work here (gcc 2.95.4).

Nope, the probem is that in the 3 places that I use the SETANDTEST()
macro they need the returned value.

Later, Juan.

maciej> -- 
maciej> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
maciej> +--------------------------------------------------------------+
maciej> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

maciej> patch-mips-2.4.20-pre6-20021212-setcx-0
maciej> diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips/math-emu/ieee754int.h linux-mips-2.4.20-pre6-20021212/arch/mips/math-emu/ieee754int.h
maciej> --- linux-mips-2.4.20-pre6-20021212.macro/arch/mips/math-emu/ieee754int.h	2002-12-16 17:17:55.000000000 +0000
maciej> +++ linux-mips-2.4.20-pre6-20021212/arch/mips/math-emu/ieee754int.h	2002-12-18 18:31:51.000000000 +0000
maciej> @@ -58,10 +58,10 @@
maciej> #define CLPAIR(x,y)	((x)*6+(y))
 
maciej> #define CLEARCX	\
maciej> -  (ieee754_csr.cx = 0)
maciej> +	(ieee754_csr.cx = 0)
 
maciej> #define SETCX(x) \
maciej> -  (ieee754_csr.cx |= (x),ieee754_csr.sx |= (x),ieee754_csr.mx & (x))
maciej> +	({ieee754_csr.cx |= (x); ieee754_csr.sx |= (x); ieee754_csr.mx & (x);})
 
maciej> #define TSTX()	\
maciej> (ieee754_csr.cx & ieee754_csr.mx)


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
