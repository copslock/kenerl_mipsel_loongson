Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2004 17:56:28 +0000 (GMT)
Received: from [IPv6:::ffff:68.145.108.97] ([IPv6:::ffff:68.145.108.97]:58124
	"EHLO mail.otii.com") by linux-mips.org with ESMTP
	id <S8224923AbULUR4W>; Tue, 21 Dec 2004 17:56:22 +0000
Received: from [192.168.7.50] (unknown [68.145.108.98])
	by mail.otii.com (Postfix) with ESMTP id ECA35B03A
	for <linux-mips@linux-mips.org>; Tue, 21 Dec 2004 11:09:08 -0700 (MST)
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <9040F8C6-5379-11D9-944D-000393DBC6BE@otii.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-mips@linux-mips.org
From: =?ISO-8859-1?Q?S=E9bastien_Taylor?= <sebastient@otii.com>
Subject: Problem registering interrupt
Date: Tue, 21 Dec 2004 10:55:56 -0700
X-Mailer: Apple Mail (2.619)
Return-Path: <sebastient@otii.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastient@otii.com
Precedence: bulk
X-list: linux-mips

Hello,

I am porting my driver from 2.4 to 2.6 and am having an issue with 
interrupts, I've updated my interrupt handler to return irqreturn_t 
instead of void and it looks like it should be ok, but on init, when I 
call request_irq it blows up in my face (trace bellow).

Now, if I request_irq with SA_SHIRQ it does boot up fine, but when I 
try to use the driver it blows up again. Now, I'm guessing that means 
something else is requesting my irq number first which is why it works 
with SA_SHIRQ but why would that cause a crash?  Should it not just 
return an error message?

Wasn't sure what code would be relevant so hopefully that explaination 
helps,
Any help would be greatly appreciated.


CPU 0 Unable to handle kernel paging request at virtual address 
00000004, epc =4
Oops in arch/mips/mm/fault.c::do_page_fault, line 166[#1]:
Cpu 0
$ 0   : 00000000 1000fc00 00000000 803382d8
$ 4   : 803382d8 80340000 00000001 804e92a8
$ 8   : 80340000 00000a35 80510000 80510000
$12   : 80510000 8113f074 8113f07c 0000ffff
$16   : 80367620 80367628 1000fc01 00000031
$20   : 805bef28 00000000 00000000 00000000
$24   : 00000000 00000078
$28   : 80570000 80571f20 00000000 801430c4
Hi    : 000000a1
Lo    : 47ad5a00
epc   : 801430c8 setup_irq+0x148/0x224     Not tainted
ra    : 801430c4 setup_irq+0x144/0x224
Status: 1000fc02    KERNEL EXL
Cause : 00808008
BadVA : 000000e1
PrId  : 03030200
Process swapper (pid: 1, threadinfo=80570000, task=80554b48)
Stack : 805bef28 80340000 00000001 804e92a8 805bef28 80217188 00000000 
00000000
         00000031 803250e8 801433b4 80143368 00000000 80340000 00000001 
804e92a8
         00000000 80320000 80380000 00000000 00000000 00000000 8037a958 
8037a56c
         00000000 00000001 80808081 00000000 00000000 00000000 80382fec 
00000000
         80380000 80100518 00000000 00000000 00000000 00000000 00000000 
00000000
         ...
Call Trace:
  [<80217188>] mc2interrupt+0x0/0x368
  [<801433b4>] request_irq+0xd0/0x12c
  [<80143368>] request_irq+0x84/0x12c
  [<80380000>] init+0x38/0xe0
  [<8037a958>] mc2init+0x80/0x1d4
  [<8037a56c>] tty_init+0x160/0x184
  [<80380000>] init+0x38/0xe0
  [<80100518>] init+0xbc/0x1f8
  [<80104de0>] kernel_thread_helper+0x10/0x18
  [<80104dd0>] kernel_thread_helper+0x0/0x18


Code: 0c049dad  ae00000c  8e020004 <8c420004> 1040000a  00000000  
3c048032  0c0
Kernel panic - not syncing: Attempted to kill init! 
                             
