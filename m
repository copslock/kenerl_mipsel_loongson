Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 16:43:09 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57593 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491182Ab0HROnF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Aug 2010 16:43:05 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o7IEh12t028519;
        Wed, 18 Aug 2010 15:43:01 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o7IEh1Hk028517;
        Wed, 18 Aug 2010 15:43:01 +0100
Date:   Wed, 18 Aug 2010 15:43:01 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     naveen yadav <yad.naveen@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: kmalloc issue on MIPS target
Message-ID: <20100818144301.GC2849@linux-mips.org>
References: <AANLkTiniH42L=-DdJ_XHOm1Uo_=YoAqE-j9Jrm45imtG@mail.gmail.com>
 <20100818133336.GA25740@linux-mips.org>
 <AANLkTin8LLH3DkX38B93Ap0mmz4hb9e=cEo9U3ZKmavr@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTin8LLH3DkX38B93Ap0mmz4hb9e=cEo9U3ZKmavr@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 18, 2010 at 07:56:16PM +0530, naveen yadav wrote:

> I will give more info.
> 
> CONFIG_MIPS_L1_CACHE_SHIFT=5
> 
> CONFIG_DMA_NONCOHERENT=y
> 
> mips 34kc is processor
> 
> and File we are using is  arch/mips/include/asm/mach-generic/kmalloc.h
> 
> #ifndef __ASM_MACH_GENERIC_KMALLOC_H
> #define __ASM_MACH_GENERIC_KMALLOC_H
> 
> 
> #ifndef CONFIG_DMA_COHERENT
> /*
>  * Total overkill for most systems but need as a safe default.
>  * Set this one if any device in the system might do non-coherent DMA.
>  */
> #define ARCH_KMALLOC_MINALIGN   128
> #endif
> 
> #endif /* __ASM_MACH_GENERIC_KMALLOC_H */
> 
> 
> So shall we make value ARCH_KMALLOC_MINALIGN   from 128 to 32. is
> there any problem ?

No, that's just what you should do.  You do that by putting a file
that defines ARCH_KMALLOC_MINALIGN into your platforms's
arch/mips/include/asm/mach-<yourplatform>/kmalloc.h just like the ip32
file from your original posting.

  Ralf
