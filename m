Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2005 16:50:13 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.194]:48043 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226258AbVGEPtz> convert rfc822-to-8bit;
	Tue, 5 Jul 2005 16:49:55 +0100
Received: by wproxy.gmail.com with SMTP id i25so915715wra
        for <linux-mips@linux-mips.org>; Tue, 05 Jul 2005 08:50:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qasI0x8iUjDT002NAaXuK94hZ3cKGM0zOPAs6VTnCJdUaQ9deXTLHbAVp5naVOdWxPN4HAWM0q1RjvzpKYK/RCC0KC+yJO6kVPrq0KNTSbxpEr2LcBobgWVKEYzLQ5nKB/buWGphmjhsghotLUGKpg+WFJOEnhmztCG9vyJkUB0=
Received: by 10.54.26.19 with SMTP id 19mr4662085wrz;
        Tue, 05 Jul 2005 08:50:04 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Tue, 5 Jul 2005 08:50:03 -0700 (PDT)
Message-ID: <2db32b7205070508504b675dd6@mail.gmail.com>
Date:	Tue, 5 Jul 2005 08:50:03 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	ppopov@embeddedalley.com
Subject: Re: booting error on db1550 using linux 2.6.12 from linux-mips.org
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <1120257851.5987.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b7205070114172483d2dd@mail.gmail.com>
	 <1120253048.5987.16.camel@localhost.localdomain>
	 <2db32b72050701153566c83bb6@mail.gmail.com>
	 <1120257851.5987.37.camel@localhost.localdomain>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Pete,
I tried to make HPT working on db1550 for linux 2.6.12 cvs head. If I
didn't force it to use 372 timing, it just hangs up after it detect
the drive. If I used the 372 timing using the 2.4 trick, the kernel
just crashed. Any clue?
Thanks

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT371: IDE controller at PCI slot 0000:00:0b.0
PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
HPT371: chipset revision 2
hpt: HPT372N detected, using 372N timing.
FREQ: 73 PLL: 35
HPT371: 100% native mode on irq 5
hpt: no known IDE timings, disabling DMA.
hpt: no known IDE timings, disabling DMA.
hdg: IBM-DTTA-350840, ATA DISK drive
CPU 0 Unable to handle kernel paging request at virtual address
00000000, epc == 8029fb20, ra == 8029fc0c
Oops in arch/mips/mm/fault.c::do_page_fault, line 167[#1]:
Cpu 0
$ 0   : 00000000 1000fc00 00000000 00000000
$ 4   : 0000000c 00000000 00010000 18010017
$ 8   : 00000000 0000fc00 00000000 803a6000
$12   : 803ace64 fffffffb ffffffff 0000140d
$16   : 00000048 00000055 30070000 00000001
$20   : 804a1800 0000000c 8043a678 8043a5f8
$24   : 00000000 802a747c                  
$28   : 811de000 811dfe40 1000fc01 8029fc0c
Hi    : 0000018a
Lo    : 3d6edc00
epc   : 8029fb20 pci_bus_clock_list+0x0/0x38     Not tainted
ra    : 8029fc0c hpt372_tune_chipset+0xb4/0x138
Status: 1000fc03    KERNEL EXL IE 
Cause : 00800008
BadVA : 00000000
PrId  : 03030200
Modules linked in:
Process swapper (pid: 1, threadinfo=811de000, task=80456bf0)
Stack : 804a1800 00000005 8029f62c 80456bf0 00000000 00000000 804a1800 0000000c
        8043a678 00000001 00000000 803b0000 00000005 8029fcf8 8043a678 8043a5e8
        00000000 00000001 00000000 803b0000 00000005 8043a5f8 8043a678 8043a5e8
        00000000 00000001 00000000 803b0000 00000005 802abd0c 00000005 8043a5f8
        b0400074 b040006c 00000001 811dff30 00000000 00000000 00000000 8043a5e8
        ...
Call Trace:
 [<8029f62c>] hpt_minimum_revision+0x2c/0xec
 [<8029fcf8>] hpt3xx_tune_chipset+0x68/0x2e8
 [<802abd0c>] probe_hwif+0x8a4/0x910
 [<802ace2c>] probe_hwif_init_with_fixup+0x1c/0xcc
 [<802af8bc>] ide_setup_pci_device+0xa8/0xcc
 [<8024f09c>] idr_get_new+0x18/0x4c
 [<80422e38>] ide_scan_pcidev+0x84/0xc4
 [<801c5464>] proc_register+0x48/0x16c
 [<80422eb0>] ide_scan_pcibus+0x38/0xf8
 [<801c5874>] proc_mkdir_mode+0x54/0x80
 [<80422d98>] ide_init+0x68/0x84
 [<80422d7c>] ide_init+0x4c/0x84
 [<801004f8>] init+0x9c/0x264
 [<80105e20>] kernel_thread_helper+0x10/0x18
 [<80105e10>] kernel_thread_helper+0x0/0x18


Code: 02002821  080a7e5f  a3a20013 <90a20000> 10400008  308400ff 
00401821  10640007  00000000
Kernel panic - not syncing: Attempted to kill init!
