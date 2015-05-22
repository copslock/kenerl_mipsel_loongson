Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 11:38:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49697 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026539AbbEVJiTDbys0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 May 2015 11:38:19 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4M9cFfD031861;
        Fri, 22 May 2015 11:38:15 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4M9cDhO031860;
        Fri, 22 May 2015 11:38:13 +0200
Date:   Fri, 22 May 2015 11:38:13 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     linux-mips@linux-mips.org, rusty@rustcorp.com.au,
        alexinbeijing@gmail.com, paul.burton@imgtec.com,
        david.daney@cavium.com, alex@alex-smith.me.uk,
        linux-kernel@vger.kernel.org, james.hogan@imgtec.com,
        markos.chandras@imgtec.com, macro@linux-mips.org,
        eunb.song@samsung.com, manuel.lauss@gmail.com,
        andreas.herrmann@caviumnetworks.com
Subject: Re: [PATCH 1/2] MIPS: MSA: bugfix - disable MSA during thread switch
 correctly
Message-ID: <20150522093812.GH6941@linux-mips.org>
References: <20150519211222.35859.52798.stgit@ubuntu-yegoshin>
 <20150519211351.35859.80332.stgit@ubuntu-yegoshin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150519211351.35859.80332.stgit@ubuntu-yegoshin>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, May 19, 2015 at 02:13:51PM -0700, Leonid Yegoshin wrote:

> During thread cloning the new (child) thread should have MSA disabled even
> at first thread entry. So, the code to disable MSA is moved from macro
> 'switch_to' to assembler function 'resume' before it switches kernel stack
> to 'next' (new) thread. Call of 'disable_msa' after 'resume' in 'switch_to'
> macro never called a first time entry into thread.
> 
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
>  arch/mips/include/asm/switch_to.h |    1 -
>  arch/mips/kernel/r4k_switch.S     |    6 ++++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
> index e92d6c4b5ed1..0d0f7f8f8b3a 100644
> --- a/arch/mips/include/asm/switch_to.h
> +++ b/arch/mips/include/asm/switch_to.h
> @@ -104,7 +104,6 @@ do {									\
>  	if (test_and_clear_tsk_thread_flag(prev, TIF_USEDMSA))		\
>  		__fpsave = FP_SAVE_VECTOR;				\
>  	(last) = resume(prev, next, task_thread_info(next), __fpsave);	\
> -	disable_msa();							\
>  } while (0)
>  
>  #define finish_arch_switch(prev)					\
> diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
> index 04cbbde3521b..7dbb64656bfe 100644
> --- a/arch/mips/kernel/r4k_switch.S
> +++ b/arch/mips/kernel/r4k_switch.S
> @@ -25,6 +25,7 @@
>  /* preprocessor replaces the fp in ".set fp=64" with $30 otherwise */
>  #undef fp
>  
> +#define t4  $12

You're kidding, right?

>  /*
>   * Offset to the current process status flags, the first 32 bytes of the
>   * stack are not used.
> @@ -73,6 +74,11 @@
>  	cfc1	t1, fcr31
>  	msa_save_all	a0
>  	.set pop	/* SET_HARDFLOAT */
> +	li      t4, MIPS_CONF5_MSAEN
> +	mfc0    t3, CP0_CONFIG, 5
> +	or      t3, t3, t4
> +	xor     t3, t3, t4
> +	mtc0    t3, CP0_CONFIG, 5
>  
>  	sw	t1, THREAD_FCR31(a0)
>  	b	2f

Just move the call to finish_arch_switch().

Your rewrite also dropped the if (cpu_has_msa) condition from disable_msa()
probably causing havoc on lots of CPUs which will likely not decode the
set bits of the MFC0/MTC0 instructions thus end up accessing Config0.

  Ralf
