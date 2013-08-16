Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Aug 2013 06:53:36 +0200 (CEST)
Received: from mail.active-venture.com ([67.228.131.205]:54504 "EHLO
        mail.active-venture.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816209Ab3HPExd1z3nO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Aug 2013 06:53:33 +0200
Received: (qmail 62442 invoked by uid 399); 16 Aug 2013 04:53:23 -0000
Received: from unknown (HELO server.roeck-us.net) (linux@roeck-us.net@108.223.40.66)
  by mail.active-venture.com with ESMTPAM; 16 Aug 2013 04:53:23 -0000
X-Originating-IP: 108.223.40.66
X-Sender: linux@roeck-us.net
Message-ID: <520DB045.7000309@roeck-us.net>
Date:   Thu, 15 Aug 2013 21:53:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [ 00/17] 3.4.58-stable review
References: <20130813063501.728847844@linuxfoundation.org> <520A1D56.2050507@roeck-us.net> <20130813175858.GC7336@kroah.com> <20130813201936.GA18358@roeck-us.net> <20130815063158.GB25754@kroah.com> <520C86BD.2020903@roeck-us.net> <CAMuHMdU+EOC_etihOzUC6N0cqc2qHaGm3_L+gyTRxESCGhOzEg@mail.gmail.com>
In-Reply-To: <CAMuHMdU+EOC_etihOzUC6N0cqc2qHaGm3_L+gyTRxESCGhOzEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 08/15/2013 12:55 AM, Geert Uytterhoeven wrote:
> On Thu, Aug 15, 2013 at 9:43 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> I screwed up my stable repo clone again :(, so the full build will take a
>> bit.
>>
>> mips builds on on 3.4 with all patches applied now fail with:
>> arch/mips/include/asm/page.h: Assembler messages:
>> arch/mips/include/asm/page.h:178: Error: Unrecognized opcode `static inline
>> int pfn_valid(unsigned long pfn)'
>> arch/mips/include/asm/page.h:179: Error: junk at end of line, first
>> unrecognized character is `{'
>> arch/mips/include/asm/page.h:181: Error: Unrecognized opcode `extern
>> unsigned long max_mapnr'
>> arch/mips/include/asm/page.h:183: Error: Unrecognized opcode `return
>> pfn>=ARCH_PFN_OFFSET&&pfn<max_mapnr'
>> arch/mips/include/asm/page.h:184: Error: junk at end of line, first
>> unrecognized character is `}'
>>
>> This is the error I referred to above. Reverting above pfn rework patch
>> fixes that problem,
>> so you might want to remove that patch from the patch queue for now.
>
> Perhaps this one got applied too soon?
>
>   commit 730b8dfe016dd1e91f73d8d3e6724da91397171c
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Fri Dec 28 15:18:02 2012 +0100
>
>      MIPS: page.h: Remove now unnecessary #ifndef __ASSEMBLY__ wrapper.
>
>      Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>

Actually, you are on the right track, only in the opposite direction.
The problem is that commit 8b9232141b changed
	#define pfn_valid ...
to
	static inline pfn_valid()
in arch/mips/include/asm/page.h. In the 3.4 kernel the file _is_
still included from assembler code. This obviously doesn't work.

Fix would be to surround the new static inline function with #ifndef __ASSEMBLY__.
With this change, "mips allmodconfig" compiles with the 3.4 kernel.
It should be a safe change, since the static inline will never be used
from assembler code.

Question is if that would be acceptable as back-port of 8b9232141b to 3.4.
Greg, any comments ? If it is ok I can submit a back-port request with
the modified patch to -stable. That would be one more build fixed,
three to go (arm:allmodconfig, sparc32:defconfig, and sparc64:allmodconfig).

Thanks,
Guenter
