Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4OERknC006514
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 24 May 2002 07:27:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4OERkh6006513
	for linux-mips-outgoing; Fri, 24 May 2002 07:27:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru ([193.232.173.111])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4OERRnC006507
	for <linux-mips@oss.sgi.com>; Fri, 24 May 2002 07:27:36 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id SAA20739
	for <linux-mips@oss.sgi.com>; Fri, 24 May 2002 18:27:19 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id SAA09843 for linux-mips@oss.sgi.com; Fri, 24 May 2002 18:37:52 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id SAA27970 for <linux-mips@oss.sgi.com>; Fri, 24 May 2002 18:10:23 +0400 (MSK)
Message-ID: <3CEEBBA9.5070809@niisi.msk.ru>
Date: Fri, 24 May 2002 18:16:09 -0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.17 i686; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: 3 questions about linux-2.4.18 and R3000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, list.
I have three little questions with linux-2.4.18 on my machine.

My configuration is:
MIPS R3000, linux-2.4.18 kernel from CVS,
egcs-mips-linux-1.1.2-4 (egcs-2.91.66) and binutils-mips-linux-2.8.1-2

1. When i use MIPS specific arch_get_unmapped_area() function, my kernel
  hangs. It looks like this:
  ...
  Freeing unused kernel memory: 108k freed
  do_page_fault() #2: sending SIGSEGV to init for illegal read access 
from       
  0fb65330 (epc == 0fb65330, ra == 0fb851dc)
  ... and so on. Last message is printed infinitely.

  So, i have to give up HAVE_ARCH_UNMAPPED_AREA feature, and to use
  common arch_get_unmapped_area() routine.

2. There is a strange code in the local_flush_tlb_page() function
  (tlb-r3k.c and tlb-r4k.c):
     ...
         if (!vma || vma->vm_mm->context != 0) {
               unsigned long flags;
               int oldpid, newpid, idx;
  #ifdef DEBUG_TLB
               printk("[tlbpage<%lu,0x%08lx>]", vma->vm_mm->context, page);
  #endif
               newpid = (vma->vm_mm->context & 0xfc0);
                         ^^^^^
  Hmm... the kernel will crash if vma ==0. I guess that this code must look
  like this:

         if (vma && vma->vm_mm->context !=0) {
 
  Is any patches required?

3. I have some problems, when i try to compile latest kernels with my egcs
  and binutils, such as problems with "__INIT" and "__FINI" assembler 
macroses:

  # mips-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I include -G 0
   -mno-abicalls -fno-pic -mcpu=r3000 -mips1 -pipe -c entry.S -o entry.o
  entry.S: Assembler messages:
  entry.S:179: Error: .previous without corresponding .section; ignored

  ... and ".macro" assembler command usage:

  # mips-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I include -G 0 
   -mno-abicalls -fno-pic -mcpu=r3000 -mips1 -pipe -c head.S -o head.o
  head.S: Assembler messages:
  head.S:224: Error: .size expression too complicated to fix up
  head.S:224: Error: .size expression too complicated to fix up
  head.S:224: Error: .size expression too complicated to fix up
  head.S:224: Error: .size expression too complicated to fix up
  make[1]: *** [head.o] Error 1

  I know that my binutils are obsolete and so, I tried to use some newer
   binutils (2.9.5-1, 2.9.5-3), but my kernel crashed :(. Please, can 
you answer
   me, what egcs & binutils are suitable for linux-2.4.18 and MIPS R3000
   compliant?

  Any help will be appriciated.
