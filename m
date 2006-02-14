Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 02:20:55 +0000 (GMT)
Received: from mo01.po.2iij.net ([210.130.202.205]:18684 "EHLO
	mo01.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S3467615AbWBNCUi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 02:20:38 +0000
Received: NPO MO01 id k1E2Qtne003000; Tue, 14 Feb 2006 11:26:55 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (NPO-MR/mbox00) id k1E2QrUk018278
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 14 Feb 2006 11:26:53 +0900 (JST)
Date:	Tue, 14 Feb 2006 11:26:53 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
Message-Id: <20060214112653.25ed3e05.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060214.111547.21591480.nemoto@toshiba-tops.co.jp>
References: <20060214.011508.41198724.anemo@mba.ocn.ne.jp>
	<20060214105928.0cd46e6f.yoichi_yuasa@tripeaks.co.jp>
	<20060214.111547.21591480.nemoto@toshiba-tops.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: tripeaks.co.jp
Envelope-Id: tripeaks.co.jp
X-archive-position: 10431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Good morning,

On Tue, 14 Feb 2006 11:15:47 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> >>>>> On Tue, 14 Feb 2006 10:59:28 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> said:
> yuasa> VR41xx cannot be booted with 2.6.16-rc2 + patch.  It freeze
> yuasa> after "Freeing unused kernel memory: 168k freed".

Oops, I'm testing 2.6.16-rc3 + patch on VR41xx.
                         ^^^
> 
> Good morning!  Thank you very much for testing.
> 
> Could you give me a full boot log and some other informations?
> (icache/dcache size/associativity, highmem/preempt/smp enabled?)

Here is the boot log.

Linux version 2.6.16-rc3 (yuasa@localhost) (gcc version 3.3.2) #5 Tue Feb 14 10:32:44 JST 2006
CPU revision is: 00000c83
PClock: 199065600Hz
VTClock: 99532800Hz
TClock: 49766400Hz
Determined physical RAM map:
User-defined physical RAM map:
 memory: 04000000 @ 00000000 (usable)
Built 1 zonelists
Kernel command line: mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs
Primary instruction cache 16kB, physically tagged, 2-way, linesize 16 bytes.
Primary data cache 16kB, 2-way, linesize 16 bytes.
Synthesized TLB refill handler (21 instructions).
Synthesized TLB load handler fastpath (33 instructions).
Synthesized TLB store handler fastpath (33 instructions).
Synthesized TLB modify handler fastpath (32 instructions).
PID hash table entries: 512 (order: 9, 8192 bytes)
Using 12.442 MHz high precision timer.
Console: colour dummy device 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 61116k/65536k available (2887k kernel code, 4356k reserved, 532k data, 168k init, 0k highmem)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  unavailable.
NET: Registered protocol family 16
SCSI subsystem initialized
PCI: Bridge: 0000:01:00.0
  IO window: disabled.
  MEM window: 11a00000-11afffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:12.0
  IO window: 1000000-1000fff
  MEM window: 11a00000-11bfffff
  PREFETCH window: disabled.
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
GIU: major number 254
SIU: ttyVR0 at MMIO 0xf000800 (irq = 17) is a SIU
SIU: ttyVR1 at MMIO 0xf000820 (irq = 29) is a DSIU
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
r8169 Gigabit Ethernet driver 2.2LK loaded
r8169: PowerManagement capability not found.
eth0: RTL8169 at 0xb1b00000, 00:20:0f:00:24:04, IRQ 53
r8169 Gigabit Ethernet driver 2.2LK loaded
r8169: PowerManagement capability not found.
eth1: RTL8169 at 0xb1b00100, 00:20:0f:00:24:05, IRQ 53
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiI680: IDE controller at PCI slot 0000:00:11.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 48
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
hda: Hitachi CVM1.1.1, CFA DISK drive
ide0 at 0xb1c80080-0xb1c80087,0xb1c8008a on irq 48
hda: max request size: 64KiB
hda: 250368 sectors (128 MB) w/1KiB Cache, CHS=978/8/32
 hda: hda1
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
r8169: eth0: link up
r8169: eth1: link down
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 192.168.2.1, my address is 192.168.2.101
IP-Config: Complete:
      device=eth0, addr=192.168.2.101, mask=255.255.255.0, gw=255.255.255.255,
     host=192.168.2.101, domain=tripeaks.co.jp, nis-domain=(none),
     bootserver=192.168.2.1, rootserver=192.168.2.1, rootpath=/opt/nfsroot-tb0287
Looking up port of RPC 100003/2 on 192.168.2.1
Looking up port of RPC 100005/1 on 192.168.2.1
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 168k freed

Yoichi
