Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2014 00:56:32 +0200 (CEST)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:46553 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671AbaDSW43vl11o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Apr 2014 00:56:29 +0200
Received: by mail-ig0-f182.google.com with SMTP id uy17so666349igb.3
        for <linux-mips@linux-mips.org>; Sat, 19 Apr 2014 15:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=aoEf6lxtlBP2YZvFtj8Y+D9mvk6rlSHzlnRXBxOSSlw=;
        b=GZRJbB4VhqVIK7+Iq26EQKoDE1ZdFPKsdJN9AMLTrFkF60aP8RgPBPDP5flTeAHHVV
         mlnA6dkFzsdYMynajuAWgDY0lWVMogE/VyzpFYNnA+17zISXvTZFLKt59V+JYMEuuB0P
         ktNNmw8J2M/7Isbb/aucb2yAIPsQJi9ulSWWU52BCr+TnERkll7ylhXKhHwNeSE+v+RC
         44Pswewd7thJPSNQIwwyVSscmLD0sYhVOZkxh+9oQxjwtaWUhPCgRAf08ccAiJX753OZ
         Au3CuGytxKhU/A5UW0Z7W3SYwPe51GDwT8OEeSTIQiuUKAfof7oDerOw0znL126FBJQa
         eVyQ==
X-Received: by 10.50.22.37 with SMTP id a5mr12911949igf.30.1397948183359;
        Sat, 19 Apr 2014 15:56:23 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id kr5sm8245489igb.9.2014.04.19.15.56.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 19 Apr 2014 15:56:22 -0700 (PDT)
Message-ID: <5352FF15.2080003@gmail.com>
Date:   Sat, 19 Apr 2014 15:56:21 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Prem Karat <pkarat@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [RFC PATCH 1/1] MIPS: Enable VDSO randomization.
References: <20140419093302.GH2717@064904.mvista.com>
In-Reply-To: <20140419093302.GH2717@064904.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39868
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

On 04/19/2014 02:33 AM, Prem Karat wrote:
> Based on commit 1091458d09e1a (mmap randomization)
>
> For 32-bit address spaces randomize within a
> 16MB space, for 64-bit within a 256MB space.
>

How was it tested (i.e. what workload did you run to verify that the 
kernel still functions with this change)?

> Signed-off-by: Prem Karat <pkarat@mvista.com>
> ---
>   arch/mips/kernel/vdso.c |   15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> index 0f1af58..b49c705 100644
> --- a/arch/mips/kernel/vdso.c
> +++ b/arch/mips/kernel/vdso.c
> @@ -16,9 +16,11 @@
>   #include <linux/elf.h>
>   #include <linux/vmalloc.h>
>   #include <linux/unistd.h>
> +#include <linux/random.h>
>
>   #include <asm/vdso.h>
>   #include <asm/uasm.h>
> +#include <asm/processor.h>
>
>   /*
>    * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
> @@ -67,7 +69,18 @@ subsys_initcall(init_vdso);
>
>   static unsigned long vdso_addr(unsigned long start)
>   {
> -	return STACK_TOP;
> +	unsigned long offset = 0UL;
> +
> +	if (current->flags & PF_RANDOMIZE) {
> +		offset = get_random_int();
> +		offset = offset << PAGE_SHIFT;
> +		if (TASK_IS_32BIT_ADDR)
> +			offset &= 0xfffffful;
> +		else
> +			offset &= 0xffffffful;
> +	}
> +
> +	return (STACK_TOP + offset);

How can you be sure this address doesn't collide with, or otherwise 
interfere with, the stack?


Also, as mentioned by Sergei, run checkpatch.pl to catch obvious 
stylistic problems before submitting patches.

Thanks,
David Daney

>   }
>
>   int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>
