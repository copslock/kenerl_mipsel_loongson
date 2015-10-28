Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 20:04:58 +0100 (CET)
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37828 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011628AbbJ1TEzkBzpj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2015 20:04:55 +0100
Received: by wmff134 with SMTP id f134so11217129wmf.0
        for <linux-mips@linux-mips.org>; Wed, 28 Oct 2015 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alex-smith_me_uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qsgVLDrKNKcIMD161sjVb43EDvQPkp454SEr2ND59tI=;
        b=Tbj5XGZc4fGo8tFJtkFZ/Us2sSXCd2uKwVKzxgtu28e7HZLJLMGlo48LDcf0MDiHCN
         JYGu4oac15CGKQgte27Xp0M4hM8CdOQ8tTyhRAYVXAChIksgUmRI/krHv0Fc5i7+4t3r
         8Z28ep6WIrJ5hG8mG7Ey+fLbOh1i0t405UQMSolpzEgWzneXv7gLjMWpIGbP7LOatrzh
         u8tqXR3lJP8wvFiTNp7SkUGuCX+Oy8S2jlQbF2ANn2yiM1rJWJ2zXR2/g03Pxyk5qYsG
         iW4Cq1W/T/UEN4veuevr4qKZQPawpVVH0SCC7VoB5cCnA+IAETozhmyYoLHLCjZjhYxE
         95mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qsgVLDrKNKcIMD161sjVb43EDvQPkp454SEr2ND59tI=;
        b=d/gPj3K/0Ip+7NqsDIQV0PB+DB3t/EV1sd3IV3c4+/IW2MFLKybPn57Ob43OoV4sND
         YWgOTcbasJvMITxyCJ6x+pApitWVe4XDv3u73p9q3kcODqseG2zuzkbMJSbzXOUZ8TG5
         dUNChUNSOCRXoujDqYXuAY4lSUCz3+PeXM5MdTk6mWemkLdqSDIk5D35F7Bb9LswoBlr
         S3wL47d6Ns7qOah5DdPHUZUCHUgZHRq/si0/aZy8rSN7criUnsnqObQGshI7SwtV3dTP
         hbb5YPbFPw4JIIUIn5gt3rmFarCpljTYap8TzU+f6HaSy/hSBJub5Gkwi3H2iL7X9Ub/
         vlow==
X-Gm-Message-State: ALoCoQkh2QnK64W0CYyfXOGxez9j0raTP/0X/cO5QGGySXvmjwhNPj0xiaKSd9U+JNGHLKsAgIqP
MIME-Version: 1.0
X-Received: by 10.28.51.70 with SMTP id z67mr2165209wmz.25.1446059090362; Wed,
 28 Oct 2015 12:04:50 -0700 (PDT)
Received: by 10.27.11.144 with HTTP; Wed, 28 Oct 2015 12:04:50 -0700 (PDT)
In-Reply-To: <56311AA9.6040101@imgtec.com>
References: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com>
        <5629904A.2070400@imgtec.com>
        <20151027144748.GA23785@linux-mips.org>
        <562FE29C.8040106@imgtec.com>
        <562FE678.2030307@gmail.com>
        <562FE96C.3070002@imgtec.com>
        <562FF05A.508@gmail.com>
        <562FF15A.1050507@imgtec.com>
        <CAOFt0_AFnR0MF2e8rRXhz_wkiGbL2VTFy=AXpcmWTZ9_bYA=VQ@mail.gmail.com>
        <56311231.10503@imgtec.com>
        <CAOFt0_C3QXKrZ-uta_RrR04hFMbQnNdfoJP7pZjoSSUftc7dCQ@mail.gmail.com>
        <56311AA9.6040101@imgtec.com>
Date:   Wed, 28 Oct 2015 19:04:50 +0000
Message-ID: <CAOFt0_AvGQcxHAToEevTFt5JGiuhN03XnPxxjQizbZ3dC-06mg@mail.gmail.com>
Subject: Re: [v3, 3/3] MIPS: VDSO: Add implementations of gettimeofday() and clock_gettime()
From:   Alex Smith <alex@alex-smith.me.uk>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
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

On 28 October 2015 at 18:57, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com> wrote:
> On 10/28/2015 11:30 AM, Alex Smith wrote:
>>
>> On 28 October 2015 at 18:21, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> wrote:
>>>
>>>
>>>
>>> 1) I don't see that in code - there is no check that kernel uses actually
>>> uses R4K clocksource as primary (A), and if kernel uses R4K count as a
>>> clocksource and later switches to some more precise clocksource then there
>>> is no change in VDSO gettimeofday handling (B).
>>
>> Incorrect. The vdso_clock_mode flag in arch_clocksource_data that I
>> mentioned in my previous email is copied into the VDSO data page by
>> update_vsyscall(), which is called when the clocksource changes.
>
>
> OK, I see this, good.
>
>>
>>> 2) The fact that MIPS kernel as today uses CP0_COUNT in any core as the
>>> same clocksource is correct only until first power saving event with CPU
>>> clock disabled (skipping Octeon). After that it is an incorrect use without
>>> an accurate synchronization and that synchronization doesn't exist.
>>>
>>> And I remember that today kernel uses only CPU0 CP0_COUNT to update
>>> time... may be wrong, need to check, but that could be a good code.
>>>
>>>> Maybe I'm missing something but I don't see anything in the generic
>>>> timekeeping code that handles the same clocksource being
>>>> unsynchronised or running at a different rate on different CPUs.
>>>
>>>
>>> (I would like to skip here the generic timekeeping code capabilities,
>>> just to restrict a discussion to HW capabilities)
>>>
>>>> Given that, if you think there is an issue that prevents the VDSO from
>>>> using it then that would surely affect the kernel as well and needs to
>>>> be fixed separately?
>>>>
>>>> If it really is necessary to prevent the VDSO from using a certain
>>>> clocksource even though the kernel is using it, it should be a simple
>>>> matter of setting clocksource.archdata.vdso_clock_mode to
>>>> VDSO_CLOCK_NONE. This is how this patch stops it using the CP0 count
>>>> when RDHWR is broken.
>>>
>>>
>>> OK, just put kernel-build time check that it is not SMP without GIC
>>> clocksource or it is Octeon. It would be enough to stop a mess.
>>
>> If you feel it's necessary then please do.
>
>
> Please resend a patch with this fix.

As I've explained the VDSO will only use the CP0 counter in the same
situations that the kernel would when it is the active clocksource.
Any issue that makes the counter unreliable affects the kernel as well
and is unrelated to the VDSO, so a fix does not belong in this patch.

Alex

>
> - Leonid.
