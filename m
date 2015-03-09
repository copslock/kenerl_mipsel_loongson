Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 15:49:23 +0100 (CET)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:58536 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008342AbbCIOtMhqyXR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2015 15:49:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=lxI462IeSX90Wk7vWEkQUHqvzJL+2p/1NjvsHKKPpOY=;
        b=fufwm/CkMFMqP2Dy7Ir5Wa7aCM+D3WGZ8OUOPKiwjHfravHytkP8uAa8rchI1vr03C6oTdJpATtTZ1bwglXy4BOjWoPcanN47sx1KJ1QanlQujrHk8X+ZOltwUTIs7n96xquE7FX6FP3uU0M8M7Xu5N5mDP+9+giGi36Xp7JZj0=;
Received: from n2100.arm.linux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:44392)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1YUyyy-0005nf-FH; Mon, 09 Mar 2015 14:48:36 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1YUyyu-0003Bj-Bp; Mon, 09 Mar 2015 14:48:32 +0000
Date:   Mon, 9 Mar 2015 14:48:31 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Borislav Petkov <bp@suse.de>,
        Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm: factor out mmap ASLR into mmap_rnd
Message-ID: <20150309144831.GM8656@n2100.arm.linux.org.uk>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <1425341988-1599-2-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425341988-1599-2-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Mon, Mar 02, 2015 at 04:19:44PM -0800, Kees Cook wrote:
> In preparation for exporting per-arch mmap randomization functions,
> this moves the ASLR calculations for mmap on ARM into a separate routine.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks fine, thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> ---
>  arch/arm/mm/mmap.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index 5e85ed371364..0f8bc158f2c6 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -169,14 +169,21 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  	return addr;
>  }
>  
> -void arch_pick_mmap_layout(struct mm_struct *mm)
> +static unsigned long mmap_rnd(void)
>  {
> -	unsigned long random_factor = 0UL;
> +	unsigned long rnd = 0UL;
>  
>  	/* 8 bits of randomness in 20 address space bits */
>  	if ((current->flags & PF_RANDOMIZE) &&
>  	    !(current->personality & ADDR_NO_RANDOMIZE))
> -		random_factor = (get_random_int() % (1 << 8)) << PAGE_SHIFT;
> +		rnd = (get_random_int() % (1 << 8)) << PAGE_SHIFT;
> +
> +	return rnd;
> +}
> +
> +void arch_pick_mmap_layout(struct mm_struct *mm)
> +{
> +	unsigned long random_factor = mmap_rnd();
>  
>  	if (mmap_is_legacy()) {
>  		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
> -- 
> 1.9.1
> 

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
