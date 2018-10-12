Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 19:23:23 +0200 (CEST)
Received: from mail-ot1-x344.google.com ([IPv6:2607:f8b0:4864:20::344]:42042
        "EHLO mail-ot1-x344.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeJLRXUWc0zs convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Oct 2018 19:23:20 +0200
Received: by mail-ot1-x344.google.com with SMTP id c23so11300823otl.9
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wLKvl0AMOy211XIbhuy21uB9bAp6ZKu9unCjjQ3yyUI=;
        b=C4ARci1kFfc3/rfjF0x1e0ufiYTtC2lKGgdX5beckbYcGRwWHKf+NvFKEdD3p2UMPG
         1JkK0owu8CqlVHfVd0YGAropoGapEostI4DFgJdtPwLTnOTrw2YR1Cws9DdsW2UVT3xD
         Lr81eTF9fOH6pY4fyXkswc5kcqwF0Vjk48UerMcuiVJ7I0a/wSbiIyCLoL7uEXdg+1Tr
         8kyJWtPg16iYLn0yEmjOjhx/XiA8Vp1JzVnUauOU/C1+B42q4u87FcrtVk2w10AvyI1w
         8SEYIR948FPYnuYHmfIQXeDMvmtsRFQOPL886SqTh3RY0gkRDDlJjiKAUDZsSL01hQNq
         HEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wLKvl0AMOy211XIbhuy21uB9bAp6ZKu9unCjjQ3yyUI=;
        b=TqAU+Dab/REoQ8Hx/pJcoKKRQCvKjG6wTfkAMhM/pr+l2ky2zAT1Jl5SVjVvTM2xbJ
         8OZ49mUUsgLB+KIJfOhIAJ40NJY8+q8sECF+cCqDnuaoetiLXIKyDzSLG3bFlF54xtWN
         KyY0ePkL63Z4TpxabAxG2Tk05YK3di+H0Ine6yuMpmN1udAhrIsffmlrtVfv89Qik3P+
         hpMiPq88Gum2axTgTj9dqpmZQJftFIrMubhaVSQRGLlEzHRfBwj86R0ZePZl+Y+9L8vn
         T3I+8PwHZRd8DnYIksgdShSs5bFrn9ST3It6wxZ4IEV67duJsJMHtIEKC3XrqoprtlB3
         3hAw==
X-Gm-Message-State: ABuFfojqXSyqDtyYx2cjOD2A+vGlM9qL2TNrKAHLaqd3mNPuB1JRnruK
        hE93sxoxBZnz9AmIdlfQQZu+DWV7RCCsgam1VPVcqQ==
X-Google-Smtp-Source: ACcGV60PkhpBQ9N0KEOWQw25NDWusszaBDeeUba7G0l1oTS3N17uWcAsHUE/xmkdkP7VobGrZo4KJsFOoorspDpj9e4=
X-Received: by 2002:a9d:49ac:: with SMTP id g44mr4664190otf.198.1539364993786;
 Fri, 12 Oct 2018 10:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-2-rick.p.edgecombe@intel.com> <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
 <7b0714e26c7c2216721641d7df16a49687927e37.camel@intel.com>
In-Reply-To: <7b0714e26c7c2216721641d7df16a49687927e37.camel@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 12 Oct 2018 19:22:46 +0200
Message-ID: <CAG48ez0XfGFAWDYa75COMPCsKqqGfBFOtcNuGD4_dubGf2YeAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] modules: Create rlimit for module space
To:     rick.p.edgecombe@intel.com
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, jeyu@kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-s390 <linux-s390@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <jannh@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66787
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

On Fri, Oct 12, 2018 at 7:04 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> On Fri, 2018-10-12 at 02:35 +0200, Jann Horn wrote:
> > On Fri, Oct 12, 2018 at 1:40 AM Rick Edgecombe
> > <rick.p.edgecombe@intel.com> wrote:
> > > This introduces a new rlimit, RLIMIT_MODSPACE, which limits the amount of
> > > module space a user can use. The intention is to be able to limit module
> > > space
> > > allocations that may come from un-privlidged users inserting e/BPF filters.
> >
> > Note that in some configurations (iirc e.g. the default Ubuntu
> > config), normal users can use the subuid mechanism (the /etc/subuid
> > config file and the /usr/bin/newuidmap setuid helper) to gain access
> > to 65536 UIDs, which means that in such a configuration,
> > RLIMIT_MODSPACE*65537 is the actual limit for one user. (Same thing
> > applies to RLIMIT_MEMLOCK.)
> Ah, that is a problem. There is only room for about 130,000 filters on x86 with
> KASLR, so it couldn't really be set small enough.
>
> I'll have to look into what this is. Thanks for pointing it out.
>
> > Also, it is probably possible to waste a few times as much virtual
> > memory as permitted by the limit by deliberately fragmenting virtual
> > memory?
> Good point. I guess if the first point can be addressed somehow, this one could
> maybe be solved by just picking a lower limit.
>
> Any thoughts on if instead of all this there was just a system wide limit on BPF
> JIT module space usage?

That does sound more robust to me. And at least on systems that don't
compile out the BPF interpreter, everything should be more or less
fine then...

> > > There is unfortunately no cross platform place to perform this accounting
> > > during allocation in the module space, so instead two helpers are created to
> > > be
> > > inserted into the various arch’s that implement module_alloc. These
> > > helpers perform the checks and help with tracking. The intention is that
> > > they
> > > an be added to the various arch’s as easily as possible.
> >
> > nit: s/an/can/
> >
> > [...]
> > > diff --git a/kernel/module.c b/kernel/module.c
> > > index 6746c85511fe..2ef9ed95bf60 100644
> > > --- a/kernel/module.c
> > > +++ b/kernel/module.c
> > > @@ -2110,9 +2110,139 @@ static void free_module_elf(struct module *mod)
> > >  }
> > >  #endif /* CONFIG_LIVEPATCH */it
> > >
> > > +struct mod_alloc_user {
> > > +       struct rb_node node;
> > > +       unsigned long addr;
> > > +       unsigned long pages;
> > > +       kuid_t uid;
> > > +};
> > > +
> > > +static struct rb_root alloc_users = RB_ROOT;
> > > +static DEFINE_SPINLOCK(alloc_users_lock);
> >
> > Why all the rbtree stuff instead of stashing a pointer in struct
> > vmap_area, or something like that?
>
> Since the tracking was not for all vmalloc usage, the intention was to not bloat
> the structure for other usages likes stacks. I thought usually there wouldn't be
> nearly as much module space allocations as there would be kernel stacks, but I
> didn't do any actual measurements on the tradeoffs.

I imagine that one extra pointer in there - pointing to your struct
mod_alloc_user - would probably not be terrible. 8 bytes more per
kernel stack shouldn't be so bad?

> > [...]
> > > +int check_inc_mod_rlimit(unsigned long size)
> > > +{
> > > +       struct user_struct *user = get_current_user();
> > > +       unsigned long modspace_pages = rlimit(RLIMIT_MODSPACE) >>
> > > PAGE_SHIFT;
> > > +       unsigned long cur_pages = atomic_long_read(&user->module_vm);
> > > +       unsigned long new_pages = get_mod_page_cnt(size);
> > > +
> > > +       if (rlimit(RLIMIT_MODSPACE) != RLIM_INFINITY
> > > +                       && cur_pages + new_pages > modspace_pages) {
> > > +               free_uid(user);
> > > +               return 1;
> > > +       }
> > > +
> > > +       atomic_long_add(new_pages, &user->module_vm);
> > > +
> > > +       if (atomic_long_read(&user->module_vm) > modspace_pages) {
> > > +               atomic_long_sub(new_pages, &user->module_vm);
> > > +               free_uid(user);
> > > +               return 1;
> > > +       }
> > > +
> > > +       free_uid(user);
> >
> > If you drop the reference on the user_struct, an attacker with two
> > UIDs can charge module allocations to UID A, keep the associated
> > sockets alive as UID B, and then log out and back in again as UID A.
> > At that point, nobody is charged for the module space anymore. If you
> > look at the eBPF implementation, you'll see that
> > bpf_prog_charge_memlock() actually stores a refcounted pointer to the
> > user_struct.
> Ok, I'll take a look. Thanks Jann.
> > > +       return 0;
> > > +}
