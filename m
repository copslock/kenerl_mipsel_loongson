Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Mar 2017 10:38:28 +0100 (CET)
Received: from mail-lf0-x22b.google.com ([IPv6:2a00:1450:4010:c07::22b]:34186
        "EHLO mail-lf0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991232AbdCEJiQsUR8N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Mar 2017 10:38:16 +0100
Received: by mail-lf0-x22b.google.com with SMTP id k202so61793612lfe.1
        for <linux-mips@linux-mips.org>; Sun, 05 Mar 2017 01:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=uZJsmvnFeayX/+UfVXParLuw00a5Loodu03EwTiUmPc=;
        b=mH/mPX/6I+WSKX0mQy+spJtGjdT2zXzBHlBLfO3hTuchGT7Qyge9g2JSFQGdQ2URb8
         h18PCTyLsFDF+jSMFgEnNcsx/X90jYYo85HErM+qehPndJRzQjrAdx0aXdHm4zvEOby5
         2NpT/Hg9HnKxlyk/1VRRfbTyp4e2setwVdeUDvu0bZCl937XJ/oE4aTZzryvJCtNFTD4
         y/7NdOpkP9DeQ2Q4R+XDN+ueGJD5u1DNjT/wvG6t9LnbcyT+7ylCgN72zyxvAVZvMzb5
         JFxfP/FKlsGEUD6vjOq9rWKn8CFmb8ZNZMFt5lIB3FrQyHshfJjGsQCQznsBbalFY8Sd
         sfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=uZJsmvnFeayX/+UfVXParLuw00a5Loodu03EwTiUmPc=;
        b=i4xVojzsS+UxxmFQtM0lFoTRQp+KjqoUH0ec1V/6xVPJsD5WSZY4GGKgLdK9zVuQH0
         IgpdXB7p4RB6b5payCY5FSk8QbqJ7xnCg+NNxC8x0ARVwo0flA8TMWbvdCTBz50rxR1A
         jiXc9V/OhoDJcLH/sHBx1tido3D+t+pU6fTvckAKIKnkkSTHoQsSkESQsCefhkdzehA9
         yxr9y60ByZ32DFzLn6Hx7xRcsJGd7OcwVHdLw6LicWGoRnptmiUPO4IOVMmUftJ8jsln
         ycTqtUhXSg/eREonlEjKBDDOsxLJlRCgjcLImfQPqk/pCUhdmLcJVvxGNd/aQKnzjUoY
         a4zg==
X-Gm-Message-State: AMke39lTx3+hectOaQE+T0800t4S2SjCcg5/ok9Jd3Nb9nTQjtOJRLDx6I/ScdJYl6C0qg==
X-Received: by 10.46.84.78 with SMTP id y14mr3565034ljd.63.1488706691238;
        Sun, 05 Mar 2017 01:38:11 -0800 (PST)
Received: from [192.168.4.126] ([31.173.84.5])
        by smtp.gmail.com with ESMTPSA id 12sm3350243ljv.42.2017.03.05.01.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Mar 2017 01:38:09 -0800 (PST)
Subject: Re: [PATCH] MIPS: reset all task's asid to 0 after asid_cache(cpu)
 overflows
To:     Jiwei Sun <jiwei.sun@windriver.com>, ralf@linux-mips.org,
        paul.burton@imgtec.com, james.hogan@imgtec.com
References: <1488684260-18867-1-git-send-email-jiwei.sun@windriver.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        jiwei.sun.bj@qq.com
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <6054d364-5095-d13b-ebf8-a7b6bf8b2024@cogentembedded.com>
Date:   Sun, 5 Mar 2017 12:38:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1488684260-18867-1-git-send-email-jiwei.sun@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57042
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

On 3/5/2017 6:24 AM, Jiwei Sun wrote:

> If asid_cache(cpu) overflows, there may be two tasks with the same
> asid. It is a risk that the two different tasks may have the same
> address space.
>
> A process will update its asid to newer version only when switch_mm()
> is called and matches the following condition:
>     if ((cpu_context(cpu, next) ^ asid_cache(cpu))
>                     & asid_version_mask(cpu))
>             get_new_mmu_context(next, cpu);
> If asid_cache(cpu) overflows, cpu_context(cpu,next) and asid_cache(cpu)
> will be reset to asid_first_version(cpu), and start a new cycle. It
> can result in two tasks that have the same ASID in the process list.
>
> For example, in CONFIG_CPU_MIPS32_R2, task named A's asid on CPU1 is
> 0x100, and has been sleeping and been not scheduled. After a long period
> of time, another running task named B's asid on CPU1 is 0xffffffff, and
> asid cached in the CPU1 is 0xffffffff too, next task named C is forked,
> when schedule from B to C on CPU1, asid_cache(cpu) will overflow, so C's
> asid on CPU1 will be 0x100 according to get_new_mmu_context(). A's asid
> is the same as C, if now A is rescheduled on CPU1, A's asid is not able
> to renew according to 'if' clause, and the local TLB entry can't be
> flushed too, A's address space will be the same as C.
>
> If asid_cache(cpu) overflows, all of user space task's asid on this CPU
> are able to set a invalid value (such as 0), it will avoid the risk.
>
> Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
> ---
>  arch/mips/include/asm/mmu_context.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
> index ddd57ad..1f60efc 100644
> --- a/arch/mips/include/asm/mmu_context.h
> +++ b/arch/mips/include/asm/mmu_context.h
> @@ -108,8 +108,15 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
>  #else
>  		local_flush_tlb_all();	/* start new asid cycle */
>  #endif
> -		if (!asid)		/* fix version if needed */
> +		if (!asid) {		/* fix version if needed */
> +			struct task_struct *p;
> +
> +			for_each_process(p) {
> +				if ((p->mm))

    Why double parens?

> +					cpu_context(cpu, p->mm) = 0;
> +			}
>  			asid = asid_first_version(cpu);
> +		}
>  	}
>
>  	cpu_context(cpu, mm) = asid_cache(cpu) = asid;

MBR, Sergei
