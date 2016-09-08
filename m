Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2016 20:35:39 +0200 (CEST)
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:58710 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991346AbcIHSfclMkk0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Sep 2016 20:35:32 +0200
Received: from us02secmta1.synopsys.com (us02secmta1.synopsys.com [10.12.235.96])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 16F7324E0421;
        Thu,  8 Sep 2016 11:35:23 -0700 (PDT)
Received: from us02secmta1.internal.synopsys.com (us02secmta1.internal.synopsys.com [127.0.0.1])
        by us02secmta1.internal.synopsys.com (Service) with ESMTP id D07744E213;
        Thu,  8 Sep 2016 11:35:23 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by us02secmta1.internal.synopsys.com (Service) with ESMTP id E361F4E202;
        Thu,  8 Sep 2016 11:35:22 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id A3325677;
        Thu,  8 Sep 2016 11:35:22 -0700 (PDT)
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 40D7866D;
        Thu,  8 Sep 2016 11:35:20 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Thu, 8 Sep 2016 11:34:51 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Fri, 9 Sep 2016 00:04:48 +0530
Received: from [10.9.130.78] (10.9.130.78) by IN01WEHTCA.internal.synopsys.com
 (10.144.199.243) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 9 Sep
 2016 00:04:48 +0530
Subject: Re: [PATCH] atomic64: No need for
 CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
To:     Peter Zijlstra <peterz@infradead.org>
References: <1473352098-5822-1-git-send-email-vgupta@synopsys.com>
 <20160908181905.GY10153@twins.programming.kicks-ass.net>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "Ingo Molnar" <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Matthew Wilcox <willy@linux.intel.com>,
        Matt Turner <mattst88@gmail.com>, Borislav Petkov <bp@suse.de>,
        Ming Lin <ming.l@ssi.samsung.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <a37b81a2-9634-255e-b20b-51e75913cb40@synopsys.com>
Date:   Thu, 8 Sep 2016 11:34:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160908181905.GY10153@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.9.130.78]
Return-Path: <Vineet.Gupta1@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vineet.Gupta1@synopsys.com
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

On 09/08/2016 11:19 AM, Peter Zijlstra wrote:
> On Thu, Sep 08, 2016 at 09:28:18AM -0700, Vineet Gupta wrote:
>> This came to light when implementing native 64-bit atomics for ARCv2.
>>
>> The atomic64 self-test code uses CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>> to check whether atomic64_dec_if_positive() is available.
>> It seems it was needed when not every arch defined it.
>> However as of current code the Kconfig option seems needless
>>
>> - for CONFIG_GENERIC_ATOMIC64 it is auto-enabled in lib/Kconfig and a
>>   generic definition of API is present lib/atomic64.c
>> - arches with native 64-bit atomics select it in arch/*/Kconfig and
>>   define the API in their headers
>>
>> So I see no point in keeping the Kconfig option
>>
>> Compile tested for 2 representatives:
>>  - blackfin (CONFIG_GENERIC_ATOMIC64)
>>  - x86 (!CONFIG_GENERIC_ATOMIC64)
>>
>> Also logistics wise it seemed simpler to just do this in 1 patch vs.
>> splitting per arch - but I can break it up if maintainer feel that
>> is better to avoid conflicts.
> Works for me; you want me to take this, or do you need it for you ARCv2
> patches?

Please do. ARCv2 patch (following shortly) doesn't need it - I selected the
option in orig patch - which I can just take out.

Thx,
-Vineet
