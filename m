Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 15:33:43 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53075 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491184Ab0HRNdi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Aug 2010 15:33:38 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o7IDXanc026321;
        Wed, 18 Aug 2010 14:33:37 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o7IDXawF026319;
        Wed, 18 Aug 2010 14:33:36 +0100
Date:   Wed, 18 Aug 2010 14:33:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     naveen yadav <yad.naveen@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: kmalloc issue on MIPS target
Message-ID: <20100818133336.GA25740@linux-mips.org>
References: <AANLkTiniH42L=-DdJ_XHOm1Uo_=YoAqE-j9Jrm45imtG@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTiniH42L=-DdJ_XHOm1Uo_=YoAqE-j9Jrm45imtG@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 18, 2010 at 06:07:12PM +0530, naveen yadav wrote:

> To: majordomo@kvack.org, linux-mips@linux-mips.org

Your sentences are to complex for majordomo to understand.  Also its
area of expertise is generally limited to mailing list related issues.

> We are using MIPS(mips32r2) target. when I alloc memory using kmalloc
> suppose  28 bytes, the kernel still consume 128 bytes.
> 
> So when I check File on kernel source  mach-ip32/kmalloc.h
> 
> Since it is allign to 128 bytes so i understand that even if  I
> consume 1 byte it will waste 128 bytes.
> 
> #ifndef __ASM_MACH_IP32_KMALLOC_H
> #define __ASM_MACH_IP32_KMALLOC_H

Eh...  That's an IP32-specific header.  I have no idea why you're looking
at it.  It's not being used for your platform.

> So I could not understand why it is allign to 128 bytes. Is there any
> specific reason for it. ?

Each allocation needs some memory for kmalloc's internal bookkeeping,
the memory you actually asked for and for cacheline alignment.  For very
small allocations the later is likely to be larger than the other two
so will be the deciding factor in actual memory allocation.

The cacheline aligment results in better performance and on non-coherent
platforms such as probably yours it is necessary to get get DMA transfers
to work right.

It would appear that in your case CONFIG_MIPS_L1_CACHE_SHIFT is set to 7.
For a MIPS32-based platform (you didn' say what actual processor core!)
that appears to be an excessively large number.  32 bytes would be a more
typical figure.  Just check the kernel bootup messages for the cacheline
size if you don't know.

  Ralf
