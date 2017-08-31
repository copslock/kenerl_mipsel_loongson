Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Aug 2017 09:03:51 +0200 (CEST)
Received: from mail-io0-x229.google.com ([IPv6:2607:f8b0:4001:c06::229]:33109
        "EHLO mail-io0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991726AbdHaHDo5hwuO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Aug 2017 09:03:44 +0200
Received: by mail-io0-x229.google.com with SMTP id b2so2283503iof.0;
        Thu, 31 Aug 2017 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NUAlK+CnQjZoKlNb/annOt/6XCBtscJSjml/fseMgl8=;
        b=XAcEgRnOZcA6Q1Z49Ln6biYQFhTBnCrdbX6wdFiO7D0DULP0gDNdVVqTg1A+bgzawU
         pFmAZAbFV4ngsLdg0NJdTCpV5iU2S2P1aQ+np9Jn74wARcMfhVKLFEoziQqo3OTSnYV1
         tRG/y1LcOwzGXpGvRWrcJKNRcBhU+Adhx7rY3NWhDf5SAwUKuZbfWj8Om+oHl6IBW7bq
         D9/hOWiCLgcWw+3asSaJz0AW14opdbDo5sEpcd6z1QkPmSpfUWMIXQk0hlcSfWSAcNWk
         vtcSUknPv6Gdo7jBs8eDVKHD5RyHaRTYf1rWcm2QHKWt/YsT/znKueJanBfqA04k8By4
         6+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NUAlK+CnQjZoKlNb/annOt/6XCBtscJSjml/fseMgl8=;
        b=T+alRgP3p5ZsgEmv3hKUzPfegEnl4gH7Q6bQSJrgxrkG02ZiP9tfATA9BJLwxEvkYM
         Ip+jR955iD01PwH3fWWG3k9JT/WRm2/cTKo20/bcqG+tL+88/NrPqFEgYCKSqBAJmF/W
         RTVMwDMKv/FdPOHZxkUHlNeghdHJJuMX0TSP7zeVGMaMZbCUmrIYmjzQFac4BiLnn7Ym
         3qz+SCs8NGmHYh7WlvB6FEQrAY8RCXRinr2E2gBfkXW1/bF3mPK4ifJRYBCELWVz4bVF
         tdtuOzGAwb0mqKJ5SSGYNr264vxt2xzz/MCoFSmnt7bhLZXr/WH95s1o3c4Yi8VvB3C8
         2sZA==
X-Gm-Message-State: AHYfb5i2ThTipH8VMci6TMVEW4Bxp3OS3gykQLmXhWmLwNRCMCGPHmnB
        lJxhc25Z8YKBj7NdbEbqIzqGTTaSZw==
X-Received: by 10.36.65.222 with SMTP id b91mr4794979itd.121.1504163018985;
 Thu, 31 Aug 2017 00:03:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.77 with HTTP; Thu, 31 Aug 2017 00:03:38 -0700 (PDT)
In-Reply-To: <7e9037a6-195b-ca0f-75da-5a338c5e938d@imgtec.com>
References: <1503476475-21069-1-git-send-email-matt.redfearn@imgtec.com>
 <71ea8331-78da-c22b-d46d-99ab6c187bbf@nokia.com> <CAAhV-H7z82vsvdDc6Hfbp62KM6q72Z_bg6eUFdbK0azU2zmseg@mail.gmail.com>
 <7e9037a6-195b-ca0f-75da-5a338c5e938d@imgtec.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 31 Aug 2017 15:03:38 +0800
Message-ID: <CAAhV-H7TOEuFNz3ADRG_SR3LC-G0GjQsRLR4WLFMMp0+Uqh0dg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Revert "MIPS: Fix race on setting and getting cpu_online_mask"
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
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
X-archive-position: 59897
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

Yes, your original patch (8f46cca1e6c06) is needed in 4.12/4.13, but
they should be reverted in 4.1/4.4-stable branch.

Huacai

On Wed, Aug 30, 2017 at 9:24 PM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
> Hi Huacai,
>
> On 29/08/17 02:43, Huacai Chen wrote:
>>
>> I suggest to drop sync_r4k completely, because it is inaccurate. You
>> can use IPI to synchronize count/compare instead, as Loongson-3 does.
>
>
> I am all for a better fix, such as this - but that would be a much more
> invasive change than what I propose. Currently 4.13 is broken by the patch
> that this is attempting to revert. It is easy to deadlock the system by
> hotplugging a CPU while it is busy. That was what my patch 8f46cca1e6c06
> originally fixed. Even though it is, perhaps, not stylistically great to
> have the synchronisation done by callers, the fact is that it *is* done
> (added in 8df3e07e7f21f), so the behavior for 4.13 would be safe and
> deadlocks not possible. We can then look at more invasive changes that are
> acceptable to everyone during the 4.14 cycle.
>
> Thanks,
> Matt
>
>
>>
>> Huacai
>>
>> On Mon, Aug 28, 2017 at 6:07 PM, Matija Glavinic Pecotic
>> <matija.glavinic-pecotic.ext@nokia.com> wrote:
>>>
>>> On 08/23/2017 10:21 AM, Matt Redfearn wrote:
>>>>
>>>> As noted in the commit message, upstream differs in this area. The
>>>> hotplug code now waits on a completion event in bringup_wait_for_ap,
>>>> which is set by the starting CPU in cpuhp_online_idle once it calls
>>>> cpu_startup_entry. Thus there is no possibility of a race in upstream,
>>>> and this commit has only re-introduced the deadlock condition, which can
>>>> be observed on multiple platforms when running a heavy load test at the
>>>> same time as hotplugging CPUs. See commit 8f46cca1e6c06 ("MIPS: SMP: Fix
>>>> possibility of deadlock when bringing CPUs online") for details.
>>>
>>> I personally do not like the fact that synchronization is implicitly done
>>> by the callers, it is the reason why the patch was proposed. As noted
>>> before, it is enough someone checks cpu online mask somewhere in between and
>>> there is race again.
>>>
>>> How about moving synchronise_count_slave before setting the cpu online?
>>> Is there dependency it has to be done after completion?
>>>
>>> Regards,
>>>
>>> Matija
>>>
>
