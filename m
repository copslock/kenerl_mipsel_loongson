Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2013 18:30:18 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:5425 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815753Ab3LTRaPh1mNx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Dec 2013 18:30:15 +0100
Message-ID: <52B47DE8.1040905@imgtec.com>
Date:   Fri, 20 Dec 2013 17:27:04 +0000
From:   Alex Smith <alex.smith@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips: fix 64-bit compilation error without CONFIG_MIPS32_O32
References: <1387557067-51026-1-git-send-email-alex.smith@imgtec.com> <CACtiza=_eWy2CwUSUmBQReSduCx_+UwtV0yU43GBBbA4FjZ60g@mail.gmail.com>
In-Reply-To: <CACtiza=_eWy2CwUSUmBQReSduCx_+UwtV0yU43GBBbA4FjZ60g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.73]
X-SEF-Processed: 7_3_0_01192__2013_12_20_17_27_10
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

On 20/12/13 16:48, Dmitri Vorobiev wrote:
> Hi,
>
> Maybe it would be better to place the variable definition under
>
> #ifdef CONFIG_32BIT || (CONFIG_64BIT && CONFIG_64BIT_O32)
> #endif
>
> In my opinion those pseudo-qualifiers, which simply silence the
> compiler, are harmful, because they hide the problem instead of solving it.
>
> Thanks,
> Dmitri

I originally did so, but changed it to __maybe_unused as the ifdef block 
is somewhat ugly. The compiler is sensible to optimize the variable away 
when it is unused.

I can change it if others also feel that wrapping it in ifdef would be 
better.

Thanks,
Alex

>
>
> On Fri, Dec 20, 2013 at 6:31 PM, Alex Smith <alex.smith@imgtec.com
> <mailto:alex.smith@imgtec.com>> wrote:
>
>     Attempting to compile a 64-bit kernel without CONFIG_MIPS32_O32 defined
>     (using GCC 4.8.1) results in the following compilation error:
>
>     arch/mips/include/asm/syscall.h: In function 'mips_get_syscall_arg':
>     arch/mips/include/asm/syscall.h:32:16: error: unused variable 'usp'
>     [-Werror=unused-variable]
>
>     Fix by adding __maybe_unsued to the definition of usp.
>
>     Signed-off-by: Alex Smith <alex.smith@imgtec.com
>     <mailto:alex.smith@imgtec.com>>
>     Reviewed-by: Markos Chandras <markos.chandras@imgtec.com
>     <mailto:markos.chandras@imgtec.com>>
>     ---
>       arch/mips/include/asm/syscall.h | 2 +-
>       1 file changed, 1 insertion(+), 1 deletion(-)
>
>     diff --git a/arch/mips/include/asm/syscall.h
>     b/arch/mips/include/asm/syscall.h
>     index 81c8913..c48f8d8 100644
>     --- a/arch/mips/include/asm/syscall.h
>     +++ b/arch/mips/include/asm/syscall.h
>     @@ -29,7 +29,7 @@ static inline long syscall_get_nr(struct
>     task_struct *task,
>       static inline unsigned long mips_get_syscall_arg(unsigned long *arg,
>              struct task_struct *task, struct pt_regs *regs, unsigned int n)
>       {
>     -       unsigned long usp = regs->regs[29];
>     +       unsigned long __maybe_unused usp = regs->regs[29];
>
>              switch (n) {
>              case 0: case 1: case 2: case 3:
>     --
>     1.8.5.2
>
>
>
>
