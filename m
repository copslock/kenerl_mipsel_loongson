Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Sep 2016 12:59:45 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51479 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992111AbcICK7gf-yNF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Sep 2016 12:59:36 +0200
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u83ArT3R034908
        for <linux-mips@linux-mips.org>; Sat, 3 Sep 2016 06:59:35 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 257s4b6hdr-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Sat, 03 Sep 2016 06:59:35 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <heiko.carstens@de.ibm.com>;
        Sat, 3 Sep 2016 11:59:33 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp13.uk.ibm.com (192.168.101.143) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Sat, 3 Sep 2016 11:59:32 +0100
X-IBM-Helo: d06dlp01.portsmouth.uk.ibm.com
X-IBM-MailFrom: heiko.carstens@de.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 235FB17D8042;
        Sat,  3 Sep 2016 12:01:22 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u83AxV8p30933222;
        Sat, 3 Sep 2016 10:59:31 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u83AxUN7018167;
        Sat, 3 Sep 2016 04:59:31 -0600
Received: from osiris (dyn-9-152-212-161.boeblingen.de.ibm.com [9.152.212.161])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u83AxSBs018125
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA256 bits=256 verify=NO);
        Sat, 3 Sep 2016 04:59:30 -0600
Date:   Sat, 3 Sep 2016 12:59:28 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com
Subject: Re: [PATCH] uprobes: remove function declarations from
 arch/{mips,s390}
References: <1472804384-17830-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472804384-17830-1-git-send-email-marcin.nowakowski@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16090310-0012-0000-0000-000004505B46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 16090310-0013-0000-0000-000015406C57
Message-Id: <20160903105928.GB3917@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-09-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1604210000
 definitions=main-1609030158
Return-Path: <heiko.carstens@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: heiko.carstens@de.ibm.com
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

On Fri, Sep 02, 2016 at 10:19:44AM +0200, Marcin Nowakowski wrote:
> The declarations of arch-specific functions have been moved to a common
> header in commit 3820b4d2789f ('uprobes: Move function declarations out of
> arch'), but MIPS and S390 has added them to their own trees later.
> Remove the unnecessary duplicates.
> 
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> ---
>  arch/mips/include/asm/uprobes.h | 12 ------------
>  arch/s390/include/asm/uprobes.h | 10 ----------
>  2 files changed, 22 deletions(-)

You may either split this patch into two patches (mips/s390) so it can be
applied to the different architecture trees, or send it as single patch to
Andrew Morton, so he can pick it.

In any case:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

> 
> diff --git a/arch/mips/include/asm/uprobes.h b/arch/mips/include/asm/uprobes.h
> index 34c325c..28ab364 100644
> --- a/arch/mips/include/asm/uprobes.h
> +++ b/arch/mips/include/asm/uprobes.h
> @@ -43,16 +43,4 @@ struct arch_uprobe_task {
>  	unsigned long saved_trap_nr;
>  };
> 
> -extern int arch_uprobe_analyze_insn(struct arch_uprobe *aup,
> -	struct mm_struct *mm, unsigned long addr);
> -extern int arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs);
> -extern int arch_uprobe_post_xol(struct arch_uprobe *aup, struct pt_regs *regs);
> -extern bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
> -extern int arch_uprobe_exception_notify(struct notifier_block *self,
> -	unsigned long val, void *data);
> -extern void arch_uprobe_abort_xol(struct arch_uprobe *aup,
> -	struct pt_regs *regs);
> -extern unsigned long arch_uretprobe_hijack_return_addr(
> -	unsigned long trampoline_vaddr, struct pt_regs *regs);
> -
>  #endif /* __ASM_UPROBES_H */
> diff --git a/arch/s390/include/asm/uprobes.h b/arch/s390/include/asm/uprobes.h
> index 1411dff..658393c 100644
> --- a/arch/s390/include/asm/uprobes.h
> +++ b/arch/s390/include/asm/uprobes.h
> @@ -29,14 +29,4 @@ struct arch_uprobe {
>  struct arch_uprobe_task {
>  };
> 
> -int arch_uprobe_analyze_insn(struct arch_uprobe *aup, struct mm_struct *mm,
> -			     unsigned long addr);
> -int arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs);
> -int arch_uprobe_post_xol(struct arch_uprobe *aup, struct pt_regs *regs);
> -bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
> -int arch_uprobe_exception_notify(struct notifier_block *self, unsigned long val,
> -				 void *data);
> -void arch_uprobe_abort_xol(struct arch_uprobe *ap, struct pt_regs *regs);
> -unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline,
> -						struct pt_regs *regs);
>  #endif	/* _ASM_UPROBES_H */
> -- 
> 2.7.4
> 
