Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 May 2013 18:45:17 +0200 (CEST)
Received: from mail-vb0-f49.google.com ([209.85.212.49]:56240 "EHLO
        mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835041Ab3EBQpPCNw6h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 May 2013 18:45:15 +0200
Received: by mail-vb0-f49.google.com with SMTP id q12so636452vbe.22
        for <multiple recipients>; Thu, 02 May 2013 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=dKplJIN7d8dFqUYmvBcbPkMhZpHiZz591JWAY0WcDQs=;
        b=Q0zAzjVTzda0yK96jfxZMHBRHRf9Rwd4sJBblWdd0cTXB6PDP0u3nv9A/hoC864HkM
         4F9vdX3Awq8/7gQs2qCCPIE03bLYYWa3qKnRK3kfErPeLGa6R7wTd0NbPZkfU6epCp+N
         Rv97bT793vNXnN+Nto8Ps4lfzU/ZD9uAfHi1mnjOOjotUcrEuAsmR+j9QNkq31KwXJts
         gUyr6abknPu5YyXmuKOMEtzE5n+MtWWOTV4bWUM6XROs3DYE/37JsKAJzwIMSgnsWYWO
         1cSl7wSPqX6bC2IOqHPba4R0N9sZm/l2PueuiJIG42ZV5Lu66hfVWazGCUFm+ICWF1ym
         JKEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=dKplJIN7d8dFqUYmvBcbPkMhZpHiZz591JWAY0WcDQs=;
        b=HYS6oCvAfHNL0+hGwSs2gxK7eFjsEkHoTRCe7QhVU8OYL/plqvwLFlT8e13kH5vukD
         11G/NK0aA7joPLehfnS2TA+cVvvDTb2pR2Rz6Bsbw2I4UCv5BazPEhq2xTGYLf4BNSYR
         1PMzD7vzIYrG/GKigamIlOCpzfUjXcZ+0+R48=
MIME-Version: 1.0
X-Received: by 10.220.64.208 with SMTP id f16mr2466025vci.32.1367513108568;
 Thu, 02 May 2013 09:45:08 -0700 (PDT)
Received: by 10.220.186.197 with HTTP; Thu, 2 May 2013 09:45:08 -0700 (PDT)
In-Reply-To: <20130502145809.GA16236@linux-mips.org>
References: <20522420.158691367384219315.JavaMail.weblogic@epml17>
        <CAOiHx=mBPHmDse4EwL-+Fgmpz0=XhcgF_0nWdyvErFO4NU7E0Q@mail.gmail.com>
        <alpine.LFD.2.02.1305021241040.3972@ionos>
        <CAOiHx=mA-htk_2daeE9WpbEVV9YLvfLc1NYZZR=JeDdibchCnw@mail.gmail.com>
        <alpine.LFD.2.02.1305021527010.3972@ionos>
        <20130502145809.GA16236@linux-mips.org>
Date:   Thu, 2 May 2013 09:45:08 -0700
X-Google-Sender-Auth: Dy7Ks3KjiA-TAD5jlGa8KOJtMrk
Message-ID: <CA+55aFwDGyHOzu=Qh7SJOBK6QvAwAh7pMDL6LfMUE=AW_kapAw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Enable interrupts in arch_cpu_idle()
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jonas Gorski <jogo@openwrt.org>, eunb.song@samsung.com,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Thu, May 2, 2013 at 7:58 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> For a while we just used to live with the race condition resulting from
> not disabling interrupts in the idle loop.  Then c65a5480 fixed this by
> checking if we're returning to the WAIT instruction in the idle loop
> when returning from an interrupt and iff so, rolling back the
> program counter to point to the if (test_thread_flag(TIF_NEED_RESCHED))
> test at the beginning of rollback_r4k_wait.

Umm. That sounds buggy. What if there was an interrupt *between* the
two places, not right at the wait instruction?

It seriously sounds like MIPS should do this by enabling interrupts in
the *assembly* code immediately preceding the wait instruction. IOW,
you'd effectively have the same kind of "sti; halt" kind of sequence
that x86 has. Not "enable interrupts" + C compiler puts random
instructions here + "wait".

                       Linus
