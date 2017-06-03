Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 14:44:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11211 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991672AbdFCMoVpnXVK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 14:44:21 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 7CDBF74BB612E;
        Sat,  3 Jun 2017 13:44:12 +0100 (IST)
Received: from [10.20.78.110] (10.20.78.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Sat, 3 Jun 2017
 13:44:14 +0100
Date:   Sat, 3 Jun 2017 13:43:37 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Stuart Longland <stuartl@longlandclan.id.au>
CC:     <linux-mips@linux-mips.org>
Subject: Re: QEMU Malta emulation using I6400: runaway loop modprobe
 binfmt-464c
In-Reply-To: <996c275d-d969-508e-6b4e-bef22d8e7385@longlandclan.id.au>
Message-ID: <alpine.DEB.2.00.1706031310470.2590@tp.orcam.me.uk>
References: <996c275d-d969-508e-6b4e-bef22d8e7385@longlandclan.id.au>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.110]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58185
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

On Sat, 3 Jun 2017, Stuart Longland wrote:

> Now, on a single-processor MIPS64r2 VM, this same root filesystem works.
>  It won't work though for a 8-core I6400 system.  If I try to run a SMP
> MIPS64r2 VM, I get "unable to proceed without a CM", so clearly there is
> a feature in the I6400 that doesn't exist in the MIPS64r2.

 Your userland likely requires the legacy NaN encoding (as specified by 
the IEEE 754-1985 floating point standard) whereas I6400 hardware only 
supports the 2008 NaN encoding (as specified by the IEEE 754-2008 floating 
point standard), as per the R6 architecture requirement.  These encodings 
are incompatible with each other and all binaries are annotated in their 
ELF header as to which is required; use `readelf -h' and check `Flags:' 
for the presence of `nan2008' among the features reported.

 There are a couple of ways to move forward.

 First is rebuilding your userland for the 2008 NaN encoding.  I'm sure 
someone already did it, but I don't have a pointer at hand.  This might be 
the best option however.

 Second, since you're running on a simulator anyway, disabling the use of 
FPU hardware and using the Linux kernel FPU emulator should have little 
performance impact, although there surely be some for the Coprocessor 
Unusable exception handling overhead.  The Linux kernel FPU emulator 
supports both NaN encodings at once, so any userland will work 
irrespectively of which NaN encoding it requires and produce correct 
results.  Use the "nofpu" kernel parameter to activate this option.

 Finally, you might also ask the kernel to ignore the binary 
incompatibility and let binaries requiring the wrong NaN encoding run 
anyway.  This will make IEEE 754 floating point produce incorrect results 
in the uncommon case of software relying on NaN arithmetic; it may crash 
for example.  The vast majority of software does not rely on NaN 
arithmetic though.  Use the "ieee754=relaxed" kernel parameter to activate 
this option.

 You can have a look at Documentation/admin-guide/kernel-parameters.txt in 
the kernel sources for some further discussion about these kernel 
parameters.  These will have to be added to the QEMU's `-append' command 
line option.

 HTH,

  Maciej
