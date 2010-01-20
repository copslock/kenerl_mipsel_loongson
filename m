Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2010 14:03:19 +0100 (CET)
Received: from bby1mta03.pmc-sierra.com ([216.241.235.118]:37183 "EHLO
        bby1mta03.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492168Ab0ATNDP convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jan 2010 14:03:15 +0100
Received: from bby1mta03.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id 1A92610700A0;
        Wed, 20 Jan 2010 05:03:04 -0800 (PST)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
        by bby1mta03.pmc-sierra.bc.ca (Postfix) with SMTP id F408B1070083;
        Wed, 20 Jan 2010 05:03:03 -0800 (PST)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.159]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 20 Jan 2010 05:03:25 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Help in enabling HIGHMEM support  / 64 bit support
Date:   Wed, 20 Jan 2010 05:03:02 -0800
Message-ID: <A7DEA48C84FD0B48AAAE33F328C020140474B0F9@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <20100119154319.GB23161@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Help in enabling HIGHMEM support  / 64 bit support
Thread-Index: AcqZKgFg54VT94aXQb6vScIqw7FIwAAofqQA
References: <Pine.LNX.4.64.0912131240100.24267@ask.diku.dk> <A7DEA48C84FD0B48AAAE33F328C020140457EE41@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <20091214173509.GB15067@linux-mips.org> <A7DEA48C84FD0B48AAAE33F328C020140474ADC8@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <20100119154319.GB23161@linux-mips.org>
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 20 Jan 2010 13:03:25.0676 (UTC) FILETIME=[F3D832C0:01CA99D0]
X-archive-position: 25619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13250


> 
> You told the kernel mem=1024M.  That's memory at physical address zero
> so overlaps with I/O address ranges.  Boom.  The reason that you for
> further with highmem is the same except except that probably by pure
luck
> the allocation order got things to fail a little later.
> 
> To debug this sort of case I suggest you get early printk to work for
your
> board or maybe you have a working EJTAG probe and debugger.
> 
[Anoop P.A.] PMON is reporting 1024 MB memory and maps it from 0x00 to
0x40000000 . 
In platfor_mem_init I am adding determined memory as

add_memory_region(0, sequoia_memsize*1024*1024 , BOOT_MEM_RAM)

sequoia_memsize is environment variable from pmon ( in MB) 

I have tweaked printk and I am getting following Bus error if I boot
with a 1 GB RAM

5>Linux version 2.6.18 (paanoop1@blr-sw65.pmc-sierra.bc.ca) (gcc version
3.4.5) #61 Tue Jan 19 19:45:51 IST 2010
<4>MIPS 64-bit support for PMC-Sierra Sequoia
<4>memory size 1024MB
<4>cpu_clock set to 600000000
<4>CPU revision is: 000034c1
<4>FPU revision is: 00003420
<4>PMC-Sierra PM74100 Board Setup
<4>64-bit support 90000000FF080508
<4>Determined physical RAM map:
<4> memory: 0000000040000000 @ 0000000000000000 (usable)
<7>On node 0 totalpages: 262144
<7>  DMA zone: 262144 pages, LIFO batch:31
<4>Built 1 zonelists.  Total pages: 262144
<5>Kernel command line:
<4>Primary instruction cache 16kB, physically tagged, 4-way, linesize 32
bytes.
<4>Primary data cache 16kB, 4-way, linesize 32 bytes.
<6>Secondary cache size 256K, linesize 32 bytes.
<6>Synthesized TLB refill handler (39 instructions).
<6>Synthesized TLB load handler fastpath (51 instructions).
<6>Synthesized TLB store handler fastpath (51 instructions).
<6>Synthesized TLB modify handler fastpath (50 instructions).
<4>PID hash table entries: 4096 (order: 12, 32768 bytes)
<4>Using 300.000 MHz high precision timer.
<4>Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
<4>Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
<6>Memory: 1025280k/1048576k available (3860k kernel code, 22976k
reserved, 1724k data, 224k init, 0k highmem)
<6>#####################################################################
######################
<4> <6>TITAN_GE_BASE=FF080000 TITAN_GE_SIZE=10000
<4>RM9150_LOCALBUS_DCR=FF070000 RM9150_LOCALBUS_SIZE=10000
<4> <6>
<4>BOOT_FLASH_BASE=FC000000 BOOT_FLASH_SIZE=800000
<4>RTC_BASE=FC200000,
<4>FPGA_BASE=FC210000 FPGA_SIZE=10000
<6>titan_ge_base=90000000FF080000
<4>rm9150_pci0_base=90000000FF000000
<4>rm9150_pci1_base=90000000FF010000
<4>rm9150_dma_base=90000000FF040000
<4>rm9150_localbus_base=90000000FF070000
<4>sequoia_fpga_base=90000000FC210000
<6>#####################################################################
######################
<4> <6>Internal UART Support for PMC-Sierra Sequoia
<4>You are using the Dallas DS1501 RTC.
<4>UDI: initializing
<7>Calibrating delay loop... 598.01 BogoMIPS (lpj=1196032)
<4>Mount-cache hash table entries: 256
<4>Checking for 'wait' instruction...  available.
<4>Checking for the multiply/shift bug... no.
<4>Checking for the daddi bug... no.
<4>Checking for the daddiu bug... no.
<7>Registering sysdev class '<NULL>'
<6>NET: Registered protocol family 16
<5>SCSI subsystem initialized
<6>usbcore: registered new driver usbfs
<6>usbcore: registered new driver hub
<3>PCI: Failed to allocate mem resource #2:20000000@e0000000 for
0000:00:01.0
<3>PCI: Failed to allocate mem resource #2:20000000@100000000 for
0000:01:01.0
<6>NET: Registered protocol family 2
<4>IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
<1>Data bus error, epc == ffffffff80354940, ra == ffffffff8069dd50
<4>Oops[#1]:
<4>Cpu 0
<4>$ 0   : 0000000000000000 ffffffff806d0000 980000003fc00000
0000000000000000
<4>$ 4   : 980000003fc00040 0000000000000000 0000000000040000
000000000000000a
<4>$ 8   : fffffffffffffff6 0000000000000005 ffffffffffffffff
ffffffff806b1d4a
<4>$12   : 0000000000000000 980000003fc40000 ffffffff806b2110
0000000000000000
<4>$16   : ffffffff80604060 ffffffff80604060 0000000000000000
0000000000000000
<4>$20   : 0000000000000000 0000000000000000 0000000000000000
0000000000000000
<4>$24   : 0000000000000000 ffffffff804d9d30
<4>$28   : 9800000001fc4000 9800000001fc7f30 0000000000000000
ffffffff8069dd50
<4>Hi    : 0000000000000002
<4>Lo    : 0000000000000000
<4>epc   : ffffffff80354940 __bzero+0x3c/0x60     Not tainted
<4>ra    : ffffffff8069dd50 ip_rt_init+0x1d4/0x538
<4>Status: 940080e3    KX SX UX KERNEL EXL IE
<4>Cause : 0000001c
<4>PrId  : 000034c1
<4>Modules linked in:
<4>Process swapper (pid: 1, threadinfo=9800000001fc4000,
task=9800000001fc1848)
<4>Stack : ffffffff8069e2b0 ffffffff80604060 ffffffff8069ef90
ffffffff8069ef88
<4>        ffffffff806a9200 0000000000000000 ffffffff801005fc
ffffffff801005fc
<4>        0000000000000000 0000000000000000 0000000000000000
0000000000000000
<4>        9800000001fc4000 9800000001fc7fe0 0000000000000001
0000000000000000
<4>        0000000000000000 0000000000000000 0000000000000000
ffffffff80104c40
<4>        0000000000000000 ffffffff80104c30 ffffffffffffffff
ffffffffffffffff
<4>        ffffffffffffffff ffffffffffffffff
<4>Call Trace:
<4>[<ffffffff80354940>] __bzero+0x3c/0x60
<4>[<ffffffff8069dd50>] ip_rt_init+0x1d4/0x538
<4>[<ffffffff8069e2b0>] ip_init+0x10/0x1c
<4>[<ffffffff8069ef90>] inet_init+0x218/0x7e8
<4>[<ffffffff801005fc>] init+0x128/0x4ec
<4>[<ffffffff80104c40>] kernel_thread_helper+0x10/0x18
<4>
<4>
<4>Code: 01a4682d  64840040  fc85ffc0 <fc85ffc8> fc85ffd0  fc85ffd8
fc85ffe0  fc85ffe8  fc85fff0
<0>Kernel panic - not syncing: Attempted to kill init!


I can boot kernel with 1 GB module if I limit memory as follows

add_memory_region(0, 0x20000000 , BOOT_MEM_RAM)

How will I map entire 1GB of RAM. 

Is there any mips platform make use of ( >512MB)  memory. It will be
great if some body can pont me to a working source.

 
> Btw, what is the point of putting ASCII boot logs into word files
> inflating
> them 10x and getting half the mail filters of this world to throw the
> attachments or entire email away?
[Anoop P.A.] I haven't cared much about size. I am very sorry about
that. 
> 
>   Ralf
