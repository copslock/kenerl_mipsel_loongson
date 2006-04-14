Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Apr 2006 10:38:32 +0100 (BST)
Received: from smtp103.biz.mail.mud.yahoo.com ([68.142.200.238]:19037 "HELO
	smtp103.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133376AbWDNJiW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Apr 2006 10:38:22 +0100
Received: (qmail 47557 invoked from network); 14 Apr 2006 09:50:22 -0000
Received: from unknown (HELO ?192.168.1.102?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp103.biz.mail.mud.yahoo.com with SMTP; 14 Apr 2006 09:50:22 -0000
Subject: Re: mips64 kgdb fpu access bug
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060414.120944.25476367.nemoto@toshiba-tops.co.jp>
References: <1144961699.8372.127.camel@localhost.localdomain>
	 <20060414.120944.25476367.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 14 Apr 2006 02:50:20 -0700
Message-Id: <1145008220.11383.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


Looks good on inspection and my kernel boots fine now. It used to crash
consistently with this particular configuration and root file system.

Now I need to cook up something similar for the kgdb support :)

Thanks!

Pete

On Fri, 2006-04-14 at 12:09 +0900, Atsushi Nemoto wrote:
> On Thu, 13 Apr 2006 13:54:59 -0700, Pete Popov <ppopov@embeddedalley.com> wrote:
> > .macro  fpu_save_double thread status tmp1 tmp2
> >         sll     \tmp2, \tmp1, 5
> >         bgez    \tmp2, 2f
> >         fpu_save_16odd \thread
> > 2:
> >         fpu_save_16even \thread \tmp1                   # clobbers t1
> >         .endm
> > 
> > tmp1 is "t0" and it's not clear to me why we're checking t0 instead of
> > status in order to decide whether to save the odd registers or not. I
> > must be missing something because others would have hit this bug by now.
> > Any clues would be appreciated.
> 
> It seems commit d0fd5c21d07d6e13993a77f4471d8003a271a12b was somewhat
> broken.
> 
> Could you try this patch?
> 
> 
> fix register usage in fpu_save_double() and make fpu_restore_double()
> more symmetric with fpu_save_double().
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
> index 0b1b54a..db94e55 100644
> --- a/arch/mips/kernel/r4k_switch.S
> +++ b/arch/mips/kernel/r4k_switch.S
> @@ -75,8 +75,8 @@
>  	and	t0, t0, t1
>  	LONG_S	t0, ST_OFF(t3)
>  
> -	fpu_save_double a0 t1 t0 t2		# c0_status passed in t1
> -						# clobbers t0 and t2
> +	fpu_save_double a0 t0 t1		# c0_status passed in t0
> +						# clobbers t1
>  1:
>  
>  	/*
> @@ -129,9 +129,9 @@
>   */
>  LEAF(_save_fp)
>  #ifdef CONFIG_64BIT
> -	mfc0	t1, CP0_STATUS
> +	mfc0	t0, CP0_STATUS
>  #endif
> -	fpu_save_double a0 t1 t0 t2		# clobbers t1
> +	fpu_save_double a0 t0 t1		# clobbers t1
>  	jr	ra
>  	END(_save_fp)
>  
> @@ -139,7 +139,10 @@ LEAF(_save_fp)
>   * Restore a thread's fp context.
>   */
>  LEAF(_restore_fp)
> -	fpu_restore_double a0, t1		# clobbers t1
> +#ifdef CONFIG_64BIT
> +	mfc0	t0, CP0_STATUS
> +#endif
> +	fpu_restore_double a0 t0 t1		# clobbers t1
>  	jr	ra
>  	END(_restore_fp)
>  
> diff --git a/include/asm-mips/asmmacro-32.h b/include/asm-mips/asmmacro-32.h
> index 11daf5c..5de3963 100644
> --- a/include/asm-mips/asmmacro-32.h
> +++ b/include/asm-mips/asmmacro-32.h
> @@ -12,7 +12,7 @@
>  #include <asm/fpregdef.h>
>  #include <asm/mipsregs.h>
>  
> -	.macro	fpu_save_double thread status tmp1=t0 tmp2
> +	.macro	fpu_save_double thread status tmp1=t0
>  	cfc1	\tmp1,  fcr31
>  	sdc1	$f0,  THREAD_FPR0(\thread)
>  	sdc1	$f2,  THREAD_FPR2(\thread)
> @@ -70,7 +70,7 @@
>  	sw	\tmp, THREAD_FCR31(\thread)
>  	.endm
>  
> -	.macro	fpu_restore_double thread tmp=t0
> +	.macro	fpu_restore_double thread status tmp=t0
>  	lw	\tmp, THREAD_FCR31(\thread)
>  	ldc1	$f0,  THREAD_FPR0(\thread)
>  	ldc1	$f2,  THREAD_FPR2(\thread)
> diff --git a/include/asm-mips/asmmacro-64.h b/include/asm-mips/asmmacro-64.h
> index 559c355..225feef 100644
> --- a/include/asm-mips/asmmacro-64.h
> +++ b/include/asm-mips/asmmacro-64.h
> @@ -53,12 +53,12 @@
>  	sdc1	$f31, THREAD_FPR31(\thread)
>  	.endm
>  
> -	.macro	fpu_save_double thread status tmp1 tmp2
> -	sll	\tmp2, \tmp1, 5
> -	bgez	\tmp2, 2f
> +	.macro	fpu_save_double thread status tmp
> +	sll	\tmp, \status, 5
> +	bgez	\tmp, 2f
>  	fpu_save_16odd \thread
>  2:
> -	fpu_save_16even \thread \tmp1			# clobbers t1
> +	fpu_save_16even \thread \tmp
>  	.endm
>  
>  	.macro	fpu_restore_16even thread tmp=t0
> @@ -101,13 +101,12 @@
>  	ldc1	$f31, THREAD_FPR31(\thread)
>  	.endm
>  
> -	.macro	fpu_restore_double thread tmp
> -	mfc0	t0, CP0_STATUS
> -	sll	t1, t0, 5
> -	bgez	t1, 1f				# 16 register mode?
> +	.macro	fpu_restore_double thread status tmp
> +	sll	\tmp, \status, 5
> +	bgez	\tmp, 1f				# 16 register mode?
>  
> -	fpu_restore_16odd a0
> -1:	fpu_restore_16even a0, t0		# clobbers t0
> +	fpu_restore_16odd \thread
> +1:	fpu_restore_16even \thread \tmp
>  	.endm
>  
>  	.macro	cpu_save_nonscratch thread
