Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2014 11:54:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31823 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859944AbaFTJyeJE4y1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jun 2014 11:54:34 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6283AEB92DE08;
        Fri, 20 Jun 2014 10:54:25 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 20 Jun 2014 10:54:27 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 20 Jun
 2014 10:54:26 +0100
Message-ID: <53A404D2.3030303@imgtec.com>
Date:   Fri, 20 Jun 2014 10:54:26 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Sorin Dumitru <sdumitru@ixiacom.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
Subject: Re: [PATCH] mips: n32: use compat getsockopt syscall
References: <1403250786-9763-1-git-send-email-sdumitru@ixiacom.com>
In-Reply-To: <1403250786-9763-1-git-send-email-sdumitru@ixiacom.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 20/06/14 08:53, Sorin Dumitru wrote:
> Signed-off-by: Sorin Dumitru <sdumitru@ixiacom.com>

A little more commit message wouldn't hurt. Did it break a particular
program?

It's consistent with compat_sys_socketcall(), include/uapi/asm/unistd.h,
and commit 515c7af85ed9 (which does same thing for x32) though so it
looks good to me.

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/kernel/scall64-n32.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
> index c1dbcda..e543861 100644
> --- a/arch/mips/kernel/scall64-n32.S
> +++ b/arch/mips/kernel/scall64-n32.S
> @@ -162,7 +162,7 @@ EXPORT(sysn32_call_table)
>  	PTR	sys_getpeername
>  	PTR	sys_socketpair
>  	PTR	compat_sys_setsockopt
> -	PTR	sys_getsockopt
> +	PTR	compat_sys_getsockopt
>  	PTR	__sys_clone			/* 6055 */
>  	PTR	__sys_fork
>  	PTR	compat_sys_execve
> 
