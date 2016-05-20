Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2016 20:30:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62222 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028620AbcETSaJdhc2x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 May 2016 20:30:09 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 566DD1C4B97BF;
        Fri, 20 May 2016 19:29:59 +0100 (IST)
Received: from [10.20.78.16] (10.20.78.16) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Fri, 20 May 2016
 19:30:01 +0100
Date:   Fri, 20 May 2016 19:29:52 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Li Zefan <lizefan@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Building older mips kernels with different versions of binutils;
 possible patch for 3.2 and 3.4
In-Reply-To: <20160520173139.GB12632@roeck-us.net>
Message-ID: <alpine.DEB.2.00.1605201901340.6794@tp.orcam.me.uk>
References: <573936E3.3050003@roeck-us.net> <alpine.DEB.2.00.1605161452100.6794@tp.orcam.me.uk> <20160520173139.GB12632@roeck-us.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.16]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Fri, 20 May 2016, Guenter Roeck wrote:

> >  If you send me messages from build errors you think may be caused by an 
> > incompatibility between the most recent binutils and kernel code, along 
> > with a kernel GIT commit ID, then I'll investigate and see if this is a 
> > problem on the binutils or the kernel side.  I may need to ask for .config 
> > in the process.  If you have problems with older binutils, then I just 
> > *might* be able to provide advice or a workaround, but my capabilities 
> > beyond that may be limited, I'm a limited resource after all.
> > 
> 
> binutils 2.25, any kernel supporting it (3.18+), mips:allnoconfig:
> 
>   CC      arch/mips/mm/sc-ip22.o
> 
> {standard input}: Assembler messages:
> {standard input}:131: Error: number (0x9000000080000000) larger than 32 bits
> {standard input}:154: Error: number (0x9000000080000000) larger than 32 bits
> {standard input}:191: Error: number (0x9000000080000000) larger than 32 bits
> 
> There is assembler code in arch/mips/mm/sc-ip22.c which first sets "mips3"
> (which I think is 32 bit) and then issues "dli\t$1, 0x9000000080000000\n\t",
> which apparently the assembler in binutils 2.25 doesn't like.

 This has been recently fixed:

commit 22522f880a8e17a17c4f195796ec89caece7652b
Author: Maciej W. Rozycki <macro@imgtec.com>
Date:   Fri Apr 22 01:04:52 2016 +0100

    MIPS/GAS: Fix an ISA override not lifting ABI restrictions

This regression had slipped through due to the lack of test coverage 
(which has now been addressed).

> ---
> 
> binutils 2.24, mips:defconfig or mips:allnoconfig; Kernel 3.2.y or 3.4.y
> 
> arch/mips/mm/page.c:88:6: error: 'clear_page' alias in between function and variable is not supported
> void clear_page(void *page) __attribute__((alias("clear_page_array")));
> 
> [there are several of those messages]

 This is a GCC error and not one from binutils (GAS or LD), so I can't 
help with this, sorry.  Since this looks like a regression to me, you may 
try asking at the <gcc@gcc.gnu.org> mailing list, to get a clarification 
at least.

> I can not really comment on microMIPS or not. Maybe some configurations do work
> with binutils 2.24 and kernel versions 3.2 or 3.4. If so, I have not been able
> to find them.

 That's what written in:

commit c022630633624a75b3b58f43dd3c6cc896a56cff
Author: Steven J. Hill <sjhill@mips.com>
Date:   Fri Jul 6 21:56:01 2012 +0200

    MIPS: Refactor 'clear_page' and 'copy_page' functions.

-- which is what I based my reply on.  It looks like however, there has 
been an independent generic change made to GCC, which caused the `alias' 
attribute to stop working regardless of the microMIPS vs regular MIPS 
problem (which BTW has resulted from the need to set the ISA bit, i.e. bit 
#0 of code addresses, in microMIPS code references).

> Builds with binutils 2.22 on recent kernels fail on and off (there was a failure
> in -next a few days ago which has since then be fixed). Overall using it as
> "default" builder is by now too fragile, which is why I dropped it as baseline
> version. I now only build defconfig and allnoconfig with it as basic sanity test.

 I can't comment on intermittent failures unless I have a proper error 
report I'm afraid.

> For qemu tests, I ended up using a combination of binutils 2.22, 2.24, and 2.25
> depending on the kernel version. Previously I only used 2.22, but again that
> is by now too risky. I can not just use 2.25 since it isn't supported in older
> kernels (plus mips-gcc in Poky 2.0 seems to be buggy for mipsel64, or maybe that
> compiler and qemu don't like each other), I can not just use 2.24 because it
> isn't supported in 3.2 and 3.4, and I don't want to use 2.22 for recent kernels
> since all tests may end up failing because some feature only available in later
> versions of binutils was added to the kernel. 

 This is too vague for me to make any conclusions I'm afraid.  I'm not 
sure what you mean by "[2.24] isn't supported in 3.2 and 3.4" for example.  
Please elaborate and provide examples of errors you've seen and I'll try 
to help.

 Overall given commit 22522f880a8e quoted above your best bet might be 
either using current binutils master (until 2.26 is released later this 
year) or backporting the fix to an older release of choice.

  Maciej
