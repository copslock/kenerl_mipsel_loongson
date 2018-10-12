Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 02:36:04 +0200 (CEST)
Received: from mail-ot1-x343.google.com ([IPv6:2607:f8b0:4864:20::343]:35769
        "EHLO mail-ot1-x343.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994648AbeJLAgBnKAef convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Oct 2018 02:36:01 +0200
Received: by mail-ot1-x343.google.com with SMTP id 14so6788910oth.2
        for <linux-mips@linux-mips.org>; Thu, 11 Oct 2018 17:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O3dVQ2VpkzyEy5AtqvYVsyf5CfAZqFhRMHYDEQWhI2o=;
        b=bS69ll8SS+45FdCeCQXRdeyX1WZ70u0jLFH95oHGj594lfmYJy5ZlueYOW4wgzxCAA
         i+6QwpNRSKZohJK1iHuKzd2ud6l0Rpmw4iF0tAFO64asFxetHsUth2VjoF3CNPMsJJn7
         YDCiv46PJbZMlJCkp5hAzP9OE0BVbOVuPJ50gvEPBU/FLXlyaSry4LZxFt2JEWdQOXma
         lkwGxMYIxta7tId0ea1pAdPtbZRnQp+Ow8+ZeqoRWZPRalg8zWzJ3vOHGJ4+sb3rbhnm
         cVlcKFWX5CeQk354e6EbK4LxQsPditor+/Tr7mtd+IkNvVeLJqVZv6Z6m/DeFztSi4kq
         sBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O3dVQ2VpkzyEy5AtqvYVsyf5CfAZqFhRMHYDEQWhI2o=;
        b=R98YY/+/HyS7AyzLLl09zozBcY36FYIAx+6H67dqvbvuamREMfVm1x0QC9is6utWAE
         R8xomcOBjGg28mQGxK1c5ODCwZMnErJN2lU2H6ssfproeBHYwfRaYoy/AJVEmKeWAb7z
         g2Ply9UMdiHn2BYg+4eeZZ20ZYhH02riuJ8TLSdVtg7tPwIq96xihGrtGOMuy2FaEcfZ
         722UkFU3ikeSYNT4bdJw7CSdpyD+NYBs+i7iwQYqnDEJYy/CBGjd1/ZXjv/8Wid7sYox
         piPAPjl/9RkyXw0AUk0rSspDku7PpYbLaNTNBQGtQLaMO1k/wds5B1ZVhtBu5rL3qMR5
         ng4A==
X-Gm-Message-State: ABuFfojNWasnVeXZEjRg/07yvhVCe0FUV8ooSJv11dHfaAlHmn0zXp0O
        VpgeI3n1dE1plc8P1SaknH2fRaORZhxU6NdkN2CEcQ==
X-Google-Smtp-Source: ACcGV60wE/h4NRkFdQ03NEnOmZoRdeLRTJcSpJ1zcAmPTq5izdvagVxIQ4ZJUoHY5xKfIgBlSsz+ANnQ9QlcAlC5H3g=
X-Received: by 2002:a9d:4917:: with SMTP id e23mr2664587otf.73.1539304555105;
 Thu, 11 Oct 2018 17:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com> <20181011233117.7883-2-rick.p.edgecombe@intel.com>
In-Reply-To: <20181011233117.7883-2-rick.p.edgecombe@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 12 Oct 2018 02:35:28 +0200
Message-ID: <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
Return-Path: <jannh@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66756
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

On Fri, Oct 12, 2018 at 1:40 AM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> This introduces a new rlimit, RLIMIT_MODSPACE, which limits the amount of
> module space a user can use. The intention is to be able to limit module space
> allocations that may come from un-privlidged users inserting e/BPF filters.

Note that in some configurations (iirc e.g. the default Ubuntu
config), normal users can use the subuid mechanism (the /etc/subuid
config file and the /usr/bin/newuidmap setuid helper) to gain access
to 65536 UIDs, which means that in such a configuration,
RLIMIT_MODSPACE*65537 is the actual limit for one user. (Same thing
applies to RLIMIT_MEMLOCK.)

Also, it is probably possible to waste a few times as much virtual
memory as permitted by the limit by deliberately fragmenting virtual
memory?

> There is unfortunately no cross platform place to perform this accounting
> during allocation in the module space, so instead two helpers are created to be
> inserted into the various arch’s that implement module_alloc. These
> helpers perform the checks and help with tracking. The intention is that they
> an be added to the various arch’s as easily as possible.

nit: s/an/can/

[...]
> diff --git a/kernel/module.c b/kernel/module.c
> index 6746c85511fe..2ef9ed95bf60 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2110,9 +2110,139 @@ static void free_module_elf(struct module *mod)
>  }
>  #endif /* CONFIG_LIVEPATCH */
>
> +struct mod_alloc_user {
> +       struct rb_node node;
> +       unsigned long addr;
> +       unsigned long pages;
> +       kuid_t uid;
> +};
> +
> +static struct rb_root alloc_users = RB_ROOT;
> +static DEFINE_SPINLOCK(alloc_users_lock);

Why all the rbtree stuff instead of stashing a pointer in struct
vmap_area, or something like that?

[...]
> +int check_inc_mod_rlimit(unsigned long size)
> +{
> +       struct user_struct *user = get_current_user();
> +       unsigned long modspace_pages = rlimit(RLIMIT_MODSPACE) >> PAGE_SHIFT;
> +       unsigned long cur_pages = atomic_long_read(&user->module_vm);
> +       unsigned long new_pages = get_mod_page_cnt(size);
> +
> +       if (rlimit(RLIMIT_MODSPACE) != RLIM_INFINITY
> +                       && cur_pages + new_pages > modspace_pages) {
> +               free_uid(user);
> +               return 1;
> +       }
> +
> +       atomic_long_add(new_pages, &user->module_vm);
> +
> +       if (atomic_long_read(&user->module_vm) > modspace_pages) {
> +               atomic_long_sub(new_pages, &user->module_vm);
> +               free_uid(user);
> +               return 1;
> +       }
> +
> +       free_uid(user);

If you drop the reference on the user_struct, an attacker with two
UIDs can charge module allocations to UID A, keep the associated
sockets alive as UID B, and then log out and back in again as UID A.
At that point, nobody is charged for the module space anymore. If you
look at the eBPF implementation, you'll see that
bpf_prog_charge_memlock() actually stores a refcounted pointer to the
user_struct.

> +       return 0;
> +}
