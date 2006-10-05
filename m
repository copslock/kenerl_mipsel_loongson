Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2006 07:04:29 +0100 (BST)
Received: from ns2.nec.com.au ([147.76.180.2]:51605 "EHLO ns2.nec.com.au")
	by ftp.linux-mips.org with ESMTP id S20037647AbWJEGEZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2006 07:04:25 +0100
Received: from smtp1.nec.com.au (unknown [172.31.8.18])
	by ns2.nec.com.au (Postfix) with ESMTP id 332DE3B6A2
	for <linux-mips@linux-mips.org>; Thu,  5 Oct 2006 16:04:15 +1000 (EST)
Received: from [147.76.208.162] ([147.76.208.162])
	by tns.neca.nec.com.au (8.12.8/8.12.8) with ESMTP id k956A9Zl012216
	for <linux-mips@linux-mips.org>; Thu, 5 Oct 2006 16:10:11 +1000
Message-ID: <45249FE6.8080800@nec.com.au>
Date:	Thu, 05 Oct 2006 16:02:14 +1000
From:	Pak Woon <pak.woon@nec.com.au>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Roll-your-own Toolchain Builds
References: <20061002231432.733374f7.yoichi_yuasa@tripeaks.co.jp> <20061002151800.GA25180@linux-mips.org> <200610030144.k931i4TD002658@mbox32.po.2iij.net> <4522175B.80901@nec.com.au> <Pine.LNX.4.64.0610031034490.28786@yvahk3.pbagnpgbe.fr>
In-Reply-To: <Pine.LNX.4.64.0610031034490.28786@yvahk3.pbagnpgbe.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <pak.woon@nec.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pak.woon@nec.com.au
Precedence: bulk
X-list: linux-mips



Daniel Stenberg wrote:
> On Tue, 3 Oct 2006, Pak Woon wrote:
> 
>> I am trying to roll-my-own toolchain by following the instructions 
>> outlined in http://www.linux-mips.org/wiki/Toolchains.
> 
> 
>> binutils-2.16.91.0.6-5
>> gcc-4.1.1-1.fc5
> 
> 
> Funny, since that page says that the recommended gcc version is 3.4.4 
> and binutils 2.16.1... (even though I've had no problems with 3.4.6 myself)

First of all, thank you all for your suggestions. I have successfully 
built my own toolchain (using binutils-2.16.1 and gcc-3.4.4). I have 
also successfully built the kernel for the target board. (with git 
checkout linux-2.16.18-stable)

[ltu@PAKW-FEDORA linux.git]$ readelf -h vmlinux
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           MIPS R3000
  Version:                           0x1
  Entry point address:               0x803c3000
  Start of program headers:          52 (bytes into file)
  Start of section headers:          3056172 (bytes into file)
  Flags:                             0x70001001, noreorder, o32, mips32r2
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         1
  Size of section headers:           40 (bytes)
  Number of section headers:         34
  Section header string table index: 31

I am now trying to build a simple program with my new toolchain and I've 
come across the "can't find crt1.o" problem again. I am struggling with 
this.

[ltu@PAKW-FEDORA tmp]$ mips-unknown-linux-gnu-gcc -v hello.c
Using built-in specs.
Configured with: ../gcc-3.4.4/configure
--target=mips-unknown-linux-gnu
--prefix=/home/ltu/development/mips-linux-toolchain
--enable-languages=c --without-headers --with-gnu-ld --with-gnu-as
--disable-shared --disable-threads
Thread model: single
gcc version 3.4.4
/home/ltu/development/mips-linux-toolchain/libexec/gcc/mips-unknown-linux-gnu/3.4.4/cc1
-quiet -v hello.c -quiet -dumpbase hello.c -auxbase hello -version -o
/tmp/ccETB2Cl.s
ignoring nonexistent directory
"/home/ltu/development/mips-linux-toolchain/lib/gcc/mips-unknown-linux-gnu/3.4.4/../../../../mips-unknown-linux-gnu/sys-include"
ignoring nonexistent directory
"/home/ltu/development/mips-linux-toolchain/lib/gcc/mips-unknown-linux-gnu/3.4.4/../../../../mips-unknown-linux-gnu/include"
#include "..." search starts here:
#include <...> search starts here:
/home/ltu/development/mips-linux-toolchain/lib/gcc/mips-unknown-linux-gnu/3.4.4/include
End of search list.
GNU C version 3.4.4 (mips-unknown-linux-gnu)
        compiled by GNU C version 4.1.1 20060525 (Red Hat 4.1.1-1).
GGC heuristics: --param ggc-min-expand=64 --param ggc-min-heapsize=64461
hello.c: In function `main':
hello.c:2: warning: return type of 'main' is not `int'
/home/ltu/development/mips-linux-toolchain/lib/gcc/mips-unknown-linux-gnu/3.4.4/../../../../mips-unknown-linux-gnu/bin/as
-EB -no-mdebug -32 -v -KPIC -o /tmp/ccoPzQTv.o /tmp/ccETB2Cl.s
GNU assembler version 2.16.1 (mips-unknown-linux-gnu) using BFD version 
2.16.1
/home/ltu/development/mips-linux-toolchain/libexec/gcc/mips-unknown-linux-gnu/3.4.4/collect2
--eh-frame-hdr -EB -dynamic-linker /lib/ld.so.1 crt1.o crti.o
/home/ltu/development/mips-linux-toolchain/lib/gcc/mips-unknown-linux-gnu/3.4.4/crtbegin.o
-L/home/ltu/development/mips-linux-toolchain/lib/gcc/mips-unknown-linux-gnu/3.4.4
-L/home/ltu/development/mips-linux-toolchain/lib/gcc/mips-unknown-linux-gnu/3.4.4/../../../../mips-unknown-linux-gnu/lib
/tmp/ccoPzQTv.o -lgcc -rpath-link /lib:/usr/lib -lc -lgcc
/home/ltu/development/mips-linux-toolchain/lib/gcc/mips-unknown-linux-gnu/3.4.4/crtend.o
crtn.o
/home/ltu/development/mips-linux-toolchain/lib/gcc/mips-unknown-linux-gnu/3.4.4/../../../../mips-unknown-linux-gnu/bin/ld:
crt1.o: No such file: No such file or directory
collect2: ld returned 1 exit status
[ltu@PAKW-FEDORA tmp]$ echo $PATH
/home/ltu/development/mips-linux-toolchain/bin:/bin:/usr/bin
[ltu@PAKW-FEDORA tmp]$

 From my understanding, to compile code for my MIPS target, I need to 
use mips-unknown-linux-gnu-gcc (which, I assume is the same as 
/mips-linux-toolchain/mips-unknwn-linux-gnu/bin/gcc). I have ensured my 
$PATH is the bare minimum. This is the same problem as I was getting 
when I was trying to build a gcc-4.1.1-1.fc5 based cross compiler. I am 
really stuck.

FYI, my hello.c is:
void main ( void )
{
   volatile int i,j,k;

   i = 2;
   j = 1;
   k = i + j;
}

Thanks in advance

Regards,
Pak
