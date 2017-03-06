Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2017 08:59:41 +0100 (CET)
Received: from mail1.windriver.com ([147.11.146.13]:57256 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990514AbdCFH7chTF0d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Mar 2017 08:59:32 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v267xNmV029531
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 5 Mar 2017 23:59:25 -0800 (PST)
Received: from [128.224.155.85] (128.224.155.85) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 5 Mar
 2017 23:59:23 -0800
Subject: Re: [PATCH] MIPS: reset all task's asid to 0 after asid_cache(cpu)
 overflows
To:     <yhb@ruijie.com.cn>
References: <80B78A8B8FEE6145A87579E8435D78C307943B56@FZEX3.ruijie.com.cn>
CC:     <linux-mips@linux-mips.org>
From:   jsun4 <Jiwei.Sun@windriver.com>
Message-ID: <58BD170A.3080302@windriver.com>
Date:   Mon, 6 Mar 2017 16:00:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <80B78A8B8FEE6145A87579E8435D78C307943B56@FZEX3.ruijie.com.cn>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.85]
Return-Path: <Jiwei.Sun@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jiwei.Sun@windriver.com
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

Hello yhb,

Thanks for your reply and review.

On 03/06/2017 10:44 AM, yhb@ruijie.com.cn wrote:
> +		if (!asid) {		/* fix version if needed */
> +			struct task_struct *p;
> +
> +			for_each_process(p) {
> +				if ((p->mm))
> +					cpu_context(cpu, p->mm) = 0;
> +			}
>   It is not safe. When the processor is executing these codes, another processor is freeing task_struct, setting p->mm to NULL, and freeing mm_struct.

Yes, I overlooked this point. There are else code in order to resolve this question,

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 2abf94f..b1c0911 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -105,8 +105,20 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
		if (cpu_has_vtag_icache)
			flush_icache_all();
		local_flush_tlb_all(); /* start new asid cycle */
-	 	if (!asid) /* fix version if needed */
+		if (!asid) { /* fix version if needed */
+	 		struct task_struct *p;
+
+		 	read_lock(&tasklist_lock);
+ 			for_each_process(p) {
+ 				task_lock(p);
+ 				if (p->mm)
+ 					cpu_context(cpu, p->mm) = 0;
+ 				task_unlock(p);
+ 			}
+	 		read_unlock(&tasklist_lock);
+
+			asid = asid_first_version(cpu);
+ 		}
	}

Because before another processor frees mm_struct, it will get the lock p->alloc_lock.
543 /* more a memory barrier than a real lock */
544 task_lock(current);
545 current->mm = NULL;
546 up_read(&mm->mmap_sem);
547 enter_lazy_tlb(mm, current);
548 task_unlock(current);

>   I committed a patch to solve this problem.Please see https://patchwork.linux-mips.org/patch/13789/.
> 
I saw the patch that you list in the link.
Why did you add a list and a lot of else codes(else arch and mm/, kernel/) to resolve this
risk that is difficult to hit? I don't think this is a good idea.
And in clear_other_mmu_contexts()
+	static inline void clear_other_mmu_contexts(struct mm_struct *mm,
+ 	unsigned long cpu)
+	{
+ 		unsigned long flags;
+ 		struct mm_struct *p;
+
+ 		spin_lock_irqsave(&mmlink_lock, flags);
+ 		list_for_each_entry(p, &mmlist, mmlink) {
+ 			if ((p != mm) && cpu_context(cpu, p))

"(p != mm)" is not essential, because cpu_context(cpu, mm) will be changed to asid_first_version(cpu) in
get_new_mmu_context(struct mm_struct *mm, unsigned long cpu), and it is inefficient.
And "cpu_context(cpu, p)" is not essential too, I think. 

+ 				cpu_context(cpu, p) = 0;
+ 		}
+ 		spin_unlock_irqrestore(&mmlink_lock, flags);
+	}
+

Thanks,
Best regards,
Jiwei
