Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g72IofRw012696
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 2 Aug 2002 11:50:41 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g72IoeaN012695
	for linux-mips-outgoing; Fri, 2 Aug 2002 11:50:40 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g72IoSRw012668
	for <linux-mips@oss.sgi.com>; Fri, 2 Aug 2002 11:50:28 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g72Iq0Xb000945;
	Fri, 2 Aug 2002 11:52:00 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA23142;
	Fri, 2 Aug 2002 11:52:00 -0700 (PDT)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g72Ipxb18032;
	Fri, 2 Aug 2002 20:51:59 +0200 (MEST)
Message-ID: <3D4AD609.21E224BE@mips.com>
Date: Fri, 02 Aug 2002 20:57:13 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: linux-mips@oss.sgi.com
Subject: Re: Today's OSS doesn't work on Malta
References: <20020802100714.A4669@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I thing it's the pci stuff that is broken, I have send Ralf a patch, but
unfortunately he hasn't checked it in yet.
Try the patch below and see if it help.

/Carsten

Index: arch/mips/kernel/pci-dma.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/pci-dma.c,v
retrieving revision 1.7.2.1
diff -u -r1.7.2.1 pci-dma.c
--- arch/mips/kernel/pci-dma.c  2002/08/01 12:40:14     1.7.2.1
+++ arch/mips/kernel/pci-dma.c  2002/08/02 18:46:46
@@ -30,11 +30,11 @@

        if (ret != NULL) {
                memset(ret, 0, size);
+               *dma_handle = virt_to_bus(ret);
 #ifdef CONFIG_NONCOHERENT_IO
                dma_cache_wback_inv((unsigned long) ret, size);
                ret = UNCAC_ADDR(ret);
 #endif
-               *dma_handle = virt_to_bus(ret);
        }

        return ret;

Index: include/asm-mips/page.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/page.h,v
retrieving revision 1.14.2.9
diff -u -r1.14.2.9 page.h
--- include/asm-mips/page.h     2002/08/01 12:40:14     1.14.2.9
+++ include/asm-mips/page.h     2002/08/02 18:49:26
@@ -125,8 +125,8 @@
 #define VM_DATA_DEFAULT_FLAGS  (VM_READ | VM_WRITE | VM_EXEC | \
                                VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)

-#define UNCAC_ADDR(addr)       ((addr) - (PAGE_OFFSET + UNCAC_BASE))
-#define CAC_ADDR(addr)         ((addr) - (UNCAC_BASE + PAGE_OFFSET))
+#define UNCAC_ADDR(addr)       ((addr) - PAGE_OFFSET + UNCAC_BASE)
+#define CAC_ADDR(addr)         ((addr) - UNCAC_BASE + PAGE_OFFSET)

 /*
  * Memory above this physical address will be considered highmem.




"H. J. Lu" wrote:

> The 2.4 kernel from today's OSS doesn't work on Malta. I got
>
> hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, (U)DMA
> Partition check:
>  hda:<1>Unable to handle kernel paging request at virtual address 611c2000,
> epc4
> Oops in fault.c::do_page_fault, line 206:
> $0 : 00000000 1000fc00 00000001 00001000 00001000 00001000 81191000 00000001
> $8 : 811c0000 81199000 00000001 00008000 00010000 802d1358 00000000 00000080
> $16: 611c2000 00000001 802d1338 00000000 00000000 00000008 00000000 00000000
> $24: 0000000a 811ddd91                   8027a000 8027bd10 8009e0d0 801eaa24
> Hi : 0000004f
> Lo : df328000
> epc  : 801eaa98    Not tainted
> Status: 1000fc03
> Cause : 0080000c
> Process swapper (pid: 0, stackpage=8027a000)
> Stack: 8027bd08 8027bd08 802b5c20 00000000 00001240 802d12c8 802d1338 801eb170
>        0000000e 00000001 b8000000 802d1338 81198320 802d1338 81198320 802d12c8
>        0000000e 00000001 801efc14 1000fc00 811dde48 802d1338 811dddd0 802d12c8
>        0000000e 00000001 801e3ca8 802d12c8 8027bd88 1000fc00 8027bde0 1000fc00
>        00000000 802d1338 81198320 801e406c 1000fc00 802d12c8 801e93e4 00000000
>        00000003 ...
> Call Trace: [<801eb170>] [<801efc14>] [<801e3ca8>] [<801e406c>] [<801e93e4>]
> [<]
>  [<801db1b4>] [<801e44ec>] [<801e3008>] [<8012ea04>] [<801e9290>] [<801e4be8>]
>  [<80109690>] [<80109970>] [<8010ae3c>] [<80254554>] [<80254d10>] [<80254860>]
>  [<801089a4>] [<80102e40>] [<80102e9c>] [<80102e44>] [<8010042c>] [<80255800>]
>
> Code: 54e00001  00a02021  3083ffff <ae060000> 00a42823  14600008  26100004  263
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
