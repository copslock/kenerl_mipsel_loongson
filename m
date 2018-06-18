Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2018 09:02:57 +0200 (CEST)
Received: from pegase1.c-s.fr ([93.17.236.30]:34559 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994552AbeFRHBRRa05N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jun 2018 09:01:17 +0200
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 418MSd182Jz9ttSc;
        Mon, 18 Jun 2018 09:01:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZT68e9OT04Es; Mon, 18 Jun 2018 09:01:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 418MSd0NGNz9ttSG;
        Mon, 18 Jun 2018 09:01:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6CF948B80A;
        Mon, 18 Jun 2018 09:01:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gF8ENAs8mmm0; Mon, 18 Jun 2018 09:01:11 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DD4F8B74B;
        Mon, 18 Jun 2018 09:01:10 +0200 (CEST)
Subject: Re: [PATCH 1/3] kbuild: add macro for controlling warnings to
 linux/compiler.h
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
 <20180616005323.7938-2-paul.burton@mips.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7184b4d5-d286-234a-2fae-21a5dee2a589@c-s.fr>
Date:   Mon, 18 Jun 2018 09:01:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180616005323.7938-2-paul.burton@mips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Return-Path: <christophe.leroy@c-s.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64339
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
> I have occasionally run into a situation where it would make sense to
> control a compiler warning from a source file rather than doing so from
> a Makefile using the $(cc-disable-warning, ...) or $(cc-option, ...)
> helpers.
> 
> The approach here is similar to what glibc uses, using __diag() and
> related macros to encapsulate a _Pragma("GCC diagnostic ...") statement
> that gets turned into the respective "#pragma GCC diagnostic ..." by
> the preprocessor when the macro gets expanded.
> 
> Like glibc, I also have an argument to pass the affected compiler
> version, but decided to actually evaluate that one. For now, this
> supports GCC_4_6, GCC_4_7, GCC_4_8, GCC_4_9, GCC_5, GCC_6, GCC_7,
> GCC_8 and GCC_9. Adding support for CLANG_5 and other interesting
> versions is straightforward here. GNU compilers starting with gcc-4.2
> could support it in principle, but "#pragma GCC diagnostic push"
> was only added in gcc-4.6, so it seems simpler to not deal with those
> at all. The same versions show a large number of warnings already,
> so it seems easier to just leave it at that and not do a more
> fine-grained control for them.
> 
> The use cases I found so far include:
> 
> - turning off the gcc-8 -Wattribute-alias warning inside of the
>    SYSCALL_DEFINEx() macro without having to do it globally.
> 
> - Reducing the build time for a simple re-make after a change,
>    once we move the warnings from ./Makefile and
>    ./scripts/Makefile.extrawarn into linux/compiler.h
> 
> - More control over the warnings based on other configurations,
>    using preprocessor syntax instead of Makefile syntax. This should make
>    it easier for the average developer to understand and change things.
> 
> - Adding an easy way to turn the W=1 option on unconditionally
>    for a subdirectory or a specific file. This has been requested
>    by several developers in the past that want to have their subsystems
>    W=1 clean.
> 
> - Integrating clang better into the build systems. Clang supports
>    more warnings than GCC, and we probably want to classify them
>    as default, W=1, W=2 etc, but there are cases in which the
>    warnings should be classified differently due to excessive false
>    positives from one or the other compiler.
> 
> - Adding a way to turn the default warnings into errors (e.g. using
>    a new "make E=0" tag) while not also turning the W=1 warnings into
>    errors.
> 
> This patch for now just adds the minimal infrastructure in order to
> do the first of the list above. As the #pragma GCC diagnostic
> takes precedence over command line options, the next step would be
> to convert a lot of the individual Makefiles that set nonstandard
> options to use __diag() instead.
> 
> [paul.burton@mips.com:
>    - Rebase atop current master.
>    - Add __diag_GCC, or more generally __diag_<compiler>, abstraction to
>      avoid code outside of linux/compiler-gcc.h needing to duplicate
>      knowledge about different GCC versions.
>    - Add a comment argument to __diag_{ignore,warn,error} which isn't
>      used in the expansion of the macros but serves to push people to
>      document the reason for using them - per feedback from Kees Cook.]
> 
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
>   include/linux/compiler-gcc.h   | 66 ++++++++++++++++++++++++++++++++++
>   include/linux/compiler_types.h | 18 ++++++++++
>   2 files changed, 84 insertions(+)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index f1a7492a5cc8..aba64a2912d8 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -347,3 +347,69 @@
>   #if GCC_VERSION >= 50100
>   #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>   #endif
> +
> +/*
> + * turn individual warnings and errors on and off locally, depending
> + * on version.
> + */
> +#define __diag_GCC(version, s) __diag_GCC_ ## version(s)
> +
> +#if GCC_VERSION >= 40600
> +#define __diag_str1(s) #s
> +#define __diag_str(s) __diag_str1(s)
> +#define __diag(s) _Pragma(__diag_str(GCC diagnostic s))
> +
> +/* compilers before gcc-4.6 do not understand "#pragma GCC diagnostic push" */
> +#define __diag_GCC_4_6(s) __diag(s)
> +#else
> +#define __diag(s)
> +#define __diag_GCC_4_6(s)
> +#endif
> +
> +#if GCC_VERSION >= 40700
> +#define __diag_GCC_4_7(s) __diag(s)
> +#else
> +#define __diag_GCC_4_7(s)
> +#endif
> +
> +#if GCC_VERSION >= 40800
> +#define __diag_GCC_4_8(s) __diag(s)
> +#else
> +#define __diag_GCC_4_8(s)
> +#endif
> +
> +#if GCC_VERSION >= 40900
> +#define __diag_GCC_4_9(s) __diag(s)
> +#else
> +#define __diag_GCC_4_9(s)
> +#endif
> +
> +#if GCC_VERSION >= 50000
> +#define __diag_GCC_5(s) __diag(s)
> +#else
> +#define __diag_GCC_5(s)
> +#endif
> +
> +#if GCC_VERSION >= 60000
> +#define __diag_GCC_6(s) __diag(s)
> +#else
> +#define __diag_GCC_6(s)
> +#endif
> +
> +#if GCC_VERSION >= 70000
> +#define __diag_GCC_7(s) __diag(s)
> +#else
> +#define __diag_GCC_7(s)
> +#endif
> +
> +#if GCC_VERSION >= 80000
> +#define __diag_GCC_8(s) __diag(s)
> +#else
> +#define __diag_GCC_8(s)
> +#endif
> +
> +#if GCC_VERSION >= 90000
> +#define __diag_GCC_9(s) __diag(s)
> +#else
> +#define __diag_GCC_9(s)
> +#endif
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 6b79a9bba9a7..313a2ad884e0 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -271,4 +271,22 @@ struct ftrace_likely_data {
>   # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>   #endif
>   
> +#ifndef __diag
> +#define __diag(string)
> +#endif
> +
> +#ifndef __diag_GCC
> +#define __diag_GCC(string)
> +#endif
> +
> +#define __diag_push()	__diag(push)
> +#define __diag_pop()	__diag(pop)
> +
> +#define __diag_ignore(compiler, version, option, comment) \
> +	__diag_ ## compiler(version, ignored option)
> +#define __diag_warn(compiler, version, option, comment) \
> +	__diag_ ## compiler(version, warning option)
> +#define __diag_error(compiler, version, option, comment) \
> +	__diag_ ## compiler(version, error   option)
> +
>   #endif /* __LINUX_COMPILER_TYPES_H */
> 
