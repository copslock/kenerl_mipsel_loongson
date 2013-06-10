Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 13:50:21 +0200 (CEST)
Received: from mail-la0-f43.google.com ([209.85.215.43]:50483 "EHLO
        mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827461Ab3FJLt7sUjIt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 13:49:59 +0200
Received: by mail-la0-f43.google.com with SMTP id gw10so5663410lab.30
        for <linux-mips@linux-mips.org>; Mon, 10 Jun 2013 04:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=nmQcEXPEOBbnTHVSZTS0ZtnZEV6PFic2jklSRJsJ0Fk=;
        b=VyEyXaba0hM/h93GNDPUcMIiYz6ooqut8FNpcx4nc2n/+pHSBayDhiwQLLzOhBkDEt
         AqiuhAzTell68xvbhTwpBXctCJtetYlHglkexqCQsSusAbTMKT6pHC8kLsqzLgG0tNKd
         OR013gvnPweKGM6odLp7igAHdYCJF6qwRke3ljvcNpNahhBaloWTwmK2Ds3dMKyEocvO
         Hi4toH3kgrbT1yh36japM1WP5Be7lEajJNudsQZ25+jVqTTYIsDMn0MOaPTOceSeBNvi
         5XRc0QiyAfuOWBBK2wca3ON3YC6crv9R5SXKABy1beB7gVA/WQxvXcYzHf3esMsp5YWK
         4wuA==
X-Received: by 10.152.1.137 with SMTP id 9mr4867013lam.10.1370864993966;
        Mon, 10 Jun 2013 04:49:53 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-148-11.pppoe.mtu-net.ru. [91.76.148.11])
        by mx.google.com with ESMTPSA id c5sm5544827lbe.1.2013.06.10.04.49.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 04:49:53 -0700 (PDT)
Message-ID: <51B5BD5F.8090604@cogentembedded.com>
Date:   Mon, 10 Jun 2013 15:49:51 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: Re: [PATCH] MIPS: include: mmu_context.h: Replace VIRTUALIZATION
 with KVM
References: <1370864548-19647-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1370864548-19647-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmUeslpGAoQ7AECfH35PvAMAL2QkmDFAnCLf84+WZhK6aZN+qfEb57Su4PR6mSoxde+r63x
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36801
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

hello.

On 10-06-2013 15:42, Markos Chandras wrote:

> The kvm_* symbols are only available if KVM is selected.

> Fixes the following linking problem on a randconfig:

> arch/mips/built-in.o: In function `local_flush_tlb_mm':
> (.text+0x18a94): undefined reference to `kvm_local_flush_tlb_all'
> arch/mips/built-in.o: In function `local_flush_tlb_range':
> (.text+0x18d0c): undefined reference to `kvm_local_flush_tlb_all'
> kernel/built-in.o: In function `__schedule':
> core.c:(.sched.text+0x2a00): undefined reference to `kvm_local_flush_tlb_all'
> mm/built-in.o: In function `use_mm':
> (.text+0x30214): undefined reference to `kvm_local_flush_tlb_all'
> fs/built-in.o: In function `flush_old_exec':
> (.text+0xf0a0): undefined reference to `kvm_local_flush_tlb_all'
> make: *** [vmlinux] Error 1

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
>   arch/mips/include/asm/mmu_context.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

> diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
> index 8201160..ee5a93b 100644
> --- a/arch/mips/include/asm/mmu_context.h
> +++ b/arch/mips/include/asm/mmu_context.h
> @@ -111,13 +111,15 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
>   static inline void
>   get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
>   {
> +#ifdef CONFIG_KVM
>   	extern void kvm_local_flush_tlb_all(void);
> +#endif

    #ifdef should not be needed around declaration.

WBR, Sergei
