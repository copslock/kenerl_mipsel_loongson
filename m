Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2010 02:40:46 +0200 (CEST)
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:49764 "EHLO
        fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491146Ab0JYAkn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Oct 2010 02:40:43 +0200
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
        by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id o9P0eWDe022040
        (envelope-from kosaki.motohiro@jp.fujitsu.com);
        Mon, 25 Oct 2010 09:40:32 +0900
Received: from smail (m2 [127.0.0.1])
        by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5410045DE51;
        Mon, 25 Oct 2010 09:40:32 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
        by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 346C645DE4F;
        Mon, 25 Oct 2010 09:40:32 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
        by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 200A71DB803A;
        Mon, 25 Oct 2010 09:40:32 +0900 (JST)
Received: from m108.s.css.fujitsu.com (m108.s.css.fujitsu.com [10.249.87.108])
        by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D684B1DB8038;
        Mon, 25 Oct 2010 09:40:28 +0900 (JST)
Received: from m108.css.fujitsu.com (m108 [127.0.0.1])
        by m108.s.css.fujitsu.com (Postfix) with ESMTP id A693342805F;
        Mon, 25 Oct 2010 09:40:28 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.124.101.153])
        by m108.s.css.fujitsu.com (Postfix) with ESMTP id 1D630428060;
        Mon, 25 Oct 2010 09:40:28 +0900 (JST)
X-SecurityPolicyCheck-FJ: OK by FujitsuOutboundMailChecker v1.3.1
Received: from KOSANOTE2[10.124.101.153] by KOSANOTE2 (FujitsuOutboundMailChecker v1.3.1/9992[10.124.101.153]); Mon, 25 Oct 2010 09:40:50 +0900 (JST)
From:   KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: MT: Fix build error iFPU affinity code
Cc:     kosaki.motohiro@jp.fujitsu.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        James Morris <jmorris@namei.org>
In-Reply-To: <20101024212350.GA18747@linux-mips.org>
References: <20101024212350.GA18747@linux-mips.org>
Message-Id: <20101025093921.9151.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.50.07 [ja]
Date:   Mon, 25 Oct 2010 09:40:28 +0900 (JST)
Return-Path: <kosaki.motohiro@jp.fujitsu.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kosaki.motohiro@jp.fujitsu.com
Precedence: bulk
X-list: linux-mips

> > commit b0ae19811375031ae3b3fecc65b702a9c6e5cc28
> > Author: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> > Date:   Fri Oct 15 04:21:18 2010 +0900
> >
> >     security: remove unused parameter from security_task_setscheduler()
> 
> broke the build of arch/mips/kernel/mips-mt-fpaff.c.  The function
> arguments were unnecessary, not the semicolon ...
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
>  arch/mips/kernel/mips-mt-fpaff.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
> index 9a526ba..802e616 100644
> --- a/arch/mips/kernel/mips-mt-fpaff.c
> +++ b/arch/mips/kernel/mips-mt-fpaff.c
> @@ -103,7 +103,7 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
>  	if (!check_same_owner(p) && !capable(CAP_SYS_NICE))
>  		goto out_unlock;
>  
> -	retval = security_task_setscheduler(p)
> +	retval = security_task_setscheduler(p);
>  	if (retval)
>  		goto out_unlock;
>  

Agh! Thank you for fixing this!
