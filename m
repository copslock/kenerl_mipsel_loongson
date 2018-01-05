Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 19:22:51 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:52674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992368AbeAESWoZW8K8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Jan 2018 19:22:44 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C3581435;
        Fri,  5 Jan 2018 10:22:37 -0800 (PST)
Received: from armageddon.cambridge.arm.com (armageddon.cambridge.arm.com [10.1.206.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 265053F53D;
        Fri,  5 Jan 2018 10:22:32 -0800 (PST)
Date:   Fri, 5 Jan 2018 18:22:29 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        James Morris <james.l.morris@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Thomas Garnier <thgarnie@google.com>
Subject: Re: [PATCH v7 07/10] kernel/jump_label: abstract jump_entry member
 accessors
Message-ID: <20180105182229.pjnlq3l5hzfac4na@armageddon.cambridge.arm.com>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-8-ard.biesheuvel@linaro.org>
 <20180105175834.vqgpsme7itsdg54u@armageddon.cambridge.arm.com>
 <CAKv+Gu8zROE-TDpfbbVi3RPOr8BNcsN_s27Gr-VvMN+-eMU+Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8zROE-TDpfbbVi3RPOr8BNcsN_s27Gr-VvMN+-eMU+Hg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <catalin.marinas@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: catalin.marinas@arm.com
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

On Fri, Jan 05, 2018 at 06:01:33PM +0000, Ard Biesheuvel wrote:
> On 5 January 2018 at 17:58, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Jan 02, 2018 at 08:05:46PM +0000, Ard Biesheuvel wrote:
> >> diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
> >> index e12d7d096fc0..7b05b404063a 100644
> >> --- a/arch/arm/include/asm/jump_label.h
> >> +++ b/arch/arm/include/asm/jump_label.h
> >> @@ -45,5 +45,32 @@ struct jump_entry {
> >>       jump_label_t key;
> >>  };
> >>
> >> +static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
> >> +{
> >> +     return entry->code;
> >> +}
> >> +
> >> +static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
> >> +{
> >> +     return (struct static_key *)((unsigned long)entry->key & ~1UL);
> >> +}
> >> +
> >> +static inline bool jump_entry_is_branch(const struct jump_entry *entry)
> >> +{
> >> +     return (unsigned long)entry->key & 1UL;
> >> +}
> >> +
> >> +static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
> >> +{
> >> +     return entry->code == 0;
> >> +}
> >> +
> >> +static inline void jump_entry_set_module_init(struct jump_entry *entry)
> >> +{
> >> +     entry->code = 0;
> >> +}
> >> +
> >> +#define jump_label_swap              NULL
> >
> > Is there any difference between these functions on any of the
> > architectures touched? Even with the relative offset, arm64 and x86
> > looked the same to me (well, I may have missed some detail).
> 
> No, the latter two are identical everywhere, and the others are the
> same modulo absolute vs relative.
> 
> The issue is that the struct definition is per-arch so the accessors
> should be as well.

Up to this patch, even the jump_entry structure is the same on all
architectures (the jump_label_t type differs).

With relative offset, can you not just define jump_label_t to s32? At a
quick grep in mainline, it doesn't seem to be used outside the structure
definition.

> Perhaps I should introduce two variants two asm-generic, similar to
> how we have different flavors of unaligned accessors.

You could as well define them directly in kernel/jump_label.h or, if
used outside this file, include/linux/jump_label.h.

-- 
Catalin
