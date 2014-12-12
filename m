Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 18:11:45 +0100 (CET)
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33110 "EHLO
        mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008105AbaLLRLniLTvu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 18:11:43 +0100
Received: by mail-ie0-f179.google.com with SMTP id rp18so7003345iec.24
        for <linux-mips@linux-mips.org>; Fri, 12 Dec 2014 09:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=QJFNbbmqpxF8ZydU/EEFq5RzqLHKifT+6faCGBGtzqA=;
        b=ZuXwigB+MpicsOT7ceOtXHNuZYp+EA2YaWFtmSR4Vryo9jAMv9OEJPYhHL+W22XOVa
         IzQZhlegPbKOpI8bq0OTOubavG/Zw7CsXR5ZKfn/Z/oNy43ZPCwV8xoG2NJe/uPXPQSp
         jqImhtq6iGiRk80AQxsHvn9rHF6og+5h+zZx/r4fV5OQcnkASOATXIDB8cssL0D82IPF
         DyNnT0qaOp6hirCKPs0xueDYR6IU6zIo52vG1uCXp7XUN/GUc5UT671dTeGvDspp5zkr
         6cp53aNBtj7o+HRm/g29xY/wRUrbTprr4nqmijML8cAIizUMHLBNVFNsS3DHErdffDOq
         d8Zg==
X-Received: by 10.50.143.101 with SMTP id sd5mr5757455igb.40.1418404297657;
        Fri, 12 Dec 2014 09:11:37 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id o185sm871171ioe.40.2014.12.12.09.11.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 09:11:37 -0800 (PST)
Message-ID: <548B21C8.7020409@gmail.com>
Date:   Fri, 12 Dec 2014 09:11:36 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Petr Malat <oss@malat.biz>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Provide correct siginfo_t.si_stime
References: <20141212142800.GA4176@bordel.klfree.net>
In-Reply-To: <20141212142800.GA4176@bordel.klfree.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 12/12/2014 06:28 AM, Petr Malat wrote:
> From: Petr Malat <oss@malat.biz>
>
> Provide correct siginfo_t.si_stime on MIPS64
>
> Bug description:
> MIPS version of copy_siginfo() is not aware of alignment on platforms with
> 64-bit long integers, which leads to an incorrect si_stime passed to signal
> handlers, because the last element (si_stime) of _sifields._sigchld is not
> copied. If _MIPS_SZLONG is 64, then the _sifields starts at the offset of
> 4 * sizeof(int).
>
> Patch description:
> Use the generic copy_siginfo, which doesn't have this problem.
>

Please state how this patch effects binary compatibility with previous 
releases of the kernel.

Thanks,
David Daney



> Signed-off-by: Petr Malat <oss@malat.biz>
> ---
> Please put me on CC, I'm not signed into the mailing list.
>
> diff -Naurp linux-3.18/arch/mips/include/asm/siginfo.h linux-3.18-new/arch/mips/include/asm/siginfo.h
> --- linux-3.18/arch/mips/include/asm/siginfo.h	2014-12-07 23:21:05.000000000 +0100
> +++ linux-3.18-new/arch/mips/include/asm/siginfo.h	1970-01-01 01:00:00.000000000 +0100
> @@ -1,29 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - *
> - * Copyright (C) 1998, 1999, 2001, 2003 Ralf Baechle
> - * Copyright (C) 2000, 2001 Silicon Graphics, Inc.
> - */
> -#ifndef _ASM_SIGINFO_H
> -#define _ASM_SIGINFO_H
> -
> -#include <uapi/asm/siginfo.h>
> -
> -
> -/*
> - * Duplicated here because of <asm-generic/siginfo.h> braindamage ...
> - */
> -#include <linux/string.h>
> -
> -static inline void copy_siginfo(struct siginfo *to, struct siginfo *from)
> -{
> -	if (from->si_code < 0)
> -		memcpy(to, from, sizeof(*to));
> -	else
> -		/* _sigchld is currently the largest know union member */
> -		memcpy(to, from, 3*sizeof(int) + sizeof(from->_sifields._sigchld));
> -}
> -
> -#endif /* _ASM_SIGINFO_H */
> diff -Naurp linux-3.18/arch/mips/include/uapi/asm/siginfo.h linux-3.18-new/arch/mips/include/uapi/asm/siginfo.h
> --- linux-3.18/arch/mips/include/uapi/asm/siginfo.h	2014-12-07 23:21:05.000000000 +0100
> +++ linux-3.18-new/arch/mips/include/uapi/asm/siginfo.h	2014-12-11 17:11:36.698056810 +0100
> @@ -16,13 +16,6 @@
>   #define HAVE_ARCH_SIGINFO_T
>
>   /*
> - * We duplicate the generic versions - <asm-generic/siginfo.h> is just borked
> - * by design ...
> - */
> -#define HAVE_ARCH_COPY_SIGINFO
> -struct siginfo;
> -
> -/*
>    * Careful to keep union _sifields from shifting ...
>    */
>   #if _MIPS_SZLONG == 32
> @@ -35,8 +28,9 @@ struct siginfo;
>
>   #define __ARCH_SIGSYS
>
> -#include <asm-generic/siginfo.h>
> +#include <uapi/asm-generic/siginfo.h>
>
> +/* We can't use generic siginfo_t, because our si_code and si_errno are swapped */
>   typedef struct siginfo {
>   	int si_signo;
>   	int si_code;
> @@ -120,5 +114,6 @@ typedef struct siginfo {
>   #define SI_TIMER __SI_CODE(__SI_TIMER, -3) /* sent by timer expiration */
>   #define SI_MESGQ __SI_CODE(__SI_MESGQ, -4) /* sent by real time mesq state change */
>
> +#include <asm-generic/siginfo.h>
>
>   #endif /* _UAPI_ASM_SIGINFO_H */
>
>
