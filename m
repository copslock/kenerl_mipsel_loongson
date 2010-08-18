Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 16:26:26 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:46302 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491168Ab0HRO0X convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Aug 2010 16:26:23 +0200
Received: by qyk8 with SMTP id 8so692676qyk.15
        for <multiple recipients>; Wed, 18 Aug 2010 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M1d6XEdkkewfSxGV3R1NTfHbqE7YdhPYpchurj706Cs=;
        b=jIyYM53mHfZ59ZZyGOMCk184lri2Nu2vp+YWB4fT1DSGQ4/UyWNTVaYAZjFiOzWow+
         L2/lzjkspQO/BERpNfipbI64eoRBjJjFf+Y0/rlEO0r3CbwpV71olAcAYmsJCDIBx29X
         aHo4pkj0KK6lsB0yG7F7ubFhhTc65qadPuLyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WvS8lWtP22ossfR0MLk2zzrz7tjvqK31ZsRcfMS+1B0yn73wy83gf++FteQqYTtNi+
         zAD3D7f3LRg2g6bMSUWFZK5fHw+0RFDDrurhIvkqCtKx7c0X2AwvmxpCVKVbsyEyNAxC
         xrqEpq2V7xeaOhYp9k0NMnyuABSTIJMdYURcc=
MIME-Version: 1.0
Received: by 10.229.96.16 with SMTP id f16mr5975504qcn.255.1282141577135; Wed,
 18 Aug 2010 07:26:17 -0700 (PDT)
Received: by 10.229.20.129 with HTTP; Wed, 18 Aug 2010 07:26:16 -0700 (PDT)
In-Reply-To: <20100818133336.GA25740@linux-mips.org>
References: <AANLkTiniH42L=-DdJ_XHOm1Uo_=YoAqE-j9Jrm45imtG@mail.gmail.com>
        <20100818133336.GA25740@linux-mips.org>
Date:   Wed, 18 Aug 2010 19:56:16 +0530
Message-ID: <AANLkTin8LLH3DkX38B93Ap0mmz4hb9e=cEo9U3ZKmavr@mail.gmail.com>
Subject: Re: kmalloc issue on MIPS target
From:   naveen yadav <yad.naveen@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks a lot Mr. Ralf Baechle for Quick answer.

I will give more info.

CONFIG_MIPS_L1_CACHE_SHIFT=5

CONFIG_DMA_NONCOHERENT=y

mips 34kc is processor

and File we are using is  arch/mips/include/asm/mach-generic/kmalloc.h

#ifndef __ASM_MACH_GENERIC_KMALLOC_H
#define __ASM_MACH_GENERIC_KMALLOC_H


#ifndef CONFIG_DMA_COHERENT
/*
 * Total overkill for most systems but need as a safe default.
 * Set this one if any device in the system might do non-coherent DMA.
 */
#define ARCH_KMALLOC_MINALIGN   128
#endif

#endif /* __ASM_MACH_GENERIC_KMALLOC_H */


So shall we make value ARCH_KMALLOC_MINALIGN   from 128 to 32. is
there any problem ?


Thanks




On Wed, Aug 18, 2010 at 7:03 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Aug 18, 2010 at 06:07:12PM +0530, naveen yadav wrote:
>
>> To: majordomo@kvack.org, linux-mips@linux-mips.org
>
> Your sentences are to complex for majordomo to understand.  Also its
> area of expertise is generally limited to mailing list related issues.
>
>> We are using MIPS(mips32r2) target. when I alloc memory using kmalloc
>> suppose  28 bytes, the kernel still consume 128 bytes.
>>
>> So when I check File on kernel source  mach-ip32/kmalloc.h
>>
>> Since it is allign to 128 bytes so i understand that even if  I
>> consume 1 byte it will waste 128 bytes.
>>
>> #ifndef __ASM_MACH_IP32_KMALLOC_H
>> #define __ASM_MACH_IP32_KMALLOC_H
>
> Eh...  That's an IP32-specific header.  I have no idea why you're looking
> at it.  It's not being used for your platform.
>
>> So I could not understand why it is allign to 128 bytes. Is there any
>> specific reason for it. ?
>
> Each allocation needs some memory for kmalloc's internal bookkeeping,
> the memory you actually asked for and for cacheline alignment.  For very
> small allocations the later is likely to be larger than the other two
> so will be the deciding factor in actual memory allocation.
>
> The cacheline aligment results in better performance and on non-coherent
> platforms such as probably yours it is necessary to get get DMA transfers
> to work right.
>
> It would appear that in your case CONFIG_MIPS_L1_CACHE_SHIFT is set to 7.
> For a MIPS32-based platform (you didn' say what actual processor core!)
> that appears to be an excessively large number.  32 bytes would be a more
> typical figure.  Just check the kernel bootup messages for the cacheline
> size if you don't know.
>
>  Ralf
>
