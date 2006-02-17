Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 22:45:58 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:59658 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133648AbWBQWpq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Feb 2006 22:45:46 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 9CD3664D59; Fri, 17 Feb 2006 22:52:23 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id CA25C8F77; Fri, 17 Feb 2006 22:52:16 +0000 (GMT)
Date:	Fri, 17 Feb 2006 22:52:16 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: Oops with git: do_signal32 on 64-bit
Message-ID: <20060217225216.GA15781@deprecation.cyrius.com>
References: <20060217191937.GA20521@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217191937.GA20521@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-02-17 19:19]:
> Any idea?

And the same do_signal32 problem on IP22 with current git.  I quickly
tried reverting some of the recent signal changes but that didn't help
and I've no time to investigate properly right now.  Maybe someone
else can take a look.  (Unsurprisingly, rc2 works whereas rc3 and
current git don't.)


 >> boot -f bootp()/srv/tftp/ip22 root=/dev/sda1
Setting $netaddr to 192.168.1.6 (from server )
 Obtaining /srv/tftp/ip22 from server 
Linux version 2.6.16-rc3 (tbm@deprecation) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #1 Fri Feb 17 22:24:53 GMT 2006
 ARCH: SGI-IP22
 PROMLIB: ARC firmware Version 1 Revision 10
 CPU revision is: 00000460
 FPU revision is: 00000500
 MC: SGI memory controller Revision 3
 MC: Probing memory configuration:
  bank0:  64M @ 08000000
  bank1:  32M @ 0c000000
 Determined physical RAM map:
  memory: 0000000006000000 @ 0000000008000000 (usable)
 Built 1 zonelists
 Kernel command line: root=scsi(0)disk(1)rdisk(0)partition(0) root=/dev/sda1
 Primary instruction cache 16kB, physically tagged, direct mapped, linesize 16 bytes.
 Primary data cache 16kB, direct mapped, linesize 16 bytes.
 Unified secondary cache 1024kB direct mapped, linesize 128 bytes.
 Synthesized TLB refill handler (32 instructions).
 Synthesized TLB load handler fastpath (45 instructions).
 Synthesized TLB store handler fastpath (45 instructions).
 Synthesized TLB modify handler fastpath (44 instructions).
 PID hash table entries: 1024 (order: 10, 32768 bytes)
 Calibrating system timer... warning: timer counts differ, retrying... disagreement, using average... 66833 [133.0333 MHz CPU]
 Using 66.833 MHz high precision timer.
 NG1: Revision 6, 24 bitplanes, REX3 revision B, VC2 revision A, xmap9 revision A, cmap revision D, bt445 revision D
 NG1: Screensize 1024x768
 Console: colour SGI Newport 128x48
 Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
 Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
 Memory: 90336k/98304k available (2916k kernel code, 7860k reserved, 788k data, 308k init, 0k highmem)
 Security Framework v1.0.0 initialized
 Mount-cache hash table entries: 256
 Checking for 'wait' instruction...  unavailable.
 Checking for the multiply/shift bug... no.
 Checking for the daddi bug... no.
 Checking for the daddiu bug... no.
 NET: Registered protocol family 16
 EISA bus registered
 SCSI subsystem initialized
 audit: initializing netlink socket (disabled)
 audit(1140215055.132:1): initialized
 VFS: Disk quotas dquot_6.5.1
 Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
 Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
 Initializing Cryptographic API
 io scheduler noop registered (default)
 DS1286 Real Time Clock Driver v1.0
 i8042.c: Warning: Keylock active.
 serio: i8042 AUX port at 0xffffffffbfbd9843,0xffffffffbfbd9847 irq 44
 serio: i8042 KBD port at 0xffffffffbfbd9843,0xffffffffbfbd9847 irq 44
 Serial: IP22 Zilog driver (1 chips).
 ttyS0 at MMIO 0xffffffff5fbd9830 (irq = 45) is a IP22-Zilog
 Console: ttyS0 (IP22-Zilog)
 ttyS1 at MMIO 0xffffffff5fbd9838 (irq = 45) is a IP22-Zilog
 RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
 eth0: SGI Seeq8003 08:00:69:09:ad:d6
 wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
            setup_args=,,,,,,,,,
            Version 1.26 - 22/Feb/2003, Compiled Feb 17 2006 at 22:21:28
 scsi0 : SGI WD93
  sending SDTR 0103013200sync_xfer=20<5>  Vendor:           Model:                   Rev:     
   Type:   Direct-Access                      ANSI SCSI revision: 00
 SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
 sda: Write Protect is off
 SCSI device sda: drive cache: write back w/ FUA
 SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
 sda: Write Protect is off
 SCSI device sda: drive cache: write back w/ FUA
  sda: sda1 sda2 sda9 sda11
 sd 0:0:0:0: Attached scsi disk sda
 mice: PS/2 mouse device common for all mice
 md: raid0 personality registered for level 0
 md: raid1 personality registered for level 1
 md: raid5 personality registered for level 5
 md: raid4 personality registered for level 4
 raid5: measuring checksumming speed
    8regs     :   172.000 MB/sec
    8regs_prefetch:   172.000 MB/sec
    32regs    :   204.000 MB/sec
    32regs_prefetch:   204.000 MB/sec
 raid5: using function: 32regs_prefetch (204.000 MB/sec)
 md: multipath personality registered for level -4
 md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
 md: bitmap version 4.39
 NET: Registered protocol family 2
 IP route cache hash table entries: 2048 (order: 2, 16384 bytes)
 TCP established hash table entries: 8192 (order: 4, 65536 bytes)
 TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
 TCP: Hash tables configured (established 8192 bind 8192)
 TCP reno registered
 TCP bic registered
 Initializing IPsec netlink socket
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 NET: Registered protocol family 15
 atkbd.c: keyboard reset failed on hpc3ps2/serio1
 md: Autodetecting RAID arrays.
 md: autorun ...
 md: ... autorun DONE.
 EXT3-fs: INFO: recovery required on readonly filesystem.
 EXT3-fs: write access will be enabled during recovery.
 atkbd.c: keyboard reset failed on hpc3ps2/serio0
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: recovery complete.
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
 Freeing unused kernel memory: 308k freed
 INIT: version 2.85 booting
CPU 0 Unable to handle kernel paging request at virtual address 0000000000000100, epc == ffffffff880149e0, ra == ffffffff88007f64
 Oops[#1]:
 Cpu 0
 $ 0   : 0000000000000000 000000001004cce1 ffffffff8d503000 ffffffff88346708
 $ 4   : ffffffff8d50beb0 0000000000000000 0000000000000004 ffffffff8d5039e0
 $ 8   : 0000000000000000 ffffffff8d50be60 0000000000000000 0000000000446324
 $12   : 0000000000000000 0000000000000003 ffffffff880158b0 ffffffff8d52c000
 $16   : 0000000000000000 ffffffffffffffff 000000001002ac28 0000000000000000
 $20   : 0000000000000000 000000000000000a 000000007fa1bf58 0000000000000000
 $24   : 0000000000000000 ffffffff880149c8                                  
 $28   : ffffffff8d508000 ffffffff8d50bde0 0000000000000000 ffffffff88007f64
 Hi    : 0000000000000000
 Lo    : 0000000000000078
 epc   : ffffffff880149e0 do_signal32+0x18/0x2a8     Not tainted
 ra    : ffffffff88007f64 work_notifysig+0xc/0x14
 Status: 1004cce2    KX SX UX KERNEL EXL 
 Cause : 00000008
 BadVA : 0000000000000100
 PrId  : 00000460
 Modules linked in:
 Process rcS (pid: 672, threadinfo=ffffffff8d508000, task=ffffffff8d503000)
 Stack : 0000000000030002 ffffffff8d503000 ffffffff880339e0 0000000000100100
         0000000000200200 0000000000000012 0000000000000000 ffffff0000000000
         000000001002ac28 0000000000000000 ffffffff88048258 0000000000000000
         0000000000020000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 ffffffff88015900 0000000000000001 000000001002ac28
         0000000000000000 ffffffffffffffff 000000001002ac28 0000000000000000
         ffffffff88007f64 ffffffff8801bb4c 0000000000000000 0000000010009cf8
         0000000000000000 0000000000000000 0000000000000003 000000007fa1bf58
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         000000001002c4c8 0000000000000000 0000000000000000 0000000000000000
         ...
 Call Trace:
  [<ffffffff880339e0>] default_wake_function+0x0/0x20
  [<ffffffff88048258>] sys_rt_sigprocmask+0x98/0x138
  [<ffffffff88015900>] sys32_rt_sigprocmask+0x50/0x198
  [<ffffffff88007f64>] work_notifysig+0xc/0x14
  [<ffffffff8801bb4c>] handle_sys+0x12c/0x148
 
 
 Code: ffbf00c0  ffb300b8  ffb200b0 <dca20100> 24030010  30420018  00a0802d  1043000b  0080882d 
 CPU 0 Unable to handle kernel paging request at virtual address 0000000000000100, epc == ffffffff880149e0, ra == ffffffff88007f64
 Oops[#2]:
 Cpu 0
 $ 0   : 0000000000000000 000000001004cce0 ffffffff8d4c4370 ffffffff88346708
 $ 4   : ffffffff8d4cbeb0 0000000000000000 0000000000000004 0000000000000001
 $ 8   : 000000001004cce1 ffffffff88350000 0000000000000001 000000000000050c
 $12   : 0000000000000000 000000000000cc00 0000000000000000 ffffffff8d508000
 $16   : 000000000000000a 0000000000000004 0000000000000080 000000007fa1c040
 $20   : 0000000000000003 000000001002c208 0000000000000003 0000000000000001
 $24   : ffffffff883f0000 ffffffff880149c8                                  
 $28   : ffffffff8d4c8000 ffffffff8d4cbde0 0000000000000001 ffffffff88007f64
 Hi    : 0000000000000000
 Lo    : 0000000000000018
 epc   : ffffffff880149e0 do_signal32+0x18/0x2a8     Not tainted
 ra    : ffffffff88007f64 work_notifysig+0xc/0x14
 Status: 1004cce2    KX SX UX KERNEL EXL 
 Cause : 00000008
 BadVA : 0000000000000100
 PrId  : 00000460
 Modules linked in:
 Process rcS (pid: 671, threadinfo=ffffffff8d4c8000, task=ffffffff8d4c4370)
 Stack : ffffffff8d4d6160 0000000000000000 000000007fa1c040 ffffffff8d4cbe88
         0000000000000080 000000001002c208 0000000000000003 0000000000000001
         0000000000000001 ffffffff8809c10c 000000007fa1c040 0000000000000080
         ffffffff8808b13c ffffffff8808b0e0 fffffffffffffff7 000000007fa1c040
         ffffffff8d4d6160 000000007fa1c040 0000000000000003 ffffffff8808be94
         000000000000000a 0000000000000004 0000000000000080 000000007fa1c040
         ffffffff88007f64 ffffffff8801bb4c 0000000000000000 000000001004cce0
         0000000000000000 000000000000000c 0000000000000003 000000007fa1c040
         0000000000000080 0000000000000000 0000000000000000 0000000000000000
         ffffffff8dc62d20 0000000000000006 0000000000000000 0000000000000006
         ...
 Call Trace:
  [<ffffffff8809c10c>] pipe_read+0x1c/0x28
  [<ffffffff8808b13c>] vfs_read+0xfc/0x1b8
  [<ffffffff8808b0e0>] vfs_read+0xa0/0x1b8
  [<ffffffff8808be94>] sys_read+0x4c/0x90
  [<ffffffff88007f64>] work_notifysig+0xc/0x14
  [<ffffffff8801bb4c>] handle_sys+0x12c/0x148
 
 
 Code: ffbf00c0  ffb300b8  ffb200b0 <dca20100> 24030010  30420018  00a0802d  1043000b  0080882d 
 /etc/CPU 0 Unable to handle kernel paging request at virtual address 0000000000000100, epc == ffffffff880149e0, ra == ffffffff88007f64
 Oops[#3]:
 Cpu 0
 $ 0   : 0000000000000000 000000001004cce1 ffffffff8d94cb40 ffffffff88346708
 $ 4   : ffffffff8daf7eb0 0000000000000000 0000000000000004 ffffffff8d94d520
 $ 8   : 0000000000000000 ffffffff8daf7e60 0000000000000000 0000000000446324
 $12   : 0000000000000000 0000000000000003 ffffffff880158b0 ffffffff88400000
 $16   : 0000000000000000 ffffffffffffffff 00000000100181a8 0000000000000000
 $20   : 000000000000008b 000000000000000a 000000007fa1c9b8 0000000000000000
 $24   : 0000000000000000 ffffffff880149c8                                  
 $28   : ffffffff8daf4000 ffffffff8daf7de0 0000000000000000 ffffffff88007f64
 Hi    : 00000000000000a2
 Lo    : 8f5c28f5c28dd500
 epc   : ffffffff880149e0 do_signal32+0x18/0x2a8     Not tainted
 ra    : ffffffff88007f64 work_notifysig+0xc/0x14
 Status: 1004cce2    KX SX UX KERNEL EXL 
 Cause : 00000008
 BadVA : 0000000000000100
 PrId  : 00000460
 Modules linked in:
 Process rcS (pid: 670, threadinfo=ffffffff8daf4000, task=ffffffff8d94cb40)
 Stack : ffffffff881ae5c8 ffffffff881ae614 0000000000000000 0000000000000001
         ffffffff8d942310 0000000000000062 0000000000000000 ffffff0000000000
         00000000100181a8 0000000000000000 ffffffff88048258 0000000000000000
         0000000000020000 0000000000000000 0000000000000000 0000000000000000
         0000000000000000 ffffffff88015900 00000000100181a8 ffffffff8808bf24
         0000000000000000 ffffffffffffffff 00000000100181a8 0000000000000000
         ffffffff88007f64 ffffffff8801bb4c 0000000000000000 0000000010009cbc
         0000000000000000 0000000000000000 0000000000000003 000000007fa1c9b8
         0000000000000000 0000000000000000 0000000000000000 0000000000000000
         ffffffffa0000000 0000000000000000 0000000000000000 0000000000000000
         ...
 Call Trace:
  [<ffffffff881ae5c8>] tty_write+0x230/0x330
  [<ffffffff881ae614>] tty_write+0x27c/0x330
  [<ffffffff88048258>] sys_rt_sigprocmask+0x98/0x138
  [<ffffffff88015900>] sys32_rt_sigprocmask+0x50/0x198
  [<ffffffff8808bf24>] sys_write+0x4c/0x90
  [<ffffffff88007f64>] work_notifysig+0xc/0x14
  [<ffffffff8801bb4c>] handle_sys+0x12c/0x148
 
 
 Code: ffbf00c0  ffb300b8  ffb200b0 <dca20100> 24030010  30420018  00a0802d  1043000b  0080882d 
 init.d/CPU 0 Unable to handle kernel paging request at virtual address 0000000000000100, epc == ffffffff880149e0, ra == ffffffff88007f64
 Oops[#4]:
 Cpu 0
 $ 0   : 0000000000000000 000000001004cce0 ffffffff8938e750 ffffffff88346708
 $ 4   : ffffffff89397eb0 0000000000000000 0000000000000004 fffffffffffffdfe
 $ 8   : 0000000500000000 000000007fdc3b98 0000000000000000 000000000000030a
 $12   : 0000000000000000 000000000000cc00 0000000000000000 ffffffff8daf4000
 $16   : 000000007fdc3c28 000000007fdc3cb8 000000007fdc3a10 000000007fdc3b90
 $20   : 0000000000000000 0000000000000001 0000000000000053 ffffffff88300000
 $24   : 0000000000000000 ffffffff880149c8                                  
 $28   : ffffffff89394000 ffffffff89397de0 ffffffff882f0000 ffffffff88007f64
 Hi    : 0000000000000000
 Lo    : 000000000007acd8
 epc   : ffffffff880149e0 do_signal32+0x18/0x2a8     Not tainted
 ra    : ffffffff88007f64 work_notifysig+0xc/0x14
 Status: 1004cce2    KX SX UX KERNEL EXL 
 Cause : 00000408
 BadVA : 0000000000000100
 PrId  : 00000460
 Modules linked in:
 Process init (pid: 1, threadinfo=ffffffff89394000, task=ffffffff8938e750)
 Stack : 0000000000000000 0000000000000000 fffffffffffffdfe ffffffff880c24b0
         ffffffff8db105f0 ffffffff8db105f8 ffffffff8db10600 ffffffff8db10608
         ffffffff8db10610 ffffffff8db10618 000000007fdc3b90 000000007fdc3cb8
         000000007fdc3a10 000000007fdc3b90 0000000000000000 0000000000000001
         0000000000000053 ffffffff88300000 ffffffff882f0000 ffffffff880c2944
         000000007fdc3c28 000000007fdc3cb8 000000007fdc3a10 000000007fdc3b90
         ffffffff88007f64 ffffffff8801bb4c 0000000000000202 00000000100000ec
         0000000000000202 000000007fdc3a10 000000000000000b 000000007fdc3cb8
         0000000000000000 0000000000000001 0000000000000000 000000007fdc3950
         00000000000044ee ffffffff88350000 0000000000000000 ffffffff88191d48
         ...
 Call Trace:
  [<ffffffff880c24b0>] compat_core_sys_select+0x250/0x258
  [<ffffffff880c2944>] compat_sys_select+0x3c/0x230
  [<ffffffff88007f64>] work_notifysig+0xc/0x14
  [<ffffffff8801bb4c>] handle_sys+0x12c/0x148
  [<ffffffff88191d48>] memset_partial+0x44/0x60
  [<ffffffff8808a6f0>] sys_open+0x0/0x18
 
 
 Code: ffbf00c0  ffb300b8  ffb200b0 <dca20100> 24030010  30420018  00a0802d  1043000b  0080882d 
 Kernel panic - not syncing: Attempted to kill init!
  rcS: line 57:   671 Segmentation fault      ( trap - INT QUIT TSTP; set start; . $i )

-- 
Martin Michlmayr
http://www.cyrius.com/
