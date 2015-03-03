Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 19:03:29 +0100 (CET)
Received: from mail-vc0-f180.google.com ([209.85.220.180]:59089 "EHLO
        mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008012AbbCCSD2PvAV8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Mar 2015 19:03:28 +0100
Received: by mail-vc0-f180.google.com with SMTP id le20so7165982vcb.11
        for <linux-mips@linux-mips.org>; Tue, 03 Mar 2015 10:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HCG/Rcn/De1XIhPs3E6xlcAb1FACr+ruyEZGggJZ2DY=;
        b=XsY5ZvEOf5ozLtmZYC0irSs/UQ/OvTpa7XZDUl3H2PHyHVwP9rVm10nZgywDpi4J5x
         bwirt8iZ61JXuiCbdrZM8nQh2TybQgiAVDVFWJjx2Dk/npzxCeY0/DtdcoAhsYcGD68Z
         65IMD5IJbcw5KuAun9K4a90cuwts0Kf76VcxUUGmOSn9AU0HInynRj7Y/RSGiCT5n27m
         TaYx/qjCjdLtJsQcRw5ApPo09dWco40xhMuhj567kvF0qCDl6yh6M9eKvyNYVXS8coQd
         pIhtjCijlffXEQgDpZKwM5SnFthWEGqG7+PxM7UiZ5QA3IXFaqbcCl3aa7ow50HWOTCB
         byOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HCG/Rcn/De1XIhPs3E6xlcAb1FACr+ruyEZGggJZ2DY=;
        b=GGtAj2xIe9gRFxAjYW3VhOqbezcLYgmn5LqQ6IqndOogXzFbX1kxv/iTsA92SpGMrt
         MTMxQCS/+VSTaKQLrUsIJG9az6HSJMYUs+d3smVrmr6WzTFfeyK2ki1p3Nh3r/2ojc7E
         GVgX22A8G34OS1egBCUt154mvMiMLE+D7PHt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HCG/Rcn/De1XIhPs3E6xlcAb1FACr+ruyEZGggJZ2DY=;
        b=fSg97zpNcNM2zuzKybB/u3j0r67LKYN2I9aXpd3K10KqJeR9GnemqZpXrWgDT7zidy
         mnYosFnP+SlO4ypvSlfk8Wn1M9ZhnVI+rMVpJ8CVwkFk5XR+PhXPja9L1s1JFv0J181F
         yUfMFRSlkpVTvonBOEuUful4td/ysEOksA3GAabs9mNvIV1/CnO9HDpCtwBpI52qAQOG
         oJteJ0Nl5Vu/VHY7UZJem6caSM7oNDn9uI4xDTHyd3zhAWTI8ptGaLvDcG8kUa1skW3I
         lswJWdl/++pVmkaO4vh01/u1XTPskFD/QYMnGGWRny2Ma9HvGkRTi3u7J2KaBt1uR/tk
         FNbQ==
X-Gm-Message-State: ALoCoQmOOBNfUgMmbDdEZd+ZmedGAKMTBbrSr1vgodvNBxq0LiTQ6ds8z1/hSZDeRkvTA1a8ZPzY
MIME-Version: 1.0
X-Received: by 10.52.12.169 with SMTP id z9mr17836vdb.69.1425405803154; Tue,
 03 Mar 2015 10:03:23 -0800 (PST)
Received: by 10.52.116.135 with HTTP; Tue, 3 Mar 2015 10:03:22 -0800 (PST)
In-Reply-To: <20150303073132.GA30602@gmail.com>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
        <20150303073132.GA30602@gmail.com>
Date:   Tue, 3 Mar 2015 10:03:22 -0800
X-Google-Sender-Auth: se5ehG526z39YexVad368x3q8rY
Message-ID: <CAGXu5j+qJLeRx2xx=890OxHp8kjd=ws8zg3_JYPNJd_6p2xoYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] split ET_DYN ASLR from mmap ASLR
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "x86@kernel.org" <x86@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Borislav Petkov <bp@suse.de>,
        =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <dl9pf@gmx.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Mon, Mar 2, 2015 at 11:31 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kees Cook <keescook@chromium.org> wrote:
>
>> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
>> ASLR from mmap ASLR, as already done on s390. The architectures
>> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
>> and x86), have their various forms of arch_mmap_rnd() made available
>> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
>> arch_randomize_brk() is collapsed as well.
>>
>> This is an alternative to the solutions in:
>> https://lkml.org/lkml/2015/2/23/442
>
> Looks good so far:
>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
>
> While reviewing this series I also noticed that the following code
> could be factored out from architecture mmap code as well:
>
>   - arch_pick_mmap_layout() uses very similar patterns across the
>     platforms, with only few variations. Many architectures use
>     the same duplicated mmap_is_legacy() helper as well. There's
>     usually just trivial differences between mmap_legacy_base()
>     approaches as well.

I was nervous to start refactoring this code, but it's true: most of
it is the same.

>   - arch_mmap_rnd(): the PF_RANDOMIZE checks are needlessly
>     exposed to the arch routine - the arch routine should only
>     concentrate on arch details, not generic flags like
>     PF_RANDOMIZE.

Yeah, excellent point. I will send a follow-up patch to move this into
binfmt_elf instead. I'd like to avoid removing it in any of the other
patches since each was attempting a single step in the refactoring.

> In theory the mmap layout could be fully parametrized as well: i.e. no
> callback functions to architectures by default at all: just
> declarations of bits of randomization desired (or, available address
> space bits), and perhaps an arch helper to allow 32-bit vs. 64-bit
> address space distinctions.

Yeah, I was considering that too, since each architecture has a nearly
identical arch_mmap_rnd() at this point. Only the size of the entropy
was changing.

> 'Weird' architectures could provide special routines, but only by
> overriding the default behavior, which should be generic, safe and
> robust.

Yeah, quite true. Should entropy size be a #define like
ELF_ET_DYN_BASE? Something like ASLR_MMAP_ENTROPY and
ASLR_MMAP_ENTROPY_32? Is there a common function for determining a
compat task? That seemed to be per-arch too. Maybe
arch_mmap_entropy()?

-Kees

-- 
Kees Cook
Chrome OS Security
