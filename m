Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2004 06:04:06 +0000 (GMT)
Received: from sccrmhc13.comcast.net ([IPv6:::ffff:204.127.202.64]:30870 "EHLO
	sccrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225198AbUCIGEF>; Tue, 9 Mar 2004 06:04:05 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc13) with ESMTP
          id <200403090603580160060e0fe>
          (Authid: kumba12345);
          Tue, 9 Mar 2004 06:03:58 +0000
Message-ID: <404D5F32.8020507@gentoo.org>
Date: Tue, 09 Mar 2004 01:07:46 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de> <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de> <404D1909.1020005@gentoo.org> <20040309013841.GI16163@rembrandt.csv.ica.uni-stuttgart.de> <404D28B1.4010608@gentoo.org> <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:

> Well, then the effects I wrote about were not caused by that patch
> but by a broken linker. Re-doing the final link with the old linker
> should be enough to prove that.
> 
>>From the different alignment, this _might_ be related to Maciej's
> binutils patch for PAGE_SIZE != 4k.
> http://sources.redhat.com/ml/binutils/2003-12/msg00380.html

This patch looks to be the culprit.  Removing it from 
binutils-2.15.90.0.1.1 source and rebuilding my cross-compiler creates a 
bootable kernel (2.4.25).  I also noticed it changed the output of 
'readelf -l vmlinux' so that there is a second 'LOAD' program header. 
The PaX patch doesn't make a bit of difference, and I've test booted 
kernels built without Maciej's patch, including and excluding the PaX patch.

In the readelf -l <target> snippets below, one was built with Maciej's 
patch, one without, and the one without is the one that booted on my Indy.


With:
Elf file type is EXEC (Executable file)
Entry point 0x88144040
There are 3 program headers, starting at offset 52

Program Headers:
   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
   REGINFO        0x1573c0 0x881573c0 0x881573c0 0x00018 0x00018 R   0x4
   LOAD           0x000000 0x88000000 0x88000000 0x16d000 0x194400 RWE 
0x10000
   PAX_FLAGS      0x000000 0x00000000 0x00000000 0x00000 0x00000     0x4

  Section to Segment mapping:
   Segment Sections...
    00     .reginfo
    01     .text .fixup .kstrtab __ex_table __ksymtab .data.init_task 
.text.init .data.init .setup.init .initcall.init .data.cacheline_aligned 
.reginfo .data .bss
    02



Without:
Elf file type is EXEC (Executable file)
Entry point 0x88144040
There are 4 program headers, starting at offset 52

Program Headers:
   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
   REGINFO        0x1563c0 0x881573c0 0x881573c0 0x00018 0x00018 R   0x4
   LOAD           0x001000 0x88002000 0x88002000 0x13ffc0 0x13ffc0 R E 
0x1000
   LOAD           0x141000 0x88142000 0x88142000 0x2b000 0x52400 RWE 0x1000
   PAX_FLAGS      0x000000 0x00000000 0x00000000 0x00000 0x00000     0x4

  Section to Segment mapping:
   Segment Sections...
    00     .reginfo
    01     .text .fixup .kstrtab __ex_table __ksymtab
    02     .data.init_task .text.init .data.init .setup.init 
.initcall.init .data.cacheline_aligned .reginfo .data .bss
    03




--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
