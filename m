Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 19:06:08 +0100 (CET)
Received: from mail-vc0-f180.google.com ([209.85.220.180]:62463 "EHLO
        mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008422AbbCISGFnKa0K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2015 19:06:05 +0100
Received: by mail-vc0-f180.google.com with SMTP id hq12so5612247vcb.11
        for <linux-mips@linux-mips.org>; Mon, 09 Mar 2015 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rNNWmW0CNKuzmhIOi3Ms1zFdd8uAE6RecflmGCXvYXE=;
        b=CQyYFDdkSLm1tmyiwQyjpxmloLhS3NbK9l6fyOwWU7chlT+AXtlGRYYUg0WFbNqryS
         eHTE4Cbtgs3+nKUbVk5v04ecYMD18PXaf7L7NnjBxyszSE9Ob9Cddh2n1OnZnFgi8vbw
         XBQfGU9YX+7wpJ0eBd5v5Q045R/h5qxjQtOuaAvvpXTnEcDeqMUdBfRR+ecQzVU84BMv
         sPF7Q9HQUBeZc+4E3QZnDs2fxppvC415vI3anqlMra4uVfZHanuhjC04Lz2+1TcX9vo1
         KIvBBlviEU8TcZV+yOw4h/QSZL8Cnho09Ot9s4whDcFJyKQtzhXBbHC5CcL/8SqzfQLW
         XmNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rNNWmW0CNKuzmhIOi3Ms1zFdd8uAE6RecflmGCXvYXE=;
        b=c7V6xregoXn+0IfYcggewe3vY02gubrCXxxqeKuAt154ZMCrGAjNXJy/IM3YorVXKi
         wU946gFaDeTEq8Xq4WNzFByHUecuZkFzYvKxDhM9jX0QY8up/k+ne6RQ5fBPHLuoFJQ8
         nmmSTktemx74vDvc5D2MMObiDR+ZOUYMcZq4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rNNWmW0CNKuzmhIOi3Ms1zFdd8uAE6RecflmGCXvYXE=;
        b=AWFyXuxMBQYjFsr+6DcJ91tC6wXW/R7XIrjM4xeU2yHkevybCW4T1PKZt1s2aodCOd
         KqeXldV7SgCEP6Zv6gxTZFaRhx0RsgGzBEUh+ZqLcu6eF1PhBdvNcAocmzTUpw477+y8
         psgPq1OgnEyQHdOqD0s0Osg3q7oYtcT+Bzyj+YsWAcHGKKXJgkcP74+7VZQ+YnWaByM2
         B37Qho1PQfP52PPEz501wdWKqexJT8L5et8m/9yRe+kRp5shaVT47PmZS7nePbMG2HMR
         txE8EaDPdYnCju/Q1FLqQuUh4Bik1Gwf8CPP6NinGql//mWvMIxWv7MuVxRofQDEQjnD
         4rCw==
X-Gm-Message-State: ALoCoQmeNnLuq9VeB0u9OPT4Kdb3fqG/h2hqdAy3ebLwwga69ereFU4wbLWCSmmN6vETG/AOdqEy
MIME-Version: 1.0
X-Received: by 10.52.109.227 with SMTP id hv3mr35156521vdb.22.1425924360426;
 Mon, 09 Mar 2015 11:06:00 -0700 (PDT)
Received: by 10.52.172.35 with HTTP; Mon, 9 Mar 2015 11:06:00 -0700 (PDT)
In-Reply-To: <20150309161912.GW8656@n2100.arm.linux.org.uk>
References: <1425435025-30284-1-git-send-email-keescook@chromium.org>
        <20150309161912.GW8656@n2100.arm.linux.org.uk>
Date:   Mon, 9 Mar 2015 11:06:00 -0700
X-Google-Sender-Auth: 2Cl8mu5yMy1_cbDkqQY_Z3VpL0I
Message-ID: <CAGXu5jK=bEQDao+QZN7AZuVi0FB_+AsT4LAPodVZg3VTK=Pi-A@mail.gmail.com>
Subject: Re: [PATCH v3 0/10] split ET_DYN ASLR from mmap ASLR
From:   Kees Cook <keescook@chromium.org>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Ismael Ripoll <iripoll@upv.es>,
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
        Min-Hua Chen <orca.chen@gmail.com>,
        Dan McGee <dpmcgee@gmail.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Behan Webster <behanw@converseincode.com>,
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
X-archive-position: 46304
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

On Mon, Mar 9, 2015 at 9:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Mar 03, 2015 at 06:10:15PM -0800, Kees Cook wrote:
>> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
>> ASLR from mmap ASLR, as already done on s390. The architectures
>> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
>> and x86), have their various forms of arch_mmap_rnd() made available
>> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
>> arch_randomize_brk() is collapsed as well.
>>
>> This is an alternative to the solutions in:
>> https://lkml.org/lkml/2015/2/23/442
>>
>> I've been able to test x86 and arm, and the buildbot (so far) seems
>> happy with building the rest.
>
> Hmm, do you want to wrap my acks up to your previous one into this set?
> What about my tested-by?
>
> I'd rather not waste time testing this version if my previous test is
> still valid (or if there's yet another version of this patch set which
> is later than this set.)
>
> Unless I hear anything, I'll assume that it's broadly the same as the
> previous patch set and requires no action.

Yeah, it's broadly the same. I tweaked a few minor things, so I'm
comfortable retaining the acks and tested-bys. Thank you for the
reviews and tests!

-Kees

-- 
Kees Cook
Chrome OS Security
