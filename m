Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Nov 2012 00:31:03 +0100 (CET)
Received: from mail-da0-f49.google.com ([209.85.210.49]:51181 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825937Ab2KOXbCl0pwW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Nov 2012 00:31:02 +0100
Received: by mail-da0-f49.google.com with SMTP id q27so831364daj.36
        for <multiple recipients>; Thu, 15 Nov 2012 15:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=RRPTCLcOzB0Poqu+fY7wx2jkqybJHJbZ5uNMDmFVCts=;
        b=IF+kdP7GuwQFxnQj8y5pdq5hCtdC2wS4+cGYEOQ3cLURZ0m4I0tjgvh5XgjkCjNEkm
         cLvBDITH0JUVMUb0xreFRveaXldqPhiJSjkmdOrU1KCa+MeZD9MWbY/N7OxLVLVUnr1L
         fpPPlvFbhUfpCnzkZCKwcOdpoBfy6gc7VVXSGTGRGCEj5y5T71ztB6ovV9mc80yen/xb
         6wwNrx+Ic2n2HNxlO6FdYJCDLMY9VVhm4OkYpzJEeP8wEbuwlbH6tlD5/7+VmiVlJ7Oc
         /KpVWwfVg91m4OgqxR6QzEM+TqNa2GAANRsytO/P2U4A+s9plPLsqrSzrhQPEA7O4kb8
         s1Yw==
Received: by 10.68.192.66 with SMTP id he2mr3620629pbc.112.1353022255898;
        Thu, 15 Nov 2012 15:30:55 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id s1sm10444397paz.0.2012.11.15.15.30.54
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Nov 2012 15:30:55 -0800 (PST)
Message-ID: <50A57B2E.4000608@gmail.com>
Date:   Thu, 15 Nov 2012 15:30:54 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121029 Thunderbird/16.0.2
MIME-Version: 1.0
To:     Al Cooper <alcooperx@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, cernekee@gmail.com
Subject: Re: [PATCH] MIPS: Fix crash that occurs when function tracing is
 enabled
References: <y> <1353021374-3311-1-git-send-email-alcooperx@gmail.com>
In-Reply-To: <1353021374-3311-1-git-send-email-alcooperx@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35021
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/15/2012 03:16 PM, Al Cooper wrote:
> A recent patch changed some irq routines from inlines to functions.
> These routines are called by the tracer code. Now that they're functions,
> if they are compiled for function tracing they will call the tracer
> and crash the system due to infinite recursion. The fix disables
> tracing in these functions by using "notrace" in the function
> definition.
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Makes sense,

Reviewed-by: David Daney <david.daney@cavium.com>


> ---
>   arch/mips/lib/mips-atomic.c |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/lib/mips-atomic.c b/arch/mips/lib/mips-atomic.c
> index e091430..cd160be 100644
> --- a/arch/mips/lib/mips-atomic.c
> +++ b/arch/mips/lib/mips-atomic.c
> @@ -56,7 +56,7 @@ __asm__(
>   	"	.set	pop						\n"
>   	"	.endm							\n");
>
> -void arch_local_irq_disable(void)
> +notrace void arch_local_irq_disable(void)
>   {
.
.
.
