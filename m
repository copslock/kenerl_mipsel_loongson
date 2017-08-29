Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 03:43:28 +0200 (CEST)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:34499
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994895AbdH2BnWVFBkb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 03:43:22 +0200
Received: by mail-io0-x241.google.com with SMTP id d81so1323008ioj.1;
        Mon, 28 Aug 2017 18:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=64JCY27RZ6jL3O9qC7NmrcT3y5aUlSCIAEJBad4xyl8=;
        b=deHv5B8mRcw01jsc80DhNLUe9SJ1GYG2x1UOm28+cx2AW1g43f5lplmVW7nNYj4Emo
         0yYsPWESdWvohnn3WgiMZb/HWOkQZPf4ZtFRb6VejeohUMSg43JPRhg5n/gic5jJQ60m
         uTdtKeQ+MGTh2Atd4OThi7+IA6eo8aKTSeFn4QVu3qpHF+q7JMP2zTgRsXKhWUUba1aM
         Q7gFxRvuGdHvjAfaFl0jFZ98N0gpyK1YI7ujnR7e/AGZX5K0IteucHzEufqxZIIYdBHm
         34fVFOxg+Nyz2Sfs3uC/Jkc+ayzWypnrppocU+T8W3qUHzm7n8nItYHEjaHRSz0xBZjQ
         cC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=64JCY27RZ6jL3O9qC7NmrcT3y5aUlSCIAEJBad4xyl8=;
        b=B4W7M4jrdFAZnbt1Wc7rvK3SvdrgsMIDEU+RaGckO4VPoyX9WKnAXSjFFIkZ1A7nLo
         z5HlKu7GyPU3xZvO2A+Is1zbt3g1AQeoVRF+86miZVHMHgbm52RUzA8GiCjq6Cp3bH1A
         /4Jsv+zrm2M4ZFsZVZiLPPRJ+4aRNXxTz+JC5MMriE1XK5CQprBRxCH5dHdUk4v0ymtD
         ixnaLF9noSw1dO1FFM2U6g6MAhggEeUAk59fC8bvtf38oqzQNdq/NC7dX3mhU+gWPQt6
         wFElYB5Jeja4RXop9F7BPEm4ekiB8uMWH1WNg2ownu1PjW4hncFkT0OXA0TXYLNwsNEd
         M4wg==
X-Gm-Message-State: AHYfb5hYRYzSmNGuEUDxiQoSXO8aWnzyoo+D1yz5whijyl1WwcAXjwz2
        uyrLQ1dLOuJvhDWRv0npcmslh2t9qg==
X-Received: by 10.36.50.82 with SMTP id j79mr2613757ita.108.1503970996550;
 Mon, 28 Aug 2017 18:43:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.183.75 with HTTP; Mon, 28 Aug 2017 18:43:15 -0700 (PDT)
In-Reply-To: <71ea8331-78da-c22b-d46d-99ab6c187bbf@nokia.com>
References: <1503476475-21069-1-git-send-email-matt.redfearn@imgtec.com> <71ea8331-78da-c22b-d46d-99ab6c187bbf@nokia.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 29 Aug 2017 09:43:15 +0800
Message-ID: <CAAhV-H7z82vsvdDc6Hfbp62KM6q72Z_bg6eUFdbK0azU2zmseg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Revert "MIPS: Fix race on setting and getting cpu_online_mask"
To:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

I suggest to drop sync_r4k completely, because it is inaccurate. You
can use IPI to synchronize count/compare instead, as Loongson-3 does.

Huacai

On Mon, Aug 28, 2017 at 6:07 PM, Matija Glavinic Pecotic
<matija.glavinic-pecotic.ext@nokia.com> wrote:
> On 08/23/2017 10:21 AM, Matt Redfearn wrote:
>> As noted in the commit message, upstream differs in this area. The
>> hotplug code now waits on a completion event in bringup_wait_for_ap,
>> which is set by the starting CPU in cpuhp_online_idle once it calls
>> cpu_startup_entry. Thus there is no possibility of a race in upstream,
>> and this commit has only re-introduced the deadlock condition, which can
>> be observed on multiple platforms when running a heavy load test at the
>> same time as hotplugging CPUs. See commit 8f46cca1e6c06 ("MIPS: SMP: Fix
>> possibility of deadlock when bringing CPUs online") for details.
>
> I personally do not like the fact that synchronization is implicitly done by the callers, it is the reason why the patch was proposed. As noted before, it is enough someone checks cpu online mask somewhere in between and there is race again.
>
> How about moving synchronise_count_slave before setting the cpu online? Is there dependency it has to be done after completion?
>
> Regards,
>
> Matija
>
