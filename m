Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2004 00:01:00 +0000 (GMT)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:42919 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225299AbUCIAA7>; Tue, 9 Mar 2004 00:00:59 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc11) with ESMTP
          id <2004030900005201100fbt0fe>
          (Authid: kumba12345);
          Tue, 9 Mar 2004 00:00:53 +0000
Message-ID: <404D0A18.6050802@gentoo.org>
Date: Mon, 08 Mar 2004 19:04:40 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:

> What's the output of readelf -l for this kernel?

# mips-unknown-linux-gnu-readelf -l vmlinux

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


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
