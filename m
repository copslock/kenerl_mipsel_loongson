Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2005 02:34:04 +0000 (GMT)
Received: from nssinet2.co-nss.co.jp ([IPv6:::ffff:150.96.0.5]:4570 "EHLO
	nssinet2.co-nss.co.jp") by linux-mips.org with ESMTP
	id <S8225330AbVAKCd7>; Tue, 11 Jan 2005 02:33:59 +0000
Received: from nssinet2.co-nss.co.jp (localhost [127.0.0.1])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id LAA14928;
	Tue, 11 Jan 2005 11:29:03 +0900 (JST)
Received: from nssnet.co-nss.co.jp (nssnet.co-nss.co.jp [150.96.64.250])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id LAA14915;
	Tue, 11 Jan 2005 11:29:02 +0900 (JST)
Received: from NUNOE ([150.96.160.60])
	by nssnet.co-nss.co.jp (8.9.3+Sun/3.7W) with SMTP id LAA02146;
	Tue, 11 Jan 2005 11:20:17 +0900 (JST)
Message-ID: <002801c4f785$fcafd7b0$3ca06096@NUNOE>
From: "Hdei Nunoe" <nunoe@co-nss.co.jp>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
References: <001101c4dbf9$1da02270$3ca06096@NUNOE> <20041207095837.GA13264@linux-mips.org> <001701c4e195$24d48260$3ca06096@NUNOE> <20041215141508.GA29222@linux-mips.org>
Subject: Re: HIGHMEM
Date: Tue, 11 Jan 2005 11:33:51 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Return-Path: <nunoe@co-nss.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nunoe@co-nss.co.jp
Precedence: bulk
X-list: linux-mips

Ralf,

It worked fine with small changes!!   Comment and Criticism are welcome.

>> >Other than that you can also just setup your system
>> >as 0x0 - 0x10000000 being RAM, 0x10000000 - 0x20000000 being reserved
>> >memory and 0x20000000 - 0x30000000 being highmem.  Which works but is a
>> >bit wasteful.

I have set up my system as following :
- 0x00000000 - 0x10000000 RAM
- 0x10000000 - 0x40000000 RESERVED
- 0x40000000 - 0x50000000 RAM
So that the gap in physical address space and one in virtual address space 
becomes equal.
It is 0x40000000 in this case (0x10000000 - 0x40000000 vs 0x90000000 - 
0xc0000000).
That means no physical <-> virtual macro change are needed.  hehe...
And the MMU mapping to the upper 256MB is fixed with the CP0 wired register.

Changes are pretty small as follows :
--- tlb-r4k.c ---
381c381
<       write_32bit_cp0_register(CP0_WIRED, 0);
---
>       write_32bit_cp0_register(CP0_WIRED, 8 /* XXX 0 */);

--- pgtable.h ---
123c123
< #define VMALLOC_START     KSEG2
---
> #define VMALLOC_START     KSEG3               /* XXX KSEG2 */

--- page.h ---
148c148
< #define HIGHMEM_START 0x20000000UL
---
> #define HIGHMEM_START 0x50000000UL    /* XXX 0x20000000UL */

--- prom.c ---
>       add_memory_region(0, (256*1024*1024), BOOT_MEM_RAM);
>       add_memory_region(0x10000000, (256*1024*1024), BOOT_MEM_RESERVED);
>       add_memory_region(0x20000000, (512*1024*1024), BOOT_MEM_RESERVED);
>       add_memory_region(0x40000000, (256*1024*1024), BOOT_MEM_RAM);
>
>       {
>           TLB_TBL32 tlb;
>           unsigned int nTlb = 48;             /* max TLB entry */
>           unsigned int size = 0x02000000;     /* 32MB boundary */
>           unsigned int vadr = 0xc0000000;     /* virtual address */
>           unsigned int padr = 0x40000000;     /* physical address */
>
>           printk ("memory map started.\n");
>             for (i=0; i<8; i++)
>               {
>               tlb.mask = 0x01ffe000;          /* 16M bit[24-13] */
>               tlb.hi  = vadr + (i*size);
>               tlb.lo1 = (padr >> 6) | ((i*size + (size/2)) >> 6) | 0x1f;
>               tlb.lo0 = (padr >> 6) | ((i*size) >> 6) | 0x1f;
>               setTLB32 (i, &tlb);
>               }
>             for (i=8; i<nTlb; i++)
>               {
>               tlb.mask = 0x0;
>               tlb.hi  = 0x80000000;
>               tlb.lo1 = 0;
>               tlb.lo0 = 0;
>               setTLB32 (i, &tlb);
>               }
>             for (i=0; i<nTlb; i++)
>               {
>               getTLB32 (i, &tlb);
>               printk ("get: mask=0x%08x hi=0x%08x lo0=0x%08x 
> lo1=0x%08x.\n",
>                       tlb.mask, tlb.hi, tlb.lo0, tlb.lo1);
>               }
>       }

Cheers,
-hdei
