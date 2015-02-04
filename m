Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 13:57:38 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27011486AbbBDM5f7cC2h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 13:57:35 +0100
Date:   Wed, 4 Feb 2015 12:57:35 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Daniel Sanders <daniel.sanders@imgtec.com>
cc:     Toma Tabacu <toma.tabacu@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] MIPS: LLVMLinux: Fix an 'inline asm input/output
 type mismatch' error.
In-Reply-To: <1422970639-7922-4-git-send-email-daniel.sanders@imgtec.com>
Message-ID: <alpine.LFD.2.11.1502041151300.22715@eddie.linux-mips.org>
References: <1422970639-7922-1-git-send-email-daniel.sanders@imgtec.com> <1422970639-7922-4-git-send-email-daniel.sanders@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, 3 Feb 2015, Daniel Sanders wrote:

> From: Toma Tabacu <toma.tabacu@imgtec.com>
> 
> Change the type of csum_ipv6_magic's 'proto' argument from unsigned
> short to __u32.
> 
> This fixes a type mismatch between the 'htonl(proto)' inline asm
> input, which is __u32, and the 'proto' output, which is unsigned
> short.
> 
> This is the error message reported by clang:
> arch/mips/include/asm/checksum.h:285:27: error: unsupported inline asm: input with type '__be32' (aka 'unsigned int') matching output with type 'unsigned short'
>           "0" (htonl(len)), "1" (htonl(proto)), "r" (sum));
>                                  ^~~~~~~~~~~~
> 
> The changed code can be compiled successfully by both gcc and clang.

 This definitely looks like a bug in clang to me.  What this construct 
means is both input #5 and output #1 live in the same register, and that 
an `__u32' value is taken on input (from the result of the `htonl(proto)' 
calculation) and an `unsigned short' value produced in the same register 
on output, that'll be the value of the `proto' variable from there on.  A 
perfectly valid arrangement.  This would be the right arrangement to use 
with the MIPS16 SEH instruction for example.  Has this bug been reported 
to clang maintainers?

 And I'd prefer to leave the declaration of `proto' alone as IPv6 network 
protocol numbers are 16-bit quantities.

 That said this code is indeed weird if not wrong, which is probably why 
this arrangement resulted, in an attempt to prevent GCC from messing up 
the registers used.

 First and foremost both outputs, and especially #1, lack an earlyclobber.  
This I imagine may have prompted GCC to overwrite one of the inputs, which 
in turn is why whoever poked at this code decided to alias input #5 to 
output #1.  But as you can see in the asm there's no real aliasing between 
input #5 and output #1.  Input #5 is consumed early on (and even referred 
to with `%5' rather than `%1', which would be the norm in the case of 
actual aliasing), and the containing register reused for something else.  
So the two operands can be separated.  This is unlike input #4 vs output 
#0, that is both read and written right away (and just as one'd expect 
there's no reference to `%4' anywhere).

 Output #0 can do without an earlyclobber as it is aliased to input #4 and 
therefore cannot be assigned by GCC to another input.  But it won't hurt 
to have one too and it will set a good practice and serve a documentation 
purpose.

 I suggest a fix like this then:

static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
					  const struct in6_addr *daddr,
					  __u32 len, unsigned short proto,
					  __wsum sum)
{
	__wsum tmp;

	__asm__(
[...]
	: "=&r" (sum), "=&r" (tmp)
	: "r" (saddr), "r" (daddr),
	  "0" (htonl(len)), "r" (htonl(proto)), "r" (sum));

        return csum_fold(sum);
}

Try and see if it works for you.

 I wonder why this is an asm in the first place though.  There's no rocket 
science here that GCC couldn't handle.  I guess it must have been very bad 
at optimising a C equivalent then.

  Maciej
