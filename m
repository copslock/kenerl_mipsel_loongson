Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Aug 2018 12:53:23 +0200 (CEST)
Received: from mout.gmx.net ([212.227.15.19]:43453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994551AbeHYKxIFpiNK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 25 Aug 2018 12:53:08 +0200
Received: from [192.168.20.60] ([92.116.128.156]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRGTX-1gNX4804tD-00UWoM; Sat, 25
 Aug 2018 12:49:07 +0200
Subject: Re: [PATCH] treewide: remove current_text_addr
To:     Nick Desaulniers <ndesaulniers@google.com>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc:     ebiederm@xmission.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, horms@verge.net.au, natechancellor@gmail.com,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Noam Camus <noamc@ezchip.com>,
        Mickael GUENE <mickael.guene@st.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Huacai Chen <chenhc@lemote.com>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Philippe Bergheaud <felix@linux.vnet.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Cornelia Huck <cohuck@redhat.com>,
        Vasily Gorbik <gor@linux.vnet.ibm.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Shannon Nelson <shannon.nelson@oracle.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; prefer-encrypt=mutual; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
Date:   Sat, 25 Aug 2018 12:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180821202900.208417-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TQVxMhqGwVY9ejfXg9b+8lBJETviyUpv7IsvOwVi9WcgnyrEObK
 ifHRqFfSwpfyw8FTh6CVlM/EPZ0gnxj2kTnDgP1EESkknKUWjPmiMn6VkpjYlwHqzA7bRpN
 N3auDnw92xjIJYYta7cUdBbut8P+XeQ1hkKtCQNcIyW3hYMhXKXXsTXOpuUjrH+u/tPq9Xg
 iCVZor/TOPclsQRDfdGYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3YwzMKbBL1g=:E3Fqfe92RI88yaiWhfDAYB
 AjAQXw2PhUravOyKc8k25aCEnJ97wY0BWSBh4XYH2MxkW1zzZLC0jfDC/eVKVuqCA7cjEOFqu
 2moLHtkJ0oXtMnE2vxRvmgxN0TWBdbbb3uVVk1kRItmInQAHAQ1hJ4bRcLvafMBcqalJQfvm8
 7pEq6E3HmaL9y37lAr77Py1eB41zEbsUA1OqbQ3JIR1IjNnpTwxjUP6Iy1ncP4vUWGISv25i0
 VhKHKKThLK1LjsmnZr6WfG0GJYkPaViKrsGFZdh2wvqpxXIwYlcyaLdMZQg7iUVLUkrSZ64zX
 fgXjXJCTeDT0iHApo13kTQfx7sACh9muZg+gecVRJq+0TUyX6n+Un+0q0wNQ6GB/j7V/QW0Qn
 7/3lgmdj9hD93b6fsBZsuvL8Yjs+sDGR70+UzshF8bGnJJb7NbGUHVfqoqBxSzSv9g5Xrcafg
 goUniaSSQ6X2bmVohHZbSvS2aVKiYibzcyORDbOmiq9t/izQVotO2UbJXpWFX3aUg4IPxO1i5
 e2rOASJRuZHmyKYSt//LXuylNJCCdNkLmOL4Bn0Cr79G4uny5+8u4Feklxkrzowpe2m+rb4KJ
 ++c74bcNfF4UFyxBmU5RGMsTvpmeGllfm09+J4Su4Rud2kbdrEk6dskWm5d/+VbSKNUa0G2RH
 xt0PCX+LYE4ZLCqGuYW5LYgWy81uq9WfWUT56/qP00ejtvs5pO6QccV6HuRjW3srSngjlEQMx
 DMnY4jHsZ1JPgt+KsMxAq1vU4UjdKOllIMHJwmF5K9SUAuMM0OSSdlTf67s3wPzhNKSniGl09
 4xagd8T
Return-Path: <deller@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deller@gmx.de
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

On 21.08.2018 22:28, Nick Desaulniers wrote:
> Prefer _THIS_IP_ defined in linux/kernel.h.
> 
> Most definitions of current_text_addr were the same as _THIS_IP_, but
> a few archs had inline assembly instead.
> 
> This patch removes the final call site of current_text_addr, making all
> of the definitions dead code.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> I suspect that current_text_addr predated GNU C extensions for statement
> expressions and/or taking the address of a label, then the macro was
> reimplemented for every new archs include/asm/processor.h, even though
> there were very few call sites, and none required an assembly
> implementation vs the C implementation.
> 
> I am sad to see a few neat arch specific ways of getting the ip/pc, but
> we should prefer the higher level C in cases where assembly is not
> required. And the definitions can always be found again in git history.

Currently alpha, s390, sparc, sh, c6x, ia64 and parisc provide an
inline assembly function to get the current instruction pointer. 
As mentioned in an earlier thread, I personally would *prefer* if 
_THIS_IP_ would use those inline assembly instructions on those
architectures instead of the (currently used) higher C-level
implementation.

Helge


>  arch/alpha/include/asm/processor.h      |  6 ------
>  arch/arc/include/asm/processor.h        |  8 --------
>  arch/arm/include/asm/processor.h        |  6 ------
>  arch/arm64/include/asm/processor.h      |  7 -------
>  arch/c6x/include/asm/processor.h        | 11 -----------
>  arch/h8300/include/asm/processor.h      |  6 ------
>  arch/hexagon/include/asm/processor.h    |  3 ---
>  arch/ia64/include/asm/processor.h       |  6 ------
>  arch/m68k/include/asm/processor.h       |  6 ------
>  arch/microblaze/include/asm/processor.h | 12 ------------
>  arch/mips/include/asm/processor.h       |  5 -----
>  arch/nds32/include/asm/processor.h      |  6 ------
>  arch/nios2/include/asm/processor.h      |  6 ------
>  arch/openrisc/include/asm/processor.h   |  5 -----
>  arch/parisc/include/asm/processor.h     | 11 -----------
>  arch/powerpc/include/asm/processor.h    |  6 ------
>  arch/riscv/include/asm/processor.h      |  6 ------
>  arch/s390/include/asm/processor.h       |  6 ------
>  arch/sh/include/asm/processor_32.h      |  6 ------
>  arch/sh/include/asm/processor_64.h      | 15 ---------------
>  arch/sparc/include/asm/processor_32.h   |  6 ------
>  arch/sparc/include/asm/processor_64.h   |  6 ------
>  arch/unicore32/include/asm/processor.h  |  6 ------
>  arch/x86/include/asm/kexec.h            |  3 ++-
>  arch/x86/include/asm/processor.h        | 12 ------------
>  arch/x86/um/asm/processor_32.h          |  8 --------
>  arch/x86/um/asm/processor_64.h          |  3 ---
>  arch/xtensa/include/asm/processor.h     |  8 --------
>  28 files changed, 2 insertions(+), 193 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/processor.h b/arch/alpha/include/asm/processor.h
> index cb05d045efe3..6100431da07a 100644
> --- a/arch/alpha/include/asm/processor.h
> +++ b/arch/alpha/include/asm/processor.h
> @@ -10,12 +10,6 @@
>  
>  #include <linux/personality.h>	/* for ADDR_LIMIT_32BIT */
>  
> -/*
> - * Returns current instruction pointer ("program counter").
> - */
> -#define current_text_addr() \
> -  ({ void *__pc; __asm__ ("br %0,.+4" : "=r"(__pc)); __pc; })
> -
>  /*
>   * We have a 42-bit user address space: 4TB user VM...
>   */
> diff --git a/arch/arc/include/asm/processor.h b/arch/arc/include/asm/processor.h
> index 8ee41e988169..10346d6cf926 100644
> --- a/arch/arc/include/asm/processor.h
> +++ b/arch/arc/include/asm/processor.h
> @@ -98,14 +98,6 @@ extern void start_thread(struct pt_regs * regs, unsigned long pc,
>  
>  extern unsigned int get_wchan(struct task_struct *p);
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - * Should the PC register be read instead ? This macro does not seem to
> - * be used in many places so this wont be all that bad.
> - */
> -#define current_text_addr() ({ __label__ _l; _l: &&_l; })
> -
>  #endif /* !__ASSEMBLY__ */
>  
>  /*
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index 1bf65b47808a..120f4c9bbfde 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -11,12 +11,6 @@
>  #ifndef __ASM_ARM_PROCESSOR_H
>  #define __ASM_ARM_PROCESSOR_H
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ __label__ _l; _l: &&_l;})
> -
>  #ifdef __KERNEL__
>  
>  #include <asm/hw_breakpoint.h>
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 79657ad91397..966214f473b4 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -25,13 +25,6 @@
>  #define USER_DS		(TASK_SIZE_64 - 1)
>  
>  #ifndef __ASSEMBLY__
> -
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ __label__ _l; _l: &&_l;})
> -
>  #ifdef __KERNEL__
>  
>  #include <linux/build_bug.h>
> diff --git a/arch/c6x/include/asm/processor.h b/arch/c6x/include/asm/processor.h
> index 8f7cce829f8e..a8581f5b27f6 100644
> --- a/arch/c6x/include/asm/processor.h
> +++ b/arch/c6x/include/asm/processor.h
> @@ -17,17 +17,6 @@
>  #include <asm/page.h>
>  #include <asm/current.h>
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr()			\
> -({						\
> -	void *__pc;				\
> -	asm("mvc .S2 pce1,%0\n" : "=b"(__pc));	\
> -	__pc;					\
> -})
> -
>  /*
>   * User space process size. This is mostly meaningless for NOMMU
>   * but some C6X processors may have RAM addresses up to 0xFFFFFFFF.
> diff --git a/arch/h8300/include/asm/processor.h b/arch/h8300/include/asm/processor.h
> index 985346393e4a..a060b41b2d31 100644
> --- a/arch/h8300/include/asm/processor.h
> +++ b/arch/h8300/include/asm/processor.h
> @@ -12,12 +12,6 @@
>  #ifndef __ASM_H8300_PROCESSOR_H
>  #define __ASM_H8300_PROCESSOR_H
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ __label__ _l; _l: &&_l; })
> -
>  #include <linux/compiler.h>
>  #include <asm/segment.h>
>  #include <asm/ptrace.h>
> diff --git a/arch/hexagon/include/asm/processor.h b/arch/hexagon/include/asm/processor.h
> index ce67940860a5..227bcb9cfdac 100644
> --- a/arch/hexagon/include/asm/processor.h
> +++ b/arch/hexagon/include/asm/processor.h
> @@ -27,9 +27,6 @@
>  #include <asm/registers.h>
>  #include <asm/hexagon_vm.h>
>  
> -/*  must be a macro  */
> -#define current_text_addr() ({ __label__ _l; _l: &&_l; })
> -
>  /*  task_struct, defined elsewhere, is the "process descriptor" */
>  struct task_struct;
>  
> diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
> index 10061ccf0440..c91ef98ed6bf 100644
> --- a/arch/ia64/include/asm/processor.h
> +++ b/arch/ia64/include/asm/processor.h
> @@ -602,12 +602,6 @@ ia64_set_unat (__u64 *unat, void *spill_addr, unsigned long nat)
>  	*unat = (*unat & ~mask) | (nat << bit);
>  }
>  
> -/*
> - * Get the current instruction/program counter value.
> - */
> -#define current_text_addr() \
> -	({ void *_pc; _pc = (void *)ia64_getreg(_IA64_REG_IP); _pc; })
> -
>  static inline __u64
>  ia64_get_ivr (void)
>  {
> diff --git a/arch/m68k/include/asm/processor.h b/arch/m68k/include/asm/processor.h
> index 464e9f5f50ee..3750819ac5a1 100644
> --- a/arch/m68k/include/asm/processor.h
> +++ b/arch/m68k/include/asm/processor.h
> @@ -8,12 +8,6 @@
>  #ifndef __ASM_M68K_PROCESSOR_H
>  #define __ASM_M68K_PROCESSOR_H
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ __label__ _l; _l: &&_l;})
> -
>  #include <linux/thread_info.h>
>  #include <asm/segment.h>
>  #include <asm/fpu.h>
> diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
> index 330d556860ba..66b537b8d138 100644
> --- a/arch/microblaze/include/asm/processor.h
> +++ b/arch/microblaze/include/asm/processor.h
> @@ -45,12 +45,6 @@ extern void ret_from_kernel_thread(void);
>   */
>  # define TASK_SIZE	(0x81000000 - 0x80000000)
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -# define current_text_addr() ({ __label__ _l; _l: &&_l; })
> -
>  /*
>   * This decides where the kernel will search for a free chunk of vm
>   * space during mmap's. We won't be using it
> @@ -92,12 +86,6 @@ extern unsigned long get_wchan(struct task_struct *p);
>  
>  #  ifndef __ASSEMBLY__
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#  define current_text_addr()	({ __label__ _l; _l: &&_l; })
> -
>  /* If you change this, you must change the associated assembly-languages
>   * constants defined below, THREAD_*.
>   */
> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> index b2fa62922d88..f08417f8772e 100644
> --- a/arch/mips/include/asm/processor.h
> +++ b/arch/mips/include/asm/processor.h
> @@ -22,11 +22,6 @@
>  #include <asm/mipsregs.h>
>  #include <asm/prefetch.h>
>  
> -/*
> - * Return current * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ __label__ _l; _l: &&_l;})
> -
>  /*
>   * System setup and hardware flags..
>   */
> diff --git a/arch/nds32/include/asm/processor.h b/arch/nds32/include/asm/processor.h
> index 9c83caf4269f..c2660f566bac 100644
> --- a/arch/nds32/include/asm/processor.h
> +++ b/arch/nds32/include/asm/processor.h
> @@ -4,12 +4,6 @@
>  #ifndef __ASM_NDS32_PROCESSOR_H
>  #define __ASM_NDS32_PROCESSOR_H
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ __label__ _l; _l: &&_l;})
> -
>  #ifdef __KERNEL__
>  
>  #include <asm/ptrace.h>
> diff --git a/arch/nios2/include/asm/processor.h b/arch/nios2/include/asm/processor.h
> index 4944e2e1d8b0..94bcb86f679f 100644
> --- a/arch/nios2/include/asm/processor.h
> +++ b/arch/nios2/include/asm/processor.h
> @@ -38,12 +38,6 @@
>  #define KUSER_SIZE		(PAGE_SIZE)
>  #ifndef __ASSEMBLY__
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ __label__ _l; _l: &&_l; })
> -
>  # define TASK_SIZE		0x7FFF0000UL
>  # define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
>  
> diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
> index af31a9fe736a..351d3aed7a06 100644
> --- a/arch/openrisc/include/asm/processor.h
> +++ b/arch/openrisc/include/asm/processor.h
> @@ -30,11 +30,6 @@
>  		   | SPR_SR_DCE | SPR_SR_SM)
>  #define USER_SR   (SPR_SR_DME | SPR_SR_IME | SPR_SR_ICE \
>  		   | SPR_SR_DCE | SPR_SR_IEE | SPR_SR_TEE)
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ __label__ _l; _l: &&_l; })
>  
>  /*
>   * User space process size. This is hardcoded into a few places,
> diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
> index 2dbe5580a1a4..0d7f64ef9c7d 100644
> --- a/arch/parisc/include/asm/processor.h
> +++ b/arch/parisc/include/asm/processor.h
> @@ -20,17 +20,6 @@
>  #include <asm/percpu.h>
>  #endif /* __ASSEMBLY__ */
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#ifdef CONFIG_PA20
> -#define current_ia(x)	__asm__("mfia %0" : "=r"(x))
> -#else /* mfia added in pa2.0 */
> -#define current_ia(x)	__asm__("blr 0,%0\n\tnop" : "=r"(x))
> -#endif
> -#define current_text_addr() ({ void *pc; current_ia(pc); pc; })
> -
>  #define HAVE_ARCH_PICK_MMAP_LAYOUT
>  
>  #define TASK_SIZE_OF(tsk)       ((tsk)->thread.task_size)
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 52fadded5c1e..1fff74df06e6 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -67,12 +67,6 @@ extern int _chrp_type;
>  
>  #endif /* defined(__KERNEL__) && defined(CONFIG_PPC32) */
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ __label__ _l; _l: &&_l;})
> -
>  /* Macros for adjusting thread priority (hardware multi-threading) */
>  #define HMT_very_low()   asm volatile("or 31,31,31   # very low priority")
>  #define HMT_low()	 asm volatile("or 1,1,1	     # low priority")
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 3fe4af8147d2..020e35947060 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -33,12 +33,6 @@
>  struct task_struct;
>  struct pt_regs;
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr()	({ __label__ _l; _l: &&_l; })
> -
>  /* CPU-specific state of a task */
>  struct thread_struct {
>  	/* Callee-saved registers */
> diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
> index 7f2953c15c37..f8028d37bb18 100644
> --- a/arch/s390/include/asm/processor.h
> +++ b/arch/s390/include/asm/processor.h
> @@ -73,12 +73,6 @@ static inline int test_cpu_flag_of(int flag, int cpu)
>  
>  #define arch_needs_cpu() test_cpu_flag(CIF_NOHZ_DELAY)
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ void *pc; asm("basr %0,0" : "=a" (pc)); pc; })
> -
>  static inline void get_cpu_id(struct cpuid *ptr)
>  {
>  	asm volatile("stidp %0" : "=Q" (*ptr));
> diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
> index 95100d8a0b7b..0e0ecc0132e3 100644
> --- a/arch/sh/include/asm/processor_32.h
> +++ b/arch/sh/include/asm/processor_32.h
> @@ -16,12 +16,6 @@
>  #include <asm/types.h>
>  #include <asm/hw_breakpoint.h>
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ void *pc; __asm__("mova	1f, %0\n.align 2\n1:":"=z" (pc)); pc; })
> -
>  /* Core Processor Version Register */
>  #define CCN_PVR		0xff000030
>  #define CCN_CVR		0xff000040
> diff --git a/arch/sh/include/asm/processor_64.h b/arch/sh/include/asm/processor_64.h
> index 777a16318aff..f3d7075648d0 100644
> --- a/arch/sh/include/asm/processor_64.h
> +++ b/arch/sh/include/asm/processor_64.h
> @@ -19,21 +19,6 @@
>  #include <asm/types.h>
>  #include <cpu/registers.h>
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ \
> -void *pc; \
> -unsigned long long __dummy = 0; \
> -__asm__("gettr	tr0, %1\n\t" \
> -	"pta	4, tr0\n\t" \
> -	"gettr	tr0, %0\n\t" \
> -	"ptabs	%1, tr0\n\t"	\
> -	:"=r" (pc), "=r" (__dummy) \
> -	: "1" (__dummy)); \
> -pc; })
> -
>  #endif
>  
>  /*
> diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/processor_32.h
> index 192493c257fa..3c4bc2189092 100644
> --- a/arch/sparc/include/asm/processor_32.h
> +++ b/arch/sparc/include/asm/processor_32.h
> @@ -7,12 +7,6 @@
>  #ifndef __ASM_SPARC_PROCESSOR_H
>  #define __ASM_SPARC_PROCESSOR_H
>  
> -/*
> - * Sparc32 implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ void *pc; __asm__("sethi %%hi(1f), %0; or %0, %%lo(1f), %0;\n1:" : "=r" (pc)); pc; })
> -
>  #include <asm/psr.h>
>  #include <asm/ptrace.h>
>  #include <asm/head.h>
> diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
> index aac23d4a4ddd..5cf145f18f36 100644
> --- a/arch/sparc/include/asm/processor_64.h
> +++ b/arch/sparc/include/asm/processor_64.h
> @@ -8,12 +8,6 @@
>  #ifndef __ASM_SPARC64_PROCESSOR_H
>  #define __ASM_SPARC64_PROCESSOR_H
>  
> -/*
> - * Sparc64 implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ void *pc; __asm__("rd %%pc, %0" : "=r" (pc)); pc; })
> -
>  #include <asm/asi.h>
>  #include <asm/pstate.h>
>  #include <asm/ptrace.h>
> diff --git a/arch/unicore32/include/asm/processor.h b/arch/unicore32/include/asm/processor.h
> index 4eaa42167667..b772ed1c0f25 100644
> --- a/arch/unicore32/include/asm/processor.h
> +++ b/arch/unicore32/include/asm/processor.h
> @@ -13,12 +13,6 @@
>  #ifndef __UNICORE_PROCESSOR_H__
>  #define __UNICORE_PROCESSOR_H__
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr() ({ __label__ _l; _l: &&_l; })
> -
>  #ifdef __KERNEL__
>  
>  #include <asm/ptrace.h>
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index f327236f0fa7..86924d594ecd 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -21,6 +21,7 @@
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/string.h>
> +#include <linux/kernel.h>
>  
>  #include <asm/page.h>
>  #include <asm/ptrace.h>
> @@ -132,7 +133,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
>  		asm volatile("movl %%cs, %%eax;" :"=a"(newregs->cs));
>  		asm volatile("pushfq; popq %0" :"=m"(newregs->flags));
>  #endif
> -		newregs->ip = (unsigned long)current_text_addr();
> +		newregs->ip = _THIS_IP_;
>  	}
>  }
>  
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 682286aca881..20080b303605 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -42,18 +42,6 @@ struct vm86;
>  #define NET_IP_ALIGN	0
>  
>  #define HBP_NUM 4
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -static inline void *current_text_addr(void)
> -{
> -	void *pc;
> -
> -	asm volatile("mov $1f, %0; 1:":"=r" (pc));
> -
> -	return pc;
> -}
>  
>  /*
>   * These alignment constraints are for performance in the vSMP case,
> diff --git a/arch/x86/um/asm/processor_32.h b/arch/x86/um/asm/processor_32.h
> index c112de81c9e1..5fb1b8449adf 100644
> --- a/arch/x86/um/asm/processor_32.h
> +++ b/arch/x86/um/asm/processor_32.h
> @@ -47,14 +47,6 @@ static inline void arch_copy_thread(struct arch_thread *from,
>          memcpy(&to->tls_array, &from->tls_array, sizeof(from->tls_array));
>  }
>  
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter"). Stolen
> - * from asm-i386/processor.h
> - */
> -#define current_text_addr() \
> -	({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); pc; })
> -
>  #define current_sp() ({ void *sp; __asm__("movl %%esp, %0" : "=r" (sp) : ); sp; })
>  #define current_bp() ({ unsigned long bp; __asm__("movl %%ebp, %0" : "=r" (bp) : ); bp; })
>  
> diff --git a/arch/x86/um/asm/processor_64.h b/arch/x86/um/asm/processor_64.h
> index c3be85205a65..1ef9c21877bc 100644
> --- a/arch/x86/um/asm/processor_64.h
> +++ b/arch/x86/um/asm/processor_64.h
> @@ -31,9 +31,6 @@ static inline void arch_copy_thread(struct arch_thread *from,
>  	to->fs = from->fs;
>  }
>  
> -#define current_text_addr() \
> -	({ void *pc; __asm__("movq $1f,%0\n1:":"=g" (pc)); pc; })
> -
>  #define current_sp() ({ void *sp; __asm__("movq %%rsp, %0" : "=r" (sp) : ); sp; })
>  #define current_bp() ({ unsigned long bp; __asm__("movq %%rbp, %0" : "=r" (bp) : ); bp; })
>  
> diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
> index 5b0027d4ecc0..68891c992105 100644
> --- a/arch/xtensa/include/asm/processor.h
> +++ b/arch/xtensa/include/asm/processor.h
> @@ -153,14 +153,6 @@ struct thread_struct {
>  	int align[0] __attribute__ ((aligned(16)));
>  };
>  
> -
> -/*
> - * Default implementation of macro that returns current
> - * instruction pointer ("program counter").
> - */
> -#define current_text_addr()  ({ __label__ _l; _l: &&_l;})
> -
> -
>  /* This decides where the kernel will search for a free chunk of vm
>   * space during mmap's.
>   */
> 
