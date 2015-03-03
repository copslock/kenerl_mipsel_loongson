Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 09:30:14 +0100 (CET)
Received: from mail-wg0-f47.google.com ([74.125.82.47]:32910 "EHLO
        mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006779AbbCCIaMuz4QM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Mar 2015 09:30:12 +0100
Received: by wghb13 with SMTP id b13so38403735wgh.0;
        Tue, 03 Mar 2015 00:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/JrdxPdphzSUhyngAweLNA4mz3FC4rtVZmyP6ugtoJE=;
        b=nFm+jsSLd/H0vrBd53AHmlh3uVuwXnatzufPuxQ2xjkBpNUa7WkQz6hc5IUoToBPFM
         lY41VhJQTF2Fahcqnsdih3KmQZn0xlkbb4hJq/8fsPJS0pgzNE9ti4OWDZFCglRO1H7U
         vmJZm/NHeZ9x3NLiDZqQJoRdMsyyZvEVPytuecozzaS1APEfb+x5VUC9DeiUgU2jAx6z
         Y0XKoPLFLL1BmejZEBkOtTSEYHUgOfIFqXdR/ylCe543erDWR/7fZ19XJsNdxLzLlLE7
         PW46Fz50I0qxNnfHQfwK6UC5Z85dKfl+opOSUvf5XOXR1zk/hMgPw7BrRvpgI2/LMmWY
         HYMg==
X-Received: by 10.194.236.133 with SMTP id uu5mr5786262wjc.155.1425371407851;
        Tue, 03 Mar 2015 00:30:07 -0800 (PST)
Received: from gmail.com (540334ED.catv.pool.telekom.hu. [84.3.52.237])
        by mx.google.com with ESMTPSA id vv9sm202723wjc.35.2015.03.03.00.30.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2015 00:30:05 -0800 (PST)
Date:   Tue, 3 Mar 2015 09:30:02 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Russell King <linux@arm.linux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        x86@kernel.org, Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Laura Abbott <lauraa@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] seccomp: switch to using asm-generic for seccomp.h
Message-ID: <20150303083002.GA1207@gmail.com>
References: <20150302231254.GA4857@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150302231254.GA4857@www.outflux.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Kees Cook <keescook@chromium.org> wrote:

> Most architectures don't need to do anything special for the strict
> seccomp syscall entries. Remove the redundant headers and reduce the
> others.

>  19 files changed, 27 insertions(+), 137 deletions(-)

Lovely cleanup factor.

Just to make sure, are you sure the 32-bit details are identical 
across architectures?

For example some architectures did this:

> --- a/arch/microblaze/include/asm/seccomp.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -#ifndef _ASM_MICROBLAZE_SECCOMP_H
> -#define _ASM_MICROBLAZE_SECCOMP_H
> -
> -#include <linux/unistd.h>
> -
> -#define __NR_seccomp_read		__NR_read
> -#define __NR_seccomp_write		__NR_write
> -#define __NR_seccomp_exit		__NR_exit
> -#define __NR_seccomp_sigreturn		__NR_sigreturn
> -
> -#define __NR_seccomp_read_32		__NR_read
> -#define __NR_seccomp_write_32		__NR_write
> -#define __NR_seccomp_exit_32		__NR_exit
> -#define __NR_seccomp_sigreturn_32	__NR_sigreturn

others did this:

> diff --git a/arch/x86/include/asm/seccomp_64.h b/arch/x86/include/asm/seccomp_64.h
> deleted file mode 100644
> index 84ec1bd161a5..000000000000
> --- a/arch/x86/include/asm/seccomp_64.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -#ifndef _ASM_X86_SECCOMP_64_H
> -#define _ASM_X86_SECCOMP_64_H
> -
> -#include <linux/unistd.h>
> -#include <asm/ia32_unistd.h>
> -
> -#define __NR_seccomp_read __NR_read
> -#define __NR_seccomp_write __NR_write
> -#define __NR_seccomp_exit __NR_exit
> -#define __NR_seccomp_sigreturn __NR_rt_sigreturn
> -
> -#define __NR_seccomp_read_32 __NR_ia32_read
> -#define __NR_seccomp_write_32 __NR_ia32_write
> -#define __NR_seccomp_exit_32 __NR_ia32_exit
> -#define __NR_seccomp_sigreturn_32 __NR_ia32_sigreturn
> -
> -#endif /* _ASM_X86_SECCOMP_64_H */

While in yet another case you kept the syscall mappings:

> --- a/arch/x86/include/asm/seccomp.h
> +++ b/arch/x86/include/asm/seccomp.h
> @@ -1,5 +1,20 @@
> +#ifndef _ASM_X86_SECCOMP_H
> +#define _ASM_X86_SECCOMP_H
> +
> +#include <asm/unistd.h>
> +
> +#ifdef CONFIG_COMPAT
> +#include <asm/ia32_unistd.h>
> +#define __NR_seccomp_read_32		__NR_ia32_read
> +#define __NR_seccomp_write_32		__NR_ia32_write
> +#define __NR_seccomp_exit_32		__NR_ia32_exit
> +#define __NR_seccomp_sigreturn_32	__NR_ia32_sigreturn
> +#endif
> +
>  #ifdef CONFIG_X86_32
> -# include <asm/seccomp_32.h>
> -#else
> -# include <asm/seccomp_64.h>
> +#define __NR_seccomp_sigreturn		__NR_sigreturn
>  #endif
> +
> +#include <asm-generic/seccomp.h>
> +
> +#endif /* _ASM_X86_SECCOMP_H */

It might all be correct, but it's not obvious to me.

Thanks,

	Ingo
