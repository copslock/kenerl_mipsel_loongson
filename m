Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2007 21:53:39 +0000 (GMT)
Received: from rrcs-64-183-102-11.west.biz.rr.com ([64.183.102.11]:7311 "EHLO
	jg555.com") by ftp.linux-mips.org with ESMTP id S20022350AbXCRVxh
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Mar 2007 21:53:37 +0000
Received: from [192.168.55.157] ([::ffff:192.168.55.157])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Sun, 18 Mar 2007 14:52:34 -0700
  id 004501A1.45FDB4A2.00005301
Message-ID: <45FDB498.1040504@jg555.com>
Date:	Sun, 18 Mar 2007 14:52:24 -0700
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
CC:	Linux MIPS List <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Building 64 bit kernel on Cobalt
References: <45EB53D5.8060007@jg555.com>	 <20070304232731.GA25039@linux-mips.org> <45EFA92C.3070203@jg555.com>	 <cda58cb80703080448yca7fa21xb005e0685d42d318@mail.gmail.com>	 <45F0359A.105@jg555.com> <45F5F709.6060707@jg555.com> <cda58cb80703130338t57240ba9m15e6b0e37da875b4@mail.gmail.com>
In-Reply-To: <cda58cb80703130338t57240ba9m15e6b0e37da875b4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Frank,
    Got it narrowed down further. This reverting these 3 sections will 
allow it to boot, but then mounting root it gives a unaligned access 
error. Reverting all the changes to setup.c, fixes the issue and boots 
completely.

--- linux-2.6.19.2/arch/mips/kernel/setup.c     2007-01-10 
11:10:37.000000000 -0800
+++ linux-2.6.20.1/arch/mips/kernel/setup.c     2007-03-07 
20:59:28.000000000 -0800
@@ -204,12 +226,12 @@
                printk(KERN_INFO "Initrd not found or empty");
                goto disable;
        }
-       if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
+       if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
                printk("Initrd extends beyond end of memory");
                goto disable;
        }

-       reserve_bootmem(CPHYSADDR(initrd_start), size);
+       reserve_bootmem(__pa(initrd_start), size);
        initrd_below_start_ok = 1;

        printk(KERN_INFO "Initial ramdisk at: 0x%lx (%lu bytes)\n",
@@ -259,8 +281,7 @@
         * not selected. Once that done we can determine the low bound
         * of usable memory.
         */
-       reserved_end = init_initrd();
-       reserved_end = PFN_UP(CPHYSADDR(max(reserved_end, (unsigned 
long)&_end)));
+       reserved_end = max(init_initrd(), PFN_UP(__pa_symbol(&_end)));

        /*
         * Find the highest page frame number we have available.
@@ -432,10 +453,10 @@
        if (UNCAC_BASE != IO_BASE)
                return;

-       code_resource.start = virt_to_phys(&_text);
-       code_resource.end = virt_to_phys(&_etext) - 1;
-       data_resource.start = virt_to_phys(&_etext);
-       data_resource.end = virt_to_phys(&_edata) - 1;
+       code_resource.start = __pa_symbol(&_text);
+       code_resource.end = __pa_symbol(&_etext) - 1;
+       data_resource.start = __pa_symbol(&_etext);
+       data_resource.end = __pa_symbol(&_edata) - 1;

        /*
         * Request address space for all standard RAM.

VFS: Mounted root (nfs filesystem) readonly.
Unhandled kernel unaligned access[#1]:
Cpu 0
$ 0   : 0000000000000000 ffffffff802adc70 0000000000000000 0000000000000000
$ 4   : ffffffff80089fac ffffffffde020000 ffffffff8008c648 0000000000000000
$ 8   : 0000000000561024 996bffffff40b050 0000000000000000 000000000000f6f8
$12   : ffffffff94004ce0 000000001000001e 0000000000000000 ffffffff80300000
$16   : 9800000000387df0 ffffffff80326000 0000000000000000 00067ffffff80326
$20   : 00067ffffff80326 000000000000002d fffffffffffffbff 67ffffff80353000
$24   : 0000000000000010 ffffffff80176998
$28   : 9800000000384000 9800000000387dc0 67ffffff80326000 ffffffff80081ee8
Hi    : 0000000000000000
Lo    : 0000000000000000
epc   : ffffffff80089fc4 do_ade+0x3a4/0x4c0     Not tainted
ra    : ffffffff80081ee8 ret_from_exception+0x0/0x1c
Status: 94004ce2    KX SX UX KERNEL EXL
Cause : 00808010
BadVA : 996bffffff40b057
PrId  : 000028a0
Process swapper (pid: 1, threadinfo=9800000000384000, task=9800000000381828)
Stack : 996bffffff40b050 ffffffff80326000 016bfffffe40b050 00067ffffff80326
        ffffffff80081ee8 0000000000000000 0000000000000000 ffffffff94004ce0
        9800000001000000 019ffffffe00c980 ffffffff94004ce1 00067ffffff80353
        6800000000000000 9800000000381828 98000000013e9a40 98000000003b3000
        ffffffff803097a8 000000000000f6f8 0000000000000001 ffffffff801b9448
        0000000000000000 ffffffff80300000 996bffffff40b050 ffffffff80326000
        016bfffffe40b050 00067ffffff80326 00067ffffff80326 000000000000002d
        fffffffffffffbff 67ffffff80353000 0000000000000010 ffffffff80176998
        ffffffff800fb66c ffffffff800fb66c 9800000000384000 9800000000387f20
        67ffffff80326000 ffffffff8008c590 ffffffff94004ce2 0000000000000000
        ...
Call Trace:
[<ffffffff80089fc4>] do_ade+0x3a4/0x4c0
[<ffffffff80081ee8>] ret_from_exception+0x0/0x1c
[<ffffffff8008c648>] free_initmem+0xe8/0x218
[<ffffffff80080688>] init+0x248/0x510
[<ffffffff800844e0>] kernel_thread_helper+0x10/0x18


Code: 00431024  5440ff77  de020100 <69230007> 6d230000  24020000  
1440ffba  00051402  08022790
