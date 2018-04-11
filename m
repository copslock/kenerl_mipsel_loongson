Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Apr 2018 12:09:05 +0200 (CEST)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:46966
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbeDKKI6a3p63 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Apr 2018 12:08:58 +0200
Received: by mail-qk0-x244.google.com with SMTP id l16so290522qke.13
        for <linux-mips@linux-mips.org>; Wed, 11 Apr 2018 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=V5psy+kJgYxBotBWKaGcOBr64KsWORkUlVfiZW1FHHo=;
        b=gRcQ6DkvyJGIs12j48GEfQR2cOvab0hj1xA8P5qsqBWmbx818CTC9GsGJAkbsvzkNn
         Rs5nkSSexcB5955ZuZAc6eyIUH03Vix5PABSVSbjY+Q2gZeLeBNSRM15hWw9uIs2cAVN
         mlD0T0/1qDvYwMQdk6bbWjVjy8kZAd+N/qp4vu9GQ8LdmuGxbMXFkzp3+NrWtAB7N+1F
         bRZAb391qiQ/B3N3Jxumu61bVrPI2WAxXCHNuJgrOppFET+t96Xq/f808c5ZFuT5xvOT
         pVOJU4xfROIQcBEraUS/NHdmUpgNaWdELrwxaBXpyJcirZXfoH9+VWARK8MF/6byLqxN
         Cl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=V5psy+kJgYxBotBWKaGcOBr64KsWORkUlVfiZW1FHHo=;
        b=taL5rPBMeVAaa26wfU/CkuPNdXsd+xThv2zheTBdRJHKXj7+JT6+Q77UFMTQpHYpb6
         UrW3FMNDWhLAnen5aMvUsQ1AWFguhBECz/wYaTtTSRQqXe0E62qzigcw8jEkMC9icjhf
         YWleMQprY9khVCZ8//9aGfeQGgjb/nlCqFNhuSM9sbLtkEthWV6NHa0PQ4zB15Yuh3Yv
         LLWE7jI5DKcXU2CjNQJEn9Ob1wP369P3jKPCwNDwprB0xvK8jwNRqyvG/bzoWG5bS/Br
         jn4E2UXZiZtqePGLyXC4OBbuPGe0yCzsVcgNcydAoyR+Apzh3S6K5cCALzs7w5YRjH7m
         ygOQ==
X-Gm-Message-State: ALQs6tC91rzfiGYe4uAXrxAygmmyM9E1KvXi6M0YT9nIrn1mkv+Fn70T
        AxA6G47hxKQEFbWfoioTom5yDv0ttu/ZOrpOgjU=
X-Google-Smtp-Source: AIpwx4/XIE7Eu7VMfFWbZ/Jt7g4+Lk0pB9acjUYMqvnqSWnMPd40JpajmGBEh53gLkMTENHP8dRMi6lTOZ36NdsDoYA=
X-Received: by 10.55.225.16 with SMTP id c16mr5506435qkm.343.1523441332243;
 Wed, 11 Apr 2018 03:08:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.25 with HTTP; Wed, 11 Apr 2018 03:08:51 -0700 (PDT)
In-Reply-To: <20180411095359.GB21429@saruman>
References: <20171219114112.939391-1-arnd@arndb.de> <20180410224805.GA21429@saruman>
 <CAK8P3a0-_u7_FCj-nH0izBv4ub6krm1uA32bwi2jtBzXJePcnQ@mail.gmail.com> <20180411095359.GB21429@saruman>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Apr 2018 12:08:51 +0200
X-Google-Sender-Auth: t8Y5JFZ2ohjdioqhKh1Px9Qjymw
Message-ID: <CAK8P3a2_ihWCuUvDz_SVA1TMomkO1d7pa6e2bOQkZcEVP+Ff-A@mail.gmail.com>
Subject: Re: [PATCH] bug.h: Work around GCC PR82365 in BUG()
To:     James Hogan <jhogan@kernel.org>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Maciej Rozycki <macro@mips.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        Christopher Li <sparse@chrisli.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, Apr 11, 2018 at 11:54 AM, James Hogan <jhogan@kernel.org> wrote:
> On Wed, Apr 11, 2018 at 09:30:56AM +0200, Arnd Bergmann wrote:
>> On Wed, Apr 11, 2018 at 12:48 AM, James Hogan <jhogan@kernel.org> wrote:
>> > Before I forward port those patches to add .insn for MIPS, is that sort
>> > of approach (an arch specific asm/compiler-gcc.h to allow MIPS to
>> > override barrier_before_unreachable()) an acceptable fix?
>>
>> That sounds fine to me. However, I would suggest making that
>> asm/compiler.h instead of asm/compiler-gcc.h, so we can also
>> use the same file to include workarounds for clang if needed.
>
> Yes, though there are a few asm/compiler.h's already, and the alpha one
> includes linux/compiler.h before undefining inline, so seems to have its
> own specific purpose...

Interesting. For the other ones, including asm/compiler.h from linux/compiler.h
seems appropriate though, so the question would be what to do with the
alpha case. I think we can simply remove that header file and replace
it with this patch:

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index b2022885ced8..5502404f54cd 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -81,6 +81,9 @@ config PGTABLE_LEVELS
        int
        default 3

+config OPTIMIZE_INLINING
+       def_bool y
+
 source "init/Kconfig"
 source "kernel/Kconfig.freezer"

which should have the same effect.
