Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Aug 2018 01:22:01 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.136]:60499 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993941AbeHZXV6kH3Sw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Aug 2018 01:21:58 +0200
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w7QNKPiK367410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 26 Aug 2018 16:20:25 -0700
Subject: Re: [PATCH] treewide: remove current_text_addr
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Helge Deller <deller@gmx.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc:     ebiederm@xmission.com, tglx@linutronix.de, mingo@redhat.com,
        horms@verge.net.au, natechancellor@gmail.com, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        Richard Henderson <rth@twiddle.net>,
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
        linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
Message-ID: <e425d208-214b-06a2-a032-7442a10388fc@zytor.com>
Date:   Sun, 26 Aug 2018 16:20:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
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

On 08/26/18 12:30, H. Peter Anvin wrote:
> Here is a full-blown (user space) test program demonstrating the whole
> technique and how to use it.
> 
> 	-hpa

Incidentally, it looks like _RET_IP_ really should be defined as:


/*
 * Is there any reason whatsoever to have _RET_IP_ an unsigned int
 * rather than a pointer throughout?
 */

#define _RET_IP_PTR_ \
	__builtin_extract_return_addr(__builtin_return_addr(0))
#define _RET_IP_ ((unsigned long)_RET_IP_PTR_)

On some architectures __builtin_extract_return_addr() is apparently
necessary; its a nop on x86.  Why that isn't part of
__builtin_return_addr() one can really wonder.

So, checking into all of this, the generic _THIS_IP_ DOES NOT WORK on
x86.  I have tried a tons of variants, including adding various asm
volatile(...) instructions, and no matter what I do, it will always
return the address of the surrounding function rather than any kind of
local IP.  The only way to get a localized address seems to be in
assembly, but even so, there is absolutely no guarantee that the value
of _THIS_IP_ has anything to do with where the code is otherwise
localized in the function.

From examining the output of gcc, the fundamental problem seems to be
that *no matter what* one do with the label, unless gcc actually
produces a computed goto somewhere in the code, that it can't remove
with dead-code elimination or constant propagation, it will arbitrarily
hoist the labels all the way to the beginning of the function. Given
that, I suspect that other versions of gcc might have similar problems.

This is the closest thing to arch-neutral I have been able to find that
also works on x86, while not at the same time horribly polluting the
namespace:

#define __here(n) ___here_ ## n
#define __hereasm(n) ".L___here_" #n
#define _THIS_IP_CTR_(n)					\
	({							\
		extern const char __here(n) asm(__hereasm(n));	\
		asm volatile(__hereasm(n) ": /* _THIS_IP_ */"); \
		(unsigned long)&__here(n);			\
	})
#define _THIS_IP_ _THIS_IP_CTR_(__COUNTER__)

The use of asm volatile() to define a label means that the position in
the instruction stream is at least reasonably well-defined.

	-hpa
