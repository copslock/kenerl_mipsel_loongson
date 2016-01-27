Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 21:29:43 +0100 (CET)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35807 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011828AbcA0U3kgsgFN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 21:29:40 +0100
Received: by mail-oi0-f52.google.com with SMTP id p187so13345056oia.2
        for <linux-mips@linux-mips.org>; Wed, 27 Jan 2016 12:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FPRZr0KAR4F952/dY3oU149IheGj+qRHaQwFmLeg3WA=;
        b=BojvhHPgJo0/Vw5uIdKU1IcsWIkpF0cDDm0pTX2SNRmdzln6Cdco8lfaAWK15VtDZU
         Nv2NilW+yzqYVBiLHGIxavHAkQZDNswtoEeEye1KFUEt37r1ELOOqg+ByV/XfgLFRR0a
         sIaLofQlQlQgrluKf9TmsgARiHJcRQxSO/wFj2OH+9ZVziJUlkuLCOhvYCSazofyMWfg
         MpIG8HvltntAmTesNIW85rGmZk2zrQj4ZNL+CDrcN58I1AjkudyH6ZLfyNmeqsQAf3vu
         UAno4FbyuN6ZQWEg1ykNk1YQJNI4RuuTiWCQnedmfHbg0K8cYvKOfdE3+eNdkVEF8hQC
         rIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=FPRZr0KAR4F952/dY3oU149IheGj+qRHaQwFmLeg3WA=;
        b=Zzn3YrRsWK8QjLJbXI9EuLTB9ajmYvbGxCBrYBCdh90Xz5bGkDGQb8Cz6P4hB7srkj
         dWw2eBx2S0F2UkS4nOva/q260ROBNnMKDRs2B5T8MTqwr+9EiIVnGOf5lnXW5VhwXjwl
         z4CtwOIkwcKYCIgQLEAazyn0IcMlzrINrm9zcDOg656w9zrUTdFbTf8/yhrmUuhGwolb
         8RZDR6Ub3r4/Jm0G7nlSb0dLa3enJzKALlRH+RW9c0cyRpM7j/FuWtfFGNZqrS+pThpA
         lS5CmqdkEGVIn1z8PHoh6PMu0Q1DC7l40/lTMyJF52dmeKx4P2g6UALXmOtexdGjhGBZ
         facg==
X-Gm-Message-State: AG10YOS2ZerdQGMBZ2Vu+gn1E3CPoV6bWFLqKFtT4FpmMl3Gu6fTgYznR3nxeMlgIid5I5xc5qA0LTsArkXkNbsU
X-Received: by 10.202.212.208 with SMTP id l199mr23500497oig.43.1453926574443;
 Wed, 27 Jan 2016 12:29:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.202.102.231 with HTTP; Wed, 27 Jan 2016 12:29:14 -0800 (PST)
In-Reply-To: <CAKdAkRQm6ADz5aCYAFxXcoGZ2zNFwTUXjMzZdNj-D2-YrYQtrg@mail.gmail.com>
References: <cover.1453759363.git.luto@kernel.org> <64480084bc652d5fa91bf5cd4be979e2f1e4cf11.1453759363.git.luto@kernel.org>
 <CAKdAkRQm6ADz5aCYAFxXcoGZ2zNFwTUXjMzZdNj-D2-YrYQtrg@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 27 Jan 2016 12:29:14 -0800
Message-ID: <CALCETrUUNM1Qoqna1e7qmEqNUwo99PJe9fSuXG4fzPdSBLfPuA@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] input: Redefine INPUT_COMPAT_TEST as in_compat_syscall()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-parisc@vger.kernel.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Wed, Jan 27, 2016 at 11:17 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Andy,
>
> On Mon, Jan 25, 2016 at 2:24 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> The input compat code should work like all other compat code: for
>> 32-bit syscalls, use the 32-bit ABI and for 64-bit syscalls, use the
>> 64-bit ABI.  We have a helper for that (in_compat_syscall()): just
>> use it.
>>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>  drivers/input/input-compat.h | 12 +-----------
>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/drivers/input/input-compat.h b/drivers/input/input-compat.h
>> index 148f66fe3205..0f25878d5fa2 100644
>> --- a/drivers/input/input-compat.h
>> +++ b/drivers/input/input-compat.h
>> @@ -17,17 +17,7 @@
>>
>>  #ifdef CONFIG_COMPAT
>>
>> -/* Note to the author of this code: did it ever occur to
>> -   you why the ifdefs are needed? Think about it again. -AK */
>> -#if defined(CONFIG_X86_64) || defined(CONFIG_TILE)
>> -#  define INPUT_COMPAT_TEST is_compat_task()
>> -#elif defined(CONFIG_S390)
>> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_31BIT)
>> -#elif defined(CONFIG_MIPS)
>> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_32BIT_ADDR)
>> -#else
>> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_32BIT)
>> -#endif
>> +#define INPUT_COMPAT_TEST in_compat_syscall()
>>
>
>
> If we now have function that works on all arches I'd prefer if we used
> it directly instead of continuing using INPUT_COMPAT_TEST.

I'll write a followup patch for that if you don't beat me to it.

--Andy
