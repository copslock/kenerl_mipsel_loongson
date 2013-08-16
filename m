Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Aug 2013 07:09:16 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:47482 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816209Ab3HPFJNZ7L26 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Aug 2013 07:09:13 +0200
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net [76.28.172.123])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4773C714;
        Fri, 16 Aug 2013 05:09:05 +0000 (UTC)
Date:   Thu, 15 Aug 2013 22:10:41 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [ 00/17] 3.4.58-stable review
Message-ID: <20130816051041.GA23784@kroah.com>
References: <20130813063501.728847844@linuxfoundation.org>
 <520A1D56.2050507@roeck-us.net>
 <20130813175858.GC7336@kroah.com>
 <20130813201936.GA18358@roeck-us.net>
 <20130815063158.GB25754@kroah.com>
 <520C86BD.2020903@roeck-us.net>
 <CAMuHMdU+EOC_etihOzUC6N0cqc2qHaGm3_L+gyTRxESCGhOzEg@mail.gmail.com>
 <520DB045.7000309@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <520DB045.7000309@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Thu, Aug 15, 2013 at 09:53:25PM -0700, Guenter Roeck wrote:
> On 08/15/2013 12:55 AM, Geert Uytterhoeven wrote:
> > On Thu, Aug 15, 2013 at 9:43 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> >> I screwed up my stable repo clone again :(, so the full build will take a
> >> bit.
> >>
> >> mips builds on on 3.4 with all patches applied now fail with:
> >> arch/mips/include/asm/page.h: Assembler messages:
> >> arch/mips/include/asm/page.h:178: Error: Unrecognized opcode `static inline
> >> int pfn_valid(unsigned long pfn)'
> >> arch/mips/include/asm/page.h:179: Error: junk at end of line, first
> >> unrecognized character is `{'
> >> arch/mips/include/asm/page.h:181: Error: Unrecognized opcode `extern
> >> unsigned long max_mapnr'
> >> arch/mips/include/asm/page.h:183: Error: Unrecognized opcode `return
> >> pfn>=ARCH_PFN_OFFSET&&pfn<max_mapnr'
> >> arch/mips/include/asm/page.h:184: Error: junk at end of line, first
> >> unrecognized character is `}'
> >>
> >> This is the error I referred to above. Reverting above pfn rework patch
> >> fixes that problem,
> >> so you might want to remove that patch from the patch queue for now.
> >
> > Perhaps this one got applied too soon?
> >
> >   commit 730b8dfe016dd1e91f73d8d3e6724da91397171c
> > Author: Ralf Baechle <ralf@linux-mips.org>
> > Date:   Fri Dec 28 15:18:02 2012 +0100
> >
> >      MIPS: page.h: Remove now unnecessary #ifndef __ASSEMBLY__ wrapper.
> >
> >      Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> >
> 
> Actually, you are on the right track, only in the opposite direction.
> The problem is that commit 8b9232141b changed
> 	#define pfn_valid ...
> to
> 	static inline pfn_valid()
> in arch/mips/include/asm/page.h. In the 3.4 kernel the file _is_
> still included from assembler code. This obviously doesn't work.
> 
> Fix would be to surround the new static inline function with #ifndef __ASSEMBLY__.
> With this change, "mips allmodconfig" compiles with the 3.4 kernel.
> It should be a safe change, since the static inline will never be used
> from assembler code.
> 
> Question is if that would be acceptable as back-port of 8b9232141b to 3.4.
> Greg, any comments ? If it is ok I can submit a back-port request with
> the modified patch to -stable. That would be one more build fixed,
> three to go (arm:allmodconfig, sparc32:defconfig, and sparc64:allmodconfig).

That sounds reasonable to me, as it is a valid fix, and I do know of
some MIPS people using 3.4 (although their versions all seem to be
heavily patched, perhaps for issues like this, I don't really know...)

So, feel free to send such a backport on to me.

thanks,

greg k-h
