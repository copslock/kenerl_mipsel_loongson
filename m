Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2016 15:21:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59482 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27031701AbcETNVwAVIRY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 May 2016 15:21:52 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id DC6E3366BC190;
        Fri, 20 May 2016 14:21:42 +0100 (IST)
Received: from [10.20.78.16] (10.20.78.16) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Fri, 20 May 2016
 14:21:44 +0100
Date:   Fri, 20 May 2016 14:21:34 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Li Zefan <lizefan@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Building older mips kernels with different versions of binutils;
 possible patch for 3.2 and 3.4
In-Reply-To: <573936E3.3050003@roeck-us.net>
Message-ID: <alpine.DEB.2.00.1605161452100.6794@tp.orcam.me.uk>
References: <573936E3.3050003@roeck-us.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.16]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53559
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

Hi Guenter,

> building mips images with a consistent infrastructure is becoming more and
> more difficult.

 As the current MIPS binutils maintainer I am sorry to hear about this, 
and apologise for the state of affairs.  Of course I can't help with any 
sins of the past, but at least I can help straightening out the current 
situation and making sure that the most recent binutils work as expected.

> Current state is as follows.
> 
> Binutils/	2.22	2.24	2.25
> Kernel
> 3.2		X	-	-
> 3.4		X	-	-
> 3.10		X	X	-
> 3.14		X	X	-
> 3.16		X	X	-
> 3.18		X	X	(X) [1]
> 4.1		X	X	(X)
> 4.4		X	X	(X)
> 4.5		X	X	(X)
> 4.6		X	X	(X)
> next		-	X	(X)
> 
> [1] (at least) allnoconfig fails to build with binutils 2.25 (2.25.1, more
> specifically).
> 
> I used the following toolchains for the above tests:
> - Poky 1.3 (binutils 2.22)
> - Poky 2.0 (binutils 2.25.1)
> - gcc-4.6.3-nolibc from kernel.org (binutils 2.22)
> - gcc-4.9.0-nolibc from kernel.org (binutils 2.24)
> 
> For 3.4 and 3.2 kernels to build with binutils v2.24, it would be necessary to
> apply patch c02263063362 ("MIPS: Refactor 'clear_page' and 'copy_page'
> functions").

 Mind that this change is really only needed to build microMIPS kernels, 
only required for pure microMIPS hardware, i.e. processors which do not 
support regular (aka AD 1985 classic) MIPS execution at all -- have you 
been building such configurations?  For mixed-mode processors a regular 
MIPS kernel will do as it'll handle microMIPS userland just fine.

 Or is there a hidden catch in this change beyond what's been stated in 
the commit description?

> It applies cleanly to 3.4, but has a Makefile conflict in 3.2. It might
> make sense to apply this patch to both releases. Would this be possible ?
> This way, we would have at least one toolchain which can build all 3.2+
> kernels.

 If you send me messages from build errors you think may be caused by an 
incompatibility between the most recent binutils and kernel code, along 
with a kernel GIT commit ID, then I'll investigate and see if this is a 
problem on the binutils or the kernel side.  I may need to ask for .config 
in the process.  If you have problems with older binutils, then I just 
*might* be able to provide advice or a workaround, but my capabilities 
beyond that may be limited, I'm a limited resource after all.

  Maciej
