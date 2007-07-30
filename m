Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 04:45:27 +0100 (BST)
Received: from mf2.realtek.com.tw ([60.248.182.6]:48139 "EHLO
	mf2.realtek.com.tw") by ftp.linux-mips.org with ESMTP
	id S20021342AbXG3DpZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jul 2007 04:45:25 +0100
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.7) with ESMTP id <T81235be162dc803816ad0@mf2.realtek.com.tw>;
 Mon, 30 Jul 2007 11:46:45 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2007073011451779-4697477 ;
          Mon, 30 Jul 2007 11:45:17 +0800 
Message-ID: <037301c7d25c$0c4681c0$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>,
	"Markus Gothe" <markus.gothe@27m.se>
Cc:	<linux-mips@linux-mips.org>
References: <014201c7cdc1$984e50c0$106215ac@realtek.com.tw> <5C55354F-E857-4E83-A347-9C4A4EEA85E2@27m.se> <46ACAE8D.2050800@ru.mvista.com>
Subject: Re: [SPAM] Linux 2.6.12 cannot run on 24K. Please give me some clues.
Date:	Mon, 30 Jul 2007 11:45:18 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2007/07/30 =?Bog5?B?pFekyCAxMTo0NToxNw==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2007/07/30 =?Bog5?B?pFekyCAxMTo0NToxOA==?=,
	Serialize complete at 2007/07/30 =?Bog5?B?pFekyCAxMTo0NToxOA==?=
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


This is the second situations.
EPC is in:

static inline void __cache_free(kmem_cache_t *cachep, void *objp)
{
        struct array_cache *ac = ac_data(cachep);

        check_irq_off();
        objp = cache_free_debugcheck(cachep, objp,
__builtin_return_address(0));

>>>>>>>>>   if (likely(ac->avail < ac->limit)) {
                STATS_INC_FREEHIT(cachep);
                ac_entry(ac)[ac->avail++] = objp;
                return;
        } else {
                STATS_INC_FREEMISS(cachep);
                cache_flusharray(cachep, ac);
                ac_entry(ac)[ac->avail++] = objp;
        }
}

I am trying to use MIPS32 release 2 code on 24k. I found that 2.6.12 &
2.6.13 donot support release 2 well. They can not even be compiled.
Therefore, I upgrade Linux to 2.6.14.

Colin









k init, 0k highmem)
17.92 BogoMIPS (lpj=89600)
==================== Warning! The calculated loops_per_jiffy is not similar
to t
he default one. ====================
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  available.
CPU 0 Unable to handle kernel paging request at virtual address 44100280,
epc ==
 801549b0, ra == 8020805c
Oops in arch/mips/mm/fault.c::do_page_fault, line 167[#1]:
Cpu 0
$ 0   : 00000000 10007700 80805540 80800000
$ 4   : 8fbc0010 0000000f 00000003 8021b000
$ 8   : 00078554 80290000 80290000 80290000
$12   : 801eead8 00000063 00000063 801eead8
$16   : 44100280 000033e0 802aa000 10007701
$20   : 0000003c 81a95bf1 80220000 80290000
$24   : 00000000 00000000
$28   : 80854000 80855980 00000000 8020805c
Hi    : 00000000
Lo    : 00000000
epc   : 801549b0     Not tainted
ra    : 8020805c Status: 10007702    KERNEL EXL
Cause : 08800008
BadVA : 44100280
PrId  : 00019378
Process swapper (pid: 1, threadinfo=80854000, task=80851bd8)
Stack : 80854000 808559a8 00000006 80207e94 8085e788 000033e0 000032c8
00000007
        8020805c 80207ddc 11801001 020c0810 00000000 801eea1c 801ee9e0
808574a4
        80855ec4 05eb0019 00000005 00000006 00000006 00000007 00000007
00000008
        00000008 00000008 00000008 00000008 00000008 00000009 00000008
00000009
        0000000b 00000009 00000007 00000008 00000008 00000008 00000007
00000009
        ...
Call Trace: [<80207e94>]  [<8020805c>]  [<80207ddc>]  [<802087c8>]
[<80141ba0>]
  [<801004e8>]  [<80103870>]  [<80103860>]

Code: 00431021  8c440018  8c900000 <8e030000> 8e020004  0062102b  10400007
2611
0010  00031080
Kernel panic - not syncing: Attempted to kill init!



----- Original Message ----- 
From: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
To: "Markus Gothe" <markus.gothe@27m.se>
Cc: "colin" <colin@realtek.com.tw>; <linux-mips@linux-mips.org>
Sent: Sunday, July 29, 2007 11:13 PM
Subject: Re: [SPAM] Linux 2.6.12 cannot run on 24K. Please give me some
clues.


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
