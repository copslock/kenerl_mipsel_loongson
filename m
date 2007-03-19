Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 05:21:38 +0000 (GMT)
Received: from rrcs-64-183-102-11.west.biz.rr.com ([64.183.102.11]:21189 "EHLO
	jg555.com") by ftp.linux-mips.org with ESMTP id S20021371AbXCSFVg
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 05:21:36 +0000
Received: from [192.168.55.157] ([::ffff:192.168.55.157])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Sun, 18 Mar 2007 22:20:33 -0700
  id 00488216.45FE1DA1.00007A57
Message-ID: <45FE1D95.8050204@jg555.com>
Date:	Sun, 18 Mar 2007 22:20:21 -0700
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: Building 64 bit kernel on Cobalt
References: <45F5F709.6060707@jg555.com>	<cda58cb80703130338t57240ba9m15e6b0e37da875b4@mail.gmail.com>	<45FDB498.1040504@jg555.com> <20070319.101209.79013781.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20070319.101209.79013781.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Sun, 18 Mar 2007 14:52:24 -0700, Jim Gifford <maillist@jg555.com> wrote:
>   
>> Frank,
>>     Got it narrowed down further. This reverting these 3 sections will 
>> allow it to boot, but then mounting root it gives a unaligned access 
>> error. Reverting all the changes to setup.c, fixes the issue and boots 
>> completely.
>>     
>
> You said you are not using initrd, right?  I can not see why these
> changes affects non-initrd environment.  Full boot log and .config
> would help us to find what was wrong.
>
> ---
> Atsushi Nemoto
>
>   
Here's the config file I'm using http://ftp.jg555.com/cobalt.config
Now if I revert all changes that have occurred to setup.c from 2.6.19 to 
2.6.20, everything works perfectly.

Without that patch, this is as far as it gets.

 > execute root=/dev/nfs nfsroot=192.168.55.2:/nfsroot 
console=ttyS0,115200 ip=dhcp
inflate: decompressing
elf64: 00080000 - 0037701f (ffffffff.80326000) (ffffffff.80000000)
elf64: ffffffff.80080000 (80080000) 2957446t + 151450t
net: interface down
Linux version 2.6.20.1 (root@build) (gcc version 4.1.2) #1 Sun Mar 18 
22:07:40 PDT 2007
CPU revision is: 000028a0
FPU revision is: 000028a0
Cobalt board ID: 6
registering PCI controller with io_map_base unset
Cobalt: early console registered
Determined physical RAM map:
 memory: 0000000010000000 @ 0000000000000000 (usable)

With the patch, here's the info
 > execute root=/dev/nfs nfsroot=192.168.55.2:/nfsroot 
console=ttyS0,115200 ip=dhcp
inflate: decompressing
elf64: 00080000 - 0037701f (ffffffff.80326000) (ffffffff.80000000)
elf64: ffffffff.80080000 (80080000) 2957446t + 151450t
net: interface down
Linux version 2.6.20.1 (root@build) (gcc version 4.1.2) #1 Sun Mar 18 
22:15:54 PDT 2007
CPU revision is: 000028a0
FPU revision is: 000028a0
Cobalt board ID: 6
registering PCI controller with io_map_base unset
Cobalt: early console registered
Determined physical RAM map:
 memory: 0000000010000000 @ 0000000000000000 (usable)
Built 1 zonelists.  Total pages: 64640
Kernel command line: root=/dev/nfs nfsroot=192.168.55.2:/nfsroot 
console=ttyS0,115200 ip=dhcp
Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 32kB, 2-way, linesize 32 bytes.
Synthesized TLB refill handler (32 instructions).
Synthesized TLB load handler fastpath (46 instructions).
Synthesized TLB store handler fastpath (46 instructions).
Synthesized TLB modify handler fastpath (45 instructions).
PID hash table entries: 1024 (order: 10, 8192 bytes)
Linux version 2.6.20.1 (root@build) (gcc version 4.1.2) #1 Sun Mar 18 
22:15:54 PDT 2007
CPU revision is: 000028a0
FPU revision is: 000028a0
Cobalt board ID: 6
registering PCI controller with io_map_base unset
Cobalt: early console registered
Determined physical RAM map:
 memory: 0000000010000000 @ 0000000000000000 (usable)
Built 1 zonelists.  Total pages: 64640
Kernel command line: root=/dev/nfs nfsroot=192.168.55.2:/nfsroot 
console=ttyS0,115200 ip=dhcp
Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 32kB, 2-way, linesize 32 bytes.
Synthesized TLB refill handler (32 instructions).
Synthesized TLB load handler fastpath (46 instructions).
Synthesized TLB store handler fastpath (46 instructions).
Synthesized TLB modify handler fastpath (45 instructions).
PID hash table entries: 1024 (order: 10, 8192 bytes)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Memory: 254464k/262144k available (2214k kernel code, 7540k reserved, 
493k data, 180k init, 0k highmem)
Mount-cache hash table entries: 256
Checking for the multiply/shift bug... no.
Checking for the daddi bug... no.
Checking for the daddiu bug... no.
NET: Registered protocol family 16
Galileo: fixed bridge class
Galileo: revision 17
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 2, 16384 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
Activating ISA DMA hang workarounds.
rtc: SRM (post-2000) epoch (2000) detected
Real Time Clock Driver v1.12ac
Cobalt LCD Driver v2.10
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ÿserial8250: ttyS0 at I/O 0xc800000 (irq = 21) is a ST16650V2
Linux Tulip driver version 1.1.14 (December 15, 2004)
PCI: Enabling device 0000:00:07.0 (0041 -> 0043)
io_map_base of root PCI bus 0000:00 unset.  Trying to continue but you 
better
fix this issue or report it to linux-mips@linux-mips.org or your vendor.
tulip0: Old format EEPROM on 'Cobalt Microserver' board.  Using 
substitute media control info.
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
eth0: Digital DS21142/43 Tulip rev 65 at Port 0x1000, 00:10:E0:00:47:6E, 
IRQ 19.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:09.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586a (rev 27) IDE UDMA33 controller on pci0000:00:09.1
    ide0: BM-DMA at 0x10a0-0x10a7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x10a8-0x10af, BIOS settings: hdc:pio, hdd:pio
ide0: I/O resource 0xFFFFFFFFF00003F6-0xFFFFFFFFF00003F6 not free.
ide0: ports already in use, skipping probe
ide1: I/O resource 0xFFFFFFFFF0000376-0xFFFFFFFFF0000376 not free.
ide1: ports already in use, skipping probe
ide0: I/O resource 0xFFFFFFFFF00003F6-0xFFFFFFFFF00003F6 not free.
ide0: ports already in use, skipping probe
ide1: I/O resource 0xFFFFFFFFF0000376-0xFFFFFFFFF0000376 not free.
ide1: ports already in use, skipping probe
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Sending DHCP requests .<7>0000:00:07.0: tulip_stop_rxtx() failed (CSR5 
0xf0660000 CSR6 0xb20e2202)
eth0: Setting full-duplex based on MII#1 link partner capability of 4de1.
., OK
IP-Config: Got DHCP answer from 192.168.55.2, my address is 192.168.55.112
IP-Config: Complete:
      device=eth0, addr=192.168.55.112, mask=255.255.255.0, gw=192.168.55.1,
     host=raq22, domain=jg555.com, nis-domain=(none),
     bootserver=192.168.55.2, rootserver=192.168.55.2, rootpath=/nfsroot
Looking up port of RPC 100003/2 on 192.168.55.2
Looking up port of RPC 100005/1 on 192.168.55.2
VFS: Mounted root (nfs filesystem) readonly.
Unhandled kernel unaligned access[#1]:
Cpu 0
$ 0   : 0000000000000000 ffffffff802adc70 0000000000000000 0000000000000000
$ 4   : ffffffff80089fac ffffffffde020000 ffffffff8008c648 0000000000000000
$ 8   : 0000000000561024 996bffffff40b050 0000000000000000 000000000000f6f8
$12   : ffffffff94004ce0 000000001000001e 0000000000000000 ffffffff80300000
$16   : 9800000000387df0 ffffffff80326000 0000000000000000 00067ffffff80326
$20   : 00067ffffff80326 000000000000002d fffffffffffffbff 67ffffff80353000
$24   : 0000000000000010 ffffffff80176998
$28   : 9800000000384000 9800000000387dc0 67ffffff80326000 ffffffff80081ee8
Hi    : 0000000000000000
Lo    : 0000000000000000
epc   : ffffffff80089fc4 do_ade+0x3a4/0x4c0     Not tainted
ra    : ffffffff80081ee8 ret_from_exception+0x0/0x1c
Status: 94004ce2    KX SX UX KERNEL EXL
Cause : 00808010
BadVA : 996bffffff40b057
PrId  : 000028a0
Process swapper (pid: 1, threadinfo=9800000000384000, task=9800000000381828)
Stack : 996bffffff40b050 ffffffff80326000 016bfffffe40b050 00067ffffff80326
        ffffffff80081ee8 0000000000000000 0000000000000000 ffffffff94004ce0
        9800000001000000 019ffffffe00c980 ffffffff94004ce1 00067ffffff80353
        6800000000000000 9800000000381828 98000000013e9a40 98000000003b3000
        ffffffff803097a8 000000000000f6f8 0000000000000001 ffffffff801b9448
        0000000000000000 ffffffff80300000 996bffffff40b050 ffffffff80326000
        016bfffffe40b050 00067ffffff80326 00067ffffff80326 000000000000002d
        fffffffffffffbff 67ffffff80353000 0000000000000010 ffffffff80176998
        ffffffff800fb66c ffffffff800fb66c 9800000000384000 9800000000387f20
        67ffffff80326000 ffffffff8008c590 ffffffff94004ce2 0000000000000000
        ...
Call Trace:
[<ffffffff80089fc4>] do_ade+0x3a4/0x4c0
[<ffffffff80081ee8>] ret_from_exception+0x0/0x1c
[<ffffffff8008c648>] free_initmem+0xe8/0x218
[<ffffffff80080688>] init+0x248/0x510
[<ffffffff800844e0>] kernel_thread_helper+0x10/0x18


Code: 00431024  5440ff77  de020100 <69230007> 6d230000  24020000  
1440ffba  00051402  08022790
Kernel panic - not syncing: Attempted to kill init!
