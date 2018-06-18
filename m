Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2018 09:03:15 +0200 (CEST)
Received: from pegase1.c-s.fr ([93.17.236.30]:14148 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994571AbeFRHBbTR1HN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jun 2018 09:01:31 +0200
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 418MSs01Xqz9ttlc;
        Mon, 18 Jun 2018 09:01:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bRUGuSVImyWT; Mon, 18 Jun 2018 09:01:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 418MSr6TfQz9ttlX;
        Mon, 18 Jun 2018 09:01:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4BE438B80A;
        Mon, 18 Jun 2018 09:01:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pjoqG5II4fxC; Mon, 18 Jun 2018 09:01:23 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1BC258B74B;
        Mon, 18 Jun 2018 09:01:22 +0200 (CEST)
Subject: Re: [PATCH 2/3] disable -Wattribute-alias warning for
 SYSCALL_DEFINEx()
To:     Paul Burton <paul.burton@mips.com>, linux-kbuild@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@kernel.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        He Zhe <zhe.he@windriver.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Khem Raj <raj.khem@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Gideon Israel Dsouza <gidisrael@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20180616005323.7938-1-paul.burton@mips.com>
 <20180616005323.7938-3-paul.burton@mips.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <8b6f684a-38d4-c757-ce0f-fdb2e0a3476b@c-s.fr>
Date:   Mon, 18 Jun 2018 09:01:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180616005323.7938-3-paul.burton@mips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Return-Path: <christophe.leroy@c-s.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christophe.leroy@c-s.fr
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



Le 16/06/2018 à 02:53, Paul Burton a écrit :
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-8 warns for every single definition of a system call entry
> point, e.g.:
> 
> include/linux/compat.h:56:18: error: 'compat_sys_rt_sigprocmask' alias between functions of incompatible types 'long int(int,  compat_sigset_t *, compat_sigset_t *, compat_size_t)' {aka 'long int(int,  struct <anonymous> *, struct <anonymous> *, unsigned int)'} and 'long int(long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
>    asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))\
>                    ^~~~~~~~~~
> include/linux/compat.h:45:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
>    COMPAT_SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
>    ^~~~~~~~~~~~~~~~~~~~~~
> kernel/signal.c:2601:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE4'
>   COMPAT_SYSCALL_DEFINE4(rt_sigprocmask, int, how, compat_sigset_t __user *, nset,
>   ^~~~~~~~~~~~~~~~~~~~~~
> include/linux/compat.h:60:18: note: aliased declaration here
>    asmlinkage long compat_SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))\
>                    ^~~~~~~~~~
> 
> The new warning seems reasonable in principle, but it doesn't
> help us here, since we rely on the type mismatch to sanitize the
> system call arguments. After I reported this as GCC PR82435, a new
> -Wno-attribute-alias option was added that could be used to turn the
> warning off globally on the command line, but I'd prefer to do it a
> little more fine-grained.
> 
> Interestingly, turning a warning off and on again inside of
> a single macro doesn't always work, in this case I had to add
> an extra statement inbetween and decided to copy the __SC_TEST
> one from the native syscall to the compat syscall macro.  See
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 for more details
> about this.
> 
> [paul.burton@mips.com:
>    - Rebase atop current master.
>    - Split GCC & version arguments to __diag_ignore() in order to match
>      changes to the preceding patch.
>    - Add the comment argument to match the preceding patch.]
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82435
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Matthew Wilcox <matthew@wil.cx>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Gideon Israel Dsouza <gidisrael@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Khem Raj <raj.khem@gmail.com>
> Cc: He Zhe <zhe.he@windriver.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org

Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>


> ---
> 
>   include/linux/compat.h   | 8 +++++++-
>   include/linux/syscalls.h | 4 ++++
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index b1a5562b3215..c68acc47da57 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -72,6 +72,9 @@
>    */
>   #ifndef COMPAT_SYSCALL_DEFINEx
>   #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
> +	__diag_push();								\
> +	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
> +		      "Type aliasing is used to sanitize syscall arguments");\
>   	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
>   	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
>   		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
> @@ -80,8 +83,11 @@
>   	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
>   	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
>   	{									\
> -		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
> +		long ret = __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
> +		__MAP(x,__SC_TEST,__VA_ARGS__);					\
> +		return ret;							\
>   	}									\
> +	__diag_pop();								\
>   	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
>   #endif /* COMPAT_SYSCALL_DEFINEx */
>   
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 73810808cdf2..a368a68cb667 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -231,6 +231,9 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>    */
>   #ifndef __SYSCALL_DEFINEx
>   #define __SYSCALL_DEFINEx(x, name, ...)					\
> +	__diag_push();							\
> +	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
> +		      "Type aliasing is used to sanitize syscall arguments");\
>   	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
>   		__attribute__((alias(__stringify(__se_sys##name))));	\
>   	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
> @@ -243,6 +246,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>   		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
>   		return ret;						\
>   	}								\
> +	__diag_pop();							\
>   	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
>   #endif /* __SYSCALL_DEFINEx */
>   
> 
