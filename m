Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2014 09:37:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:38302 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822314AbaCFIh2VVNzq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2014 09:37:28 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 76AA0BC333753;
        Thu,  6 Mar 2014 08:37:20 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 6 Mar 2014 08:37:21 +0000
Received: from [192.168.154.47] (192.168.154.47) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 6 Mar
 2014 08:37:21 +0000
Message-ID: <531833F0.8080300@imgtec.com>
Date:   Thu, 6 Mar 2014 08:38:08 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To:     Richard Guy Briggs <rgb@redhat.com>, <linux-audit@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <eparis@redhat.com>, <sgrubb@redhat.com>, <oleg@redhat.com>,
        <linux-mips@linux-mips.org>,
        <user-mode-linux-devel@lists.sourceforge.net>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/6][RFC] syscall: define syscall_get_arch() for each
 audit-supported arch
References: <cover.1393974970.git.rgb@redhat.com> <cb88576237b1bc4fc7981200c2c23ae05790db0d.1393974970.git.rgb@redhat.com>
In-Reply-To: <cb88576237b1bc4fc7981200c2c23ae05790db0d.1393974970.git.rgb@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.47]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39427
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

Hi Richard,

On 03/05/2014 09:27 PM, Richard Guy Briggs wrote:
> Each arch that supports audit requires syscall_get_arch() to able to log and
> identify architecture-dependent syscall numbers.  The information is used in at
> least two different subsystems, so standardize it in the same call across all
> arches.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>
> ---
> diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
> index 81c8913..41ecde4 100644
> --- a/arch/mips/include/asm/syscall.h
> +++ b/arch/mips/include/asm/syscall.h
> @@ -103,7 +103,7 @@ extern const unsigned long sysn32_call_table[];
>
>   static inline int __syscall_get_arch(void)
>   {
> -	int arch = EM_MIPS;
> +	int arch = AUDIT_ARCH_MIPS;
>   #ifdef CONFIG_64BIT
>   	arch |=  __AUDIT_ARCH_64BIT;
>   #endif
> @@ -113,4 +113,10 @@ static inline int __syscall_get_arch(void)
>   	return arch;
>   }
>
> +static inline int syscall_get_arch(struct task_struct *task,
> +				   struct pt_regs *regs)
> +{
> +	return __syscall_get_arch();
> +}
> +
>   #endif	/* __ASM_MIPS_SYSCALL_H */

This is already fixed for MIPS

http://patchwork.linux-mips.org/patch/6398/

The code is in linux-next targeting 3.15 as far as I can tell.

-- 
markos
