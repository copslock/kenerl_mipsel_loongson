Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g46IZMwJ027391
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 6 May 2002 11:35:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g46IZMrJ027390
	for linux-mips-outgoing; Mon, 6 May 2002 11:35:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g46IZ4wJ027370;
	Mon, 6 May 2002 11:35:04 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA07204; Mon, 6 May 2002 11:36:12 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA14702;
	Mon, 6 May 2002 11:19:47 -0700
Message-ID: <3CD6C8EA.9060807@mvista.com>
Date: Mon, 06 May 2002 11:18:18 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: what is the right behavior of copy_to_user(0x0, ..., ...)?
References: <3CD3052B.1050400@mvista.com> <20020503162337.A27366@dea.linux-mips.net> <3CD32044.9040109@mvista.com> <20020503184000.A1238@dea.linux-mips.net>
Content-Type: multipart/mixed;
 boundary="------------080607000901020806060009"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


This is a multi-part message in MIME format.
--------------080607000901020806060009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


It would help if not for the gross typo. :-)  See the attachment.

Jun


Ralf Baechle wrote:

> On Fri, May 03, 2002 at 04:41:56PM -0700, Jun Sun wrote:
> 
> 
>>It appears earlier version of kernel does not have this problem.  I have not 
>>fully figured out why.
>>
> 
> We didn't handle exceptions in branch delay slots.  Try this patch and
> tell me if it helps.
> 
>   Ralf
> 
> Index: arch/mips/mm/fault.c
> ===================================================================
> RCS file: /home/pub/cvs/linux/arch/mips/mm/fault.c,v
> retrieving revision 1.25.2.2
> diff -u -r1.25.2.2 fault.c
> --- arch/mips/mm/fault.c	16 Jan 2002 03:49:24 -0000	1.25.2.2
> +++ arch/mips/mm/fault.c	4 May 2002 01:28:34 -0000
> @@ -19,6 +19,7 @@
>  #include <linux/smp_lock.h>
>  #include <linux/version.h>
>  
> +#include <asm/branch.h>
>  #include <asm/hardirq.h>
>  #include <asm/pgalloc.h>
>  #include <asm/mmu_context.h>
> @@ -77,7 +78,7 @@
>  	struct vm_area_struct * vma;
>  	struct task_struct *tsk = current;
>  	struct mm_struct *mm = tsk->mm;
> -	unsigned long fixup;
> +	unsigned long epc, fixup;
>  	siginfo_t info;
>  
>  	/*
> @@ -181,7 +182,8 @@
>  
>  no_context:
>  	/* Are we prepared to handle this kernel fault?  */
> -	fixup = search_exception_table(regs->cp0_epc);
> +	epc = regs->cp0_epc + delay_slot(regs) ? 4 : 0;
> +	fixup = search_exception_table(epc);
>  	if (fixup) {
>  		long new_epc;
>  
> Index: arch/mips64/mm/fault.c
> ===================================================================
> RCS file: /home/pub/cvs/linux/arch/mips64/mm/fault.c,v
> retrieving revision 1.26.2.6
> diff -u -r1.26.2.6 fault.c
> --- arch/mips64/mm/fault.c	23 Feb 2002 02:16:42 -0000	1.26.2.6
> +++ arch/mips64/mm/fault.c	4 May 2002 01:28:34 -0000
> @@ -21,6 +21,7 @@
>  #include <linux/smp_lock.h>
>  #include <linux/version.h>
>  
> +#include <asm/branch.h>
>  #include <asm/hardirq.h>
>  #include <asm/pgalloc.h>
>  #include <asm/mmu_context.h>
> @@ -103,7 +104,7 @@
>  	struct vm_area_struct * vma;
>  	struct task_struct *tsk = current;
>  	struct mm_struct *mm = tsk->mm;
> -	unsigned long fixup;
> +	unsigned long epc, fixup;
>  	siginfo_t info;
>  
>  #if 0
> @@ -208,7 +209,8 @@
>  
>  no_context:
>  	/* Are we prepared to handle this kernel fault?  */
> -	fixup = search_exception_table(regs->cp0_epc);
> +	epc = regs->cp0_epc + delay_slot(regs) ? 4 : 0;
> +	fixup = search_exception_table(epc);
>  	if (fixup) {
>  		long new_epc;
>  
> 


--------------080607000901020806060009
Content-Type: text/plain;
 name="junk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="junk"

diff -Nru link/arch/mips/mm/fault.c.orig link/arch/mips/mm/fault.c
--- link/arch/mips/mm/fault.c.orig	Mon May  6 11:12:41 2002
+++ link/arch/mips/mm/fault.c	Mon May  6 11:15:12 2002
@@ -182,7 +182,7 @@
 
 no_context:
 	/* Are we prepared to handle this kernel fault?  */
-	epc = regs->cp0_epc + delay_slot(regs) ? 4 : 0;
+	epc = regs->cp0_epc + (delay_slot(regs) ? 4 : 0);
 	fixup = search_exception_table(epc);
 	if (fixup) {
 		long new_epc;
diff -Nru link/arch/mips64/mm/fault.c.orig link/arch/mips64/mm/fault.c
--- link/arch/mips64/mm/fault.c.orig	Mon May  6 11:12:44 2002
+++ link/arch/mips64/mm/fault.c	Mon May  6 11:15:26 2002
@@ -209,7 +209,7 @@
 
 no_context:
 	/* Are we prepared to handle this kernel fault?  */
-	epc = regs->cp0_epc + delay_slot(regs) ? 4 : 0;
+	epc = regs->cp0_epc + (delay_slot(regs) ? 4 : 0);
 	fixup = search_exception_table(epc);
 	if (fixup) {
 		long new_epc;

--------------080607000901020806060009--
