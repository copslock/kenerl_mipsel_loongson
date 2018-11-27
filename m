Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2018 11:34:46 +0100 (CET)
Received: from ozlabs.org ([IPv6:2401:3900:2:1::2]:46967 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993946AbeK0KelEokem (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Nov 2018 11:34:41 +0100
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4340X95kDkz9s29;
        Tue, 27 Nov 2018 21:34:33 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, x86@kernel.org,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linux-snps-arc@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>, linux-audit@redhat.com,
        linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 16/15] syscall_get_arch: add "struct task_struct *" argument
In-Reply-To: <20181121004422.GA29053@altlinux.org>
References: <20181107042751.3b519062@akathisia> <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com> <20181120001128.GA11300@altlinux.org> <20181121004422.GA29053@altlinux.org>
Date:   Tue, 27 Nov 2018 21:34:29 +1100
Message-ID: <87in0ihkqy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index ab9f3f0a8637..d88b34179118 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -100,9 +100,15 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  		regs->orig_gpr3 = args[0];
>  }
>  
> -static inline int syscall_get_arch(void)
> +static inline int syscall_get_arch(struct task_struct *task)
>  {
> -	int arch = is_32bit_task() ? AUDIT_ARCH_PPC : AUDIT_ARCH_PPC64;
> +	int arch;
> +
> +	if (IS_ENABLED(CONFIG_PPC64) && !test_tsk_thread_flag(task, TIF_32BIT))
> +		arch = AUDIT_ARCH_PPC64;
> +	else
> +		arch = AUDIT_ARCH_PPC;
> +
>  #ifdef __LITTLE_ENDIAN__
>  	arch |= __AUDIT_ARCH_LE;
>  #endif

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
