Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 May 2004 03:50:22 +0100 (BST)
Received: from sea2-f19.sea2.hotmail.com ([IPv6:::ffff:207.68.165.19]:47368
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225994AbUEYCuT>; Tue, 25 May 2004 03:50:19 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 24 May 2004 19:50:11 -0700
Received: from 61.230.216.210 by sea2fd.sea2.hotmail.msn.com with HTTP;
	Tue, 25 May 2004 02:50:11 GMT
X-Originating-IP: [61.230.216.210]
X-Originating-Email: [brad1972_10@hotmail.com]
X-Sender: brad1972_10@hotmail.com
From:	=?big5?B?tsAgtmmlwQ==?= <brad1972_10@hotmail.com>
To:	linux-mips@linux-mips.org, raiko@niisi.msk.ru
Cc:	ralf@gnu.org, info@uclinux.com
Subject: A question about memory allocation of linux kernel!!
Date:	Tue, 25 May 2004 10:50:11 +0800
Mime-Version: 1.0
Content-Type: text/plain; charset=big5; format=flowed
Message-ID: <Sea2-F197vy0dV1Hv8g00066d73@hotmail.com>
X-OriginalArrivalTime: 25 May 2004 02:50:11.0856 (UTC) FILETIME=[FF955100:01C44202]
Return-Path: <brad1972_10@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad1972_10@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi, Sir,

I have a question about memory allocation when linux OS is booting. We use 
linux as embedded OS for internet access device(ADSL router). Our system is 
MIPS-like CPU (R3000)  with 2M flash and 8M SDRAM(MMU less). Due to use 
small memory footprint, we can not run many application on ADSL router. But 
we confuse about the memory for kernel "reserved". We can see the message 
that printed by booting procedure. Listed below:

Loading R[23]000 MMU routines.
CPU revision is: 136451c3
Primary instruction cache 4kb, linesize 16 bytes
Primary data cache 1kb, linesize 16 bytes
Linux version 2.4.17-uc0 (brad@localhost) (gcc version egcs-2.91.66 
19990314/Linux (egcs-1.1.2 rel4Determined physical RAM map:
boot_mem_map.nr_map==1
 memory: 00800000 @ 00000000 (usable)
PAGE_SIZE(1000)
the address of _end==80279d70
start_pfn(27a)
boot_mem_map.map[0].size==8388608
max_pfn==0
start PFN 0 end PFN 2048
start < first_usable_pfn
first_usable_pfn==-1
start==0
end=2048
before init bootmem first_usable_pfn=0000027a max_pfn=00000800
max_low_pfn(800),min_low_pfn(27a)
bootmap_size = 0x100
before reserve bootmem first_usable_pfn 
address=0027a000,bootmap_size=00000100
reserve_bootmem_core: start(0),addr(27a000),size(100)
sidx(27a), eidx(27b), end(27b)
Initial ramdisk at: 0x8015b000 (666765 bytes)
On node 0 totalpages: 2048
size(20040).
zone(0): 2048 pages.
size(80).
size(40).
size(20).
size(10).
size(8).
size(4).
size(4).
size(4).
size(4).
size(4).
zone(1): 0 pages.
zone(2): 0 pages.
size(1c).
Kernel command line: root=/dev/ram0 
ip=199.190.143.254::199.190.143.1:255.255.255.0:tc3160:eth0:onoCalibrating 
delay loop... 199.47 BogoMIPS
Brad Add: init mem_init
totalram_pages==1381
reservedpages==667
Memory: 5524k/8192k available (1168k kernel code, 2668k reserved, 745k 
data, 52k init)
                              :
                              :
                              :
We can see the memory usage by linux kernel from booting message. The total 
memory size we can use is 5524K bytes. Because there are 2668K are 
reserved. Can we reduce the "reserved" memory size? Or where we can set the 
size of memory for reserved? Please provide comment! Thanks!!

Best Regards
Brad.

_________________________________________________________________
現在就上 MSN 會員目錄：在線上結交新朋友，找到興趣相投的夥伴 
http://members.msn.com?pgmarket=zh-tw 
