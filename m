Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2004 02:11:38 +0000 (GMT)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:9176 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225316AbUCICLe>; Tue, 9 Mar 2004 02:11:34 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc13) with ESMTP
          id <20040309021126015006b3jje>
          (Authid: kumba12345);
          Tue, 9 Mar 2004 02:11:26 +0000
Message-ID: <404D28B1.4010608@gentoo.org>
Date: Mon, 08 Mar 2004 21:15:13 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de> <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de> <404D1909.1020005@gentoo.org> <20040309013841.GI16163@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20040309013841.GI16163@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:

> It looks like that pax patch makes the difference.
> 
> Speculation:
> With this large alignment, the load would overwrite the exception
> handlers at 0x80000000 if the firmware wouldn't recognize this area
> as already in use. Reducing the alignment to 4k may improve things.
> 
> Btw, an empty segment with no section assigned looks like a bug to me.
> 
> Btw2, converting the non-writable segment into a writeable one
> doesn't look like an improvement (but doesn't matter much).

Well, I re-generated my cross-compiler w/o the patch, doesn't seem to 
have affected much.

I'll strip the remaining patches out, and see what the outcome is 
(although the remaining patches have been in gentoo's binutils since 
2.13.* and haven't had issues).


--Kumba

-------------------------------------------------

# mips-unknown-linux-gnu-readelf --version
GNU readelf 2.15.90.0.1.1 20040303
Copyright 2004 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.



# mips-unknown-linux-gnu-readelf -l vmlinux

Elf file type is EXEC (Executable file)
Entry point 0x88144040
There are 2 program headers, starting at offset 52

Program Headers:
   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
   REGINFO        0x1573c0 0x881573c0 0x881573c0 0x00018 0x00018 R   0x4
   LOAD           0x000000 0x88000000 0x88000000 0x16d000 0x194400 RWE 
0x10000

  Section to Segment mapping:
   Segment Sections...
    00     .reginfo
    01     .text .fixup .kstrtab __ex_table __ksymtab .data.init_task 
.text.init .data.init .setup.init .initcall.init .data.cacheline_aligned 
.reginfo .data .bss



# mips-unknown-linux-gnu-readelf -S vmlinux
There are 23 section headers, starting at offset 0x19188c:

Section Headers:
   [Nr] Name              Type            Addr     Off    Size   ES Flg 
Lk Inf Al
   [ 0]                   NULL            00000000 000000 000000 00 
  0   0  0
   [ 1] .text             PROGBITS        88002000 002000 137790 00  AX 
  0   0 32
   [ 2] .fixup            PROGBITS        88139790 139790 00121c 00  AX 
  0   0  1
   [ 3] .kstrtab          PROGBITS        8813a9ac 13a9ac 004094 00   A 
  0   0  4
   [ 4] __ex_table        PROGBITS        8813ea40 13ea40 0016f8 00   A 
  0   0  4
   [ 5] __dbe_table       PROGBITS        88140138 140138 000000 00   A 
  0   0  1
   [ 6] __ksymtab         PROGBITS        88140138 140138 001e88 00   A 
  0   0  4
   [ 7] .data.init_task   PROGBITS        88142000 142000 002000 00  WA 
  0   0  8
   [ 8] .text.init        PROGBITS        88144000 144000 010bb4 00  AX 
  0   0  4
   [ 9] .data.init        PROGBITS        88154bb4 154bb4 000724 00  WA 
  0   0  4
   [10] .setup.init       PROGBITS        881552e0 1552e0 0000b8 00  WA 
  0   0  4
   [11] .initcall.init    PROGBITS        88155398 155398 00008c 00  WA 
  0   0  4
   [12] .data.cacheline_a PROGBITS        88156000 156000 0013c0 00  WA 
  0   0 32
   [13] .reginfo          MIPS_REGINFO    881573c0 1573c0 000018 18   A 
  0   0  4
   [14] .data             PROGBITS        88158000 158000 015000 00  WA 
  0   0 4096
   [15] .sbss             NOBITS          8816d000 16d000 000000 00 WAp 
  0   0  4
   [16] .bss              NOBITS          8816d000 16d000 027400 00  WA 
  0   0 32
   [17] .comment          PROGBITS        88194400 16d000 0052c6 00 
  0   0  1
   [18] .pdr              PROGBITS        00000000 1722c8 01f4e0 00 
  0   0  4
   [19] .mdebug.abi32     PROGBITS        00000000 1917a8 000000 00 
  0   0  1
   [20] .shstrtab         STRTAB          00000000 1917a8 0000e1 00 
  0   0  1
   [21] .symtab           SYMTAB          00000000 191c24 020520 10 
22 da1  4
   [22] .strtab           STRTAB          00000000 1b2144 021f71 00 
  0   0  1
Key to Flags:
   W (write), A (alloc), X (execute), M (merge), S (strings)
   I (info), L (link order), G (group), x (unknown)
   O (extra OS processing required) o (OS specific), p (processor specific)


-----------------------------


 >> boot -f 2425x1

Cannot load scsi(0)disk(4)rdisk(0)partition(8)/2425x1.
Text start 0x8000000, size 0x194400 doesn't fit in a FreeMemory area.
Unable to load 2425x1: ``2425x1'' is not a valid file to boot.



-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
