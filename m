Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 22:18:24 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.197]:16723 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226173AbVGAVSE> convert rfc822-to-8bit;
	Fri, 1 Jul 2005 22:18:04 +0100
Received: by wproxy.gmail.com with SMTP id 70so434355wra
        for <linux-mips@linux-mips.org>; Fri, 01 Jul 2005 14:17:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RiYSaoYkdKN/5gqnNEw8iGZNXvKk3F0D44nqcmiXC4oU1ETiMCFU2Pw1BpkChfqGRkmzgzDRfciSXVpFzZE7uO4UfKYwb7v51jbHm2+Fx7rM5w0WyuXs6A/wRbVad38/0XMamSvrCdkueP/kPbqG1v6dw137qc/17MSpAKHvuCY=
Received: by 10.54.26.45 with SMTP id 45mr1937182wrz;
        Fri, 01 Jul 2005 14:17:46 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Fri, 1 Jul 2005 14:17:46 -0700 (PDT)
Message-ID: <2db32b7205070114172483d2dd@mail.gmail.com>
Date:	Fri, 1 Jul 2005 14:17:46 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: booting error on db1550 using linux 2.6.12 from linux-mips.org
Cc:	rolfliu@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

linux crashes during the booting process. it is right at mounting the
root file system through NFS server. the following is the trace. the
root file system is based on redhat 7.1, could be used to boot 2.4
kernel. Any suggestions?

Another problem is, if I want to compile in the hpt366.c, the kernel
will hang right after it found the disk drive:
(Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT371: IDE controller at PCI slot 0000:00:0b.0
PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
HPT371: chipset revision 2
HPT37X: using 33MHz PCI clock
HPT371: 100% native mode on irq 5
    ide2: BM-DMA at 0x1000-0x1007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1008-0x100f, BIOS settings: hdg:pio, hdh:pio
hdg: IBM-DTTA-350840, ATA DISK drive
)
It just freeze there for ever :(

a long email. I really appreciate the help and will give the feedback then.

thanks

OUTPUT:
Linux version 2.6.12-mipscvs-20050626 (rolf@DBServer) (gcc version
3.4.4) #3 Fri Jul 1 13:25:50 PDT 2005
CPU revision is: 03030200
AMD Alchemy Au1550/Db1550 Board
(PRId 03030200) @ 396MHZ
BCLK switching enabled!
Determined physical RAM map:
 memory: 0c000000 @ 00000000 (usable)
Built 1 zonelists
Kernel command line: ip=dhcp nfsroot=10.200.0.198:/db1550 console=ttyS0,115200
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
Primary data cache 16kB, 4-way, linesize 32 bytes.
Synthesized TLB refill handler (17 instructions).
Synthesized TLB load handler fastpath (34 instructions).
Synthesized TLB store handler fastpath (34 instructions).
Synthesized TLB modify handler fastpath (33 instructions).
PID hash table entries: 1024 (order: 10, 16384 bytes)
calculating r4koff... 00060ae0(396000)
CPU frequency 396.00 MHz
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 190212k/196608k available (2486k kernel code, 6160k reserved,
617k data, 128k init, 0k highmem)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  unavailable.
NET: Registered protocol family 16
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Serial: Au1x00 driver
ttyS0 at I/O 0xb1100000 (irq = 0) is a AU1X00_UART
ttyS1 at I/O 0xb1200000 (irq = 8) is a AU1X00_UART
ttyS2 at I/O 0xb1400000 (irq = 9) is a AU1X00_UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
au1000eth version 1.5 Pete Popov <ppopov@embeddedalley.com>
eth0: Au1x Ethernet found at 0xb0500000, irq 27
eth0: AMD 79C874 10/100 BaseT PHY at phy address 31
eth0: Using AMD 79C874 10/100 BaseT PHY as default
eth1: Au1x Ethernet found at 0xb0510000, irq 28
eth1: AMD 79C874 10/100 BaseT PHY at phy address 31
eth1: Using AMD 79C874 10/100 BaseT PHY as default
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Db1550 Flash: probing 32-bit flash bus
Db1550 Flash: Found 2 x16 devices at 0x0 in 32-bit bank
Db1550 Flash: Found 2 x16 devices at 0x4000000 in 32-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
Db1550 Flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 2
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Creating 3 MTD partitions on "Db1550 Flash":
0x00000000-0x07c00000 : "User FS"
0x07c00000-0x07d00000 : "YAMON"
0x07d00000-0x07fc0000 : "raw kernel"
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Sending DHCP requests .<6>eth0: link up
eth1: link up
., OK
IP-Config: Got DHCP answer from 255.255.255.255, my address is 10.200.1.54
IP-Config: Complete:
      device=eth0, addr=10.200.1.54, mask=255.255.0.0, gw=10.200.0.1,
     host=10.200.1.54, domain=sel, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=10.200.0.198, rootpath=
Looking up port of RPC 100003/2 on 10.200.0.198
Reserved instruction in kernel code in
arch/mips/kernel/traps.c::do_ri, line 706[#1]:
Cpu 0
$ 0   : 00000000 1000fc00 00010000 00000000
$ 4   : 812b8e40 00000093 00000000 811df97c
$ 8   : 00000040 812b9e40 00000000 812a4e10
$12   : 0000ffff 00200200 00100100 812a3ef4
$16   : 812b8e40 00000000 812b8e40 00000060
$20   : 8042a6e0 00010000 811df90c 80144b20
$24   : 00000000 00000001                  
$28   : 811de000 811df8f0 8042a6e0 802facd0
Hi    : 00000000
Lo    : 00000780
epc   : 802ca258 sock_alloc_send_skb+0x74/0x5c8     Not tainted
ra    : 802facd0 ip_append_data+0x7c8/0xa34
Status: 1000fc03    KERNEL EXL IE 
Cause : 00800028
PrId  : 03030200
Modules linked in:
Process swapper (pid: 1, threadinfo=811de000, task=80456bf0)
Stack : c600c80a 3601c80a 00000000 00000000 00000000 00000000 00000000 00000000
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        00000074 00000000 812b8e40 00000060 812b8e40 812b9e40 00000060 00000008
        812b8e98 802facd0 00000000 00000093 00000000 811df97c 00000000 00000000
        00000000 00000000 812b9e40 00000000 00000010 00000000 000005dc 00000000
        ...
Call Trace:
 [<802facd0>] ip_append_data+0x7c8/0xa34
 [<8031e3c4>] udp_sendmsg+0x224/0xa08
 [<802fa44c>] ip_generic_getfrag+0x0/0xbc
 [<802c6558>] sock_sendmsg+0xac/0xf0
 [<80334890>] fn_hash_lookup+0x100/0x150
 [<80334890>] fn_hash_lookup+0x100/0x150
 [<80144b20>] autoremove_wake_function+0x0/0x44
 [<802c65c0>] kernel_sendmsg+0x24/0x38
 [<80362f48>] xdr_sendpages+0x1dc/0x29c
 [<80355284>] xprt_transmit+0xec/0x5f4
 [<80144b20>] autoremove_wake_function+0x0/0x44
 [<803529c4>] call_transmit+0x1f4/0x2d4
 [<80356674>] rpc_delete_timer+0xdc/0x108
 [<80357cb4>] __rpc_execute+0xa8/0x54c
 [<80420000>] init_mtdchar+0x20/0x60
 [<80144b20>] autoremove_wake_function+0x0/0x44
 [<8035976c>] rpcauth_bindcred+0xac/0x248
 [<80144b20>] autoremove_wake_function+0x0/0x44
 [<80420000>] init_mtdchar+0x20/0x60
 [<80420000>] init_mtdchar+0x20/0x60
 [<80420000>] init_mtdchar+0x20/0x60
 [<80351d28>] rpc_call_sync+0x8c/0xd8
 [<80351d14>] rpc_call_sync+0x78/0xd8
 [<80361fdc>] pmap_create+0x74/0xc0
 [<80420000>] init_mtdchar+0x20/0x60
 [<803622e8>] rpc_getport_external+0x11c/0x180
 [<80420000>] init_mtdchar+0x20/0x60
 [<8041b854>] root_nfs_getport+0x8c/0xa8
 [<80420000>] init_mtdchar+0x20/0x60
 [<80254000>] snprintf+0x14/0x20
 [<8041bb94>] nfs_root_data+0x324/0x3a8
 [<80420000>] init_mtdchar+0x20/0x60
 [<80128f24>] printk+0x1c/0x28
 [<80144b20>] autoremove_wake_function+0x0/0x44
 [<80420000>] init_mtdchar+0x20/0x60
 [<8013e444>] flush_workqueue+0x28/0x34
 [<80197f58>] path_lookup+0xe0/0x3d0
 [<80194c78>] getname+0x28/0xf8
 [<80198644>] __user_walk+0x78/0x94
 [<80420000>] init_mtdchar+0x20/0x60
 [<80409cb0>] mount_root+0xac/0x1c4
 [<80144b20>] autoremove_wake_function+0x0/0x44
 [<80420000>] init_mtdchar+0x20/0x60
 [<80420000>] init_mtdchar+0x20/0x60
 [<80409e10>] prepare_namespace+0x48/0x148
 [<8013e444>] flush_workqueue+0x28/0x34
 [<8010065c>] init+0x200/0x264
 [<80100574>] init+0x118/0x264
 [<80105e20>] kernel_thread_helper+0x10/0x18
 [<80105e10>] kernel_thread_helper+0x0/0x18


Code: 10400091  0280f021  c20300a0 <0000102d> e20200a0  1040fffc 
00000000  00032823  14a0009f
Kernel panic - not syncing: Attempted to kill init!




Also, I tried to run 2.4.31 on db1550, but got no luck to get the hard
drive working, which also crashes during the probing process:
probing for hda: present=0, media=32, probetype=ATA
probing for hda: present=0, media=32, probetype=ATAPI
probing for hdb: present=0, media=32, probetype=ATA
probing for hdb: present=0, media=32, probetype=ATAPI
probing for hdc: present=0, media=32, probetype=ATA
probing for hdc: present=0, media=32, probetype=ATAPI
probing for hdd: present=0, media=32, probetype=ATA
probing for hdd: present=0, media=32, probetype=ATAPI
probing for hde: present=0, media=32, probetype=ATA
probing for hde: present=0, media=32, probetype=ATAPI
probing for hdf: present=0, media=32, probetype=ATA
probing for hdf: present=0, media=32, probetype=ATAPI
probing for hdg: present=0, media=32, probetype=ATA
hdg: IBM-DTTA-350840, ATA DISK drive
probing for hdh: present=0, media=32, probetype=ATA
probing for hdh: present=0, media=32, probetype=ATAPI
Unable to handle kernel paging request at virtual address 00000000,
epc == 801e77f0, ra == 801e7b48
Oops in fault.c::do_page_fault, line 206:
