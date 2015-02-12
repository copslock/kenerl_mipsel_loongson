Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2015 14:45:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28141 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013304AbbBLNpPFa9gg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Feb 2015 14:45:15 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EF557A0EA0E42;
        Thu, 12 Feb 2015 13:45:06 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 12 Feb 2015 13:45:09 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 12 Feb
 2015 13:45:08 +0000
Message-ID: <54DCAE64.5050901@imgtec.com>
Date:   Thu, 12 Feb 2015 13:45:08 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Tony Wu <tung7970@gmail.com>, <ralf@linux-mips.org>
CC:     Lars Persson <larper@axis.com>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix syscall_trace_enter compilation error
References: <20150206004026-tung7970@googlemail.com>
In-Reply-To: <20150206004026-tung7970@googlemail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 02/05/2015 04:43 PM, Tony Wu wrote:
> Commit cf6ce084 (MIPS: Fix syscall_get_nr for the syscall exit
> tracing.) broke 3.13 and 3.14 stable tree due to the missing syscall
> argument. So, get the syscall from regs[2] before it's trashed.
> 
> This patch should go to the 3.13 and 3.14 stable tree.
> 
> Signed-off-by: Tony Wu <tung7970@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lars Persson <larper@axis.com>
> Cc: linux-mips@linux-mips.org
> 
> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> index 64e18f9..01f1413 100644
> --- a/arch/mips/kernel/ptrace.c
> +++ b/arch/mips/kernel/ptrace.c
> @@ -799,7 +799,7 @@ asmlinkage void syscall_trace_enter(struct pt_regs *regs)
>  	long ret = 0;
>  	user_exit();
>  
> -	current_thread_info()->syscall = syscall;
> +	current_thread_info()->syscall = regs->regs[2];
>  
>  	/* do the secure computing check first */
>  	secure_computing_strict(regs->regs[2]);
> 

Hi,

Commit cf6ce084 (MIPS: Fix syscall_get_nr for the syscall exit..) is not
in the stable branches. How did it brake the 3.13 and 3.14 build?

-- 
markos
