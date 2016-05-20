Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2016 19:31:45 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:60572 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27031903AbcETRbnDQv1b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 May 2016 19:31:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=oU/dp2XLISwNqdhfDP2gkzLoke80ZZJWpa7Mn2zwlCU=; b=nf1Z8P5M4TyKzm3Q3KzTUmGYra
        v14P8yNmeDa3kQEjcvtQ3cxKDCP3NmFII/iro0zY88WPcOL6s3UnpvC6V2Ihz2LUAMQpgXS8mjCty
        GlCBBHaKlLBRHxw2rxxOL+iF6ZxH9Us88j9mt6YJpxYU6Ag4iheycXkGZtK/xTTfn1JtexrJYwjlC
        9Vlgj7kSuOZsVGtwP3uZS0r8JZ5udMAt2pWKS2NF16n5gNpLwRlysLyeH32o/Fa6lLwRIoEZnpJf8
        dBY53JfIceuL7PlzH/kpDQB6j9QRBgPEN+9j3eXYgDS47phoFpKLNSI6JUgbuKg1QblJNUVxPfgjN
        Sv/u2BuA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:50574 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1b3oGs-002qQx-3T; Fri, 20 May 2016 17:31:34 +0000
Date:   Fri, 20 May 2016 10:31:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Li Zefan <lizefan@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Building older mips kernels with different versions of binutils;
 possible patch for 3.2 and 3.4
Message-ID: <20160520173139.GB12632@roeck-us.net>
References: <573936E3.3050003@roeck-us.net>
 <alpine.DEB.2.00.1605161452100.6794@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1605161452100.6794@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53564
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

On Fri, May 20, 2016 at 02:21:34PM +0100, Maciej W. Rozycki wrote:
> Hi Guenter,
> 
> > building mips images with a consistent infrastructure is becoming more and
> > more difficult.
> 
>  As the current MIPS binutils maintainer I am sorry to hear about this, 
> and apologise for the state of affairs.  Of course I can't help with any 
> sins of the past, but at least I can help straightening out the current 
> situation and making sure that the most recent binutils work as expected.
> 
> > Current state is as follows.
> > 
> > Binutils/	2.22	2.24	2.25
> > Kernel
> > 3.2		X	-	-
> > 3.4		X	-	-
> > 3.10		X	X	-
> > 3.14		X	X	-
> > 3.16		X	X	-
> > 3.18		X	X	(X) [1]
> > 4.1		X	X	(X)
> > 4.4		X	X	(X)
> > 4.5		X	X	(X)
> > 4.6		X	X	(X)
> > next		-	X	(X)
> > 
> > [1] (at least) allnoconfig fails to build with binutils 2.25 (2.25.1, more
> > specifically).
> > 
> > I used the following toolchains for the above tests:
> > - Poky 1.3 (binutils 2.22)
> > - Poky 2.0 (binutils 2.25.1)
> > - gcc-4.6.3-nolibc from kernel.org (binutils 2.22)
> > - gcc-4.9.0-nolibc from kernel.org (binutils 2.24)
> > 
> > For 3.4 and 3.2 kernels to build with binutils v2.24, it would be necessary to
> > apply patch c02263063362 ("MIPS: Refactor 'clear_page' and 'copy_page'
> > functions").
> 
>  Mind that this change is really only needed to build microMIPS kernels, 
> only required for pure microMIPS hardware, i.e. processors which do not 
> support regular (aka AD 1985 classic) MIPS execution at all -- have you 
> been building such configurations?  For mixed-mode processors a regular 
> MIPS kernel will do as it'll handle microMIPS userland just fine.
> 
>  Or is there a hidden catch in this change beyond what's been stated in 
> the commit description?
> 
> > It applies cleanly to 3.4, but has a Makefile conflict in 3.2. It might
> > make sense to apply this patch to both releases. Would this be possible ?
> > This way, we would have at least one toolchain which can build all 3.2+
> > kernels.
> 
>  If you send me messages from build errors you think may be caused by an 
> incompatibility between the most recent binutils and kernel code, along 
> with a kernel GIT commit ID, then I'll investigate and see if this is a 
> problem on the binutils or the kernel side.  I may need to ask for .config 
> in the process.  If you have problems with older binutils, then I just 
> *might* be able to provide advice or a workaround, but my capabilities 
> beyond that may be limited, I'm a limited resource after all.
> 

binutils 2.25, any kernel supporting it (3.18+), mips:allnoconfig:

  CC      arch/mips/mm/sc-ip22.o

{standard input}: Assembler messages:
{standard input}:131: Error: number (0x9000000080000000) larger than 32 bits
{standard input}:154: Error: number (0x9000000080000000) larger than 32 bits
{standard input}:191: Error: number (0x9000000080000000) larger than 32 bits

There is assembler code in arch/mips/mm/sc-ip22.c which first sets "mips3"
(which I think is 32 bit) and then issues "dli\t$1, 0x9000000080000000\n\t",
which apparently the assembler in binutils 2.25 doesn't like.

---

binutils 2.24, mips:defconfig or mips:allnoconfig; Kernel 3.2.y or 3.4.y

arch/mips/mm/page.c:88:6: error: 'clear_page' alias in between function and variable is not supported
void clear_page(void *page) __attribute__((alias("clear_page_array")));

[there are several of those messages]

I can not really comment on microMIPS or not. Maybe some configurations do work
with binutils 2.24 and kernel versions 3.2 or 3.4. If so, I have not been able
to find them.

Builds with binutils 2.22 on recent kernels fail on and off (there was a failure
in -next a few days ago which has since then be fixed). Overall using it as
"default" builder is by now too fragile, which is why I dropped it as baseline
version. I now only build defconfig and allnoconfig with it as basic sanity test.

For qemu tests, I ended up using a combination of binutils 2.22, 2.24, and 2.25
depending on the kernel version. Previously I only used 2.22, but again that
is by now too risky. I can not just use 2.25 since it isn't supported in older
kernels (plus mips-gcc in Poky 2.0 seems to be buggy for mipsel64, or maybe that
compiler and qemu don't like each other), I can not just use 2.24 because it
isn't supported in 3.2 and 3.4, and I don't want to use 2.22 for recent kernels
since all tests may end up failing because some feature only available in later
versions of binutils was added to the kernel. 

Guenter
