Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4OLTBnC019668
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 24 May 2002 14:29:11 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4OLTBjG019667
	for linux-mips-outgoing; Fri, 24 May 2002 14:29:11 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4OLSvnC019657
	for <linux-mips@oss.sgi.com>; Fri, 24 May 2002 14:28:58 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA01234
	for <linux-mips@oss.sgi.com>; Fri, 24 May 2002 14:29:52 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA06593;
	Fri, 24 May 2002 14:12:40 -0700
Message-ID: <3CEEAC5F.6010802@mvista.com>
Date: Fri, 24 May 2002 14:10:55 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alexandr Andreev <andreev@niisi.msk.ru>
CC: linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
References: <3CEEBBA9.5070809@niisi.msk.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Alexandr Andreev wrote:

> Hi, list.
> I have three little questions with linux-2.4.18 on my machine.
> 
> My configuration is:
> MIPS R3000, linux-2.4.18 kernel from CVS,
> egcs-mips-linux-1.1.2-4 (egcs-2.91.66) and binutils-mips-linux-2.8.1-2
> 
> 1. When i use MIPS specific arch_get_unmapped_area() function, my kernel
>  hangs. It looks like this:
>  ...
>  Freeing unused kernel memory: 108k freed
>  do_page_fault() #2: sending SIGSEGV to init for illegal read access 
> from        0fb65330 (epc == 0fb65330, ra == 0fb851dc)
>  ... and so on. Last message is printed infinitely.
> 
>  So, i have to give up HAVE_ARCH_UNMAPPED_AREA feature, and to use
>  common arch_get_unmapped_area() routine.
> 


I took a look of the arch_get_unmapped_area(),  and it looks fine to me.

Can you try the following changes and let me know what happens?

1) change COLOUR_ALIGN
#define COLOUR_ALIGN(addr,pgoff) 	addr

2) I don't understand why we need color alignment if file is not NULL.  (Can 
someone explain?).  So you can try to remove that condition:

diff -Nru ./arch/mips/kernel/syscall.c.orig ./arch/mips/kernel/syscall.c
--- ./arch/mips/kernel/syscall.c.orig   Sat May 11 00:05:34 2002
+++ ./arch/mips/kernel/syscall.c        Fri May 24 13:54:47 2002
@@ -77,7 +77,7 @@
         if (len > TASK_SIZE)
                 return -ENOMEM;
         do_color_align = 0;
-       if (filp || (flags & MAP_SHARED))
+       if (flags & MAP_SHARED)
                 do_color_align = 1;
         if (addr) {
                 if (do_color_align)



> 2. There is a strange code in the local_flush_tlb_page() function
>  (tlb-r3k.c and tlb-r4k.c):
>     ...
>         if (!vma || vma->vm_mm->context != 0) {
>               unsigned long flags;
>               int oldpid, newpid, idx;
>  #ifdef DEBUG_TLB
>               printk("[tlbpage<%lu,0x%08lx>]", vma->vm_mm->context, page);
>  #endif
>               newpid = (vma->vm_mm->context & 0xfc0);
>                         ^^^^^
>  Hmm... the kernel will crash if vma ==0. I guess that this code must look
>  like this:
> 
>         if (vma && vma->vm_mm->context !=0) {
> 
>  Is any patches required?
> 


I think you just found a bug.  The fix looks good to me.


> 3. I have some problems, when i try to compile latest kernels with my egcs
>  and binutils, such as problems with "__INIT" and "__FINI" assembler 
> macroses:
> 
>  # mips-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I include -G 0
>   -mno-abicalls -fno-pic -mcpu=r3000 -mips1 -pipe -c entry.S -o entry.o
>  entry.S: Assembler messages:
>  entry.S:179: Error: .previous without corresponding .section; ignored
> 
>  ... and ".macro" assembler command usage:
> 
>  # mips-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I include -G 0   
> -mno-abicalls -fno-pic -mcpu=r3000 -mips1 -pipe -c head.S -o head.o
>  head.S: Assembler messages:
>  head.S:224: Error: .size expression too complicated to fix up
>  head.S:224: Error: .size expression too complicated to fix up
>  head.S:224: Error: .size expression too complicated to fix up
>  head.S:224: Error: .size expression too complicated to fix up
>  make[1]: *** [head.o] Error 1
> 
>  I know that my binutils are obsolete and so, I tried to use some newer
>   binutils (2.9.5-1, 2.9.5-3), but my kernel crashed :(. Please, can you 
> answer
>   me, what egcs & binutils are suitable for linux-2.4.18 and MIPS R3000
>   compliant?
>


We have been using gcc 2.9.5 and binutils 2.10.x for R3000 CPUs for quite a 
while with no problems.  It seems newer gcc and binutiles are fine too.

Jun
