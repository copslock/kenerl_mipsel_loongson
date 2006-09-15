Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2006 23:11:51 +0100 (BST)
Received: from web31504.mail.mud.yahoo.com ([68.142.198.133]:65426 "HELO
	web31504.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20037875AbWIOWLr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Sep 2006 23:11:47 +0100
Received: (qmail 69176 invoked by uid 60001); 15 Sep 2006 22:11:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=EL6EMe/0HiXDtiyEJhFWbKsro4MHywYRIHVWaLizVTBNc6hR40s9eHiMs9UkcHGNE92I2YY44AgunMqUyqqFezh5NfVNpogmYUBCtnsnmJfpb3zkgHTwqceIyfjejyW4bKerJBzQVQqrVzcYgeWbb9B47zZWrJxazH8Uc90a888=  ;
Message-ID: <20060915221141.69174.qmail@web31504.mail.mud.yahoo.com>
Received: from [70.103.67.194] by web31504.mail.mud.yahoo.com via HTTP; Fri, 15 Sep 2006 15:11:40 PDT
Date:	Fri, 15 Sep 2006 15:11:40 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Kernel debugging contd.
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Ok, here's the console output with virtually every
Linux debug option I could find enabled. It softlocks
(no console activity, but kernel pings) after freeing
memory. Any thoughts on using the magic key over
minicom would also be welcome. The thing that stands
out the most is line 864000, where we have an IRQ
handler mismatch and a call trace.

Suggestions, anyone?

CFE version 1.2.5 for SENTOSA (64bit,MP,BE,MIPS)
Build Date: Tue Feb 28 15:32:44 PST 2006
(elhoward@localhost.localdomain)
Copyright (C) 2000,2001,2002,2003,2004,2005 Broadcom
Corporation.

Initializing Arena.
Initializing PCI. [normal]
HyperTransport: 400 MHz
HyperTransport not initialized: InitDone not set
 SriCmd 5221
 TXNum 0000ffff TxDen 10  RxNum 0000ffff RxDen 10
ErrCtl 00000000
 LDTCmd 20010008 LDTCfg 000000c0 LDTFreq 00000211
Initializing Devices.
SENTOSA board revision 2
sbeth: found phy 1, vendor 000818 part 0E
sbeth: found phy 1, vendor 000818 part 0E
PCIIDE: 0 controllers found
Config switch: 2
CPU: BCM1250 B2
L2 Cache Status: OK
Wafer ID:   0x92CEE019  [Lot 9395, Wafer 23]
Manuf Test: Bin A [2CPU_FI_FD_F2 (OK)] 
SysCfg: 0000000024C20800 [PLL_DIV: 16, IOB0_DIV:
CPUCLK/4, IOB1_DIV: CPUCLK/3]
CPU type 0x1040102: 800MHz
Total memory: 0x10000000 bytes (256MB)

Total memory used by CFE:  0x8FEA8000 - 0x8FFFF080
(1405056)
Initialized Data:          0x8FEF70B8 - 0x8FEFCA00
(22856)
BSS Area:                  0x8FEFCA00 - 0x8FEFD070
(1648)
Local Heap:                0x8FEFD080 - 0x8FFFD080
(1048576)
Stack Area:                0x8FFFD080 - 0x8FFFF080
(8192)
Text (code) segment:       0x8FEA8000 - 0x8FEF68B1
(321713)
Boot area (physical):      0x0FE67000 - 0x0FEA7000
Relocation Factor:         I:F02A8000 - D:F02A8000

sbeth: found phy 1, vendor 000818 part 0E
eth0: Link speed: 100BaseT FDX
Device eth0:  hwaddr 00-02-4C-FD-0D-3C, ipaddr
10.1.3.148, mask 255.255.255.0
        gateway 10.1.3.1, nameserver 10.1.3.10, domain
lightfleet
Loader:elf Filesys:tftp Dev:eth0
File:10.1.3.187:vmlinux.sentosa Options:(null)
eth0: Link speed: 100BaseT FDX
0xffffffff80680480/269184 Entry at 0x80640000
Closing network.
Starting program at 0x80640000

Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
Board type: SiByte BCM91250E (Sentosa)
[17179569.184000] Linux version
2.6.18-rc7-lightfleet-0.3-g50125477 (root@10.1.3.148)
(gcc version 4.1.1) #4 SMP Fri Sep 15 19:37:13 UTC
2006
[17179569.184000] CPU revision is: 01040102
[17179569.184000] FPU revision is: 000f0102
[17179569.184000] swarm setup: M41T81 RTC detected.
[17179569.184000] This kernel optimized for board runs
with CFE
[17179569.184000] Determined physical RAM map:
[17179569.184000]  memory: 000000000fea7e00 @
0000000000000000 (usable)
[17179569.184000] Detected 1 available secondary
CPU(s)
[17179569.184000] Built 1 zonelists.  Total pages:
65191
[17179569.184000] Kernel command line: ip=any rw
nfsroot=10.1.3.187:/home/developer root=/dev/nfs
serial=1,115200n8
[17179569.184000] Primary instruction cache 32kB,
4-way, linesize 32 bytes.
[17179569.184000] Primary data cache 32kB, 4-way,
linesize 32 bytes.
[17179569.184000] Synthesized TLB refill handler (40
instructions).
[17179569.184000] Synthesized TLB load handler
fastpath (54 instructions).
[17179569.184000] Synthesized TLB store handler
fastpath (49 instructions).
[17179569.184000] Synthesized TLB modify handler
fastpath (48 instructions).
[17179569.184000] PID hash table entries: 1024 (order:
10, 8192 bytes)
[17179569.184000] Using 512.000 MHz high precision
timer.
[17179569.184000] start_kernel(): bug: interrupts were
enabled early
[17179569.188000] ------------------------
[17179569.192000] | Locking API testsuite:
[17179569.192000]
----------------------------------------------------------------------------
[17179569.196000]                                  |
spin |wlock |rlock |mutex | wsem | rsem |
[17179569.200000]  
--------------------------------------------------------------------------
[17179569.204000]                      A-A
deadlock:failed|failed|  ok  |failed|failed|failed|
[17179569.212000]                  A-B-B-A
deadlock:failed|failed|  ok  |failed|failed|failed|
[17179569.220000]              A-B-B-C-C-A
deadlock:failed|failed|  ok  |failed|failed|failed|
[17179569.228000]              A-B-C-A-B-C
deadlock:failed|failed|  ok  |failed|failed|failed|
[17179569.236000]          A-B-B-C-C-D-D-A
deadlock:failed|failed|  ok  |failed|failed|failed|
[17179569.244000]          A-B-C-D-B-D-D-A
deadlock:failed|failed|  ok  |failed|failed|failed|
[17179569.252000]          A-B-C-D-B-C-D-A
deadlock:failed|failed|  ok  |failed|failed|failed|
[17179569.260000]                     double unlock: 
ok  |  ok  |failed|  ok  |failed|failed|
[17179569.268000]                   initialize
held:failed|failed|failed|failed|failed|failed|
[17179569.276000]                  bad unlock order: 
ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[17179569.284000]  
--------------------------------------------------------------------------
[17179569.288000]               recursive read-lock:  
          |  ok  |             |failed|
[17179569.296000]            recursive read-lock #2:  
          |  ok  |             |failed|
[17179569.300000]             mixed read-write-lock:  
          |failed|             |failed|
[17179569.308000]             mixed write-read-lock:  
          |failed|             |failed|
[17179569.316000]  
--------------------------------------------------------------------------
[17179569.320000]      hard-irqs-on +
irq-safe-A/12:failed|failed|  ok  |
[17179569.324000]      soft-irqs-on +
irq-safe-A/12:failed|failed|  ok  |
[17179569.332000]      hard-irqs-on +
irq-safe-A/21:failed|failed|  ok  |
[17179569.340000]      soft-irqs-on +
irq-safe-A/21:failed|failed|  ok  |
[17179569.344000]        sirq-safe-A =>
hirqs-on/12:failed|failed|  ok  |
[17179569.352000]        sirq-safe-A =>
hirqs-on/21:failed|failed|  ok  |
[17179569.356000]          hard-safe-A +
irqs-on/12:failed|failed|  ok  |
[17179569.364000]          soft-safe-A +
irqs-on/12:failed|failed|  ok  |
[17179569.372000]          hard-safe-A +
irqs-on/21:failed|failed|  ok  |
[17179569.376000]          soft-safe-A +
irqs-on/21:failed|failed|  ok  |
[17179569.384000]     hard-safe-A + unsafe-B
#1/123:failed|failed|  ok  |
[17179569.388000]     soft-safe-A + unsafe-B
#1/123:failed|failed|  ok  |
[17179569.392000]     hard-safe-A + unsafe-B
#1/132:failed|failed|  ok  |
[17179569.400000]     soft-safe-A + unsafe-B
#1/132:failed|failed|  ok  |
[17179569.404000]     hard-safe-A + unsafe-B
#1/213:failed|failed|  ok  |
[17179569.412000]     soft-safe-A + unsafe-B
#1/213:failed|failed|  ok  |
[17179569.416000]     hard-safe-A + unsafe-B
#1/231:failed|failed|  ok  |
[17179569.420000]     soft-safe-A + unsafe-B
#1/231:failed|failed|  ok  |
[17179569.428000]     hard-safe-A + unsafe-B
#1/312:failed|failed|  ok  |
[17179569.432000]     soft-safe-A + unsafe-B
#1/312:failed|failed|  ok  |
[17179569.440000]     hard-safe-A + unsafe-B
#1/321:failed|failed|  ok  |
[17179569.448000]     soft-safe-A + unsafe-B
#1/321:failed|failed|  ok  |
[17179569.452000]     hard-safe-A + unsafe-B
#2/123:failed|failed|  ok  |
[17179569.460000]     soft-safe-A + unsafe-B
#2/123:failed|failed|  ok  |
[17179569.464000]     hard-safe-A + unsafe-B
#2/132:failed|failed|  ok  |
[17179569.472000]     soft-safe-A + unsafe-B
#2/132:failed|failed|  ok  |
[17179569.480000]     hard-safe-A + unsafe-B
#2/213:failed|failed|  ok  |
[17179569.484000]     soft-safe-A + unsafe-B
#2/213:failed|failed|  ok  |
[17179569.492000]     hard-safe-A + unsafe-B
#2/231:failed|failed|  ok  |
[17179569.496000]     soft-safe-A + unsafe-B
#2/231:failed|failed|  ok  |
[17179569.500000]     hard-safe-A + unsafe-B
#2/312:failed|failed|  ok  |
[17179569.508000]     soft-safe-A + unsafe-B
#2/312:failed|failed|  ok  |
[17179569.512000]     hard-safe-A + unsafe-B
#2/321:failed|failed|  ok  |
[17179569.520000]     soft-safe-A + unsafe-B
#2/321:failed|failed|  ok  |
[17179569.524000]       hard-irq
lock-inversion/123:failed|failed|  ok  |
[17179569.528000]       soft-irq
lock-inversion/123:failed|failed|  ok  |
[17179569.536000]       hard-irq
lock-inversion/132:failed|failed|  ok  |
[17179569.540000]       soft-irq
lock-inversion/132:failed|failed|  ok  |
[17179569.548000]       hard-irq
lock-inversion/213:failed|failed|  ok  |
[17179569.556000]       soft-irq
lock-inversion/213:failed|failed|  ok  |
[17179569.560000]       hard-irq
lock-inversion/231:failed|failed|  ok  |
[17179569.568000]       soft-irq
lock-inversion/231:failed|failed|  ok  |
[17179569.572000]       hard-irq
lock-inversion/312:failed|failed|  ok  |
[17179569.576000]       soft-irq
lock-inversion/312:failed|failed|  ok  |
[17179569.584000]       hard-irq
lock-inversion/321:failed|failed|  ok  |
[17179569.588000]       soft-irq
lock-inversion/321:failed|failed|  ok  |
[17179569.596000]       hard-irq read-recursion/123: 
ok  |
[17179569.600000]       soft-irq read-recursion/123: 
ok  |
[17179569.604000]       hard-irq read-recursion/132: 
ok  |
[17179569.608000]       soft-irq read-recursion/132: 
ok  |
[17179569.612000]       hard-irq read-recursion/213: 
ok  |
[17179569.616000]       soft-irq read-recursion/213: 
ok  |
[17179569.620000]       hard-irq read-recursion/231: 
ok  |
[17179569.624000]       soft-irq read-recursion/231: 
ok  |
[17179569.628000]       hard-irq read-recursion/312: 
ok  |
[17179569.636000]       soft-irq read-recursion/312: 
ok  |
[17179569.640000]       hard-irq read-recursion/321: 
ok  |
[17179569.644000]       soft-irq read-recursion/321: 
ok  |
[17179569.652000]
--------------------------------------------------------
[17179569.656000] 142 out of 218 testcases failed, as
expected. |
[17179569.660000]
----------------------------------------------------
[17179569.664000] Dentry cache hash table entries:
32768 (order: 6, 262144 bytes)
[17179569.668000] Inode-cache hash table entries:
16384 (order: 5, 131072 bytes)
[17179569.700000] Memory: 249464k/260764k available
(4112k kernel code, 10976k reserved, 1260k data, 260k
init, 0k highmem)
[17179569.804000] Mount-cache hash table entries: 256
[17179569.808000] Checking for 'wait' instruction... 
unavailable.
[17179569.816000] Checking for the multiply/shift
bug... no.
[17179569.820000] Checking for the daddi bug... no.
[17179569.824000] Checking for the daddiu bug... no.
[17179569.832000] CPU revision is: 03040102
[17179569.832000] FPU revision is: 000f0102
[17179569.832000] Primary instruction cache 32kB,
4-way, linesize 32 bytes.
[17179569.832000] Primary data cache 32kB, 4-way,
linesize 32 bytes.
[17179569.832000] Synthesized TLB refill handler (40
instructions).
[17179569.932000] Brought up 2 CPUs
[17179570.248000] migration_cost=8000
[17179570.260000] NET: Registered protocol family 16
[17179570.272000] Generic PHY: Registered new driver
[17179570.280000] SCSI subsystem initialized
[17179570.284000] usbcore: registered new driver usbfs
[17179570.292000] usbcore: registered new driver hub
[17179570.304000] NET: Registered protocol family 2
[17179570.352000] IP route cache hash table entries:
2048 (order: 2, 16384 bytes)
[17179570.360000] TCP established hash table entries:
8192 (order: 6, 262144 bytes)
[17179570.368000] TCP bind hash table entries: 4096
(order: 5, 131072 bytes)
[17179570.372000] TCP: Hash tables configured
(established 8192 bind 4096)
[17179570.376000] TCP reno registered
[17179570.420000] Initializing RT-Tester: OK
[17179570.428000] JFS: nTxBlock = 1951, nTxLock =
15611
[17179570.436000] Installing v9fs 9P2000 file system
support
[17179570.444000] Initializing Cryptographic API
[17179570.448000] io scheduler noop registered
[17179570.452000] io scheduler anticipatory registered
[17179570.456000] io scheduler deadline registered
(default)
[17179570.460000] io scheduler cfq registered
[17179570.840000] IRQ handler type mismatch for IRQ 8
[17179570.844000] Call Trace:
[17179570.848000] [<ffffffff80109f90>]
dump_stack+0x18/0x58
[17179570.852000] [<ffffffff8016e6c8>]
setup_irq+0x1b0/0x2d8
[17179570.856000] [<ffffffff8016e8f8>]
request_irq+0x108/0x128
[17179570.864000] [<ffffffff80664754>]
rtc_init+0xb4/0x5b8
[17179570.868000] [<ffffffff80100734>]
init+0x29c/0x6c0
[17179570.872000] [<ffffffff80104a08>]
kernel_thread_helper+0x10/0x18
[17179570.880000] 
[17179570.880000] rtc: IRQ 8 is not free.
[17179570.884000] RAMDISK driver initialized: 1 RAM
disks of 4096K size 1024 blocksize
[17179570.900000] loop: loaded (max 8 devices)
[17179570.904000] nbd: registered device at major 43
[17179570.924000] Ethernet Channel Bonding Driver:
v3.0.3 (March 23, 2006)
[17179570.932000] bonding: Warning: either miimon or
arp_interval and arp_ip_target module parameters must
be specified, otherwise bonding will not detect li.
[17179570.952000] eth0: enabling TCP rcv checksum
[17179570.956000] eth0: SiByte Ethernet at 0x10064000,
address: 00:02:4C:FD:0D:3C
[17179570.964000] eth1: enabling TCP rcv checksum
[17179570.968000] eth1: SiByte Ethernet at 0x10065000,
address: 00:02:4C:FD:0D:3D
[17179570.976000] Equalizer2002: Simon Janes
(simon@ncm.com) and David S. Miller (davem@redhat.com)
[17179570.988000] Initializing USB Mass Storage
driver...
[17179570.996000] usbcore: registered new driver
usb-storage
[17179571.000000] USB Mass Storage support registered.
[17179571.004000] usbcore: registered new driver
libusual
[17179571.012000] usbcore: registered new driver
usbhid
[17179571.016000] drivers/usb/input/hid-core.c:
v2.6:USB HID core driver
[17179571.024000] mice: PS/2 mouse device common for
all mice
[17179571.032000] rtc-test rtc-test.0: rtc intf: sysfs
[17179571.036000] rtc-test rtc-test.0: rtc intf: proc
[17179571.040000] rtc-test rtc-test.0: rtc intf: dev
(254:0)
[17179571.048000] rtc-test rtc-test.0: rtc core:
registered test as rtc0
[17179571.052000] rtc-test rtc-test.1: rtc intf: sysfs
[17179571.060000] rtc-test rtc-test.1: rtc intf: dev
(254:1)
[17179571.064000] rtc-test rtc-test.1: rtc core:
registered test as rtc1
[17179571.072000] i2c /dev entries driver
[17179571.076000] i2c-swarm.o: i2c SMBus adapter
module for SiByte board
[17179571.092000] pktgen v2.67: Packet Generator for
packet performance testing.
[17179571.100000] netem: version 1.2
[17179571.104000] NET: Registered protocol family 1
[17179571.108000] NET: Registered protocol family 10
[17179571.116000] lo: Disabled Privacy Extensions
[17179571.120000] IPv6 over IPv4 tunneling driver
[17179571.124000] NET: Registered protocol family 17
[17179571.148000] CCID: Registered CCID 3 (ccid3)
[17179571.152000] CCID: Registered CCID 2 (ccid2)
[17179571.180000] SCTP: Hash tables configured
(established 2048 bind 2048)
[17179571.184000] TIPC: Activated (version 1.6.1
compiled Sep 15 2006 19:32:28)
[17179571.196000] NET: Registered protocol family 30
[17179571.200000] TIPC: Started in single node mode
[17179571.204000] rtc-test rtc-test.0: setting the
system clock to 2006-09-15 19:53:10 (1158349990)
[17179571.716000] ADDRCONF(NETDEV_UP): bond0: link is
not ready
[17179571.720000] eth0: found phy 1, vendor 000818
part 0e
[17179571.728000] eth0: Link speed: 100BaseT FDX
[17179571.732000] eth1: found phy 1, vendor 000818
part 0e
[17179572.744000] Sending DHCP requests .,. OK
[17179578.444000] IP-Config: Got DHCP answer from
0.0.0.0, my address is 10.1.3.148
[17179578.496000] IP-Config: Complete:
[17179578.500000]       device=eth0, addr=10.1.3.148,
mask=255.255.255.0, gw=10.1.3.1,
[17179578.508000]      host=10.1.3.148,
domain=lightfleet, nis-domain=(none),
[17179578.512000]      bootserver=0.0.0.0,
rootserver=10.1.3.187, rootpath=
[17179578.520000] Looking up port of RPC 100003/2 on
10.1.3.187
[17179578.532000] Looking up port of RPC 100005/1 on
10.1.3.187
[17179578.552000] VFS: Mounted root (nfs filesystem).
[17179578.560000] Freeing unused kernel memory: 260k
freed


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
