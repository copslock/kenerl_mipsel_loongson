Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 16:53:43 +0200 (CEST)
Received: from smtp24.services.sfr.fr ([93.17.128.83]:15952 "EHLO
        smtp24.services.sfr.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868571Ab3JCOxgv9gQ2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Oct 2013 16:53:36 +0200
Received: from filter.sfr.fr (localhost [127.0.0.1])
        by msfrf2419.sfr.fr (SMTP Server) with ESMTP id 2FE4F70000B7;
        Thu,  3 Oct 2013 16:53:31 +0200 (CEST)
Received: from [192.168.123.10] (138.35.3.109.rev.sfr.net [109.3.35.138])
        by msfrf2419.sfr.fr (SMTP Server) with ESMTP id D82D970000A3;
        Thu,  3 Oct 2013 16:53:30 +0200 (CEST)
X-SFR-UUID: 20131003145330885.D82D970000A3@msfrf2419.sfr.fr
Message-ID: <524D84EB.8060102@efixo.com>
Date:   Thu, 03 Oct 2013 16:53:31 +0200
From:   Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130923
        Thunderbird/17.0.9
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: fix forced successful syscalls
References: <1380550969-9522-1-git-send-email-tanguy.bouzeloc@efixo.com>
        <20131002091909.GA23236@linux-mips.org>
In-Reply-To: <20131002091909.GA23236@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tanguy.bouzeloc@efixo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanguy.bouzeloc@efixo.com
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

On 10/02/2013 11:19 AM, Ralf Baechle wrote:
> To my personal embarassment I have to admit that I knew about this since the
> day the syscall wrapper was written - but was considering it an acceptable
> bug ...
>
> Where it really bits is sigreturn and similar which use the following
> stunt:
>
>          /*
>           * Don't let your children do this ...
>           */
>          __asm__ __volatile__(
>                  "move\t$29, %0\n\t"
>                  "j\tsyscall_exit"
>                  :/* no outputs */
>                  :"r" (&regs));
>          /* Unreached */
>
> to keep the syscall return path from tampering with the return value.
>
> The scall*.S part of your patch is clearing TIF_NOERROR using a non-atomic
> LW/SW sequence.  This needs to be done atomically or the thread's flags
> variable might get corrupted.  This is complicated by MIPS I, R5900 and
> afair some older oddball not-quite MIPS II CPUs lacking LL/SC rsp. LLD/SCD.
>
>    Ralf
>

I discover the issue when changing the HZ of the kernel to 100HZ, in 
this case the jiffies returned to the userland are the same as the 
kernel ticks and it'll wrap after 5 minutes of uptime. With kernel HZ at 
250 or 1000H it'll make happen the ticks wrap after 230~260j.

Unfortunately programs relying on ticks (they shouldn't but that 
happens) have unpredictable behavior for 11.3s before the wrap.

I can update the patch in order to access atomically the thread flags, 
the point is ... it'll make the kernel incompatible with old hardware.

Regards,
Tanguy.
