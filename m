Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2017 09:10:02 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60148 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993893AbdAZIJzXakcB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Jan 2017 09:09:55 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v0Q89o2h029008;
        Thu, 26 Jan 2017 09:09:50 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v0Q89lkW029003;
        Thu, 26 Jan 2017 09:09:47 +0100
Date:   Thu, 26 Jan 2017 09:09:47 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Mark Zhang <bomb.zhang@gmail.com>,
        David Miller <davem@davemloft.net>,
        Alexander Duyck <aduyck@mirantis.com>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Bug fix]mips 64bits checksum error -- csum_tcpudp_nofold
Message-ID: <20170126080947.GE21568@linux-mips.org>
References: <CAEbrdOCo9DeOa=rXYBxCEERNu_Cq=7N+5dDOwLwuZy87D3M6bA@mail.gmail.com>
 <CAKgT0UdBkqsUmp5y2d4fbi4MopW=6rxge_YzAwVvaKCqLj11_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdBkqsUmp5y2d4fbi4MopW=6rxge_YzAwVvaKCqLj11_Q@mail.gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Jan 25, 2017 at 10:13:32AM -0800, Alexander Duyck wrote:

> On Tue, Jan 24, 2017 at 8:35 PM, Mark Zhang <bomb.zhang@gmail.com> wrote:
> > If the input parameters as saddr = 0xc0a8fd60,daddr = 0xc0a8fda1,len =
> > 80, proto = 17, sum =0x7eae049d.
> > The correct result should be 1, but original function return 0.
> >
> > Attached the correction patch.
> 
> I've copied your patch here:
> 
> >From 52e265f7fe0acf9a6e9c4346e1fe6fa994aa00b6 Mon Sep 17 00:00:00 2001
> From: qzhang <qin.2.zhang@nsn.com>
> Date: Wed, 25 Jan 2017 12:25:25 +0800
> Subject: [PATCH] Fixed the mips 64bits checksum error -- csum_tcpudp_nofold
> 
> ---
>  arch/mips/include/asm/checksum.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
> index 7749daf..0e351c5 100644
> --- a/arch/mips/include/asm/checksum.h
> +++ b/arch/mips/include/asm/checksum.h
> @@ -184,6 +184,10 @@ static inline __wsum csum_tcpudp_nofold(__be32
> saddr, __be32 daddr,
>   " daddu %0, %2 \n"
>   " daddu %0, %3 \n"
>   " daddu %0, %4 \n"
> + " dsrl32  $1, %0, 0 \n"		# Put upper 32 bits of %0 into $1

> + " dsll32 %0, %0, 0 \n"		# zero upper 32 bits of %0
> + " dsrl32 %0, %0, 0 \n"

> + " daddu   %0, $1 \n"		# now add

>   " dsll32 $1, %0, 0 \n"
>   " daddu %0, $1 \n"
>   " dsra32 %0, %0, 0 \n"

See the comments I added into above code.

> I agree there does appear to be a bug in the code, and my
> understanding of MIPS assembly is limited, but I don't think your
> patch truly fixes it.  From what I can understand it seems like you
> would just be shifting the register called out at %0 past 64 bits
> which would just zero it out.

Not quite, DSLL32 is a logic shift left by 32 + x bits where x is the 0..31
constant of the 3rd argument.  Similarly DSRA32 is an arithmetic shift
right by 32 + x bits where x is the 0..31 constant of the 3rd argument.

> Below is the snippet you are updating:
> 
>     #ifdef CONFIG_64BIT
>             "       daddu   %0, %2          \n"
>             "       daddu   %0, %3          \n"
>             "       daddu   %0, %4          \n"
>             "       dsll32  $1, %0, 0       \n"
>             "       daddu   %0, $1          \n"
>             "       dsra32  %0, %0, 0       \n"
>     #endif
> 
> >From what I can tell the issue is that the dsll32 really needs to be
> replaced with some sort of rotation type call instead of a shift, but
> it looks like MIPS doesn't have a rotation instruction.  We need to
> add the combination of a shift left by 32, to a shift right 32, and
> then add that value back to the original register.  Then we will get
> the correct result in the upper 32 bits.

The DSLL32 is fine.  What the DSLL32 does is moving the low 32 bits of %0
to the upper 32 bits of the target register $1 before the DADDU is adding
both 32 bit halfs of the 64 bit intermediate checksum together.

The real bug is that above inline code was written assuming that when
folding the intermediate 64-bit sum to 32 bit there can not ever be a
carry.

> I'm not even sure it is necessary to use inline assembler.  You could
> probably just use the inline assembler for the 32b and change the 64b
> approach over to using C.  The code for it would be pretty simple:
>     unsigned long res = (__force unsigned long)sum;
> 
>     res += (__force unsigned long)daddr;
>     res += (__force unsigned long)saddr;
> #ifdef __MIPSEL__
>     res += (proto + len) << 8;
> #else
>     res += proto + len;
> #endif
>     res += (res << 32) | (res >> 32);
> 
>     return (__force __wsum)(res >> 32);
> 
> That would probably be enough to fix the issue and odds are it should
> generate assembly code very similar to what was already there.

GCC used to do silly things at times which is the sole reason why it
ever made sense to use inline assembler.  No more and compiled C code
can be scheduled better than inline assembler these days.

I have a fix but unlike Mark's original fix it only adds two instructions.

  Ralf
