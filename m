Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Mar 2005 16:34:21 +0000 (GMT)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:20879
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8224950AbVCUQeF>;
	Mon, 21 Mar 2005 16:34:05 +0000
Received: from [172.16.0.150] (w2rz8l4s02.jg555.com [::ffff:172.16.0.150])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 21 Mar 2005 08:34:03 -0800
  id 0000847B.423EF77B.00000D53
Message-ID: <423EF764.1070305@jg555.com>
Date:	Mon, 21 Mar 2005 08:33:40 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Current Build Warning Message
References: <42375617.3020002@jg555.com> <20050315215538.GJ6025@linux-mips.org> <423EF440.9090902@jg555.com>
In-Reply-To: <423EF440.9090902@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Jim Gifford wrote:

FYI for the list. Didn't mean to send to you excusively Ralf, sorry.

 Ralf,
    Got that one fixed, everything compiles ok. But now on bootup I get 
this.
      If you need it, I can give you ssh access to a RaQ2 to work with. 
Let me know.

 Cobalt Microserver Diagnostics - 'We serve it, you surf it'
 Built Wed Mar  3 21:26:25 PST 1999

 1.LCD Test................................PASS
 2.Controller Test.........................PASS
 5.Bank 0:.................................64M
6.Bank 1:.................................64M
 7.Bank 2:.................................64M
 8.Bank 3:.................................64M
 9.Serial Test.............................PASS
 10.PCI Expansion Slot....................**EMPTY**
 12.IDE Test................................PASS
 13.Ethernet Test...........................PASS
 16.RTC Test................................PASS
 BOOTLOADER: trying to boot from partition /dev/hda1
 Decompressing done
 Decompressing done.

 [ "CoLo" v1.17 ]
 stage2: 8ffa0000-90000000
 cpu: clock 250.000MHz
 pci: unit type <RaQ2>
 tulip: #0 device 21143
 tulip: #1 device 21143
 tulip: {00:10:e0:00:33:94}
 ide: resetting
 boot: running boot menu
 1> lcd 'Booting...'
 1> mount
 ide: {HDS722580VLAT20}
 ide: LBA48 156250000
 ide: supports PIO mode 4
 ide: mode 4 timing
 ide: partition 1
 ext2: revision 0
 1> lcd 'Booting...' /dev/{mounted-volume}
 1> -load /boot/default.colo
 ext2: {boot/default.colo} --> {./default.colo}
 000002f6 758t
 1> -script
 2> var _image vmlinux-2.6.11.5-jg-1.gz
 2> var _console ''
 2> -var _console console=ttyS0,{console-speed}
 2> -noop {menu-option}
 2> select 'BOOT KERNEL' 100 2.6.11.5-jg-1 2.6.11.4-jg-1 2.6.9-jg-2 
2.6.9 vmlinux.old
 2> goto {menu-option}
 2> lcd 'Loading ...' {_image}
 2> mount
 ide: partition 1
 ext2: revision 0
 2> cd /boot
 ext2: {boot} --> {.}
 /
 2> load {_image}
 0013161a 1250842t
 2> execute root=/dev/hda2 {_console} ide1=noprobe
 elf32: 00080000 - 0032401f (802f1000) (ffffffff.80000000)
 elf32: 80080000 (80080000) 2670725t + 98203t
 Linux version 2.6.11.5-jg-1 (root@lfs) (gcc version 3.4.3) #1 Sun Mar 
20 01:22:16 PST 2005
 CPU revision is: 000028a0
 FPU revision is: 000028a0
 Cobalt board ID: 6
 Determined physical RAM map:
 memory: 10000000 @ 00000000 (usable)
 Built 1 zonelists
 Kernel command line: root=/dev/hda2 console=ttyS0,115200 ide1=noprobe
 ide_setup: ide1=noprobe
 Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 
bytes.
 Primary data cache 32kB, 2-way, linesize 32 bytes.
 Synthesized TLB refill handler (21 instructions).
 Synthesized TLB load handler fastpath (34 instructions).
 Synthesized TLB store handler fastpath (34 instructions).
 Synthesized TLB modify handler fastpath (33 instructions).
 PID hash table entries: 2048 (order: 11, 32768 bytes)
 Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
 Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
 Memory: 256256k/262144k available (2074k kernel code, 5692k reserved, 
421k data, 112k init, 0k highmem)
 Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
 Checking for 'wait' instruction...  available.
 NET: Registered protocol family 16
 Galileo ID: 17
 Activating ISA DMA hang workarounds.
 Break instruction in kernel code in arch/mips/kernel/traps.c::do_bp, 
line 560[#1]:
 Cpu 0
 $ 0   : 00000000 90004400 00000000 10000000
 $ 4   : 80350008 803142f4 fffb6ced 80310000
 $ 8   : 10000000 00000008 80310000 80310000
 $12   : 80310000 00100100 00200200 812a6674
 $16   : 000005af 000005af 8126bb78 90004401
 $20   : 802b1fb8 fffffa51 80310000 0000003c
 $24   : 812a667c 00000000                 $28   : 80350000 80351de0 
80351de0 80081338
 Hi    : 00000000
 Lo    : 00000000
 epc   : 802833f0     Not tainted
 ra    : 80081338 Status: 90004402    KERNEL EXL
 Cause : 00808024
 PrId  : 000028a0
 Modules linked in:
 Process swapper (pid: 1, threadinfo=80350000, task=8126bb78)
 Stack : 802b1fb8 80080a30 000005af 800ae97c 000005af 000005af 802b0000 
0000003e
        80081338 800dd5d8 8126bb78 00000000 802b37fc 800d8038 0000000d 
e0000000
        00000000 90004400 80310000 802e7bc0 000005af 000005af 00000001 
803186a4
        000005af 802b1fb8 80310000 80310000 80310000 00100100 00200200 
812a6674
        000005af 000005af 802b0000 90004401 802b1fb8 fffffa51 80310000 
0000003c
        ...
 Call Trace: [<80080a30>]  [<800ae97c>]  [<80081338>]  [<800dd5d8>]  
[<800d8038>]  [<800a6c18>]  [<800a70c4>]  <800a70e0>]  [<800a75a0>]  
[<801cb638>]  [<80113424>]  [<801a8d28>]  [<800a7738>]  [<801a829c>]  
<801a9614>]  [<801a7220>]  [<80080538>]  [<80082d9c>]  [<80082d8c>]>
 Code: 8fb00010  03e00008  27bd0028 <0200000d> 080a0cd9  8f820010  
27bdffb0  afbe0048  afb00040
 Kernel panic - not syncing: Attempted to kill init!



-- 
----
Jim Gifford
maillist@jg555.com
