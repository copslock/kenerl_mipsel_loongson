Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 02:10:15 +0200 (CEST)
Received: from imr3.ericy.com ([198.24.6.13]:56892 "EHLO imr3.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492164Ab1HSAKL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Aug 2011 02:10:11 +0200
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
        by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id p7J0A4Y8011333
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-mips@linux-mips.org>; Thu, 18 Aug 2011 19:10:04 -0500
Received: from [IPv6:::1] (147.117.20.214) by smtps-am.internal.ericsson.com
 (147.117.20.178) with Microsoft SMTP Server (TLS) id 8.3.137.0; Thu, 18 Aug
 2011 20:10:04 -0400
Message-ID: <4E4DA9DA.60305@ericsson.com>
Date:   Thu, 18 Aug 2011 17:10:02 -0700
From:   Jason Kwon <jason.kwon@ericsson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
Subject: Problems booting 3.0.3 kernel on Octeon CN58XX board
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason.kwon@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13765

Attempting to boot a 3.0.3 kernel on a CN58XX board produced the 
following oops:

CPU 4 Unable to handle kernel paging request at virtual address 
0000000001c00000, epc == ffffffff811aa9f4, ra == ffffffff811aaa98
Oops[#1]:
Cpu 4
$ 0   : 0000000000000000 0000000010008ce0 ffffffff821d2b80 0000000001c00000
$ 4   : 0000000001c00038 000000000000017c 0000000000080000 0000000000080072
$ 8   : 0000000000000008 0000000000000002 0000000000000003 a800000002284520
$12   : 0000000000000002 ffffffff8186ee80 ffffffffffffff80 0000000000000030
$16   : 0000000000080072 0000000000000001 0000000001bfa8f0 0000000001bfa928
$20   : a800000003aff8f0 00000000000f0000 ffffffff8186ee80 ffffffff821d2a80
$24   : 0000000000000001 0000000000000038
$28   : a80000041fc48000 a80000041fc4bd90 fffffffffffffffc ffffffff811aaa98
Hi    : 0000000000000000
Lo    : 0000000000000000
epc   : ffffffff811aa9f4 setup_per_zone_wmarks+0x19c/0x2d8
     Not tainted
ra    : ffffffff811aaa98 setup_per_zone_wmarks+0x240/0x2d8
Status: 10008ce2    KX SX UX KERNEL EXL
Cause : 40808408
BadVA : 0000000001c00000
PrId  : 000d0301 (Cavium Octeon+)
Modules linked in:
Process swapper (pid: 1, threadinfo=a80000041fc48000, 
task=a80000041fc44038, tls=0000000000000000)
Stack : 0000000000000000 000000000006f75d ffffffff8186eec0 0000000000000001
         0000000000000547 ffffffff81825598 ffffffff81a80000 ffffffff818b3e68
         ffffffff818a40ac 0000000000000000 ffffffff81a80000 0000000000000000
         0000000000000000 0000000000000000 0000000000000000 ffffffff818a40f0
         ffffffff81a80000 ffffffff81100438 ffffffff818b4198 ffffffff818b3e68
         ffffffff818b46c8 0000000000000000 0000000000000000 ffffffff818721d0
         0000000000000000 0000000000000000 0000000000000000 ffffffff81109bb0
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 0000000000000000 0000000000000000 ffffffff818720f8
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         ...
Call Trace:
[<ffffffff811aa9f4>] setup_per_zone_wmarks+0x19c/0x2d8
[<ffffffff818a40f0>] init_per_zone_wmark_min+0x44/0xe0
[<ffffffff81100438>] do_one_initcall+0x38/0x160
[<ffffffff818721d0>] kernel_init+0xd8/0x178
[<ffffffff81109bb0>] kernel_thread_helper+0x10/0x18


Code: 007e1824  0064182d  64840038 <dc620000> c84afff5  64c60001  
66020200  66737000  1220000c

All code
========
    0:    24 18                    and    $0x18,%al
    2:    7e 00                    jle    0x4
    4:    2d 18 64 00 38           sub    $0x38006418,%eax
    9:    00 84 64 00 00 62 dc     add    %al,-0x239e0000(%rsp,%riz,2)
   10:    f5                       cmc
   11:    ff 4a c8                 decl   -0x38(%rdx)
   14:    01 00                    add    %eax,(%rax)
   16:    c6                       (bad)
   17:    64 00 02                 add    %al,%fs:(%rdx)
   1a:    02 66 00                 add    0x0(%rsi),%ah
   1d:    70 73                    jo     0x92
   1f:    66                       data16
   20:    0c 00                    or     $0x0,%al
   22:    20 12                    and    %dl,(%rdx)

Code starting with the faulting instruction
===========================================
    0:    00 00                    add    %al,(%rax)
    2:    62                       (bad)
    3:    dc f5                    fdiv   %st,%st(5)
    5:    ff 4a c8                 decl   -0x38(%rdx)
    8:    01 00                    add    %eax,(%rax)
    a:    c6                       (bad)
    b:    64 00 02                 add    %al,%fs:(%rdx)
    e:    02 66 00                 add    0x0(%rsi),%ah
   11:    70 73                    jo     0x86
   13:    66                       data16
   14:    0c 00                    or     $0x0,%al
   16:    20 12                    and    %dl,(%rdx)

(gdb) list *setup_per_zone_wmarks+0x19c
0x811aa9f4 is in setup_per_zone_wmarks 
(include/asm-generic/bitops/non-atomic.h:105).
100     * @nr: bit number to test
101     * @addr: Address to start counting from
102     */
103    static inline int test_bit(int nr, const volatile unsigned long 
*addr)
104    {
105        return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
106    }
107
108    #endif /* _ASM_GENERIC_BITOPS_NON_ATOMIC_H_ */
(gdb)

I am able to boot 2.6.39.3 on this board.  Is this a known issue?  Thanks,

Jason
