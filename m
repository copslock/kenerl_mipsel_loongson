Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 19:41:40 +0100 (BST)
Received: from mail.codesourcery.com ([65.74.133.4]:43740 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S20038523AbYFKSli (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jun 2008 19:41:38 +0100
Received: (qmail 20200 invoked from network); 11 Jun 2008 18:41:34 -0000
Received: from unknown (HELO mbp.local) (maxim@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 11 Jun 2008 18:41:34 -0000
Message-ID: <48501C55.5060602@codesourcery.com>
Date:	Wed, 11 Jun 2008 22:41:25 +0400
From:	Maxim Kuvyrkov <maxim@codesourcery.com>
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
Subject: Re: Changing the treatment of the MIPS HI and LO registers
References: <87tzgj4nh6.fsf@firetop.home> 	<Pine.LNX.4.55.0805272134540.18833@cliff.in.clinika.pl> 	<87abib4d9t.fsf@firetop.home> 	<Pine.LNX.4.55.0805272357020.18833@cliff.in.clinika.pl> 	<87r6bm1ebd.fsf@firetop.home> 	<Pine.LNX.4.55.0805290213140.29522@cliff.in.clinika.pl> 	<878wxtvarg.fsf@firetop.home> <8763stz2p3.fsf@firetop.home> <87zlpuxqfb.fsf@firetop.home>
In-Reply-To: <87zlpuxqfb.fsf@firetop.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maxim@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxim@codesourcery.com
Precedence: bulk
X-list: linux-mips

Richard Sandiford wrote:

...

> +    <li>The MIPS port no longer recognizes the <code>h</code>
> +    <code>asm</code> constraint.  It was necessary to remove
> +    this constraint in order to avoid generating unpredictable
> +    code sequences.
> +
> +    <p>One of the main uses of the <code>h</code> constraint
> +    was to extract the high part of a multiplication on
> +    64-bit targets.  For example:</p>
> +    <pre>
> +    asm ("dmultu\t%1,%2" : "=h" (result) : "r" (x), "r" (y));</pre>
> +    <p>You can now achieve the same effect using 128-bit types:</p>
> +    <pre>
> +    typedef unsigned int uint128_t __attribute__((mode(TI)));
> +    result = ((uint128_t) x * y) >> 64;</pre>
> +    <p>The second sequence is better in many ways.  For example,
> +    if <code>x</code> and <code>y</code> are constants, the
> +    compiler can perform the multiplication at compile time.
> +    If <code>x</code> and <code>y</code> are not constants,
> +    the compiler can schedule the runtime multiplication
> +    better than it can schedule an <code>asm</code> statement.</p>
> +    </li>
>   </ul>

Hi,

GLIBC contains the following code in stdlib/longlong.h:
<snip>
#if defined (__mips__) && W_TYPE_SIZE == 32
#define umul_ppmm(w1, w0, u, v) \
   __asm__ ("multu %2,%3"						\
	   : "=l" ((USItype) (w0)),					\
	     "=h" ((USItype) (w1))					\
	   : "d" ((USItype) (u)),					\
	     "d" ((USItype) (v)))
#define UMUL_TIME 10
#define UDIV_TIME 100
#endif /* __mips__ */
</snip>

What would be a correct fix in this case?  Something like this:
<snip>
#define umul_ppmm(w1, w0, u, v)					\
   ({unsigned int __attribute__((mode(DI))) __xx;		\
     __xx = (unsigned int __attribute__((mode(DI)))) u * v;	\
     w0 = __xx & ((1 << 32) - 1);				\
     w1 = __xx >> 32;})
</snip>

Or is there a better way?


Thanks,

Maxim
