Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 18:45:56 +0200 (CEST)
Received: from mail-ig0-f169.google.com ([209.85.213.169]:43045 "EHLO
        mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822272AbaDDQpxtmkI0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 18:45:53 +0200
Received: by mail-ig0-f169.google.com with SMTP id h18so2136027igc.4
        for <multiple recipients>; Fri, 04 Apr 2014 09:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9q/wv4dnhPBxuHyoA68S/LhhYp9+7uAJw0Fm+BqDIW4=;
        b=FktYjVly1Z3Xid1XARLdKTf5XzXopioTHGleun/jOH/aCAnc52JIEDCn74XBEdcQGJ
         rKKztCoTUL0I0FM3YErRDkVeqMyyr28aJTh4gIGBPc2SQAgVrvpwMCc0YJPKBSeAvShO
         bJhRTHsn0rEFTh6bjjftpu42yilCHKGNwdjr/lRivwfyiXWNGfLbyFNIAXrqxL7PjcSH
         KcmqXcH/4aDtnuxQrDp0x1P3IoRyaAg4zi0OWBtx/IEPhvG1FEu2mF5m7uaCtPmq75/A
         DNCLOJyvFr0Hd5MubaZ01KoboVwLnoymkUwpn7u7uGRlUhsfV7c/RZ0/PYyPcz04aNjL
         db2g==
X-Received: by 10.50.44.115 with SMTP id d19mr4123698igm.1.1396629947355;
        Fri, 04 Apr 2014 09:45:47 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id b8sm7166242igx.3.2014.04.04.09.45.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 04 Apr 2014 09:45:46 -0700 (PDT)
Message-ID: <533EE1B9.2040805@gmail.com>
Date:   Fri, 04 Apr 2014 09:45:45 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 5/9] MIPS: Add numa api support
References: <1396599104-24370-1-git-send-email-chenhc@lemote.com> <1396599104-24370-6-git-send-email-chenhc@lemote.com>
In-Reply-To: <1396599104-24370-6-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 04/04/2014 01:11 AM, Huacai Chen wrote:
> Enable sys_mbind()/sys_get_mempolicy()/sys_set_mempolicy() for O32, N32,
> and N64 ABIs.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

NACK.

You need compat versions of the syscalls...

Also current migrate_pages and move_pages syscalls need to use the 
compat wrappers for 32-bit ABIs.

David Daney


> ---
>   arch/mips/kernel/scall32-o32.S |    4 ++--
>   arch/mips/kernel/scall64-64.S  |    4 ++--
>   arch/mips/kernel/scall64-n32.S |    6 +++---
>   arch/mips/kernel/scall64-o32.S |    6 +++---
>   4 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
> index fdc70b4..7f7e2fb 100644
> --- a/arch/mips/kernel/scall32-o32.S
> +++ b/arch/mips/kernel/scall32-o32.S
> @@ -495,8 +495,8 @@ EXPORT(sys_call_table)
>   	PTR	sys_tgkill
>   	PTR	sys_utimes
>   	PTR	sys_mbind
> -	PTR	sys_ni_syscall			/* sys_get_mempolicy */
> -	PTR	sys_ni_syscall			/* 4270 sys_set_mempolicy */
> +	PTR	sys_get_mempolicy
> +	PTR	sys_set_mempolicy		/* 4270 */
>   	PTR	sys_mq_open
>   	PTR	sys_mq_unlink
>   	PTR	sys_mq_timedsend
> diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
> index dd99c328..a4baf06 100644
> --- a/arch/mips/kernel/scall64-64.S
> +++ b/arch/mips/kernel/scall64-64.S
> @@ -347,8 +347,8 @@ EXPORT(sys_call_table)
>   	PTR	sys_tgkill			/* 5225 */
>   	PTR	sys_utimes
>   	PTR	sys_mbind
> -	PTR	sys_ni_syscall			/* sys_get_mempolicy */
> -	PTR	sys_ni_syscall			/* sys_set_mempolicy */
> +	PTR	sys_get_mempolicy
> +	PTR	sys_set_mempolicy
>   	PTR	sys_mq_open			/* 5230 */
>   	PTR	sys_mq_unlink
>   	PTR	sys_mq_timedsend
> diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
> index f68d2f4..92db19e 100644
> --- a/arch/mips/kernel/scall64-n32.S
> +++ b/arch/mips/kernel/scall64-n32.S
> @@ -339,9 +339,9 @@ EXPORT(sysn32_call_table)
>   	PTR	compat_sys_clock_nanosleep
>   	PTR	sys_tgkill
>   	PTR	compat_sys_utimes		/* 6230 */
> -	PTR	sys_ni_syscall			/* sys_mbind */
> -	PTR	sys_ni_syscall			/* sys_get_mempolicy */
> -	PTR	sys_ni_syscall			/* sys_set_mempolicy */
> +	PTR	sys_mbind
> +	PTR	sys_get_mempolicy
> +	PTR	sys_set_mempolicy

Here


>   	PTR	compat_sys_mq_open
>   	PTR	sys_mq_unlink			/* 6235 */
>   	PTR	compat_sys_mq_timedsend
> diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
> index 70f6ace..0230429 100644
> --- a/arch/mips/kernel/scall64-o32.S
> +++ b/arch/mips/kernel/scall64-o32.S
> @@ -473,9 +473,9 @@ EXPORT(sys32_call_table)
>   	PTR	compat_sys_clock_nanosleep	/* 4265 */
>   	PTR	sys_tgkill
>   	PTR	compat_sys_utimes
> -	PTR	sys_ni_syscall			/* sys_mbind */
> -	PTR	sys_ni_syscall			/* sys_get_mempolicy */
> -	PTR	sys_ni_syscall			/* 4270 sys_set_mempolicy */
> +	PTR	sys_mbind
> +	PTR	sys_get_mempolicy
> +	PTR	sys_set_mempolicy		/* 4270 */

And Here.


>   	PTR	compat_sys_mq_open
>   	PTR	sys_mq_unlink
>   	PTR	compat_sys_mq_timedsend
>
