Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 19:30:40 +0100 (CET)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38507 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011688AbbJ1SajC9IPj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 19:30:39 +0100
Received: by wicll6 with SMTP id ll6so23078688wic.1
        for <linux-mips@linux-mips.org>; Wed, 28 Oct 2015 11:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alex-smith_me_uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nBMZi7zGOhNruqtUGV5t2MuphyiTIRW0ohw1KnoFnWY=;
        b=tp4HS0WGTMR69VwPP6c/TvKPgPq48n9MrDittfsjABoAaRKsy7sqXaZXIdp7BQvWap
         ptcjo/2izZO9aTGHN55F7nCdq0X8ACBO01ePiyjZZPbi/1ZUqdkT8j0M04UdejPsmsHA
         Urp5Mkqpq8WaZbGHvBP7JOUP3UeS0fjGZkOalag57rRWkwsBDCdYogjMUomTl1pDpEkf
         V9DVxaZKftyeE2ahWN5SVwj7z1mQGzLIoFzZfrZaqlGIg90bJSP8TxDWlHWfvlOsPSG/
         lWUHT2zr/OmXEp/VVEx2RBoNIULume/Iw0gszQrQ1I980/Q0Hk0kMSLdrwpdjRVar81z
         Bt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nBMZi7zGOhNruqtUGV5t2MuphyiTIRW0ohw1KnoFnWY=;
        b=ItP3jQIXKY/DNora9ADlGE9xX2/TRUc7DHzmYzDcXrUSacLl0BAVtLxUiOBkZ3lVKL
         aLyB6cPv8MTP8x0vXK9xANSr8gbSkXA2ZrmIiaWg3E3YjUmFEW2k1shzM6EN5QbcZnGC
         uemcDHqn8DLX+125OMeEc/qmj8vvo3WPgePZ6uOwADJIu+oqCPUWbU5cDPkDb9xlku45
         4C/yce66YbXTU6OlaxJmWoW8YWfnajWsc1cCwXdGodqQ4c00Nh7VpSybmXIY4mR6nNcq
         UBK3fwKOcs80js+q0t6k27XFqAv75ZhcWWZ4YkNoWvHljnTL6N1A7pNjgp0nvm7Rpq5k
         0Fbg==
X-Gm-Message-State: ALoCoQkBhfIizD/RL9Ta0KRpO3a538CFvrdDRhZYh32pDo3xnkC5tpnOBX0cVRON2DxYx+AOU26k
MIME-Version: 1.0
X-Received: by 10.194.115.100 with SMTP id jn4mr30589087wjb.155.1446057033799;
 Wed, 28 Oct 2015 11:30:33 -0700 (PDT)
Received: by 10.27.11.144 with HTTP; Wed, 28 Oct 2015 11:30:33 -0700 (PDT)
In-Reply-To: <56311231.10503@imgtec.com>
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
Date:   Wed, 28 Oct 2015 18:30:33 +0000
Message-ID: <CAOFt0_C3QXKrZ-uta_RrR04hFMbQnNdfoJP7pZjoSSUftc7dCQ@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49734
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

On 28 October 2015 at 18:21, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com> wrote:
>
> On 10/28/2015 03:20 AM, Alex Smith wrote:
>>
>> On 27 October 2015 at 20:46, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com> wrote:
>>>
>>> I believe, until this issue is fixed the R4K only CPU should be excluded
>>> from VDSO timing acceleration.
>>
>> The VDSO code will currently use the CP0 count whenever the kernel is
>> using it as its primary clocksource, aside from the case where RDHWR
>> is broken as it is on old QEMUs.
>
>
> 1) I don't see that in code - there is no check that kernel uses actually uses R4K clocksource as primary (A), and if kernel uses R4K count as a clocksource and later switches to some more precise clocksource then there is no change in VDSO gettimeofday handling (B).

Incorrect. The vdso_clock_mode flag in arch_clocksource_data that I
mentioned in my previous email is copied into the VDSO data page by
update_vsyscall(), which is called when the clocksource changes.

>
> 2) The fact that MIPS kernel as today uses CP0_COUNT in any core as the same clocksource is correct only until first power saving event with CPU clock disabled (skipping Octeon). After that it is an incorrect use without an accurate synchronization and that synchronization doesn't exist.
>
> And I remember that today kernel uses only CPU0 CP0_COUNT to update time... may be wrong, need to check, but that could be a good code.
>
>>
>> Maybe I'm missing something but I don't see anything in the generic
>> timekeeping code that handles the same clocksource being
>> unsynchronised or running at a different rate on different CPUs.
>
>
> (I would like to skip here the generic timekeeping code capabilities, just to restrict a discussion to HW capabilities)
>
>>
>> Given that, if you think there is an issue that prevents the VDSO from
>> using it then that would surely affect the kernel as well and needs to
>> be fixed separately?
>>
>> If it really is necessary to prevent the VDSO from using a certain
>> clocksource even though the kernel is using it, it should be a simple
>> matter of setting clocksource.archdata.vdso_clock_mode to
>> VDSO_CLOCK_NONE. This is how this patch stops it using the CP0 count
>> when RDHWR is broken.
>
>
> OK, just put kernel-build time check that it is not SMP without GIC clocksource or it is Octeon. It would be enough to stop a mess.

If you feel it's necessary then please do.

Thanks,
Alex

>
> - Leonid
>
