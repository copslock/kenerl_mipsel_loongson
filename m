Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 15:26:36 +0200 (CEST)
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50711 "EHLO
        mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817913AbaDVN0PlFd1- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2014 15:26:15 +0200
Received: by mail-ee0-f46.google.com with SMTP id t10so4635867eei.19
        for <multiple recipients>; Tue, 22 Apr 2014 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=usdcjit+jb2omBcHZIXY4GH1gZy7ynnc8LjxvnDtApo=;
        b=kHs/wj2mvkiOlhV3TJmf0G50bJF7BRhrb+OP62m2/HLLxAXheYDZwb89hHHyb8Nq1i
         9iFKz0XZF/t4czyVxF6CVo7Dw9QQrO0k09dXIEJbXj409kQxVknYz1DbeWNSAcUAwx9t
         YAgw3FfVitpswWADMZVwV1LX5UdRhoB1HXOLIzYUNYnbZYmuFrLMdnh9/DK9DRYc927d
         JRdfz9ChNAMZobcEXO5rcYugRnhc90DrZyQwFhuQiUdqAs3ZtSPKt2EgpAIBSyWbImTV
         rcWt0AtxsUVa2/URqLviq5Eg2/h3na/J/vtoLlSGgvReR5lsRoV8FswbfvW8swx4qXOo
         Pp8w==
X-Received: by 10.14.211.66 with SMTP id v42mr55456337eeo.31.1398173163261;
        Tue, 22 Apr 2014 06:26:03 -0700 (PDT)
Received: from alberich ([2.171.76.237])
        by mx.google.com with ESMTPSA id a4sm113053405eep.12.2014.04.22.06.26.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Apr 2014 06:26:02 -0700 (PDT)
Date:   Tue, 22 Apr 2014 15:25:59 +0200
From:   Andreas Herrmann <herrmann.der.user@googlemail.com>
To:     Davidlohr Bueso <davidlohr@hp.com>
Cc:     akpm@linux-foundation.org, zeus@gnu.org, aswin@hp.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/6] mips: call find_vma with the mmap_sem held
Message-ID: <20140422132559.GD10997@alberich>
References: <1397960791-16320-1-git-send-email-davidlohr@hp.com>
 <1397960791-16320-4-git-send-email-davidlohr@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1397960791-16320-4-git-send-email-davidlohr@hp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herrmann.der.user@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herrmann.der.user@googlemail.com
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

On Sat, Apr 19, 2014 at 07:26:28PM -0700, Davidlohr Bueso wrote:
> Performing vma lookups without taking the mm->mmap_sem is asking
> for trouble. While doing the search, the vma in question can be
> modified or even removed before returning to the caller. Take the
> lock (exclusively) in order to avoid races while iterating through
> the vmacache and/or rbtree.
> 
> Updates two functions:
>   - process_fpemu_return()
>   - cteon_flush_cache_sigtramp()
> 
> This patch is completely *untested*.
> 
> Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

Tested-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>


Thanks,

Andreas

> ---
>  arch/mips/kernel/traps.c | 2 ++
>  arch/mips/mm/c-octeon.c  | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 074e857..c51bd20 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -712,10 +712,12 @@ int process_fpemu_return(int sig, void __user *fault_addr)
>  		si.si_addr = fault_addr;
>  		si.si_signo = sig;
>  		if (sig == SIGSEGV) {
> +			down_read(&current->mm->mmap_sem);
>  			if (find_vma(current->mm, (unsigned long)fault_addr))
>  				si.si_code = SEGV_ACCERR;
>  			else
>  				si.si_code = SEGV_MAPERR;
> +			up_read(&current->mm->mmap_sem);
>  		} else {
>  			si.si_code = BUS_ADRERR;
>  		}
> diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
> index f41a5c5..05b1d7c 100644
> --- a/arch/mips/mm/c-octeon.c
> +++ b/arch/mips/mm/c-octeon.c
> @@ -137,8 +137,10 @@ static void octeon_flush_cache_sigtramp(unsigned long addr)
>  {
>  	struct vm_area_struct *vma;
>  
> +	down_read(&current->mm->mmap_sem);
>  	vma = find_vma(current->mm, addr);
>  	octeon_flush_icache_all_cores(vma);
> +	up_read(&current->mm->mmap_sem);
>  }
>  
>  
> -- 
> 1.8.1.4
> 
> 
