Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5S835203754
	for linux-mips-outgoing; Thu, 28 Jun 2001 01:03:05 -0700
Received: from dsic.co.kr ([210.221.126.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5S82wV03736
	for <linux-mips@oss.sgi.com>; Thu, 28 Jun 2001 01:02:59 -0700
Received: from astonlinux.com [192.168.2.173] by dsic.co.kr [210.221.126.1]
	with SMTP (MDaemon.v3.5.6.R)
	for <linux-mips@oss.sgi.com>; Thu, 28 Jun 2001 17:01:05 +0900
Message-ID: <3B3B9C29.6898DC59@astonlinux.com>
Date: Thu, 28 Jun 2001 17:05:45 -0400
From: =?EUC-KR?B?sK29xbHU?= <cosmos@astonlinux.com>
Organization: astonlinux
X-Mailer: Mozilla 4.75 [ko] (X11; U; Linux 2.2.16-21hl i686)
X-Accept-Language: ko
MIME-Version: 1.0
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Help me.
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 8bit
X-MDRemoteIP: 192.168.2.173
X-Return-Path: cosmos@astonlinux.com
X-MDaemon-Deliver-To: linux-mips@oss.sgi.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, my name is Shinkyu Kang.

I am trying to port a linux 2.4 to R3000 based system (LSI LOGIC
SC2000).
SC2000 have caches. one is Two-way set associative or direct mapped
Instruction cache (16K) and another is Direct-mapped data cache(8K).

The following show the contents of each RAM(data and tag) cache.

- I-Cache Set 0 or D-Cache Data Ram
31-24(bit) : byte 3
23-16 : byte 2
15-8   : byte 1
7-0 : byte 0

- I-Cache Set 0 or D-Cache Tag Ram
23-5 : Cache Tag ID
4 : Cache Lock bit
3 : High word valid bit
2 : Third word valid bit
1 :  Second word valid bit
0 : Low word valid bit

- I-Cache Set 1 Data Ram
31-0 : Instruction

- I-Cache Set 1 Tag Ram
22-4 : Cache Tag ID
3 : High word valid bit
2 : Third word valid bit
1 : Second word valid bit
0 : Low word valid bit


SC2000 have a BBCC(Basic BIU and Cache Controller) Configuration
Register like following :
31(bit) : MMU enable -> setting this bit enables the full memory
management unit(MMU).
30 : Write buffer enable -> setting this bit enables the write buffer.
29-14 : reserved
13: Data error - the BBCC sets this bit when a bus error ouccurs duringa
data load/store. Clearing this bit acknowledges the error.
12-10 : Page Size -> These bits inform the BBCC of the page size so that
the BBCC can determine if stores are burst write transactions; in
otherwords, if they are consecutive stores to the same page.
---------------
    ps        page size
   0b000    16 words
   0b001    32 words
   0b010    64 words
   0b011    128 words
   0b100    256 words
   0b101    512 words
   0b110    1024 words
   0b111    2048 words
----------------

9-8 : Cache Mode -> These bits determine the Cache mode.
    CM        Cache Mode
------------------
  0b00        Nomal
  0b01        I-Cache Software Test (Data Ram)
  0b10        I-Cache Software Test(Tag Ram)
  0b11        D-Cache Software Test(Tag Ram)
-------------------

7 : Read Priority Enable  -> Setting this bit causes the BBCC to assign
higher priority to loads over stores, whenever possible.
6-5 : D-Cache Block Refill Size  -> These bits specify the D-cache block

refill size
    DRS     Refill Size
-------------------
   0b00       1 word
   0b01       2 words
   0b10       4 words
   0b11       8 words
-------------------

4 : D-Cache Enable  -> setting this bit enable the D-cache

3-2 : I-Cache Block Refill Size -> these bits specifiy the I-cache block

refill size.
  -------------------
   0b00       1 word
   0b01       2 words
   0b10       4 words
   0b11       8 words
-------------------

1 : I-Cache Set 1 Enable -> setting this bit enables the I-cache Set 1.

0 : I-Cache Enable -> setting this bit enables the I-cache.
----------------------------------------------------------------------------




I modify the r2300.c and add a new file (lsi-cache.S) like following :

-------------------r2300.c-------------------------------
static void r3k_flush_icache_range(unsigned long start, unsigned long
end)
{
         flush_icache();
}

void __init ld_mmu_r23000(void)
{
        unsigned long config;

        printk("CPU revision is: %08x\n",
read_32bit_cp0_register(CP0_PRID));

        _clear_page = r3k_clear_page;
        _copy_page = r3k_copy_page;

        r3k_probe_cache();

        _flush_cache_all = r3k_flush_cache_all;
        ___flush_cache_all = r3k_flush_cache_all;
        _flush_cache_mm = r3k_flush_cache_mm;
        _flush_cache_range = r3k_flush_cache_range;
        _flush_cache_page = r3k_flush_cache_page;
        _flush_cache_sigtramp = r3k_flush_cache_sigtramp;
        _flush_page_to_ram = r3k_flush_page_to_ram;
        _flush_icache_page = r3k_flush_icache_page;
        _flush_icache_range = r3k_flush_icache_range;

        _dma_cache_wback_inv = r3k_dma_cache_wback_inv;

        printk("Primary instruction cache %dkb, linesize %d bytes\n",
                (int) (icache_size >> 10), (int) icache_lsize);
        printk("Primary data cache %dkb, linesize %d bytes\n",
                (int) (dcache_size >> 10), (int) dcache_lsize);

        flush_tlb_all();
}
---------------lsi-cache.S--------------------------------

/* void flush_icache(void) */
LEAF(flush_icache)
        .set    noreorder

        la      a3, icache_size     # 8Kbyte
        lw      t4, 0(a3)

        mfc0    t7, CP0_STATUS          # save SR
        nop
        nop

        and     t0, t7, ~ST0_IEC        # disable interrupts
        mtc0    t0, CP0_STATUS
        nop
        nop

        li      t3, CBSYS             # BBCC configuration register
        lw      t8, 0(t3)               # save config. register
        nop

        li      t0, KSEG0
        or      t4, t4, t0              # end of I-cache

        move    t5, t0

2:        la      t0, 3f                  # switch to Kseg1
        or      t0, KSEG1
        jr      t0
        nop

#
# flush I-cache set 0
#
3:
        li      t0, (CFG_DCEN | CFG_ICEN)
        or      t0, CFG_CMODE_ITEST     # I-cache set1 enable
                                        # D-cache enable, I-cache set0
enable
                                        # I-cache software test
        sw      t0, 0(t3)
        lw      zero, 0(t3)
        addi    zero, zero, 1

        move    t0, t5
4:      sw      zero, (t0)
        nop
        lw      zero, (t0)
        addu    t0, t6
        bltu    t0, t4, 4b
        nop

#
# flush I-cache set 1
#
        li      t0, (CFG_DCEN | CFG_ICEN | CFG_IS1EN)
        or      t0, CFG_CMODE_ITEST     # I-cache set1 enable
                                        # D-cache enable, I-cache set0
enable
                                        # I-cache software test
        sw      t0, 0(t3)
        lw      zero, 0(t3)
        addi    zero, zero, 1

        move    t0, t5
5:      sw      zero, (t0)
        nop
        lw      zero, (t0)
        addu    t0, t6
        bltu    t0, t4, 5b
#
# restore status and config. register
#
        sw      t8, 0(t3)               # restore config. register
        lw      zero, 0(t3)
        addi    zero, zero, 1

        mtc0    t7, CP0_STATUS          # restore SR
        nop
        nop

        j       ra
        nop

        .set    reorder
END(flush_icache)
        nop
-----------------------------------------------------------------------

The default setting of CBSYS register is 0xC0000013 (MMU on, Write
buffer on, I, D-Cache on, I cache set 1 on)

-----Question.------------
When I turn off I, D-cache, bash or sash is doing well.
but when I turn on the cache, kernel die during sash or bash is up.

1. Is there more file to modified in kernel ?

2.  Here is a booting message when caches are off.

Starting kernel ...
command line: root=/dev/ram
Loading R[23]000 MMU routines.
CPU Revision Number is: 00002597
Primary instruction cache 8kb, linesize 16 bytes
Primary data cache 8kb, linesize 16 bytes
Linux version 2.4.3 (root@localhost.localdomain) (gcc version 3.0
20010422 (prerelease)) #442 목 6월 28 16 :42:17 EDT 2001
Determined physical RAM map:
 memory: 01000000 @ 00000000 (usable)
Initial ramdisk at: 0x800f6000 (2214364 bytes)
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
sc2000 timer init...
Calibrating delay loop... 6.63 BogoMIPS
Memory: 12836k/16384k available (859k kernel code, 3548k reserved, 2226k
data, 56k init)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
initialize_kbd: Keyboard failed self test
block: queued sectors max/low 8456kB/2818kB, 64 slots per queue
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 2162k freed
loop: loaded (max 8 devices)
Serial driver version 1.00 (2001-02-27)
ttyS00 at 0x0000 (irq = 0) is a LSI UART
VFS: Mounted root (ext2 filesystem).
Freeing prom memory: 0kb freed
Freeing unused kernel memory: 56k freed
<load_elf_binary> start
<load_elf_binary> padzero start
<load_elf_binary> new_pc : 400150, new_sp : 7fff7f80
<do_execve> end
<sys_execve> end
Algorithmics/MIPS FPU Emulator v1.4
Stand-alone shell (version 3.4)
>
----------------------------------------------
Here is a booting message when cache on.

Starting kernel ...
command line: root=/dev/ram
Loading R[23]000 MMU routines.
CPU Revision Number is: 00002597
Primary instruction cache 8kb, linesize 16 bytes
Primary data cache 8kb, linesize 16 bytes
Linux version 2.4.3 (root@localhost.localdomain) (gcc version 3.0
20010422 (prerelease)) #442 목 6월 28 16
:42:17 EDT 2001
Determined physical RAM map:
 memory: 01000000 @ 00000000 (usable)
Initial ramdisk at: 0x800f6000 (2214364 bytes)
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
sc2000 timer init...
Calibrating delay loop... 107.72 BogoMIPS
Memory: 12836k/16384k available (859k kernel code, 3548k reserved, 2226k
data, 56k init)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
initialize_kbd: Keyboard failed self test
block: queued sectors max/low 8456kB/2818kB, 64 slots per queue
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 2162k freed
loop: loaded (max 8 devices)
Serial driver version 1.00 (2001-02-27)
ttyS00 at 0x0000 (irq = 0) is a LSI UART
VFS: Mounted root (ext2 filesystem).
Freeing prom memory: 0kb freed
Freeing unused kernel memory: 56k freed
<load_elf_binary> start
<load_elf_binary> padzero start
<load_elf_binary> new_pc : 400150, new_sp : 7fff7f80
-----------------------------------------------------------------
Please tell me what can I do?


-----------------------------------------------------------------
Best Regards
Shinkyu.
