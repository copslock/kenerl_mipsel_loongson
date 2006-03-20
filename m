Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 12:26:31 +0000 (GMT)
Received: from mail.soc-soft.com ([202.56.254.199]:59666 "EHLO
	igateway.soc-soft.com") by ftp.linux-mips.org with ESMTP
	id S8133385AbWCTM0V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Mar 2006 12:26:21 +0000
Received: from keys.soc-soft.com ([192.168.4.44]) by igateway.soc-soft.com with InterScan VirusWall; Mon, 20 Mar 2006 18:05:52 +0530
Received: from soc-mail.soc-soft.com ([192.168.4.25])
  by keys.soc-soft.com (PGP Universal service);
  Mon, 20 Mar 2006 18:03:33 +0530
X-PGP-Universal: processed;
	by keys.soc-soft.com on Mon, 20 Mar 2006 18:03:33 +0530
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: RE: Init not working in 64-bit kernel
Date:	Mon, 20 Mar 2006 18:05:51 +0530
Message-ID: <4BF47D56A0DD2346A1B8D622C5C5902C01525385@soc-mail.soc-soft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Init not working in 64-bit kernel
Thread-Index: AcZJzMjTawNWPeDRTf+gdnxFkM91wgCTeVvg
From:	<Vadivelan@soc-soft.com>
To:	<ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <Vadivelan@soc-soft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vadivelan@soc-soft.com
Precedence: bulk
X-list: linux-mips


Hi Ralf,
	I've attached the kernel dmesg below for ur reference.

----------------------------------------------------------------

YAMON> go
Linux version 2.6.10_mvl401-bcm91250-mips64_fp_be (root@ramkumar) (gcc
version 3
.4.3 (MontaVista 3.4.3-25.0.70.0501961 2005-12-18)) #127 Mon Mar 20
18:00:26 IST
 2006
CPU revision is: 00002d30
FPU revision is: 00002d30

rbtx4938_ce_base[0] : 0x1c000000
rbtx4938_ce_base[2] : 0x17f00000
rbtx4938_ce_base[7] : 0x17e00000TX4938 -- 300MHz(M25MHz) CRIR:49380010
CCFG:3306
427905 PCFG:680000010fbf0100
TX4938 SDRAMC -- CR0:0000007e00000544 TR:35000830c
request resource for internal registers failed
PIOSEL: disabling both ata and nand selection
RBTX4938 --- FPGA(Rev f0) DIPSW:ff,f8
Determined physical RAM map:
 memory: 0000000008000000 @ 0000000000000000 (usable)
Built 1 zonelists
Kernel command line: console=ttyS0,38400 ip=dhcp root=/dev/nfs rw
Primary instruction cache 32kB, physically tagged, 4-way, linesize 32
bytes.
Primary data cache 32kB, 4-way, linesize 32 bytes.
Synthesized TLB refill handler (31 instructions).
Synthesized TLB load handler fastpath (44 instructions).
Synthesized TLB store handler fastpath (44 instructions).
Synthesized TLB modify handler fastpath (43 instructions).
PID hash table entries: 1024 (order: 10, 32768 bytes)
Using 150.000 MHz high precision timer.
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Memory: 124192k/131072k available (2640k kernel code, 6776k reserved,
496k data,
 200k init, 0k highmem)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
Checking for 'wait' instruction...  available.
Checking for the multiply/shift bug... no.
Checking for the daddi bug... no.
Checking for the daddiu bug... no.
spawn_desched_task(0000000000000000)
desched cpu_callback 3/0000000000000000
ksoftirqd started up.
desched cpu_callback 2/0000000000000000
desched thread 0 started up.
NET: Registered protocol family 16
Can't analyze prologue code at ffffffff803907c8
Initializing Cryptographic API
Generic RTC Driver v1.07
TX39/49 Serial driver version 1.04
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x17f20280: 00 60 0a 00 4d 80
eth0: RBHMA4X00/RTL8019 found at 0x17f20280, using IRQ 27.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
NET: Registered protocol family 24
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 192.168.5.93, my address is
192.168.5.249
IP-Config: Complete:
      device=eth0, addr=192.168.5.249, mask=255.255.255.0,
gw=255.255.255.255,
     host=192.168.5.249, domain=, nis-domain=(none),
     bootserver=192.168.5.93, rootserver=192.168.5.93,
rootpath=/usr/mvl64/monta
vista/pro/devkit/mips64/fp_be/target
Looking up port of RPC 100003/2 on 192.168.5.93
Looking up port of RPC 100005/1 on 192.168.5.93
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 200k freed

----------------------------------------------------

It does not boot after this. I'm unable to trace the problem.
If u can plz let me know.

Regards,
vadi



-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Friday, March 17, 2006 7:42 PM
To: Vadivelan M
Cc: linux-mips@linux-mips.org
Subject: Re: Init not working in 64-bit kernel


On Fri, Mar 17, 2006 at 07:19:08PM +0530, Vadivelan@soc-soft.com wrote:

> I've another doubt. Is it enough to set only the bits KX,SX and UX of
> the status register to work in 64-bit mode?

KX, SX and UX will be set by the kernel itself on startup.

SX doesn't actually matter because Linux doesn't use the supervisor
mode.

More for completness sake - there are some slight differences between
the various 64-bit processors if attempting to execute 64-bit
instructions or addresses on a processor configured to 32-bit mode.

> Though I've used the cross compiler mips64_fp_be-gcc from MontaVista,
> the generated vmlinux image seems to boot fine even without setting
> the above bits. I don't know if I'm operating in 32-bit or 64-bit
> mode. But I've enabled 64-bit support in kernel configuration.

Always 64-bit mode on a 64-bit kernels - even for 32-bit software.
Always 32-bit mode on 32-bit kernels - even on 64-bit hardware.

  Ralf






The information contained in this e-mail message and in any annexure is
confidential to the  recipient and may contain privileged information. If you are not
the intended recipient, please notify the sender and delete the message along with
any annexure. You should not disclose, copy or otherwise use the information contained
in the message or any annexure. Any views expressed in this e-mail are those of the
individual sender except where the sender specifically states them to be the views of
SoCrates Software India Pvt Ltd., Bangalore.
