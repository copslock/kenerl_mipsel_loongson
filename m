Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5BEoQW32060
	for linux-mips-outgoing; Mon, 11 Jun 2001 07:50:26 -0700
Received: from bunny.shuttle.de (bunny.shuttle.de [193.174.247.132])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5BEoKV32041;
	Mon, 11 Jun 2001 07:50:20 -0700
Received: by bunny.shuttle.de (Postfix, from userid 112)
	id 950124AAAA; Mon, 11 Jun 2001 16:50:19 +0200 (CEST)
Date: Mon, 11 Jun 2001 16:50:19 +0200
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays)
Message-ID: <20010611165019.A17263@bunny.shuttle.de>
References: <20010611000359.A25631@paradigm.rfc822.org> <20010611064249.A15039@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010611064249.A15039@bacchus.dhis.org>
User-Agent: Mutt/1.3.18i
From: borenius@shuttle.de (Raoul Borenius)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

On Mon, Jun 11, 2001 at 06:42:49AM +0200, Ralf Baechle wrote:
> On Mon, Jun 11, 2001 at 12:03:59AM +0200, Florian Lohoff wrote:
> 
> > Hi,
> > i just tried to boot an Indy of mine with the current cvs (from this
> > morning) and it crashes 
> 
> > No modules in ksyms, skipping objects
> > kernel BUG at semaphore.c:235!
> > Unable to handle kernel paging request at virtual address 00000000, epc == 8800f02c, ra == 8800f02c
> 
> This is a known and yet unresolved problem.  Yet I'm surprised - so far
> I've only seen this problem on mips64.
> 
>   Ralf

Just FYI: the same happens on our Indy, see trace.txt and boot.txt.

Hope it helps...

Regards

Raoul

 ---------------------------------------------------------------------
 Raoul Gunnar Borenius		Deutsches Forschungsnetz e.V.
 WiNShuttle			Lindenspürstr.32, 70176 Stuttgart
 Phone  : +49 711 63314-206	FAX: +49 711 63314-133
 E-Mail : borenius@shuttle.de	http://www.shuttle.de
 ---------------------------------------------------------------------


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="trace.txt"

ksymoops 2.4.1 on mips 2.4.3-cvs20010611.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3-cvs20010611/ (default)
     -m /boot/System.map-2.4.3-cvs20010611 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Starting periodic command scheduler: cronkernel BUG at semaphore.c:235!
Unable to handle kernel paging request at virtual address 00000000, epc == 8800eed0, ra == 8800eed0
$0 : 00000000 1000fc00 0000001f 00000001
$4 : 00000017 0000001f 8f626000 886603a0
$8 : 000d1b70 0000003c 00079c00 00000000
$12: 88157570 fffffff9 ffffffff 8f627ce2
$16: 8866059c 00000000 8f627f00 886605a4
$20: 8f627f04 8f627f00 8f627f04 00000009
$24: 00000002 0000000a
$28: 8f626000 8f627dd0 7fff7bb0 8800eed0
epc   : 8800eed0
Using defaults from ksymoops -t elf32-tradbigmips -a mips:3000
Status: 1000fc03
Cause : 0000000c
Process start-stop-daem (pid: 129, stackpage=8f626000)
Stack: 881080e0 881081c4 000000eb 00000002 8866059c 8f626000 8800eb5c 8806854c
       00000000 8ff862e0 88067590 00000000 00000000 8f626000 886605a8 886605a8
       fffffffe 88660580 8f627f00 8866059c 880672ac 880679c4 8f8deca0 8f9ad8a0
       8f627f00 8f9ada20 00000000 8f9ada20 8f627f00 8814200d 8f627e98 8f627f00
       88067e28 88067dc4 8f9ada20 88060364 8f627e98 8f627f00 8f8deca0 8f8deca0
       8f9ada20 ...
Call Trace: [<881080e0>] [<881081c4>] [<8800eb5c>] [<8806854c>] [<88067590>] [<880672ac>] [<880679c4>] [<88067e28>] [<88067dc4>] [<88060364>] [<88053da4>] [<88054488>] [<88053070>] [<8804fdf8>] [<8804fe50>] [<8800fca8>] [<8800fca8>]
Code: 24a581c4  0e007c56  240600eb <ae200000> 26040014  24050003  0e006f4a  24060001  8fbf0018 

>>RA;  8800eed0 <__rwsem_wake+98/c8>
>>PC;  8800eed0 <__rwsem_wake+98/c8>   <=====
Trace; 881080e0 <prom_getsysid+1638/2414>
Trace; 881081c4 <prom_getsysid+171c/2414>
Trace; 8800eb5c <__down_read+84/194>
Trace; 8806854c <proc_pid_make_inode+24/110>
Trace; 88067590 <proc_root_link+c0/e0>
Trace; 880672ac <proc_exe_link+78/1bc>
Trace; 880679c4 <proc_check_root+134/194>
Trace; 88067e28 <proc_pid_follow_link+88/b0>
Trace; 88067dc4 <proc_pid_follow_link+24/b0>
Trace; 88060364 <update_atime+64/70>
Trace; 88053da4 <path_walk+88c/9e8>
Trace; 88054488 <__user_walk+5c/90>
Trace; 88053070 <path_release+18/6c>
Trace; 8804fdf8 <sys_newstat+20/90>
Trace; 8804fe50 <sys_newstat+78/90>
Trace; 8800fca8 <stack_done+1c/38>
Trace; 8800fca8 <stack_done+1c/38>
Code;  8800eec4 <__rwsem_wake+8c/c8>
0000000000000000 <_PC>:
Code;  8800eec4 <__rwsem_wake+8c/c8>
   0:   24a581c4  addiu   $a1,$a1,-32316
Code;  8800eec8 <__rwsem_wake+90/c8>
   4:   0e007c56  jal     801f158 <_PC+0x801f158> 9002e01c <END_OF_CODE+7eb359c/????>
Code;  8800eecc <__rwsem_wake+94/c8>
   8:   240600eb  li      $a2,235
Code;  8800eed0 <__rwsem_wake+98/c8>   <=====
   c:   ae200000  sw      $zero,0($s1)   <=====
Code;  8800eed4 <__rwsem_wake+9c/c8>
  10:   26040014  addiu   $a0,$s0,20
Code;  8800eed8 <__rwsem_wake+a0/c8>
  14:   24050003  li      $a1,3
Code;  8800eedc <__rwsem_wake+a4/c8>
  18:   0e006f4a  jal     801bd28 <_PC+0x801bd28> 9002abec <END_OF_CODE+7eb016c/????>
Code;  8800eee0 <__rwsem_wake+a8/c8>
  1c:   24060001  li      $a2,1
Code;  8800eee4 <__rwsem_wake+ac/c8>
  20:   8fbf0018  lw      $ra,24($sp)


2 warnings issued.  Results may not be reliable.

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="boot.txt"

>> printenv
SystemPartition=scsi(0)disk(1)rdisk(0)partition(8)
OSLoadPartition=/dev/sda1                         
OSLoader=vmlinux         
OSLoadFilename=/vmlinux
AutoLoad=Yes           
TimeZone=PST8PDT
console=d       
diskless=0
dbaud=9600
volume=2  
sgilogo=y
autopower=y
eaddr=08:00:69:08:4f:b2
ConsoleOut=serial(0)   
ConsoleIn=serial(0) 
cpufreq=100        
>> boot    
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE 
Loading R4000 MMU routines.
CPU revision is: 00002020
Primary instruction cache 16kb, linesize 32 bytes.
Primary data cache 16kb, linesize 32 bytes.
Linux version 2.4.3-cvs20010611 (raoul@bunny) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #12 Mon Jun 11 16:22:41 CEST 2001
MC: SGI memory controller Revision 3
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 00001000 @ 00001000 (reserved)
 memory: 00179000 @ 08002000 (reserved)
 memory: 005c5000 @ 0817b000 (usable)
 memory: 000c0000 @ 08740000 (ROM data)
 memory: 07800000 @ 08800000 (usable)
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda1
Calibrating system timer... 500000 [100.00 MHz CPU]
Console: colour dummy device 80x25
zs0: console input
Console: ttyS0 (Zilog8530)
Calibrating delay loop... 99.73 BogoMIPS
Memory: 124408k/128788k available (1231k kernel code, 4380k reserved, 77k data, 52k init)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
initialize_kbd: Keyboard reset failed, no ACK
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
DS1286 Real Time Clock Driver v1.0
streamable misc devices registered (keyb:150, gfx:148)
block: queued sectors max/low 82378kB/27459kB, 256 slots per queue
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:08:4f:b2 
SCSI subsystem driver Revision: 1.00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Jun 11 2001 at 16:24:01
scsi0 : SGI WD93
 sending SDTR 0103013f0csync_xfer=2c  Vendor: CONNER    Model: CFP2105S  2.14GB  Rev: 2B4B
  Type:   Direct-Access                      ANSI SCSI revision: 02
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: IBMDSAS-3540      Rev: S47K
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 2, lun 0
SCSI device sda: 4194304 512-byte hdwr sectors (2147 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
SCSI device sdb: 1070496 512-byte hdwr sectors (548 MB)
 sdb: sdb1 sdb2 sdb3
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9830 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9838 (irq = 21) is a Zilog8530
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing prom memory: 768kb freed
Freeing unused kernel memory: 52k freed
INIT: version 2.78 booting
Activating swap...
Adding Swap: 138992k swap-space (priority -1)
Checking root file system...
Parallelizing fsck version 1.20 (25-May-2001)
/dev/sda1: clean, 28429/243840 files, 138949/487542 blocks
Checking all file systems...
Parallelizing fsck version 1.20 (25-May-2001)
Setting kernel variables.
Mounting local filesystems...
tmpfs on /dev/shm type shm (rw)
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces: done.

Setting the System Clock using the Hardware Clock as reference...
System Clock set. Local time: Mon Jun 11 16:31:33 CEST 2001

Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... done.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting internet superserver: inetd.
Starting OpenBSD Secure Shell server: sshd.
Starting NTP server: ntpd.
Starting periodic command scheduler: cronkernel BUG at semaphore.c:235!
Unable to handle kernel paging request at virtual address 00000000, epc == 8800eed0, ra == 8800eed0
Oops in fault.c:do_page_fault, line 172:
$0 : 00000000 1000fc00 0000001f 00000001
$4 : 00000017 0000001f 8f626000 886603a0
$8 : 000d1b70 0000003c 00079c00 00000000
$12: 88157570 fffffff9 ffffffff 8f627ce2
$16: 8866059c 00000000 8f627f00 886605a4
$20: 8f627f04 8f627f00 8f627f04 00000009
$24: 00000002 0000000a
$28: 8f626000 8f627dd0 7fff7bb0 8800eed0
epc   : 8800eed0
Status: 1000fc03
Cause : 0000000c
Process start-stop-daem (pid: 129, stackpage=8f626000)
Stack: 881080e0 881081c4 000000eb 00000002 8866059c 8f626000 8800eb5c 8806854c
       00000000 8ff862e0 88067590 00000000 00000000 8f626000 886605a8 886605a8
       fffffffe 88660580 8f627f00 8866059c 880672ac 880679c4 8f8deca0 8f9ad8a0
       8f627f00 8f9ada20 00000000 8f9ada20 8f627f00 8814200d 8f627e98 8f627f00
       88067e28 88067dc4 8f9ada20 88060364 8f627e98 8f627f00 8f8deca0 8f8deca0
       8f9ada20 ...
Call Trace: [<881080e0>] [<881081c4>] [<8800eb5c>] [<8806854c>] [<88067590>] [<880672ac>] [<880679c4>] [<88067e28>] [<88067dc4>] [<88060364>] [<88053da4>] [<88054488>] [<88053070>] [<8804fdf8>] [<8804fe50>] [<8800fca8>] [<8800fca8>]
Code: 24a581c4  0e007c56  240600eb <ae200000> 26040014  24050003  0e006f4a  24060001  8fbf0018 

--2fHTh5uZTiUOsy+g--
