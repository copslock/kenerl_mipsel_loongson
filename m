Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BC7BRw025994
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 05:07:11 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BC7B4Y025993
	for linux-mips-outgoing; Thu, 11 Jul 2002 05:07:11 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from columba.www.eur.3com.com (ip-161-71-171-238.corp-eur.3com.com [161.71.171.238])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BC6qRw025983;
	Thu, 11 Jul 2002 05:06:53 -0700
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id g6BCCvE18002;
	Thu, 11 Jul 2002 13:12:57 +0100 (BST)
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id g6BCBmR06363;
	Thu, 11 Jul 2002 13:11:48 +0100 (BST)
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256BF3.00435429 ; Thu, 11 Jul 2002 13:15:24 +0100
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: Carsten Langgaard <carstenl@mips.com>
cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Message-ID: <80256BF3.00435388.00@notesmta.eur.3com.com>
Date: Thu, 11 Jul 2002 13:11:02 +0100
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



>> I don't wonder if other IDT CPUs also require this, including those that
>> conform MIPS32.
>> Basically, requirement of uncached run makes hadrware logic much simpler
>> and allows  to save silicon a bit.
>
>That could be true, but then again I suggest making specific cache routines for
those
>CPUs.
>It would be a real performance hit for the rest of us, if we have to operate
from
>uncached space.

I pulled together the relevant code to generate a module to test this problem
and it looks like the CPU always misses 1 instruction following the end of the
cache loop. If I add some nop's to change the alignment of the code it doesn't
seem to make any difference. The same thing seems to happen even if I change the
cache flush to a 'Hit_invalidate' of some completely different memory region.
One thing I thought might happen is the CPU ending the loop early as soon as it
invalidates the cacheline containing the current instructions, but this doesn't
seem to be the case, the 'end' address is always correct. Perhaps this really is
a hardware problem.

The test module below does a blast_icache then a few well known instructions and
signifies if anything has been missed. I typically get the following on our
board.
     Cacheop skipped 1 instructions, end = 0x80004000

The end address is correct, so the cache flush completes, but 1 instruction is
missed.

I would be interested to know if someone can test this on another mips32
processor since I don't have any others available.

Simply adding an extra nop after the cache loop might be a good workaround for
this board.

Module compiled with:
/tmp/crossdev/mips/bin/mips-linux-gcc -G 0 -mips2 -mno-abicalls -fno-pic
-mlong-calls -fno-common -O2 -fno-strict-aliasing  -I/usr/src/linux/include
-Wall -DMODULE -D__KERNEL__ -fno-common -c -o  test_tmp.o test.c
/tmp/crossdev/mips/bin/mips-linux-ld -r -G0 -o test.o test_tmp.o


#include <linux/module.h>
#include <linux/init.h>
#include <linux/sysctl.h>
#include <asm/cacheops.h>

#include <asm/bootinfo.h>
#include <asm/cpu.h>
#include <asm/bcache.h>
#include <asm/page.h>
#include <asm/system.h>
#include <asm/addrspace.h>

#define icache_size (16 * 1024)
#define ic_lsize (16)

#define cache_unroll(base,op)                   \
        __asm__ __volatile__("                  \
                .set noreorder;                 \
                .set mips3;                     \
                cache %1, (%0);                 \
                .set mips0;                     \
                .set reorder"                   \
                :                               \
                : "r" (base),                   \
                  "i" (op));

static inline unsigned test_blast_icache(void)
{
     unsigned long start = KSEG0;
     unsigned long end = (start + icache_size);

     while(start < end) {
          cache_unroll(start,Index_Invalidate_I);
          start += ic_lsize;
     }
     return start;
}

static int __init init(void)
{
     int i = 4;
     unsigned int end;

     end = test_blast_icache();

     __asm__(
          ".set push        \n"
          ".set noreorder   \n"
          "   addu %0,-1   \n"
          "   addu %0,-1   \n"
          "   addu %0,-1   \n"
          "   addu %0,-1   \n"
          ".set pop         \n"
          : "=r" (i)
          : "r" (i));

     printk("Cacheop skipped %u instructions, end = 0x%x\n", i, end);
     return 0;
}

static void __exit fini(void)
{
}

module_init(init);
module_exit(fini);
