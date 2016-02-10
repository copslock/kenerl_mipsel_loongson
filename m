Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:36:05 +0100 (CET)
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38503 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012521AbcBJAbSU-obx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:31:18 +0100
Received: by mail-wm0-f49.google.com with SMTP id p63so6007234wmp.1
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DcvWfTR9tEq7H3OqMb7kpoki2n0LVEFxIVqCi3RRMog=;
        b=lHqOZRtMakjiYzyq0Ap3xu6yZPDcZlphE1Q5IvgAjUIEQEO2TGCUufUhI3hT119ydV
         6+7yb/QvUVIRTV3YKt/grOFnnn6u67RgUiXs3s0fODh26SQUT06FFcsWuEwskTYeR/Ak
         5GZbqnfl0lZvKcgasvuJ1xY28b7niaMqDhvp4tSS5IP+iV5fcXm2/2SpKIFEjR+352fH
         hhnTFBRUr4xH1Kn151vc5DanQAiqUvCdouAMb4GB/OT0Lw6tgudjUug+K16OoXm2glpQ
         kcZo5EUUjQiyYzYLjW8s49UVsvoetMQh73gvxU7cIKAFWfMLxLVgSn5W/QovKp3mO5CF
         iFhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DcvWfTR9tEq7H3OqMb7kpoki2n0LVEFxIVqCi3RRMog=;
        b=WZb+/tSI895MSKBRr7pkN5SunB6SvrwJDfJqbpoSKuSzaUM9Hl5XlC8srK1GmeX7TS
         3dCrXKgbrX59nZ+ce29yiv0mtr1Sgav2I6nhgSmJQQdmlqpz20tploSlKpYdI2YBXqCQ
         bWzsxgSbmtn8hUdJG1KOgjQJZx/RQkBWjji/1BsnD706DA2BhiKTHTmyYq2jNw8AX6/B
         gDzfi0vD7E78KLcBE2sbcCLzziF+lgcCTh+0G3+bEdUWPdMY2s/8DTSkI0knoj8LUgje
         HgRE11Y39Us9/n7yBQgHfzKaGXzx3AiBC7wKW+FYbPqozXVvPSUGe6bBZrhBT9wMeGit
         9c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-type;
        bh=DcvWfTR9tEq7H3OqMb7kpoki2n0LVEFxIVqCi3RRMog=;
        b=mLJWF4g8pAcG6SizXSufzeqdkWWhlA1Eom50N+i9yCtUOnSlCKZxX2xatuyEldlMq4
         05Q9sTdi67/uHi1BoaIFNyeUve2E9pcfcaIK5wRa1V0rgYMQ6G8i6A+ABQ6MfQhVU6PG
         FUE6Fn838oLaK3vGxp9NjwKYUvHE3USYbsdwBRQYzOLDW99/fubKyfqPAmCtjm30WIY+
         zHaeTeMnnjFg2qBsffMNzNxUfQ8Pv4u294giDQTPt77d+zJVz0X0t5G/c5cWhee8YM50
         kW4sQKCW3afCElTBEZ+MJGpxqwmAw+FTd+ViFcmHxP2Sq1M0+R7jJPfIW/vVn9QIuOcW
         jR4A==
X-Gm-Message-State: AG10YOSI3mTeQ1EELhMlNkj46QTUuvkGEQ5pn7mSFI1HHBPR2nZjBVLEFrYIuKvTqOPjrN/4lTfMvRaSlCVDNbT7
X-Received: by 10.28.103.197 with SMTP id b188mr7550568wmc.4.1455064270980;
 Tue, 09 Feb 2016 16:31:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.27.18 with HTTP; Tue, 9 Feb 2016 16:30:51 -0800 (PST)
In-Reply-To: <20160208153635.67df5ac2576138088a859087@linux-foundation.org>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
 <1454893743-6285-2-git-send-email-ddecotig@gmail.com> <20160208153635.67df5ac2576138088a859087@linux-foundation.org>
From:   David Decotigny <ddecotig@gmail.com>
Date:   Tue, 9 Feb 2016 16:30:51 -0800
X-Google-Sender-Auth: HdDQ4WsSwLTRJvScxN1-zZ8zBx8
Message-ID: <CAG88wWaA-pWcS8CnZykQxoWR4_jZxRhhEeOVQqNK_cOFo=VxFA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 01/19] lib/bitmap.c: conversion routines
 to/from u32 array
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        linux-mips@linux-mips.org, fcoe-devel@open-fcoe.org,
        Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@emulex.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Return-Path: <decot@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddecotig@gmail.com
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

thanks. done in v8 I am sending right now.

On Mon, Feb 8, 2016 at 3:36 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Sun,  7 Feb 2016 17:08:45 -0800 David Decotigny <ddecotig@gmail.com> wrote:
>
>> From: David Decotigny <decot@googlers.com>
>>
>> Aimed at transferring bitmaps to/from user-space in a 32/64-bit agnostic
>> way.
>>
>> Tested:
>>   unit tests (next patch) on qemu i386, x86_64, ppc, ppc64 BE and LE,
>>   ARM.
>>
>> @@ -1060,6 +1062,90 @@ int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
>>  EXPORT_SYMBOL(bitmap_allocate_region);
>>
>>  /**
>> + * bitmap_from_u32array - copy the contents of a u32 array of bits to bitmap
>> + *   @bitmap: array of unsigned longs, the destination bitmap, non NULL
>> + *   @nbits: number of bits in @bitmap
>> + *   @buf: array of u32 (in host byte order), the source bitmap, non NULL
>> + *   @nwords: number of u32 words in @buf
>> + *
>> + * copy min(nbits, 32*nwords) bits from @buf to @bitmap, remaining
>> + * bits between nword and nbits in @bitmap (if any) are cleared. In
>> + * last word of @bitmap, the bits beyond nbits (if any) are kept
>> + * unchanged.
>> + */
>
> This will leave the caller not knowing how many valid bits are actually
> present in the resulting bitmap.  To determine that, the caller will
> need to perform (duplicated) math on `nbits' and `nwords'.
>
>> +void bitmap_from_u32array(unsigned long *bitmap, unsigned int nbits,
>> +                       const u32 *buf, unsigned int nwords)
>
> So how about we make this return the number of valid bits in *bitmap?
>
>> +/**
>> + * bitmap_to_u32array - copy the contents of bitmap to a u32 array of bits
>> + *   @buf: array of u32 (in host byte order), the dest bitmap, non NULL
>> + *   @nwords: number of u32 words in @buf
>> + *   @bitmap: array of unsigned longs, the source bitmap, non NULL
>> + *   @nbits: number of bits in @bitmap
>> + *
>> + * copy min(nbits, 32*nwords) bits from @bitmap to @buf. Remaining
>> + * bits after nbits in @buf (if any) are cleared.
>> + */
>> +void bitmap_to_u32array(u32 *buf, unsigned int nwords,
>> +                     const unsigned long *bitmap, unsigned int nbits)
>
> Ditto.
>
>
