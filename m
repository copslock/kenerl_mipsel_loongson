Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3CDBvP06017
	for linux-mips-outgoing; Thu, 12 Apr 2001 06:11:57 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3CDBtM06012
	for <linux-mips@oss.sgi.com>; Thu, 12 Apr 2001 06:11:56 -0700
Received: from cotw.com (ptecdev3.inter.net [192.168.10.5])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id IAA07413
	for <linux-mips@oss.sgi.com>; Thu, 12 Apr 2001 08:11:39 -0500
Message-ID: <3AD5B832.8F0C71B0@cotw.com>
Date: Thu, 12 Apr 2001 07:14:11 -0700
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: objdump error caused by .init section
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

It appears that objdump does not know how to deal with the offset
associated with the .init section.

The older set of tools I used with my 2.4.0 kernel was able to deal with
it.

Scott

-----------------------------
head ld.script
OUTPUT_FORMAT("elf32-tradlittlemips")
OUTPUT_ARCH(mips)
ENTRY(kernel_entry)
SECTIONS
{
  /* Read-only sections, merged into text segment: */
  . = 0x80000000;
  .init          : { *(.init)  } =0
  .text      :
  {

---------------------------------
mipsel-linux-objdump -S vmlinux | less

fffffff800005b0
<kernel_entry>:
<------ Wrong address (Off by 0x1000)
ffffffff800005b0:       3c1c8000        lui     $gp,0x8000
ffffffff800005b4:       279c6000        addiu   $gp,$gp,24576
ffffffff800005b8:       27881fe0        addiu   $t0,$gp,8160
ffffffff800005bc:       251dfff0        addiu   $sp,$t0,-16
ffffffff800005c0:       3c01801d        lui     $at,0x801d
ffffffff800005c4:       ac286338        sw      $t0,25400($at)
ffffffff800005c8:       3c088020        lui     $t0,0x8020
ffffffff800005cc:       2508c004        addiu   $t0,$t0,-16380
ffffffff800005d0:       ad000000        sw      $zero,0($t0)
ffffffff800005d4:       3c098025        lui     $t1,0x8025
ffffffff800005d8:       2529c8ac        addiu   $t1,$t1,-14164
ffffffff800005dc:       25080004        addiu   $t0,$t0,4
ffffffff800005e0:       1509fffe        bne     $t0,$t1,ffffffff800005dc
<kernel_entry+0x2c>
ffffffff800005e4:       ad000000        sw      $zero,0($t0)
ffffffff800005e8:       0c068da5        jal     ffffffff801a3694
<init_arch>
        ...

---------------------------
hexdump of vmlinux

0015b0 8000 3c1c 6000 279c 1fe0 2788 fff0 251d
<---- Ok, Where is the upper bits ?
00015c0 801d 3c01 6338 ac28 8020 3c08 c004 2508
00015d0 0000 ad00 8025 3c09 c8ac 2529 0004 2508
00015e0 fffe 1509 0000 ad00 8da5 0c06 0000 0000
00015f0 0000 0000 0000 0000 0000 0000 0000 0000
*



----------------------------------
mipsel-linux-readelf -S vmlinux | less

There are 22 section headers, starting at offset 0x2f15f8:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg
Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00
0   0  0
  [ 1] .text             PROGBITS        80000000 001000 1968f0 00  AX
0   0 8192            <--- Look right
  [ 2] .fixup            PROGBITS        801968f0 1978f0 001244 00  AX
0   0  1
  [ 3] .kstrtab          PROGBITS        80197b34 198b34 006338 00   A
0   0  4
  [ 4] __ex_table        PROGBITS        8019de70 19ee70 002008 00   A
0   0  4
  [ 5] __dbe_table       PROGBITS        8019fe78 1a0e78 000000 00   A
0   0  1
  [ 6] __ksymtab         PROGBITS        8019fe78 1a0e78 001de0 00   A
0   0  4
  [ 7] .text.init        PROGBITS        801a2000 1a3000 0129bc 00  AX
0   0  4
  [ 8] .data.init        PROGBITS        801b49bc 1b59bc 021178 00  WA
0   0  4
  [ 9] .setup.init       PROGBITS        801d5b40 1d6b40 0000a0 00  WA
0   0  4
  [10] .initcall.init    PROGBITS        801d5be0 1d6be0 00005c 00  WA
0   0  4
  [11] .data.cacheline_a PROGBITS        801d6000 1d7000 000260 00  WA
0   0 32
  [12] .reginfo          MIPS_REGINFO    801d6260 1d7260 000018 18   A
0   0  4
  [13] .data             PROGBITS        801d6280 1d7280 025d80 00  WA
0   0 16
  [14] .ctors            PROGBITS        801fc000 1fd000 000004 00  WA
0   0  4
  [15] .sbss             NOBITS          801fc008 1fd008 0003a0 00 WAp
0   0  8
  [16] .bss              NOBITS          801fc3b0 1fd010 050500 00  WA
0   0 16
  [17] .mdebug           MIPS_DEBUG      8024c8b0 1fd010 0f271c 01
0   0  4
  [18] .note             NOTE            803568d4 2ef72c 001e00 00
0   0  1
  [19] .shstrtab         STRTAB          00000000 2f152c 0000ca 00
0   0  1
  [20] .symtab           SYMTAB          00000000 2f1968 03cb70 10
21 2590  4
  [21] .strtab           STRTAB          00000000 32e4d8 04033c 00
0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor
specific)


-----------------

A dump from my "boot loader"

800015b0 3c1c8000 lui     gp,0x8000                         #
32768                            <--- Looks right
800015b4 279c6000 addiu   gp,gp,0x6000                      # 24576
800015b8 27881fe0 addiu   t0,gp,0x1fe0                      # 8160
800015bc 251dfff0 addiu   sp,t0,0xfff0                      # -16
800015c0 3c01801d lui     at,0x801d                         # 32797
800015c4 ac28c338 sw      t0,-15560(at)                     # 0xffffc338

800015c8 3c08801f lui     t0,0x801f                         # 32799
800015cc 25081764 addiu   t0,t0,0x1764                      # 5988
800015d0 ad000000 sw      zero,0(t0)
800015d4 3c098024 lui     t1,0x8024                         # 32804
800015d8 2529200c addiu   t1,t1,0x200c                      # 8204
800015dc 25080004 addiu   t0,t0,0x4
800015e0 1509fffe bne     t0,t1,800015dc                    # 0x800015dc

800015e4 ad000000 sw      zero,0(t0)
800015e8 0c0665a5 jal     80199694                          #
0x80199694          8
00015ec 00000000 nop
800015f0 00000000 nop
800015f4 00000000 nop
