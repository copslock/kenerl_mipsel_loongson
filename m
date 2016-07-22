Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jul 2016 01:30:21 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34028 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993074AbcGVXaODVVMt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jul 2016 01:30:14 +0200
Received: by mail-pa0-f68.google.com with SMTP id hh10so7648130pac.1;
        Fri, 22 Jul 2016 16:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=eJNXXzq4gR7jxoFSYyAn4Ww/DisHqTSNseEAbjpPrgc=;
        b=MlhgRbtnklh2bJxD7Lr8Afe2a9N21FryKhaL+HzC3llPU2T9bTkpEb3+g0t8lNyLcU
         ad/SGxGFtt31MWvnEamM5C6q/bKoBsRmXGNW8qlW7G7K7+Y09QiPYQCBM0YDmurRCt6m
         h3Tah6FS5HYYtSRyzFU130fOSfBbE3u6gujIFqvHJxUuueCZ8mElXdiajr6IHwjk26ue
         dyOaGbauyNxEbc23mnqpuOBIw4smpfu2Zigj/zmovMiWFtUZR2DoWOsCegZyatEXRPRl
         wuZiDRfJWKV6qUCRnFxZt9WzmoPjR7AcTIT5Oetnjek4rbX6zyi6pUbGV4SLSxGEXhvh
         6CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=eJNXXzq4gR7jxoFSYyAn4Ww/DisHqTSNseEAbjpPrgc=;
        b=AFKHkeZefIQ+B1flKSnLCNT54wNKSu6F+BIAUbu2VpQ1ouqZgrrMPieGB8STb2Kl4s
         HGO7p5jxOUZK1C6o4UFZOxYFVyAraQ5rMx+3xXbzs6uhq74dGZPdorEXy/NdkUnAek3d
         eccRzQ/b8qiFZu87trQFAuUtpTzdQfokp51Lowdzay1MyaSOklgSSglDeL5WjFin57Yg
         c+JlsiYyUSbEgUYDir4dcWlYHI4PBFPRb5u2hTH8Ml65wFZCVvt+X8Zs3R/lZMomRy+M
         PAvba4SAQXXkesHjdvlstqOCpxSKkyNRQACrhuMqGDluP+GsLlm4fh3MJLbeGVdO3yXb
         3X2Q==
X-Gm-Message-State: AEkoouswNbThHPRHNnXvEVbGfowI9zXRvCt1Rl+YV+XLqZrLdJrA6dvwPp1WOJwMePqijw==
X-Received: by 10.66.146.69 with SMTP id ta5mr10871496pab.157.1469230208050;
        Fri, 22 Jul 2016 16:30:08 -0700 (PDT)
Received: from [10.112.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id x5sm4187920pax.33.2016.07.22.16.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jul 2016 16:30:06 -0700 (PDT)
Subject: Re: MIPS: traps: return correct si code for accessing nonmapped
 addresses
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
References: <S23992942AbcGUNNgF7uup/20160721131336Z+440@eddie.linux-mips.org>
Cc:     john@phrozen.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5369f961-a67b-6c73-6549-eda92c31bea4@gmail.com>
Date:   Fri, 22 Jul 2016 16:30:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <S23992942AbcGUNNgF7uup/20160721131336Z+440@eddie.linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 07/21/2016 06:13 AM, linux-mips@linux-mips.org wrote:
> Author: Petar Jovanovic <petar.jovanovic@rt-rk.com> Wed Jul 13 15:23:37 2016 +0200
> Comitter: Ralf Baechle <ralf@linux-mips.org> Thu Jul 21 14:22:07 2016 +0200
> Commit: 1cb2fcc8cd1bd32cca6ce4b76bb9cc36ef5fc76d
> Gitweb: https://git.linux-mips.org/g/ralf/linux/1cb2fcc8cd1b
> Branch: linux-3.3-stable
> 
> find_vma() returns the first VMA which satisfies fault_addr < vm_end, but
> it does not guarantee fault_addr is actually within VMA. Therefore, kernel
> has to check that before it chooses correct si code on return.
> 
> Signed-off-by: Petar Jovanovic <petar.jovanovic@rt-rk.com>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/13808/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> (cherry picked from commit abe687d221b4e9fd564d5db76f5847636dae6c2e)
> 
> ---
> 
>  arch/mips/kernel/traps.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 0bb48ee..4870e02 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -673,13 +673,16 @@ asmlinkage void do_ov(struct pt_regs *regs)
>  
>  static int process_fpemu_return(int sig, void __user *fault_addr)
>  {
> +	struct vm_area_struct *vma;
> +
>  	if (sig == SIGSEGV || sig == SIGBUS) {
>  		struct siginfo si = {0};
>  		si.si_addr = fault_addr;
>  		si.si_signo = sig;
>  		if (sig == SIGSEGV) {
>  			down_read(&current->mm->mmap_sem);
> -			if (find_vma(current->mm, (unsigned long)fault_addr))
> +			find_vma(current->mm, (unsigned long)fault_addr);

Are not we missing a vma = find_vma() assignment here?

linux-4.0-stable seems to be the first branch where this cherry-pick
failed and all the way down to linux-2.6.16-stable branches...

> +			if (vma && (vma->vm_start <= (unsigned long)fault_addr))
>  				si.si_code = SEGV_ACCERR;
>  			else
>  				si.si_code = SEGV_MAPERR;
> 


-- 
Florian
