Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 18:58:56 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52304 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992368AbeAER6t2VnM8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 18:58:49 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7371E1596;
        Fri,  5 Jan 2018 09:58:42 -0800 (PST)
Received: from armageddon.cambridge.arm.com (armageddon.cambridge.arm.com [10.1.206.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CE143F581;
        Fri,  5 Jan 2018 09:58:37 -0800 (PST)
Date:   Fri, 5 Jan 2018 17:58:34 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org, Nicolas Pitre <nico@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
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
        linuxppc-dev@lists.ozlabs.org, Ralf Baechle <ralf@linux-mips.org>,
        Thomas Garnier <thgarnie@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v7 07/10] kernel/jump_label: abstract jump_entry member
 accessors
Message-ID: <20180105175834.vqgpsme7itsdg54u@armageddon.cambridge.arm.com>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-8-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180102200549.22984-8-ard.biesheuvel@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <catalin.marinas@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61915
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

On Tue, Jan 02, 2018 at 08:05:46PM +0000, Ard Biesheuvel wrote:
> diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
> index e12d7d096fc0..7b05b404063a 100644
> --- a/arch/arm/include/asm/jump_label.h
> +++ b/arch/arm/include/asm/jump_label.h
> @@ -45,5 +45,32 @@ struct jump_entry {
>  	jump_label_t key;
>  };
>  
> +static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
> +{
> +	return entry->code;
> +}
> +
> +static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
> +{
> +	return (struct static_key *)((unsigned long)entry->key & ~1UL);
> +}
> +
> +static inline bool jump_entry_is_branch(const struct jump_entry *entry)
> +{
> +	return (unsigned long)entry->key & 1UL;
> +}
> +
> +static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
> +{
> +	return entry->code == 0;
> +}
> +
> +static inline void jump_entry_set_module_init(struct jump_entry *entry)
> +{
> +	entry->code = 0;
> +}
> +
> +#define jump_label_swap		NULL

Is there any difference between these functions on any of the
architectures touched? Even with the relative offset, arm64 and x86
looked the same to me (well, I may have missed some detail).

-- 
Catalin
