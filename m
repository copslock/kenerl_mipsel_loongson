Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2017 15:12:47 +0200 (CEST)
Received: from mail-pg0-x229.google.com ([IPv6:2607:f8b0:400e:c05::229]:57293
        "EHLO mail-pg0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990399AbdJKNMklfHoK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Oct 2017 15:12:40 +0200
Received: by mail-pg0-x229.google.com with SMTP id m18so964186pgd.13
        for <linux-mips@linux-mips.org>; Wed, 11 Oct 2017 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bS6xHxg8G3EOzH270zeitjI6DK0+HySrXFS5i4cdEzE=;
        b=Ln7dMaQHTqHKhDv1QVMN3CdElNeLMxWlb3qBjkjBDz9V7YfZy6UCW8xAJuxH8IVWKw
         XhCBQ1eVD7Pbl4wRNpHcKQ/nt29qL22/bXNrJiPD1Bz/85SRc60Oeoq1RDAljzK8S1Af
         CXOeoosEAkbkZm2DZavTalf3E4vHYk+zcRoAm4q5frHqs0qBDkQ6ZCMCf9v5so0JuybW
         /gbmlXvY7rk29lOxnmXAk+SxX5jKcZgfyVnNHht7MFoIB42X7WkANof0RhwE2P3Bfhx9
         /bPhp92IsFyuM7GrZy3EfmB0P6bDI6SZQdyJmtZiev4nwVkzPek9RQCy7XZi6nHtOuRe
         rmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bS6xHxg8G3EOzH270zeitjI6DK0+HySrXFS5i4cdEzE=;
        b=f6WpawFPOb0CByOD+z1vIsfIRJ7BD+rMVXRQq9pw92I0WWCOxLn/0hip/QbnUhsX9O
         epSF+hgnZtCb1zu4+rDpEgd13L4S5sbDIe6QpgpSF5OEQLZ7WfwXFomaE34WmPD+OShE
         gH9kXnLS2mB+TFsLXuT+Kldh6lBGxzC156CPJClxKyhpW++eOjmIGcMCnTixkhTPHaPS
         4k54kHCGjkpjOtfa2qH82j39kYAsSz9yI50kaRHxlANwi9kfdzcjOXa6Fln0JobLdoo3
         f/r3yMbb6nMa+2gRsnXeAB6Pn7UG8I3OZzRhFGyqaC+WSQMBusbvhMJCwy25qjNsTCCb
         sCOg==
X-Gm-Message-State: AMCzsaWnz1IEXBel0v5lOEpJGEwrA8w4NUMoi/uZ93GoDVCJcsZhSqav
        wyCZtPUjbGYFJ6xOPNDpOVFI3w==
X-Google-Smtp-Source: AOwi7QC+qOHhDDo6PP+T8adhrM89wmoMPfQrPfrR+mnM+3xlJg47roBAyjFhlnQ7IdwmdVdOJVj8MA==
X-Received: by 10.98.78.202 with SMTP id c193mr10260764pfb.295.1507727553972;
        Wed, 11 Oct 2017 06:12:33 -0700 (PDT)
Received: from [192.168.27.3] ([47.184.168.85])
        by smtp.gmail.com with ESMTPSA id u85sm26449063pfi.132.2017.10.11.06.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Oct 2017 06:12:33 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Fix exception entry when CONFIG_EVA enabled
To:     Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>
Cc:     Matthew Fortune <matthew.fortune@mips.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <jason@zx2c4.com>,
        Paul Burton <paul.burton@imgtec.com>
References: <1507712360-20657-1-git-send-email-matt.redfearn@mips.com>
From:   Corey Minyard <cminyard@mvista.com>
Message-ID: <605f6a96-a843-085c-efc6-a2c0f2afd84a@mvista.com>
Date:   Wed, 11 Oct 2017 08:12:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1507712360-20657-1-git-send-email-matt.redfearn@mips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Return-Path: <cminyard@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cminyard@mvista.com
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

On 10/11/2017 03:59 AM, Matt Redfearn wrote:
> Commit 9fef68686317b ("MIPS: Make SAVE_SOME more standard") made several
> changes to the order in which registers are saved in the SAVE_SOME
> macro, used by exception handlers to save the processor state. In
> particular, it removed the
> move   k1, sp
> in the delay slot of the branch testing if the processor is already in
> kernel mode. This is replaced later in the macro by a
> move   k0, sp
> When CONFIG_EVA is disabled, this instruction actually appears in the
> delay slot of the branch. However, when CONFIG_EVA is enabled, instead
> the RPS workaround of
> MFC0	k0, CP0_ENTRYHI
> appears in the delay slot. This results in k0 not containing the stack
> pointer, but some unrelated value, which is then saved to the kernel
> stack. On exit from the exception, this bogus value is restored to the
> stack pointer, resulting in an OOPS.
>
> Fix this by moving the save of SP in k0 explicitly in the delay slot of
> the branch, outside of the CONFIG_EVA section, restoring the expected
> instruction ordering when CONFIG_EVA is active.
>
> Fixes: 9fef68686317b ("MIPS: Make SAVE_SOME more standard")
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> Reported-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>

I looked this over pretty carefully and it looks correct to me.  It 
makes no difference
in the instructions generated by the non-EVA case.  I shouldn't have 
missed this :(.

Reviewed-by: Corey Minyard <cminyard@mvista.com>

>
> ---
>
> Note that some of our compiler people are dubious about putting frame
> related instructions in conditionally executed blocks of code. In this
> case, presuming that we only care about unwinding the kernel stack, then
> we only care about the case in which the branch is taken, and k0 always
> contains the SP to be saved. There is also a question about putting
> frame related instructions in branch delay slots. Again, in this case,
> we think it's OK to use them since the only path that ought to be
> unwound will be the "branch taken" route where we are already on the
> kernel stack.

Since the compiler can put frame-related instructions in delay slots (see
aee16625b19 MIPS: Fix issues in backtraces), it's probably ok.  I have 
tested
this before with kernel dumps and gdb, and gdb had no issues with this.

That said, this is a tricky case.  But looking at the generated unwinding
info, it seems to do the right thing.

> Not having access to a CFI based kernel stack unwinder makes this change
> difficult to verify, but since the same construct already existed when
> CONFIG_EVA is disabled, I don't think this change is likely to break the
> unwinder, and fixes exception entry when CONFIG_EVA is enabled.

Agreed.  Thanks for fixing this.

-corey

> Thanks,
> Matt
>
> ---
>   arch/mips/include/asm/stackframe.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
> index 5d3563c55e0c..2161357cc68f 100644
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
> @@ -199,6 +199,10 @@
>   		sll	k0, 3		/* extract cu0 bit */
>   		.set	noreorder
>   		bltz	k0, 8f
> +		 move	k0, sp
> +		.if \docfi
> +		.cfi_register sp, k0
> +		.endif
>   #ifdef CONFIG_EVA
>   		/*
>   		 * Flush interAptiv's Return Prediction Stack (RPS) by writing
> @@ -225,10 +229,6 @@
>   		MTC0	k0, CP0_ENTRYHI
>   #endif
>   		.set	reorder
> -		 move	k0, sp
> -		.if \docfi
> -		.cfi_register sp, k0
> -		.endif
>   		/* Called from user mode, new stack. */
>   		get_saved_sp docfi=\docfi tosp=1
>   8:
