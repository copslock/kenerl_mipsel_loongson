Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 20:23:54 +0200 (CEST)
Received: from mail-ot1-x344.google.com ([IPv6:2607:f8b0:4864:20::344]:33654
        "EHLO mail-ot1-x344.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992267AbeJLSXrdW0Sp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 20:23:47 +0200
Received: by mail-ot1-x344.google.com with SMTP id q50so13276596otd.0
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 11:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGmx3Atq13x4FKEnBH9tw9ftM2J9cIvdsYS+LQlzga4=;
        b=THzjVlxt7VYPTyWSfgF4AI/+/OAft3oylnOWLauK4n5Q64VW0LD2bmNF9gQ5q7df7y
         7hhT1/iU1kKS3Wlxu7v7k72qYjbboH9VKVFw0+a/D5kVMRHKs/2sfmDfPXyPCvv7dcP7
         i86aHz1uqWsDkEM1QKABIAZ296bY3TB94v45jbal6LGQEqp8ElKKty0wEsh+M0+7ZsK8
         fl9UL3NlEaa25ruxqfQnySgiHITaSphufMq/zCMkZdcP4h7JqLYovfeQ2xho5wtB06P0
         ypdZUOuW7RpCod38pq59qS/19YpSIiGH2nzRWgNQAPkrfSOOA1NXVddNISHn3i8J+Gcy
         XNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGmx3Atq13x4FKEnBH9tw9ftM2J9cIvdsYS+LQlzga4=;
        b=LiYq18ALgwu5HS/VZ1kwZ7i3HiIlJO2y3Tkn/A2FzFLfhrhZmqauJTLAwMc80+5Zn0
         k/GsLxHEbQOuDF9Ko5TZPi/Sz75xtE5kNEeccnjeAs8jfoxZxaI5iHRzHlFR1gW4ZJgE
         FBrjb71u1iORrgVav+yREwgMcEKHKjDiGplA8xOQXG9arS/K6PhPqz16WAuDBGWLTDLr
         PBxk96OMs9C9cBdjyHg6TX3+aEPdr7iDSS01akyn2PajYKr4BmL3CRBwPg9YFsPIp4fm
         xNTPOSi1YLZJ/wEHVDSfjppNp31kTGkFUn5NSHXs4nESJDkV9Oy+ewMJdcQsqo1089Ho
         txGw==
X-Gm-Message-State: ABuFfojcxbf8vZO6khLi5BMDj70/eNaUjxbL3MRH9BOsA7/tOcPHz/Ft
        w7Yl+5w4693m9KxMV+vborW9wD87GfocnGhuytrd9A==
X-Google-Smtp-Source: ACcGV60N79wPaPgmvCjBXoplMwoh/HYK58FEWb/tt3Uj+enjF3u61fKXTwLtMPvlKoWY2BMIt4rnX99KRcsBMu3ms0Q=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr4676406otf.242.1539368620937;
 Fri, 12 Oct 2018 11:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-2-rick.p.edgecombe@intel.com> <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
In-Reply-To: <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 12 Oct 2018 20:23:15 +0200
Message-ID: <CAG48ez0pPX7XNqSj4dVG1s+PaDBCh4ar5xw1WcY1sLBPV_QAzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] modules: Create rlimit for module space
To:     rick.p.edgecombe@intel.com
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, jeyu@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>, kristen@linux.intel.com,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        deneen.t.dock@intel.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jannh@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jannh@google.com
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

On Fri, Oct 12, 2018 at 2:35 AM Jann Horn <jannh@google.com> wrote:
> On Fri, Oct 12, 2018 at 1:40 AM Rick Edgecombe
> <rick.p.edgecombe@intel.com> wrote:
> > This introduces a new rlimit, RLIMIT_MODSPACE, which limits the amount of
> > module space a user can use. The intention is to be able to limit module space
> > allocations that may come from un-privlidged users inserting e/BPF filters.
>
> Note that in some configurations (iirc e.g. the default Ubuntu
> config), normal users can use the subuid mechanism (the /etc/subuid
> config file and the /usr/bin/newuidmap setuid helper) to gain access
> to 65536 UIDs, which means that in such a configuration,
> RLIMIT_MODSPACE*65537 is the actual limit for one user. (Same thing
> applies to RLIMIT_MEMLOCK.)

Actually, I may have misremembered, perhaps it's not installed by
default - I just checked in a Ubuntu VM, and the newuidmap helper from
the uidmap package wasn't installed.
