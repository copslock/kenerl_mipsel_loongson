Received:  by oss.sgi.com id <S553668AbRCMHrO>;
	Mon, 12 Mar 2001 23:47:14 -0800
Received: from hermes.research.kpn.com ([139.63.192.8]:31251 "EHLO
        hermes.research.kpn.com") by oss.sgi.com with ESMTP
	id <S552774AbRCMHqr>; Mon, 12 Mar 2001 23:46:47 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01K154N1RSB2000JC6@research.kpn.com>; Tue,
 13 Mar 2001 08:46:45 +0100
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id IAA07580; Tue,
 13 Mar 2001 08:46:43 +0100 (MET)
Date:   Tue, 13 Mar 2001 08:46:43 +0100
From:   "Houten K.H.C. van (Karel)" <K.H.C.vanHouten@research.kpn.com>
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Subject: Re: Compile error with current CVS kernel
In-reply-to: "Your message of Tue, 13 Mar 2001 00:15:20 +0100."
 <20010313001520.A20673@bacchus.dhis.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Adrian Bunk <bunk@fs.tum.de>, linux-mips@oss.sgi.com,
        K.H.C.vanHouten@research.kpn.com
Reply-to: K.H.C.vanHouten@kpn.com
Message-id: <200103130746.IAA07580@sparta.research.kpn.com>
MIME-version: 1.0
X-Mailer: exmh version 1.6.5 12/11/95
Content-type: multipart/mixed ;	boundary="===_0_Tue_Mar_13_08:46:33_MET_2001"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multipart MIME message.

--===_0_Tue_Mar_13_08:46:33_MET_2001
Content-Type: text/plain; charset=us-ascii


Hi Rald, Adrian,

Ralf wrote:
> On Mon, Mar 12, 2001 at 10:56:40PM +0100, Adrian Bunk wrote:
>> [about failing cross-compile ...]
>
> Send me the output of ``mipsel-linux-objdump -p -h vmlinux''.

I get the same error on a native compile:
gcc version 2.95.3 19991030 (Maciej's src)
binutils version 2.11.90 (from CVS)
kernel source 2.4.0-test9 (from oss CVS)

I've attached my objdump output.
Hope this helps.

Regards,
Karel.


--===_0_Tue_Mar_13_08:46:33_MET_2001
Content-Type: text/plain; charset=us-ascii
Content-Description: objdump.txt


vmlinux:     file format elf32-bigmips

Program Header:
0x70000000 off    0x00000000001a11e0 vaddr 0xffffffff881981e0 paddr 
0xffffffff881981e0 align 2**2
         filesz 0x0000000000000018 memsz 0x0000000000000018 flags r--
    LOAD off    0x0000000000000000 vaddr 0x0000000000001000 paddr 
0x0000000000001000 align 2**12
         filesz 0x000000000000a184 memsz 0x000000000000a184 flags r--
    LOAD off    0x000000000000b000 vaddr 0xffffffff88002000 paddr 
0xffffffff88002000 align 2**12
         filesz 0x00000000001acd10 memsz 0x00000000001d25a4 flags rwx
private flags = 101: [no abi set] [mips1] [32bitmode]

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .text         00180020  ffffffff88002000  ffffffff88002000  0000b000  2**13
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .fixup        000011e8  ffffffff88182020  ffffffff88182020  0018b020  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 __ex_table    00001fa8  ffffffff88183210  ffffffff88183210  0018c210  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 __dbe_table   00000000  ffffffff881851b8  ffffffff881851b8  0018e1b8  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 .text.init    0000e124  ffffffff88186000  ffffffff88186000  0018f000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  5 .data.init    0000382c  ffffffff88194124  ffffffff88194124  0019d124  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  6 .setup.init   000000d8  ffffffff88197950  ffffffff88197950  001a0950  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  7 .initcall.init 00000068  ffffffff88197a28  ffffffff88197a28  001a0a28  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  8 .data.cacheline_aligned 000001e0  ffffffff88198000  ffffffff88198000  
001a1000  2**5
                  CONTENTS, ALLOC, LOAD, DATA
  9 .reginfo      00000018  ffffffff881981e0  ffffffff881981e0  001a11e0  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA, LINK_ONCE_SAME_SIZE
 10 .data         00016b10  ffffffff88198200  ffffffff88198200  001a1200  2**4
                  CONTENTS, ALLOC, LOAD, DATA
 11 .sbss         000002c4  ffffffff881aed10  ffffffff881aed10  001b7d10  2**3
                  ALLOC
 12 .bss          000255c4  ffffffff881aefe0  ffffffff881aefe0  001b7d1c  2**4
                  ALLOC
 13 .mdebug       000a6b78  0000000000000000  0000000000000000  001b7d1c  2**2
                  CONTENTS, READONLY, DEBUGGING
 14 .note         00001af4  0000000000000000  0000000000000000  0025e894  2**0
                  CONTENTS, READONLY
 15 .kstrtab      00007c24  0000000000001b00  0000000000001b00  00000b00  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 16 __ksymtab     00001a60  0000000000009724  0000000000009724  00008724  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA

--===_0_Tue_Mar_13_08:46:33_MET_2001
Content-Type: text/plain; charset=us-ascii

Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------

--===_0_Tue_Mar_13_08:46:33_MET_2001--
