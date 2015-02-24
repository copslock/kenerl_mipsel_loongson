Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 20:30:12 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34070 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007145AbbBXTaJaHCV6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 20:30:09 +0100
Received: by pabrd3 with SMTP id rd3so38358050pab.1
        for <linux-mips@linux-mips.org>; Tue, 24 Feb 2015 11:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=converseincode.com; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3Dblyix3JeFXsDsDiQ/EyIhyHIFbp+F1fmZjkA4snP0=;
        b=CF+uZzJFRfOnOyOpiYP3VcxhY0Z6kBXn0RpqMXVIQw3k10/GE7zmI1WZRa8oU9xba8
         0rxD4inl44+ZJaRCWR3Jd8X9URR3gqwtXLngVqcqxm9oYCJWj2gJ30CCcF1CkpzVEmjI
         xylBgEVx88c8HLCZx5ahQMXpNcYVU86Ua9rgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=3Dblyix3JeFXsDsDiQ/EyIhyHIFbp+F1fmZjkA4snP0=;
        b=fG76GwSX3Kt6wwW1qsadKbAFsIvtSkD6Awv8anql5IiQJF9300ytjNF/aY3O/Yurdj
         IUTe+QteSJkz0Bbi6L1E+5mAAVUAAQE4H4Gz4c7t15turZg4iKLtX5JgsBA+/KnYWTqX
         bgaS8Nu6kfiUa5fdlgEPgBQNNi7UB/m1VSLyqOX5MUT365FsDW5Mie8GPp8sm374GZaj
         +j3G5u/zL96m5yrXU4L5VmijRySZQ8olmLbyaA2EJcvCcfTcdlyAcMD9Bkmjm53/VF5O
         ZfGjo4g9O3vSnP++/4pdAtxk9lC7EWmNSWtfRGiDhnGuzvLiZU2j/4RUEj1d8/KEtN60
         Bqqw==
X-Gm-Message-State: ALoCoQki2hjLObEqzCM1DWsnzdtO8T9n9Kf9btrv/5QntpdxfSLKspNihgTMY5WSkV2yUN14S53C
X-Received: by 10.68.189.41 with SMTP id gf9mr6163803pbc.21.1424806203208;
        Tue, 24 Feb 2015 11:30:03 -0800 (PST)
Received: from ?IPv6:2001:470:b26c:0:3030:a2c6:1344:5d3b? ([2001:470:b26c:0:3030:a2c6:1344:5d3b])
        by mx.google.com with ESMTPSA id o4sm39845945pdh.6.2015.02.24.11.30.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2015 11:30:02 -0800 (PST)
Message-ID: <54ECD137.3000202@converseincode.com>
Date:   Tue, 24 Feb 2015 11:29:59 -0800
From:   Behan Webster <behanw@converseincode.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Daniel Sanders <daniel.sanders@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH v3] MIPS: Changed current_thread_info() to an equivalent
 supported by both clang and GCC
References: <1424790177-10089-1-git-send-email-daniel.sanders@imgtec.com>
In-Reply-To: <1424790177-10089-1-git-send-email-daniel.sanders@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <behanw@converseincode.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: behanw@converseincode.com
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

On 02/24/15 07:02, Daniel Sanders wrote:
> Without this, a 'break' instruction is executed very early in the boot and
> the boot hangs.
>
> The problem is that clang doesn't honour named registers on local variables
> and silently treats them as normal uninitialized variables. However, it
> does honour them on global variables.
>
> Signed-off-by: Daniel Sanders <daniel.sanders@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Markos Chandras <markos.chandras@imgtec.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: linux-mips@linux-mips.org
> Cc: Behan Webster <behanw@converseincode.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: David Daney <ddaney.cavm@gmail.com>
> ---
> v2 of this patch has been updated following David Daney's request to preserve
> the name of the original named register local.
>
> v3 of this patch just rebases to master and adds some background discussion from
> the previous threads.
>
> For reference, a similar patch for ARM's stack pointer has already been merged:
>   0abc08b ARM: 8170/1: Add global named register current_stack_pointer for ARM
>
> LLVM is unlikely to support uninitialized reads of named register locals in the
> foreseeable future. There are some significant implementation difficulties and
> there were objections based on the future direction of LLVM. The thread is at
> http://lists.cs.uiuc.edu/pipermail/llvmdev/2014-March/071555.html. I've linked
> to the bit where the issues started to be discussed rather than the start of
> the thread.
>
> Difficulty and objections aside, it's also a very large amount of work to
> support a single (as far as I know) user of named register locals, especially
> when the kernel has already accepted patches to switch named register locals to
> named register globals in the arm and arm64/aarch64 arches.
>
>  arch/mips/include/asm/thread_info.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
> index 55ed660..2f0dba3 100644
> --- a/arch/mips/include/asm/thread_info.h
> +++ b/arch/mips/include/asm/thread_info.h
> @@ -55,10 +55,10 @@ struct thread_info {
>  #define init_stack		(init_thread_union.stack)
>  
>  /* How to get the thread information struct from C.  */
> +register struct thread_info *__current_thread_info __asm__("$28");
> +
>  static inline struct thread_info *current_thread_info(void)
>  {
> -	register struct thread_info *__current_thread_info __asm__("$28");
> -
>  	return __current_thread_info;
>  }
>  

Acked-by: Behan Webster <behanw@converseincode.com>

-- 
Behan Webster
behanw@converseincode.com
