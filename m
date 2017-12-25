Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Dec 2017 22:05:29 +0100 (CET)
Received: from asavdk4.altibox.net ([109.247.116.15]:37399 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990433AbdLYVFTQdyFN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Dec 2017 22:05:19 +0100
Received: from ravnborg.org (126.158-248-196.customer.lyse.net [158.248.196.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B2062802DA;
        Mon, 25 Dec 2017 22:05:04 +0100 (CET)
Date:   Mon, 25 Dec 2017 22:05:03 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 1/8] arch: enable relative relocations for arm64,
 power, x86, s390 and x86
Message-ID: <20171225210502.GA635@ravnborg.org>
References: <20171225205440.14575-1-ard.biesheuvel@linaro.org>
 <20171225205440.14575-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171225205440.14575-2-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.2 cv=eqGd9chX c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=7CQSdrXTAAAA:8 a=wMNdZWldAAAA:8 a=hGzw-44bAAAA:8
        a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=VwQbUJbxAAAA:8
        a=KKAkSRfTAAAA:8 a=bz6qZxWEvjXusb4KMuYA:9 a=CjuIK1q_8ugA:10
        a=a-qgeE7W1pNrGK8U0ZQC:22 a=FUarYpL4UH3yWsho8X8J:22
        a=HvKuF1_PTVFglORKqfwH:22 a=NdAtdrkLVvyUPsUoGJp4:22
        a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
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

Hi Ard.

On Mon, Dec 25, 2017 at 08:54:33PM +0000, Ard Biesheuvel wrote:
> Before updating certain subsystems to use place relative 32-bit
> relocations in special sections, to save space  and reduce the
> number of absolute relocations that need to be processed at runtime
> by relocatable kernels, introduce the Kconfig symbol and define it
> for some architectures that should be able to support and benefit
> from it.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/Kconfig                    | 10 ++++++++++
>  arch/arm64/Kconfig              |  1 +

>  arch/arm64/kernel/vmlinux.lds.S |  2 +-
The change to arch/arm64/kernel/vmlinux.lds.S is
not justified in the changelog.
Did you add it by mistake?

	Sam
