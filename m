Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 14:44:46 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:51580 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491159Ab0HRMom convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Aug 2010 14:44:42 +0200
Received: by qwe4 with SMTP id 4so475935qwe.36
        for <multiple recipients>; Wed, 18 Aug 2010 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=mB6daR4SBSm8/ADaDpthGxmSfH3phc2jfTCE8Jym4lA=;
        b=TW7BPBs5Y01gskbYipPmNfqVjbCSJBVEy6Nx2l5o7aoRUwkD3FkgxX0QPnOTS0B/fo
         z+F0uMVWI60hWE9rgjMPDfU+EorsXVQWKQeSYr+AdjkjFUhY5yioIlWaMWivgULwYKdX
         pXwCywdkfpgRWH/LtWh7q+F1ymY+zob8wBd5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=praK0m4I5liaNpO6beMB8EqNFCT3HEThrPhT44NOcQd8dd7jXBOAsGqpuWuXVJ2KIP
         VVNnaNYVPBrVjNjccbFBk6hVytuqzKy2vlz+vwVdO1DpBUpxn1t438pFnvDCRIz5nzjI
         nKulaxrIhhB0S8vfSOa+LnVLaYorkga7XW8Ls=
MIME-Version: 1.0
Received: by 10.224.19.140 with SMTP id a12mr5324730qab.333.1282135476905;
 Wed, 18 Aug 2010 05:44:36 -0700 (PDT)
Received: by 10.229.20.129 with HTTP; Wed, 18 Aug 2010 05:44:36 -0700 (PDT)
In-Reply-To: <AANLkTiniH42L=-DdJ_XHOm1Uo_=YoAqE-j9Jrm45imtG@mail.gmail.com>
References: <AANLkTiniH42L=-DdJ_XHOm1Uo_=YoAqE-j9Jrm45imtG@mail.gmail.com>
Date:   Wed, 18 Aug 2010 18:14:36 +0530
Message-ID: <AANLkTinZJ7kf=uxBrADcu=0-3pGUzJ3Pv5k1U2TmdzEU@mail.gmail.com>
Subject: Re: kmalloc issue on MIPS target
From:   naveen yadav <yad.naveen@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Aug 18, 2010 at 6:07 PM, naveen yadav <yad.naveen@gmail.com> wrote:
> Hi All,
>
> We are using MIPS(mips32r2) target. when I alloc memory using kmalloc
> suppose  28 bytes, the kernel still consume 128 bytes.
>
> So when I check File on kernel source  mach-ip32/kmalloc.h
>
> Since it is allign to 128 bytes so i understand that even if  I
> consume 1 byte it will waste 128 bytes.
>
> #ifndef __ASM_MACH_IP32_KMALLOC_H
> #define __ASM_MACH_IP32_KMALLOC_H
>
>
> #if defined(CONFIG_CPU_R5000) || defined(CONFIG_CPU_RM7000)
> #define ARCH_KMALLOC_MINALIGN   32
> #else
> #define ARCH_KMALLOC_MINALIGN   128
> #endif
>
> #endif /* __ASM_MACH_IP32_KMALLOC_H */
>
>
> So I could not understand why it is allign to 128 bytes. Is there any
> specific reason for it. ?
>
> thanks
>
