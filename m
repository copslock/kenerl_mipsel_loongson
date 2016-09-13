Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 16:49:14 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43022 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992186AbcIMOtHj3KBz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Sep 2016 16:49:07 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8DEn4Zm024255;
        Tue, 13 Sep 2016 16:49:04 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8DEn2TO024254;
        Tue, 13 Sep 2016 16:49:02 +0200
Date:   Tue, 13 Sep 2016 16:49:02 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: paravirt: Fix undefined reference to smp_bootstrap
Message-ID: <20160913144901.GB20655@linux-mips.org>
References: <1473086620-21007-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1473086620-21007-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55125
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

On Mon, Sep 05, 2016 at 03:43:40PM +0100, Matt Redfearn wrote:

> If the paravirt machine is compiles without CONFIG_SMP, the following
> linker error occurs
> 
> arch/mips/kernel/head.o: In function `kernel_entry':
> (.ref.text+0x10): undefined reference to `smp_bootstrap'
> 
> due to the kernel entry macro always including SMP startup code.
> Wrap this code in CONFIG_SMP to fix the error.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

Thanks, applied.  This patch should be applied to 3.16+ also so I've
added a Cc: stable... tag.

  Ralf

>  arch/mips/include/asm/mach-paravirt/kernel-entry-init.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h b/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
> index 2f82bfa3a773..c9f5769dfc8f 100644
> --- a/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
> @@ -11,11 +11,13 @@
>  #define CP0_EBASE $15, 1
>  
>  	.macro  kernel_entry_setup
> +#ifdef CONFIG_SMP
>  	mfc0	t0, CP0_EBASE
>  	andi	t0, t0, 0x3ff		# CPUNum
>  	beqz	t0, 1f
>  	# CPUs other than zero goto smp_bootstrap
>  	j	smp_bootstrap
> +#endif /* CONFIG_SMP */
>  
>  1:
>  	.endm
> -- 
> 2.7.4
> 
