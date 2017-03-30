Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2017 17:42:25 +0200 (CEST)
Received: from mail-lf0-x22f.google.com ([IPv6:2a00:1450:4010:c07::22f]:35730
        "EHLO mail-lf0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992881AbdC3PmRJcxu0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Mar 2017 17:42:17 +0200
Received: by mail-lf0-x22f.google.com with SMTP id j90so30082345lfk.2
        for <linux-mips@linux-mips.org>; Thu, 30 Mar 2017 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=w/1+E1zaqrlEIilD9mZ+mMLzn8/xKqp3yTw0Gt/ZS9w=;
        b=koGyZzCuomrJ8AgULsaHKK/IMOs4pMgG8BnIOefBJE3ahU2pqLavSaR6avTno2FOHn
         Pq0QaGKWqxSnXFUaH/OtDI9VfPa5zHvM2TZpihk+7HjPxmK7Ah2x05gdmarzPQ3mWVP/
         BtbwwkBpTfpbCgMZ01qUwDGU1aUm3kYHWa1Yb6Pje3ctXClpyq1o3a0rl9Ext7ybdTVo
         Gsu3hg2pTnR3wvvvUqLlzFQZ0TEe48ZQsCmC46Jnb6bwaFCJYh/EODIBKyeDhWKmTKvQ
         0gesegkbg+NRg2QAZjAeXev57fjDiAqtrfI94c1hcV/P2mu4Uo2HZAxtYyKq4TBcNwQB
         +ZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=w/1+E1zaqrlEIilD9mZ+mMLzn8/xKqp3yTw0Gt/ZS9w=;
        b=ZwDBIa5cqKGofULwXmOJYJ08RcFzvKCcBVo9hfot0SYKjoUyrn1t7LwIkedqSGeo8A
         OBxhPFSBsf81W58VElJ0MNfoSffHv3+MNuiv5jeuIT9Euv0Hp5bsfUeKVyCFDj95qtPl
         NlpfFfvNYAkIARUx9cVNfEfYKxwjumacOnOGt254EYcFgNPQF4hDI3fPm0UoXUHyjmzp
         UFWPL89SpT73mJ+5TSIsXiTg99ZjrzJIArzUv1KvCHR/Syus553/Ij3SPXAdLHwBeTLz
         4VaeBv2wIyZCuRQpXF7ru5v7QsurJy/tyIFEIKjP7M0RpDxLR++yMuCXL+AuGi1OEUxJ
         /qew==
X-Gm-Message-State: AFeK/H3JPUyq52C8B76nnqGxXEERmewGOIHWZXHr/krZQbo49ajnlEHPO48YN5GQskrgOA==
X-Received: by 10.46.21.13 with SMTP id s13mr135200ljd.112.1490888531745;
        Thu, 30 Mar 2017 08:42:11 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.138])
        by smtp.gmail.com with ESMTPSA id 11sm412389ljv.67.2017.03.30.08.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Mar 2017 08:42:10 -0700 (PDT)
Subject: Re: [PATCH] MIPS: KGDB: Use kernel context for sleeping threads
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <c34c16db9efabb09ca200d5b2b14ad0e870a0b1c.1490876180.git-series.james.hogan@imgtec.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-mips@linux-mips.org, stable@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <b8d4921a-2a88-c69d-1272-5589a0bfbbe9@cogentembedded.com>
Date:   Thu, 30 Mar 2017 18:42:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <c34c16db9efabb09ca200d5b2b14ad0e870a0b1c.1490876180.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello!

On 03/30/2017 06:06 PM, James Hogan wrote:

> KGDB is a kernel debug stub and it can't be used to debug userland as it
> can only safely access kernel memory.
>
> On MIPS however KGDB has always got the register state of sleeping
> processes from the userland register context at the beginning of the
> kernel stack. This is meaningless for kernel threads (which never enter
> userland), and for user threads it prevents the user seeing what it is
> doing while in the kernel:
>
> (gdb) info threads
>   Id   Target Id         Frame
>   ...
>   3    Thread 2 (kthreadd) 0x0000000000000000 in ?? ()
>   2    Thread 1 (init)   0x000000007705c4b4 in ?? ()
>   1    Thread -2 (shadowCPU0) 0xffffffff8012524c in arch_kgdb_breakpoint () at arch/mips/kernel/kgdb.c:201
>
> Get the register state instead from the (partial) kernel register
> context stored in the task's thread_struct for resume() to restore. All
> threads now correctly appear to be in context_switch():
>
> (gdb) info threads
>   Id   Target Id         Frame
>   ...
>   3    Thread 2 (kthreadd) context_switch (rq=<optimized out>, cookie=..., next=<optimized out>, prev=0x0) at kernel/sched/core.c:2903
>   2    Thread 1 (init)   context_switch (rq=<optimized out>, cookie=..., next=<optimized out>, prev=0x0) at kernel/sched/core.c:2903
>   1    Thread -2 (shadowCPU0) 0xffffffff8012524c in arch_kgdb_breakpoint () at arch/mips/kernel/kgdb.c:201
>
> Call clobbered registers which aren't saved and exception registers
> (BadVAddr & Cause) which can't be easily determined without stack
> unwinding are reported as 0. The PC is taken from the return address,
> such that the state presented matches that found immediately after
> returning from resume().
>
> Fixes: 8854700115ec ("[MIPS] kgdb: add arch support for the kernel's kgdb core")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: linux-mips@linux-mips.org
> Cc: stable@vger.kernel.org
> ---
>  arch/mips/kernel/kgdb.c | 48 ++++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 15 deletions(-)
>
> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
> index 1f4bd222ba76..eb6c0d582626 100644
> --- a/arch/mips/kernel/kgdb.c
> +++ b/arch/mips/kernel/kgdb.c
[...]
> @@ -254,25 +251,46 @@ void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
>  #endif
>
>  	for (reg = 0; reg < 16; reg++)
> -		*(ptr++) = regs->regs[reg];
> +		*(ptr++) = 0;

    Parens are not really necessary, you can get rid of them, while at it.

[...]

MBR, Sergei
