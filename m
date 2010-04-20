Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2010 15:56:43 +0200 (CEST)
Received: from tomts10.bellnexxia.net ([209.226.175.54]:33211 "EHLO
        tomts10-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492772Ab0DTN4i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Apr 2010 15:56:38 +0200
Received: from toip4.srvr.bell.ca ([209.226.175.87])
          by tomts10-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20100420135610.SPKJ307.tomts10-srv.bellnexxia.net@toip4.srvr.bell.ca>
          for <linux-mips@linux-mips.org>; Tue, 20 Apr 2010 09:56:10 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAKVOzUtGGNqG/2dsb2JhbACcAXK9S4UPBIZP
Received: from bas6-montreal19-1176033926.dsl.bell.ca (HELO krystal.dyndns.org) ([70.24.218.134])
  by toip4.srvr.bell.ca with ESMTP; 20 Apr 2010 10:10:47 -0400
Received: from localhost (localhost [127.0.0.1])
  (uid 1000)
  by krystal.dyndns.org with local; Tue, 20 Apr 2010 09:56:08 -0400
  id 001B6594.4BCDB278.0000723C
Date:   Tue, 20 Apr 2010 09:56:08 -0400
From:   Mathieu Desnoyers <compudj@krystal.dyndns.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     ltt-dev@lists.casi.polymtl.ca, linux-mips@linux-mips.org
Subject: Re: [ltt-dev] [PATCH 2/3] lttng: MIPS: Dump MIPS system call
        tables.
Message-ID: <20100420135608.GB25175@Krystal>
References: <1271722791-27885-1-git-send-email-ddaney@caviumnetworks.com> <1271722791-27885-3-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1271722791-27885-3-git-send-email-ddaney@caviumnetworks.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.6.27.31-grsec (i686)
X-Uptime: 09:55:51 up 12 days, 23:49,  3 users,  load average: 0.37, 0.27,
        0.20
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <compudj@krystal.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: compudj@krystal.dyndns.org
Precedence: bulk
X-list: linux-mips

* David Daney (ddaney@caviumnetworks.com) wrote:
> The 64-bit kernel may support all three ABIs, so we iterate the
> sys_call_tables of all of enabled ABIs.

Merged into the LTTng tree, with some coding style cleanups. Thanks!

Mathieu

> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/Kconfig              |    1 +
>  arch/mips/kernel/scall64-64.S  |    3 +-
>  arch/mips/kernel/scall64-n32.S |    2 +
>  arch/mips/kernel/scall64-o32.S |    8 +++---
>  arch/mips/kernel/syscall.c     |   58 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 5e1133f..a690e9b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -8,6 +8,7 @@ config MIPS
>  	# Horrible source of confusion.  Die, die, die ...
>  	select EMBEDDED
>  	select RTC_LIB if !LEMOTE_FULOONG2E
> +	select HAVE_LTT_DUMP_TABLES
>  
>  mainmenu "Linux/MIPS Kernel Configuration"
>  
> diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
> index 38c0c95..f437a01 100644
> --- a/arch/mips/kernel/scall64-64.S
> +++ b/arch/mips/kernel/scall64-64.S
> @@ -125,7 +125,8 @@ illegal_syscall:
>  	END(handle_sys64)
>  
>  	.align	3
> -sys_call_table:
> +	.type	sys_call_table,@object
> +EXPORT(sys_call_table)	
>  	PTR	sys_read			/* 5000 */
>  	PTR	sys_write
>  	PTR	sys_open
> diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
> index fbecc01..49ab15a 100644
> --- a/arch/mips/kernel/scall64-n32.S
> +++ b/arch/mips/kernel/scall64-n32.S
> @@ -119,6 +119,8 @@ not_n32_scall:
>  
>  	END(handle_sysn32)
>  
> +	.align	3
> +	.type	sysn32_call_table,@object
>  EXPORT(sysn32_call_table)
>  	PTR	sys_read			/* 6000 */
>  	PTR	sys_write
> diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
> index 0db5589..01500cb 100644
> --- a/arch/mips/kernel/scall64-o32.S
> +++ b/arch/mips/kernel/scall64-o32.S
> @@ -53,7 +53,7 @@ NESTED(handle_sys, PT_SIZE, sp)
>  	sll	a3, a3, 0
>  
>  	dsll	t0, v0, 3		# offset into table
> -	ld	t2, (sys_call_table - (__NR_O32_Linux * 8))(t0)
> +	ld	t2, (syso32_call_table - (__NR_O32_Linux * 8))(t0)
>  
>  	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
>  
> @@ -179,7 +179,7 @@ LEAF(sys32_syscall)
>  	beqz	t0, einval		# do not recurse
>  	dsll	t1, t0, 3
>  	beqz	v0, einval
> -	ld	t2, sys_call_table(t1)		# syscall routine
> +	ld	t2, syso32_call_table(t1)	# syscall routine
>  
>  	move	a0, a1			# shift argument registers
>  	move	a1, a2
> @@ -201,8 +201,8 @@ einval:	li	v0, -ENOSYS
>  	END(sys32_syscall)
>  
>  	.align	3
> -	.type	sys_call_table,@object
> -sys_call_table:
> +	.type	syso32_call_table,@object
> +EXPORT(syso32_call_table)
>  	PTR	sys32_syscall			/* 4000 */
>  	PTR	sys_exit
>  	PTR	sys_fork
> diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
> index 1452e2f..996ef29 100644
> --- a/arch/mips/kernel/syscall.c
> +++ b/arch/mips/kernel/syscall.c
> @@ -29,6 +29,7 @@
>  #include <linux/module.h>
>  #include <linux/ipc.h>
>  #include <linux/uaccess.h>
> +#include <linux/kallsyms.h>
>  #include <trace/ipc.h>
>  
>  #include <asm/asm.h>
> @@ -560,3 +561,60 @@ int kernel_execve(const char *filename, char *const argv[], char *const envp[])
>  
>  	return -__v0;
>  }
> +
> +void ltt_dump_sys_call_table(void *call_data)
> +{
> +	int i;
> +	char namebuf[KSYM_NAME_LEN];
> +
> +#ifdef CONFIG_32BIT
> +	extern struct {
> +		unsigned long ptr;
> +		long j;
> +	} sys_call_table[];
> +	for (i = 0; i < __NR_O32_Linux_syscalls; i++) {
> +		sprint_symbol(namebuf, sys_call_table[i].ptr);
> +		__trace_mark(0, syscall_state, sys_call_table, call_data,
> +			"id %d address %p symbol %s",
> +			i + __NR_O32_Linux, (void*)sys_call_table[i].ptr, namebuf);
> +	}
> +#endif
> +#ifdef CONFIG_64BIT
> +# ifdef CONFIG_MIPS32_O32
> +	for (i = 0; i < __NR_O32_Linux_syscalls; i++) {
> +		extern unsigned long syso32_call_table[];
> +		sprint_symbol(namebuf, syso32_call_table[i]);
> +		__trace_mark(0, syscall_state, sys_call_table, call_data,
> +			"id %d address %p symbol %s",
> +			i + __NR_O32_Linux, (void*)syso32_call_table[i], namebuf);
> +	}
> +# endif
> +
> +	for (i = 0; i < __NR_64_Linux_syscalls; i++) {
> +		extern unsigned long sys_call_table[];
> +		sprint_symbol(namebuf, sys_call_table[i]);
> +		__trace_mark(0, syscall_state, sys_call_table, call_data,
> +			"id %d address %p symbol %s",
> +			i + __NR_64_Linux, (void*)sys_call_table[i], namebuf);
> +	}
> +
> +# ifdef CONFIG_MIPS32_N32
> +	for (i = 0; i < __NR_N32_Linux_syscalls; i++) {
> +		extern unsigned long sysn32_call_table[];
> +		sprint_symbol(namebuf, sysn32_call_table[i]);
> +		__trace_mark(0, syscall_state, sys_call_table, call_data,
> +			"id %d address %p symbol %s",
> +			i + __NR_N32_Linux, (void*)sysn32_call_table[i], namebuf);
> +	}
> +# endif
> +#endif
> +
> +}
> +EXPORT_SYMBOL_GPL(ltt_dump_sys_call_table);
> +
> +void ltt_dump_idt_table(void *call_data)
> +{
> +	/* No IDT information yet.  */
> +	return;
> +}
> +EXPORT_SYMBOL_GPL(ltt_dump_idt_table);
> -- 
> 1.6.6.1
> 
> 
> _______________________________________________
> ltt-dev mailing list
> ltt-dev@lists.casi.polymtl.ca
> http://lists.casi.polymtl.ca/cgi-bin/mailman/listinfo/ltt-dev
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
