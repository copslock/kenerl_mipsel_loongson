Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 11:20:05 +0100 (CET)
Received: from webmail34.rediffmail.com ([203.199.83.247]:33749 "HELO
	rediffmail.com") by linux-mips.org with SMTP id <S8224847AbSLDKUE>;
	Wed, 4 Dec 2002 11:20:04 +0100
Received: (qmail 5790 invoked by uid 510); 4 Dec 2002 10:18:16 -0000
Date: 4 Dec 2002 10:18:16 -0000
Message-ID: <20021204101816.5789.qmail@mailweb34.rediffmail.com>
Received: from unknown (219.65.139.45) by rediffmail.com via HTTP; 04 dec 2002 10:18:15 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: hazards during DO_FAULT macro..
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

My problem is that during return of sys_execve i get a page fault 
on userspace address (0x004000b0) but the pt_regs address in 
do_page_fault I get is 0x8013a61c which is actually envp_init 
arguement passed in execve("/bin/sh",argv_init,envp_init);

I was trying to debug where my pt_regs pointer got thrased during 
do_page_fault()

I found following stuff very strange.

macro Do_FAULt(write) expands like..

#define DO_FAULT(write) \
         .set    noreorder; \
         .set    noat; \
         SAVE_ALL; \
         STI; \
         nop; \
         .set    at; \
         move a0, sp; \
         jal     do_page_fault; \
         li     a1, write; \
         nop; \
         j       ret_from_sys_call; \
         nop; \
        .set    noat;

this macro is called by handle_tlbx() routines.
when I tracked this problem and i observed my pt_regs address
looked o.k. and apparently right till after STI; \ and just before 
instruction     mfc0    a2, CP0_BADVADDR;
this i found by putting following instructions,

move  a0,sp; \
jal show_regs; \
nop; \

later it jumps to do_page_fault() ,and pt_regs address there 
equals unexpectedly to envp_init and from thereon everythings goes 
wrong..

I also tried with negating STI; \ , but same result.

problamatic assembly code for DO_FAULT macro is following.

.set noat; \
SAVE_ALL; \
8001e694:  03a02021 	move	$a0,$sp               ----{
8001e698:  0c03bba8 	jal	800eeea0 <show_regs>  my debug code of          
                      show_regs() ...here pt_regs address is 
o.k..
8001e69c:	00000000 	nop                   ---}

8001e6a0:	40086000 	mfc0	$t0,$12     -----{
8001e6a4:	3c091000 	lui	$t1,0x1000
8001e6a8:	3529001f 	ori	$t1,$t1,0x1f
8001e6ac:	01094025 	or	$t0,$t0,$t1     STI macro code , though i 
tried without STI for testing purpose, as well
8001e6b0:	3908001e 	xori	$t0,$t0,0x1e
8001e6b4:	40886000 	mtc0	$t0,$12
8001e6b8:	40064000 	mfc0	$a2,$8      -----}
...
8001e6c4:	03a02021 	move	$a0,$sp
8001e6c8:	0c007e34 	jal	8001f8d0 <do_page_fault>
                                                    -----{now in         
          do_page_fault() pt_regs address is erronousely
         different in my case it is equal to envp_init.  }
8001e6cc:	24050000 	li	$a1,0
8001e6d0:	00000000 	nop
8001e6d4:	08006a9a 	j	8001aa68 <ret_from_irq>

what kind of hazard happening..?

Best Regards,
Atul
