Return-Path: <SRS0=ULQD=RZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D69C43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 17:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FFA20657
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 17:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553275681;
	bh=Cq9EbakpxRuqCopYhn1dCkRrdnNQDwyFy86rBTAr414=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vqdG/rZlnaxPjhSFIoEKufFgKJUT0DW+Foi3KAlhdOHDFoNcLj3sf+cr6ZIeTVxi5
	 bv3jCIlU8AWvRGEiXwTGx1F0kkcmn33SS30tQu9CyDEkl8+3sOpBSYa96G2+d7JzK7
	 F0L3YPV6T2l9bqdfmeihd+U2+hsVAsjQI2fSbwLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfCVR2B (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:28:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34274 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfCVR2A (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 22 Mar 2019 13:28:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id y18so2007928lfe.1
        for <linux-mips@vger.kernel.org>; Fri, 22 Mar 2019 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vz3qEaERAPywi/7ygEvysJD/ZMRj5JWoH5GTAfYhS9M=;
        b=EQb0PJgIUrxIFWDmv2d+roZcOdf47m4oWDh2aF9nqiM4xcdszNPdjlEZ6XBCZ7EETk
         1IfpVzYln8LpimAQjhRDAkW3OaV5XXtB4BOqOTWHoOqa+CwXq49WMc62V63vMcFKOgKB
         AUA6dt7kp1lq7E8yacEVhDOuhsd4cjNkTZNrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vz3qEaERAPywi/7ygEvysJD/ZMRj5JWoH5GTAfYhS9M=;
        b=N8uu8k48jUuS26JCJwM1Gu5Pj0fHMl3Mhe9DFRAHcOQko0/ZgqggZUUUw+/iRQFUCz
         Tvu6uq8zXr7ic4DHGOnakTttayBSPEdp0hLaaOe1QpTQCjS7I8g8JAz33RdWl9GhO2gI
         q4rBgNlapPixWYdPYqFYRWyvWNidNU9DM6vaTGVRDR33Mrip0N94ZqrYOUUdsjc+HwRm
         mNlNON8TIiQhQhqHPmWuKc1vMrWa1g0A45tYYtNWGI2OFdoLpPeqrKTW60mx5f1u8Pv7
         aNo8kTG/s0S7e4EZFdioiNp/MF5hIChSnqwPNobY1HQLBqOiMJED2qxvE0vcUm59c1Nm
         FPRg==
X-Gm-Message-State: APjAAAVvYj10zFH+GKPzcO60WbvF36HHTicTGv1ed+oPUIrCRz12n1Gc
        6l+fKnpjUR3zchSBVsuXM4ZRiot3fLs=
X-Google-Smtp-Source: APXvYqznYGs+DccipT+h5e263g6MbylRK6vbnXU1SroykZ/dmsX9NxsvUqdyM3EwJbzVG6zvvz0g7A==
X-Received: by 2002:a19:c796:: with SMTP id x144mr6250539lff.6.1553275678302;
        Fri, 22 Mar 2019 10:27:58 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id e18sm1459874ljb.12.2019.03.22.10.27.57
        for <linux-mips@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 10:27:58 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id p14so1747216ljg.5
        for <linux-mips@vger.kernel.org>; Fri, 22 Mar 2019 10:27:57 -0700 (PDT)
X-Received: by 2002:a2e:94ca:: with SMTP id r10mr5731037ljh.118.1553274129929;
 Fri, 22 Mar 2019 10:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190322143008.21313-1-longman@redhat.com> <20190322143008.21313-2-longman@redhat.com>
In-Reply-To: <20190322143008.21313-2-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Mar 2019 10:01:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikkO-1f1=FEOEzkSnaDg3yJLP=4Vd59UCuLBztFd0KOw@mail.gmail.com>
Message-ID: <CAHk-=wikkO-1f1=FEOEzkSnaDg3yJLP=4Vd59UCuLBztFd0KOw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] locking/rwsem: Remove arch specific rwsem files
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Mar 22, 2019 at 7:30 AM Waiman Long <longman@redhat.com> wrote:
>
>  19 files changed, 133 insertions(+), 930 deletions(-)

Lovely. And it all looks sane to me.

So ack.

The only comment I have is about __down_read_trylock(), which probably
isn't critical enough to actually care about, but:

> +static inline int __down_read_trylock(struct rw_semaphore *sem)
> +{
> +       long tmp;
> +
> +       while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> +               if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> +                                  tmp + RWSEM_ACTIVE_READ_BIAS)) {
> +                       return 1;
> +               }
> +       }
> +       return 0;
> +}

So this seems to

 (a) read the line early (the whole cacheline in shared state issue)

 (b) read the line again unnecessarily in the while loop

Now, (a) might be explained by "well, maybe we do trylock even with
existing readers", although I continue to think that the case we
should optimize for is simply the uncontended one, where we don't even
have multiple readers.

But (b) just seems silly.

So I wonder if it shouldn't just be

        long tmp = 0;

        do {
                long new = atomic_long_cmpxchg_acquire(&sem->count, tmp,
                        tmp + RWSEM_ACTIVE_READ_BIAS);
                if (likely(new == tmp))
                        return 1;
               tmp = new;
        } while (tmp >= 0);
        return 0;

which would seem simpler and solve both issues. Hmm?

But honestly, I didn't check what our uses of down_read_trylock() look
like. We have more of them than I expected, and I _think_ the normal
case is the "nobody else holds the lock", but that's just a gut
feeling.

Some of them _might_ be performance-critical. There's the one on
mmap_sem in the fault handling path, for example. And yes, I'd expect
the normal case to very much be "no other readers or writers" for that
one.

NOTE! The above code snippet is absolutely untested, and might be
completely wrong. Take it as a "something like this" rather than
anything else.

                   Linus
