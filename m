Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2007 16:11:21 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:58332 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022769AbXG2PLT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Jul 2007 16:11:19 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 0D82E3EC9; Sun, 29 Jul 2007 08:11:16 -0700 (PDT)
Message-ID: <46ACAE8D.2050800@ru.mvista.com>
Date:	Sun, 29 Jul 2007 19:13:17 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Markus Gothe <markus.gothe@27m.se>
Cc:	colin <colin@realtek.com.tw>, linux-mips@linux-mips.org
Subject: Re: [SPAM] Linux 2.6.12 cannot run on 24K. Please give me some clues.
References: <014201c7cdc1$984e50c0$106215ac@realtek.com.tw> <5C55354F-E857-4E83-A347-9C4A4EEA85E2@27m.se>
In-Reply-To: <5C55354F-E857-4E83-A347-9C4A4EEA85E2@27m.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Markus Gothe wrote:

> Seems to me that running in EXkLusive/supervisor mode is the culprit.

    EXL doesn't mean "exclusive", it means "exception level". And you'll 
always see this bit set in an oops happening when the kernel is handling 
exception (I'm not saying that it's actually set during all that time, just 
that the handler is entered with EXL=1 and that walue of the Status regs is 
saved on stack and later dumped along with the other regs)

> Try changing that before you get to userspace...

> On 24 Jul, 2007, at 09:09 , colin wrote:
> 
>>
>> Hi all,
>> Could you help me on porting MIPS Linux?
>>
>> Our first embedded system using 4Kec is running very well on Linux  
>> 2.6.12.
>> Now the second chip using 24K has problems. I found that mtf0 and  
>> mtc0 have
>> hazard problem and I have solved it.
>> static inline void unmask_mips_irq(unsigned int irq)
>> {
>>         set_c0_status(0x100 << (irq - mips_cpu_irq_base));
>>         irq_enable_hazard();
>> }
>>
>> Now Linux can continue running and then it will encounter problems  when
>> running the first application, init. I will appreciate your clues for
>> helping me on this probem. :D
>>
>> Colin
>>
>> ÿttyS0 at MMIO 0x0 (irq = 3) is a 16550A
>> ttyS1 at MMIO 0x0 (irq = 3) is a 16550A
>> io scheduler noop registered
>> Freeing prom memory: 0kb freed
>> Reclaim bootloader memory from 80010000 to 800f0000
>> Freeing unused kernel memory: 252k freed
>> CPU 0 Unable to handle kernel paging request at virtual address  
>> ffffff88,
>> epc == 00440f10, ra == 004000e4

   It's not a kernel address, BTW...

>> Oops in arch/mips/mm/fault.c::do_page_fault, line 167[#1]:
>> Cpu 0
>> $ 0   : 00000000 10000990 00400090 00000000
>> $ 4   : 7fdd5ed0 7fdd5f94 00000000 7fdd5f94
>> $ 8   : 00000000 00000000 80001cb2 00000b3b
>> $12   : 7f1c0300 0001ffff 0001ffff 00000115
>> $16   : 801f5e04 00000000 00000000 00000000
>> $20   : 00000000 00000000 00000000 00000000
>> $24   : 00000000 00440f00
>> $28   : 10008c70 7fdd5e18 7fdd5e38 004000e4
>> Hi    : 00000000
>> Lo    : 00000000
>> epc   : 00440f10     Not tainted
>> ra    : 004000e4 Status: 00006802    KERNEL EXL
>> Cause : 0880400c
>> BadVA : ffffff88
>> PrId  : 00019378
>> Process init (pid: 1, threadinfo=80848000, task=80854bd8)
>> Stack : 00000000 00000000 10008c70 00000000 10008c70 7fdd5e38 10008c70
>> 004276e4
>>         00000000 00000000 00000000 00000000 10008c70 00000000 7fdd5f9c
>> 00000000
>>         00000000 00000000 00000000 00000000 00000000 00000000 00000003
>> 00400034
>>         00000004 00000020 00000005 00000002 00000006 00001000 00000007
>> 000000

WBR, Sergei
