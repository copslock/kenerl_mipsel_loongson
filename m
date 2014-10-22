Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 09:12:12 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:58457 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011261AbaJVHMJkcWeG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Oct 2014 09:12:09 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 1750E281473;
        Wed, 22 Oct 2014 09:10:41 +0200 (CEST)
Received: from dicker-alter.lan (p548C87DD.dip0.t-ipconnect.de [84.140.135.221])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed, 22 Oct 2014 09:10:41 +0200 (CEST)
Message-ID: <544758AB.3060100@openwrt.org>
Date:   Wed, 22 Oct 2014 09:11:39 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     eunb.song@samsung.com, "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mips: add arch_trigger_all_cpu_backtrace() function
References: <1061520101.169091413960858532.JavaMail.weblogic@epmlwas02b>
In-Reply-To: <1061520101.169091413960858532.JavaMail.weblogic@epmlwas02b>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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



On 22/10/2014 08:54, Eunbong Song wrote:
> 
>> Hi Eubong,
> 
>> one small question inline ...
> 
>>> +void arch_trigger_all_cpu_backtrace(bool); +#define
>>> arch_trigger_all_cpu_backtrace arch_trigger_all_cpu_backtrace
> 
>> What is the purpose of this define ? is this maybe a leftover from
>> some regex/cleanups ?
> 
> Hi John.
> Actually, I just follow the same function of sparc architecture.
> You can find this in arch/sparc/include/asm/irq_64.h as below
> 
> void arch_trigger_all_cpu_backtrace(bool);
> #define arch_trigger_all_cpu_backtrace arch_trigger_all_cpu_backtrace
> 
> I guess this is used for conditional compile. 
> See below.
> include/linux/nmi.h
> #ifdef arch_trigger_all_cpu_backtrace
> static inline bool trigger_all_cpu_backtrace(void)
> {
>         arch_trigger_all_cpu_backtrace(true);
> 
>         return true;
> }
> static inline bool trigger_allbutself_cpu_backtrace(void)
> {
>         arch_trigger_all_cpu_backtrace(false);
>         return true;
> }
> #else
> static inline bool trigger_all_cpu_backtrace(void)
> {
>         return false;
> }
> static inline bool trigger_allbutself_cpu_backtrace(void)
> {
>         return false;
> }
> #endif
> 
> Thanks. 
>> John
> 

i don't see how this is required for conditional compiles. the code
define a->a which is bogus i think.

	John
