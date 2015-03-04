Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 22:13:32 +0100 (CET)
Received: from mail-vc0-f181.google.com ([209.85.220.181]:58345 "EHLO
        mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011567AbbCDVNUuWArW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 22:13:20 +0100
Received: by mail-vc0-f181.google.com with SMTP id le20so10008588vcb.12
        for <linux-mips@linux-mips.org>; Wed, 04 Mar 2015 13:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=95R31/UjCYfur6bjUOCV8CAM13GSvETyjVuPT3Jwjq4=;
        b=DZe1sze4JIygQpra4HQ6CHmqIJz1avW6s2hpghcwQPv/vqDMT98VDn4whvzwDWFIPz
         uWjwn7sVQAQaj6tkHn1ONaVe61G4/fcZZCyQsW0NmYSs6WGAq2yL/nYZUgTtipcMkLh1
         61cf1AeLhSFZzhbeX2c8LS/S+UGhr91DzO2RggzJQfbn1J76CXEy/TFiqUMNSwKEhtWr
         pibbT9pTuk/ziVaVfgqdxjWH9y0CtjbJyjoSXJiLlIzOHQC67rCDDm1UmfQAoGO8UWF3
         6PEGNOYpueV0ng4SnpYHq2skuRAf3EncnxaW71yY0pjsmbuOvF0mLcg2GjU1TjmvFGEn
         mndA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=95R31/UjCYfur6bjUOCV8CAM13GSvETyjVuPT3Jwjq4=;
        b=nuY74kV4vNaJFjIglnCpt1dYM5ALtLAYsXm2WIXuuHiOx9A+BGHfV/GeLapunFC/3E
         4WbAv9w/oQD6etqOzk0uofzYZuGfu2vhosNAk5Om6K1ywfzN40SYY1I+w7J/u1ylWf8A
         h24Aa2TbbjMc24mieX3FEK9L8CjPSoijg952s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=95R31/UjCYfur6bjUOCV8CAM13GSvETyjVuPT3Jwjq4=;
        b=EP5pNE/fD20Ki31auG9bV7tQttQ4DpGhX5HGtZTy1cc9RajSmLYtZUZX0XKFX4zm4R
         t+GY4EqLvPU5l76/lgDFQ7liEZ4TNef8uQ6VbzbjXHCTtJOOANExa+ZuStAa/ykDFoqe
         Zg/HLvkwlc4+CKK6osmh7H3h2evtxl2pTiTd/SK0rgGsK5NpNe735eGu3JuVnv6RmrqG
         rvjap2SEddMQxjWhzLXA8g1IGmk5wzYXEbLXY9dcqn8L6aAqOQe+1YJaVbPb0L0oZM77
         UjWx+5+0GjlM1dfpyJR72TadXlbU870eaH/4fHVru4ERJWHKIJtZmMiRfuyEFMVaNy3l
         4bHw==
X-Gm-Message-State: ALoCoQmdmx96nzAZSKWkgftNxE/fHWgYPytKF2+qLEK1szIdC3eKy6m/Gh8tlBzwJGmTP2qDKTj4
MIME-Version: 1.0
X-Received: by 10.52.12.169 with SMTP id z9mr9315390vdb.69.1425503595490; Wed,
 04 Mar 2015 13:13:15 -0800 (PST)
Received: by 10.52.172.35 with HTTP; Wed, 4 Mar 2015 13:13:15 -0800 (PST)
In-Reply-To: <1425442601.9084.9.camel@ellerman.id.au>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
        <1425341988-1599-5-git-send-email-keescook@chromium.org>
        <1425442601.9084.9.camel@ellerman.id.au>
Date:   Wed, 4 Mar 2015 13:13:15 -0800
X-Google-Sender-Auth: OJaRnlxc4eb8Zhqhzobq6mDFlc8
Message-ID: <CAGXu5j+Pu-xeCBcMZZqTgLfKss7Er0pfCxp04a4eWDWhuDryTQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: split ET_DYN ASLR from mmap ASLR
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
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
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46155
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

On Tue, Mar 3, 2015 at 8:16 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Mon, 2015-03-02 at 16:19 -0800, Kees Cook wrote:
>> This fixes the "offset2lib" weakness in ASLR for arm, arm64, mips,
>> powerpc, and x86. The problem is that if there is a leak of ASLR from
>> the executable (ET_DYN), it means a leak of shared library offset as
>> well (mmap), and vice versa. Further details and a PoC of this attack
>> are available here:
>> http://cybersecurity.upv.es/attacks/offset2lib/offset2lib.html
>>
>> With this patch, a PIE linked executable (ET_DYN) has its own ASLR region:
>>
>> $ ./show_mmaps_pie
>> 54859ccd6000-54859ccd7000 r-xp  ...  /tmp/show_mmaps_pie
>> 54859ced6000-54859ced7000 r--p  ...  /tmp/show_mmaps_pie
>> 54859ced7000-54859ced8000 rw-p  ...  /tmp/show_mmaps_pie
>
> Just to be clear, it's the fact that the above vmas are in a different
> address range to those below that shows the patch is working, right?

That's correct, yes. I've called this out explicitly now in the 9/10
patch in v4.

>
>> 7f75be764000-7f75be91f000 r-xp  ...  /lib/x86_64-linux-gnu/libc.so.6
>> 7f75be91f000-7f75beb1f000 ---p  ...  /lib/x86_64-linux-gnu/libc.so.6
>
>
> On powerpc I'm seeing:
>
> # /bin/dash
> # cat /proc/$$/maps
> 524e0000-52510000 r-xp 00000000 08:03 129814                             /bin/dash
> 52510000-52520000 rw-p 00020000 08:03 129814                             /bin/dash
> 10034f20000-10034f50000 rw-p 00000000 00:00 0                            [heap]
> 3fffaeaf0000-3fffaeca0000 r-xp 00000000 08:03 13529                      /lib/powerpc64le-linux-gnu/libc-2.19.so
> 3fffaeca0000-3fffaecb0000 rw-p 001a0000 08:03 13529                      /lib/powerpc64le-linux-gnu/libc-2.19.so
> 3fffaecc0000-3fffaecd0000 rw-p 00000000 00:00 0
> 3fffaecd0000-3fffaecf0000 r-xp 00000000 00:00 0                          [vdso]
> 3fffaecf0000-3fffaed20000 r-xp 00000000 08:03 13539                      /lib/powerpc64le-linux-gnu/ld-2.19.so
> 3fffaed20000-3fffaed30000 rw-p 00020000 08:03 13539                      /lib/powerpc64le-linux-gnu/ld-2.19.so
> 3fffc7070000-3fffc70a0000 rw-p 00000000 00:00 0                          [stack]
>
>
> Whereas previously the /bin/dash vmas were up at 3fff..

Fantastic! Thanks very much for testing!

>
> So looks good to me for powerpc.
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

I had a question in the powerpc-specific change that may have gone unnoticed:

Can mmap ASLR be safely enabled in the legacy mmap case here? Other archs
use "mm->mmap_base = TASK_UNMAPPED_BASE + random_factor".

Separate from this series, do you happen to know if this improvement
can be made, or if the legacy mmap on powerpc can't handle this?

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
