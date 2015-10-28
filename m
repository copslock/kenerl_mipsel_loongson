Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 20:56:03 +0100 (CET)
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37542 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011767AbbJ1T4A4e6At (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2015 20:56:00 +0100
Received: by wmff134 with SMTP id f134so11827821wmf.0
        for <linux-mips@linux-mips.org>; Wed, 28 Oct 2015 12:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alex-smith_me_uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8B2WvyU0zPpGakVoaCtL+IZ9hZPojbdJjxNWSodX+LQ=;
        b=pu/NJ9dNzRO3L+UO19jWMUnPq+1WVkvb5u65+5Lo6xukSXtF4ZFvGcTKYmIQSGFyvS
         H+obu1IxDDuDJOrmzQHKw87OuRgm+9JLOIk1wS8KkV4iBV4RVHjyLBTqWO5ZGHjqScCV
         wVpuKkjTmycMNlBtaR3kaU2WJ+40WTplgAwrwMP8hloyOkGQFPpCqdDqAXH6mDWHkBAz
         M3jDiXvCEkHLRN5jZnXx0lBDJrXehgQnWPbr5uR21KaLgtwqcK+IyY8UKDws/hcnlehx
         qHFf0O+06FUYcDghDyVIDAZNP61ytxmG+4nMleaITagA102T46/Pe5MG6DCRd6/nW1Fw
         46ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8B2WvyU0zPpGakVoaCtL+IZ9hZPojbdJjxNWSodX+LQ=;
        b=jCb309LKs0/N16bm5zWpizIgJkKzfo2bkZV07/MO3FYFNqoq72lMqWplKD2KiQP7wT
         MQFCuSIzm6hBOZUWF/Qja40QPhOodHpt4df5hgiReu0BiseXmAaiMI4/hHsyA1NqCeGp
         9iJCX0BDN0L4bwaIsPKcs8Ax3Af1kHqdL5eOYgaJjKkEjV4yaUxKjkPY/TJVQxtxRkG8
         mu1esw2ayPMyN/zUMAmyrgigh5aZfWdPIEN2ca5VQslxksxm5bB7LgbxyvMtG/TwRzUl
         HYzCJ3IVwvbKrNyJqa9adAzKokPfshNHN1EEV2kb2DnzX29G0wRzUdwu4viDuaTmgaA6
         o0Vw==
X-Gm-Message-State: ALoCoQl0P/ObNhhEE/DgvoGY9z9sOrdPxF7Vc2N2aE91hKIABQixwo0Ggxdmmuq5zVlCmDdF6BRa
MIME-Version: 1.0
X-Received: by 10.28.8.129 with SMTP id 123mr2304140wmi.25.1446062155670; Wed,
 28 Oct 2015 12:55:55 -0700 (PDT)
Received: by 10.27.11.144 with HTTP; Wed, 28 Oct 2015 12:55:55 -0700 (PDT)
In-Reply-To: <563121D5.4030601@imgtec.com>
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
        <CAOFt0_AvGQcxHAToEevTFt5JGiuhN03XnPxxjQizbZ3dC-06mg@mail.gmail.com>
        <563121D5.4030601@imgtec.com>
Date:   Wed, 28 Oct 2015 19:55:55 +0000
Message-ID: <CAOFt0_DKfouP0r68M8S-CQF=Fk0C7sPpV2WNm=u-wH3_1q=Pzw@mail.gmail.com>
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
X-archive-position: 49739
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

On 28 October 2015 at 19:28, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com> wrote:
> On 10/28/2015 12:04 PM, Alex Smith wrote:
>>
>> On 28 October 2015 at 18:57, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> wrote:
>>>
>>>
>> As I've explained the VDSO will only use the CP0 counter in the same
>> situations that the kernel would when it is the active clocksource.
>> Any issue that makes the counter unreliable affects the kernel as well
>> and is unrelated to the VDSO, so a fix does not belong in this patch.
>
>
> What would you do if some SoC with different type of cores will define CPU1
> etc CP0_COUNT as a DIFFERENT clocksource from CPU0 (because of frequency
> etc)? Timekeeping can select CPU0 clocksource but code still uses a local
> CPU1 CP0_COUNT for gettimeofday().

Clocksources are not per-CPU. If the CP0 counter is the current
clocksource, then both the kernel and VDSO implementations of
gettimeofday will read out the CP0 counter from whatever CPU they run
on.

If in future there is some behaviour dependent on the current CPU in
the kernel gettimeofday implementation, then sure, something will need
to be done about it, but right now I see no issue that specifically
affects the VDSO code.

Alex

>
> And this kind of solution is the first in line to have an accurate timing in
> systems without GIC and with different clock frequencies.
>
> - Leonid
>
