Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2009 17:01:55 +0100 (BST)
Received: from hall.aurel32.net ([88.191.82.174]:974 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S28588235AbZDVNQq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Apr 2009 14:16:46 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1LwcJb-0006CK-Mj
	for linux-mips@linux-mips.org; Wed, 22 Apr 2009 15:16:39 +0200
Date:	Wed, 22 Apr 2009 15:16:39 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Subject: kernel for a Broadcom Swarm board
Message-ID: <20090422131639.GQ10866@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Hi all,

We (Debian) have problems with Broadcom BCM91250A boards aka (Swarm) 
which do not boot with recent kernels. We tried 2.6.29 from linus tree 
and lmo, including with the swarm defconfig.

As those boards are installed remotely it is not really easy to do
debugging. That's why I am calling from help here.

Here is the boot log:

| CFE> boot -tftp 192.168.1.138:sibyl
| Loader:raw Filesys:tftp Dev:eth0 File:192.168.1.138:sibyl Options:(null)
| Loading: ....... 130116 bytes read
| Entry at 0x0000000020000000
| Closing network.
| Starting program at 0x0000000020000000
| SiByte Loader, version 2.4.2
| Built on Oct  4 2005
| Network device 'eth0' configured
| Getting configuration file tftp:192.168.1.138:sibyl.conf...
| Config file retrieved.
| Available configurations:
|   deb-tftp
| Boot which configuration [deb-tftp]:
| Loading kernel (ELF64):
|     4950976@0x80100000
| done
| Set up command line arguments to: root=/dev/hdc1 console=duart0
| Setting up initial prom_init arguments
| Cleaning up state...
| Transferring control to the kernel.
| Kernel entry point is at 0x80105970
| [    0.000000] Initializing cgroup subsys cpuset
| [    0.000000] Initializing cgroup subsys cpu
| [    0.000000] Linux version 2.6.29-1-sb1-bcm91250a (Debian 2.6.29-2) (waldi@debian.org) (gcc version 4.3.3 (Debian 4.3.3-5) ) #1 SMP Sun Apr 5 11:11:13 UTC 2009
| [    0.000000] console [early0] enabled
| [    0.000000] CPU revision is: 01040102 (SiByte SB1)
| [    0.000000] FPU revision is: 000f0102
| [    0.000000] Checking for the multiply/shift bug... no.
| [    0.000000] Checking for the daddiu bug... no.
| [    0.000000] Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
| [    0.000000] Board type: SiByte BCM91250A (SWARM)
| [    0.000000] This kernel optimized for board runs with CFE
| [    0.000000] Determined physical RAM map:
| [    0.000000]  memory: 000000000fe47e00 @ 0000000000000000 (usable)
| [    0.000000] Initrd not found or empty - disabling initrd
| [    0.000000] Zone PFN ranges:
| [    0.000000]   DMA32    0x00000000 -> 0x00100000
| [    0.000000]   Normal   0x00100000 -> 0x00100000
| [    0.000000] Movable zone start PFN for each node
| [    0.000000] early_node_map[1] active PFN ranges
| [    0.000000]     0: 0x00000000 -> 0x0000fe47
| [    0.000000] Detected 1 available secondary CPU(s)
| [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64205
| [    0.000000] Kernel command line: root=/dev/hdc1 console=duart0
| [    0.000000] Primary instruction cache 32kB, VIVT, 4-way, linesize 32 bytes.
| [    0.000000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes
| [    0.000000] PID hash table entries: 1024 (order: 10, 8192 bytes)

And then it hangs...

First of all, does someone have experienced the same problem? Any
patches floating around?

Alternatively I am interested to know about a not too old kernel version
(let's say >= 2.6.20) working for this board, and the associated .config
file. Thanks in advance.

Regards,
Aurelien

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
