Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2005 10:07:12 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.192]:42692 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8224991AbVHJJGu> convert rfc822-to-8bit;
	Wed, 10 Aug 2005 10:06:50 +0100
Received: by wproxy.gmail.com with SMTP id 70so93623wra
        for <linux-mips@linux-mips.org>; Wed, 10 Aug 2005 02:10:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XDzDFzX3SYXNaiQRFi1L5GHlksmW5mHacxrQ4JKS2yYvnsYFx5OHPl3AI7sqclpHWVUf8/4ue1kMiDys9/hahbE4lMQ4aMmJFBviK1Btl+z8aUy8wgabhFYQSuITe2EcLAwp4ErqpYX/OYpcp/i0hH1t3P3nXqp5Jw0rrMi34PI=
Received: by 10.54.30.60 with SMTP id d60mr318301wrd;
        Wed, 10 Aug 2005 02:10:47 -0700 (PDT)
Received: by 10.54.114.15 with HTTP; Wed, 10 Aug 2005 02:10:47 -0700 (PDT)
Message-ID: <c5511aaf05081002102c439fc3@mail.gmail.com>
Date:	Wed, 10 Aug 2005 17:10:47 +0800
From:	light lu <mickylu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Kernel 2.4.21 on BCM4780
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <mickylu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mickylu@gmail.com
Precedence: bulk
X-list: linux-mips

Could anybody give me some advice on kernel 2.4.21 on BCM4780 porting?
 Thanks very much.

--Light


The console log is ,

CFE> boot -z -addr=0x80001000 -max=0x800000 -tftp 192.168.1.3:vmlinuz-2.4.21
Loader:raw Filesys:tftp Dev:eth0 File:192.168.1.3:vmlinuz-2.4.21 Options:(null)
Loading: .... 2232320 bytes read
Entry at 0x80001000
Closing network.
Starting program at 0x80001000
CPU revision is: 00029006
Primary instruction cache 16kB, physically tagged, 2-way, linesize 16 bytes.
Primary data cache 16kB 2-way, linesize 16 bytes.
Linux version 2.4.21 (lightlu@light.deb) (gcc version 3.0 20010422 (prerelease)5
BCM47XX ChipID = 0x4704, RevisionID = 8, Options = 0x2
Determined physical RAM map:
 memory: 02000000 @ 00000000 (usable)
User-defined physical RAM map:
 memory: 01800000 @ 00000000 (usable)
On node 0 totalpages: 6144
zone(0): 6144 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/mtdblock5 noinitrd console=ttyS0,115200 mem=24M
CPU: BCM4704 rev 8 at 264 MHz
Calibrating delay loop... 263.78 BogoMIPS
Memory: 21868k/24576k available (1961k kernel code, 2708k reserved, 120k data, )
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
PCI: Fixing up bus 0
PCI: Fixing up bridge
PCI: Fixing up bus 1
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Reserved instruction in kernel code in traps.c::do_ri, line 652:
$0 : 00000000 8027b000 8000c240 80210974 8027a000 ba2e8ba3 81006d14 c0000000
$8 : c0000000 8022b160 ffffffe0 00000018 8027424c fffffffb 0000000a 4e4d4c4b
$16: 8027a000 80205c00 80208000 00000000 00000020 0000c000 00000010 80205c00
$24: 00000008 00000001                   80268000 80269eb8 00000000 80026030
Hi : fffff892
Lo : 0000027a
epc  : 8000c244    Not tainted
Status: 1000fc03
Cause : 00000028
Process swapper (pid: 1, stackpage=80268000)
Stack:    8000178c 8002ef3c 00000000 fffffff4 c000c000 802012b0 8000178c
 00000000 8002f1ec 80041700 00000020 00000010 00000010 00000010 c0000000
 80205c00 c000c000 fffffff4 003fffff 8002f9c8 c0000000 8001294c 80235200
 802012b0 8000178c 43464531 00000020 00000010 00000010 00000010 00000000
 800642bc 00000020 000001f2 000007df 00000010 000007df 801f6198 802011e8
 801f6914 ...
Call Trace:   [<8000178c>] [<8002ef3c>] [<8000178c>] [<8002f1ec>] [<80041700>]
 [<8002f9c8>] [<8001294c>] [<8000178c>] [<800642bc>] [<801b7d54>] [<800238a4>]
 [<801d9e84>] [<8000178c>] [<8000179c>] [<80003274>] [<8001294c>] [<80003264>]
 [<8001453c>] [<800763f0>] [<80036a58>] [<800774c8>] [<80077794>]

Code: 00000000  00000000  24811000 <bc8d0000> ac800000  ac800004  ac800008  ac8
Kernel panic: Attempted to kill init!



ksymoops 2.4.11 on i686 2.6.8-1-686.  Options used
     -v vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.8-1-686/ (default)
     -m System.map (specified)
     -t elf32-littlemips -a mips

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
$0 : 00000000 8027b000 8000c240 80210974 8027a000 ba2e8ba3 81006d14 c0000000
$8 : c0000000 8022b160 ffffffe0 00000018 8027424c fffffffb 0000000a 4e4d4c4b
$16: 8027a000 80205c00 80208000 00000000 00000020 0000c000 00000010 80205c00
$24: 00000008 00000001                   80268000 80269eb8 00000000 80026030
Hi : fffff892
Lo : 0000027a
epc  : 8000c244    Not tainted
Status: 1000fc03
Cause : 00000028
Process swapper (pid: 1, stackpage=80268000)
Stack:    8000178c 8002ef3c 00000000 fffffff4 c000c000 802012b0 8000178c
 00000000 8002f1ec 80041700 00000020 00000010 00000010 00000010 c0000000
 80205c00 c000c000 fffffff4 003fffff 8002f9c8 c0000000 8001294c 80235200
 802012b0 8000178c 43464531 00000020 00000010 00000010 00000010 00000000
 800642bc 00000020 000001f2 000007df 00000010 000007df 801f6198 802011e8
 801f6914 ...
Call Trace:   [<8000178c>] [<8002ef3c>] [<8000178c>] [<8002f1ec>] [<80041700>]
 [<8002f9c8>] [<8001294c>] [<8000178c>] [<800642bc>] [<801b7d54>] [<800238a4>]
 [<801d9e84>] [<8000178c>] [<8000179c>] [<80003274>] [<8001294c>] [<80003264>]
 [<8001453c>] [<800763f0>] [<80036a58>] [<800774c8>] [<80077794>]
Code: 00000000  00000000  24811000 <bc8d0000> ac800000  ac800004  ac800008  ac8
Error (Oops_code_values): invalid value 0xac8 in Code line, must be 2,
4, 8 or 16 digits, value ignored


>>$2; 8000c240 <r4k_clear_page32_d16+0/3c>
>>$3; 80210974 <contig_page_data+0/33c>
>>$9; 8022b160 <vmlist+0/10>
>>$17; 80205c00 <swapper_pg_dir+c00/1000>
>>$18; 80208000 <invalid_pte_table+0/1000>
>>$23; 80205c00 <swapper_pg_dir+c00/1000>
>>$28; 80268000 <_end+7f50/????>
>>$31; 80026030 <pte_alloc+cc/114>

>>PC;  8000c244 <r4k_clear_page32_d16+4/3c>   <=====

Trace; 8000178c <init+0/194>
Trace; 8002ef3c <get_vm_area+24/104>
Trace; 8000178c <init+0/194>
Trace; 8002f1ec <__vmalloc+130/2b4>
Trace; 80041700 <get_sb_nodev+30/e4>
Trace; 8002f9c8 <kmem_cache_create+e0/4c0>
Trace; 8001294c <kernel_thread+48/68>
Trace; 8000178c <init+0/194>
Trace; 800642bc <cramfs_uncompress_init+64/a8>
Trace; 801b7d54 <tvecs+7a4/9e0>
Trace; 800238a4 <start_context_thread+30/4c>
Trace; 801d9e84 <ohci_pci_ids+4bc8/5ad4>
Trace; 8000178c <init+0/194>
Trace; 8000179c <init+10/194>
Trace; 80003274 <arch_kernel_thread+44/74>
Trace; 8001294c <kernel_thread+48/68>
Trace; 80003264 <arch_kernel_thread+34/74>
Trace; 8001453c <release_console_sem+84/178>
Trace; 800763f0 <devfs_dealloc_devnum+14c/1c8>
Trace; 80036a58 <badness+98/110>
Trace; 800774c8 <parse_options+ec/61c>
Trace; 80077794 <parse_options+3b8/61c>

Code;  8000c238 <mips32_flush_cache_all_pc+c8/d0>
00000000 <_PC>:
Code;  8000c240 <r4k_clear_page32_d16+0/3c>
   8:   24811000  addiu   at,a0,4096
Code;  8000c244 <r4k_clear_page32_d16+4/3c>   <=====
   c:   bc8d0000  0xbc8d0000   <=====
Code;  8000c248 <r4k_clear_page32_d16+8/3c>
  10:   ac800000  sw      zero,0(a0)
Code;  8000c24c <r4k_clear_page32_d16+c/3c>
  14:   ac800004  sw      zero,4(a0)
Code;  8000c250 <r4k_clear_page32_d16+10/3c>
  18:   ac800008  sw      zero,8(a0)
