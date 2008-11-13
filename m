Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2008 21:11:45 +0000 (GMT)
Received: from zcars04e.nortel.com ([47.129.242.56]:63696 "EHLO
	zcars04e.nortel.com") by ftp.linux-mips.org with ESMTP
	id S23662860AbYKMVLn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2008 21:11:43 +0000
Received: from zcarhxm0.corp.nortel.com (zcarhxm0.corp.nortel.com [47.129.230.95])
	by zcars04e.nortel.com (Switch-2.2.0/Switch-2.2.0) with ESMTP id mADL8P529074;
	Thu, 13 Nov 2008 21:08:25 GMT
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: MIPS Unaligned Access Question
Date:	Thu, 13 Nov 2008 16:10:43 -0500
Message-ID: <238C6E77EA42504DA038BAEE6D1C11ECADBD39@zcarhxm0.corp.nortel.com>
In-Reply-To: <491C5F0F.5050602@caviumnetworks.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: MIPS Unaligned Access Question
Thread-Index: AclFsy3fvBguv5RuT8KCU8B0VfQM9AAILL5g
References: <238C6E77EA42504DA038BAEE6D1C11ECADB661@zcarhxm0.corp.nortel.com> <491C5F0F.5050602@caviumnetworks.com>
From:	"Ken Hicks" <hicks@nortel.com>
To:	"Chad Reese" <kreese@caviumnetworks.com>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <HICKS@nortel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hicks@nortel.com
Precedence: bulk
X-list: linux-mips

Thanks Chad,

Is there a particular Cavium patch or patch set which I can use to get
the fix?

Ken


-----Original Message-----
From: Chad Reese [mailto:kreese@caviumnetworks.com] 
Sent: Thursday, November 13, 2008 12:09 PM
To: Hicks, Ken (CAR:SI72)
Cc: linux-mips@linux-mips.org
Subject: Re: MIPS Unaligned Access Question

> Address                Exception
> 0x0001000000000000:    page fault
> 0x0010000000000000:    unaligned access

Neither address is a valid userspace address as the number of virtual
bits supported by the kernel under Linux is 40 bits. Early Octeon
kernels did not range check the lookup in the page tables, which caused
the kernel to fail in unusual ways. This has been fixed in newer kernels
from Cavium Networks.

I believe this is not a problem in the normal mainline Linux kernel.

Chad

Ken Hicks wrote:
> Hi,
> 
> This is my first post. I hope I'm following correct etiquette.  Here 
> we go....
> 
> I'm investigating why an Unaligned Access exception is generated on 
> MIPS from an accesses which are not misaligned.
> 
> The issue is that a kernel access two different unmapped addresses 
> results in different exceptions:
> Address                Exception
> 0x0001000000000000:    page fault
> 0x0010000000000000:    unaligned access
> 
> I'm using a Cavium CPU with a custom linux based on 2.6.14 but the 
> code in question hasn't changed widly in more recent kernels.
> 
> I have observed this several times, so I have manually recreated the 
> behaviour by intentionally accessing known unmapped addresses.
> 
> In this first case, I forced an access to 0x0001000000000000:
> 
> Oops in arch/mips/mm/fault.c::do_page_fault, line 232[#15]:
> Cpu 5
> $ 0   : 0000000000000000 ffffffff81680000 000000000eb5fe30
00000029e2cb9823
> $ 4   : 00000000000003e8 00000029e2c02673 000000002cb41780
0000000000000000
> $ 8   : 000000000000ed97 0000000000004001 0000000000000001
ffffffff8167d547
> $12   : ffffffffffffffff 0000000000000010 ffffffff8167d927
ffffffff81541730
> $16   : 0001000000000000 0001000000000000 0000000000000007
ffffffff81619828
> $20   : a80000000eb5fe30 a80000000eb5f0a0 a80000000eb5f0a0
ffffffff815a3400
> $24   : 0000000000000000 0000000000000030

> $28   : a80000000eb5c000 a80000000eb5fb30 ffffffffffffff80
ffffffff81101eb0
> Hi    : 0000002dc6c00000
> Lo    : 0000001e9c578400
> epc   : ffffffff81101fd0 kernel_ken+0x2f8/0x310     Tainted: P   
> ra    : ffffffff81101eb0 kernel_ken+0x1d8/0x310
> Status: 10007fe2    KX SX UX KERNEL EXL
> Cause : 4080800c
> BadVA : 0001000000000000
> 
> In this second case, I forced an access to 0x0010000000000000:
> 
> Unhandled kernel unaligned access in
> arch/mips/kernel/unaligned.c::emulate_load_store_insn, line 507[#11]:
> Cpu 3
> $ 0   : 0000000000000000 ffffffff81680000 000000000eb0be30
00000017a7f4fdc1
> $ 4   : 00000000000003e8 00000017a7e98c11 000000002cb41780
0000000000000000
> $ 8   : 0000000000003272 0000000000004001 0000000000000001
ffffffff8167d547
> $12   : ffffffffffffffff 0000000000000010 ffffffff8167d927
ffffffff81541730
> $16   : a8000000e62c0980 0010000000000000 0000000000000007
ffffffff81619828
> $20   : a80000000eb0be30 000000007fc000e0 000000007fc00190
ffffffff815a3400
> $24   : 0000000000000000 0000000000000030

> $28   : a80000000eb08000 a80000000eb0bb30 0000000000512c54
ffffffff81101eb0
> Hi    : 0000002dc6c00000
> Lo    : 0000001e9c578400
> epc   : ffffffff81101fd0 kernel_ken+0x2f8/0x310     Tainted: P   
> ra    : ffffffff81101eb0 kernel_ken+0x1d8/0x310
> Status: 10007fe2    KX SX UX KERNEL EXL
> Cause : 40808014
> BadVA : 0010000000000000
> 
> In the second case, the address is not unaligned, but it is reported 
> as an unaligned access error.
> 
> Is this behaviour related to some memory mapping?
> 
> Here's copy of cat /proc/iomem:
> 016c0000-08ebffff : System RAM
> 09010000-0fc0ffff : System RAM
> 20000000-ffffffff : System RAM
> 412000000-41fffffff : System RAM
> 1180000000800-118000000083f : serial
> 11b0008001000-11b0048001000 : Octeon PCI MEM
>   11b0008020000-11b000803ffff : 0000:00:00.0
>     11b0008020000-11b000803ffff : e1000
>   11b0008040000-11b000805ffff : 0000:00:00.1
>     11b0008040000-11b000805ffff : e1000
> 
> Is this a bug, or intentional behaviour?
> 
> In any case, would anyone be able to explain why the two accesses are 
> reported differently.
> I'd just like to understand it.
> 
> Thanks,
> Ken
> 
> Ken Hicks
> 
