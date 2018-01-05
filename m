Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 18:41:34 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:52036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992368AbeAERl16fqb8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Jan 2018 18:41:27 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEEA01435;
        Fri,  5 Jan 2018 09:41:20 -0800 (PST)
Received: from armageddon.cambridge.arm.com (armageddon.cambridge.arm.com [10.1.206.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AB893F581;
        Fri,  5 Jan 2018 09:41:15 -0800 (PST)
Date:   Fri, 5 Jan 2018 17:41:12 +0000
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
Subject: Re: [PATCH v7 05/10] PCI: Add support for relative addressing in
 quirk tables
Message-ID: <20180105174112.jk3mvo5qwg7l4vzo@armageddon.cambridge.arm.com>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-6-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180102200549.22984-6-ard.biesheuvel@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <catalin.marinas@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61913
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

On Tue, Jan 02, 2018 at 08:05:44PM +0000, Ard Biesheuvel wrote:
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 10684b17d0bd..b6d51b4d5ce1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3556,9 +3556,16 @@ static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
>  		     f->vendor == (u16) PCI_ANY_ID) &&
>  		    (f->device == dev->device ||
>  		     f->device == (u16) PCI_ANY_ID)) {
> -			calltime = fixup_debug_start(dev, f->hook);
> -			f->hook(dev);
> -			fixup_debug_report(dev, calltime, f->hook);
> +			void (*hook)(struct pci_dev *dev);
> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +			hook = (void *)((unsigned long)&f->hook_offset +
> +					f->hook_offset);
> +#else
> +			hook = f->hook;
> +#endif

More of a nitpick but I've seen this pattern in several places in your
code, maybe worth defining a macro (couldn't come up with a better
name):

#define offset_to_ptr(off) \
	((void *)((unsigned long)&(off) + (off)))

-- 
Catalin
