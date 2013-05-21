Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 May 2013 20:55:57 +0200 (CEST)
Received: from mail-pb0-f52.google.com ([209.85.160.52]:45267 "EHLO
        mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823043Ab3EUSzwCldj5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 May 2013 20:55:52 +0200
Received: by mail-pb0-f52.google.com with SMTP id um15so903343pbc.25
        for <multiple recipients>; Tue, 21 May 2013 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=wCdv19wq10RT3Stk+EFj6WsaGA97Fv7o9xaIRtKUqX0=;
        b=D3tgPdzQLm+Yv/Cd6MjQKPItJPSXc4spD206YPD4DTQMZi54avSoOeFa/uQTqUa3SN
         b71MorvBbZkonUjIQTizKEtdAd9gNWuzkspbWpUubynwN/MFd3TS6R1KS5xQ01XCyRqz
         skx9/XuVUAUx6QbsOrOBxES9a1ylfa4mn83g2Vt4m4mMcfkZdsNQdrUMRVHINwzC9PFX
         wODXzXGzzHiVZ5dPxlYB5ZWtYlehIs+9sCZG5gSJXJkqbjE/BpsLttE4pl2J+lY0vF0b
         qAZ/TMD0uVGTfuY8LEaBAROXrTSA6K2gMZ6HADJHlgR3o7fBxn6Bemihwuz13oqL/OXS
         Io/Q==
X-Received: by 10.66.163.99 with SMTP id yh3mr4666265pab.22.1369162545286;
        Tue, 21 May 2013 11:55:45 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id do4sm3746017pbc.8.2013.05.21.11.55.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 11:55:44 -0700 (PDT)
Message-ID: <519BC32E.2080405@gmail.com>
Date:   Tue, 21 May 2013 11:55:42 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Aron Xu <aron@debian.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: N64: Define getdents64
References: <1369147026-23033-1-git-send-email-aron@debian.org>
In-Reply-To: <1369147026-23033-1-git-send-email-aron@debian.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36506
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

On 05/21/2013 07:37 AM, Aron Xu wrote:
> As a relatively new ABI, N64 only had getdents syscall while other modern
> architectures have getdents64.
>
> This was noticed when Python 3.3 shifted to the latter one for aarch64.
>
> Signed-off-by: Aron Xu <aron@debian.org>

This looks correct to me.  The getdents64 call returns more information 
than getdents (it adds a field for the file type).  So, although in n64 
the widths of the d_ino and d_off fields are the same for getdents64 and 
getdents, we still need to add this syscall.

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/include/uapi/asm/unistd.h |    5 +++--
>   arch/mips/kernel/scall64-64.S       |    1 +
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
> index 16338b8..1dee279 100644
> --- a/arch/mips/include/uapi/asm/unistd.h
> +++ b/arch/mips/include/uapi/asm/unistd.h
> @@ -694,16 +694,17 @@
>   #define __NR_process_vm_writev		(__NR_Linux + 305)
>   #define __NR_kcmp			(__NR_Linux + 306)
>   #define __NR_finit_module		(__NR_Linux + 307)
> +#define __NR_getdents64			(__NR_Linux + 308)
>
>   /*
>    * Offset of the last Linux 64-bit flavoured syscall
>    */
> -#define __NR_Linux_syscalls		307
> +#define __NR_Linux_syscalls		308
>
>   #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
>
>   #define __NR_64_Linux			5000
> -#define __NR_64_Linux_syscalls		307
> +#define __NR_64_Linux_syscalls		308
>
>   #if _MIPS_SIM == _MIPS_SIM_NABI32
>
> diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
> index 36cfd40..97a5909 100644
> --- a/arch/mips/kernel/scall64-64.S
> +++ b/arch/mips/kernel/scall64-64.S
> @@ -423,4 +423,5 @@ sys_call_table:
>   	PTR	sys_process_vm_writev		/* 5305 */
>   	PTR	sys_kcmp
>   	PTR	sys_finit_module
> +	PTR	sys_getdents64
>   	.size	sys_call_table,.-sys_call_table
>
