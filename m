Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2010 20:51:40 +0100 (CET)
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40793 "EHLO
        out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493289Ab0ASTvg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2010 20:51:36 +0100
Received: from compute1.internal (compute1.internal [10.202.2.41])
        by gateway1.messagingengine.com (Postfix) with ESMTP id B862BCE537;
        Tue, 19 Jan 2010 14:51:34 -0500 (EST)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute1.internal (MEProxy); Tue, 19 Jan 2010 14:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=AFa1AfHfbhRttRP04k4QN5FijHM=; b=E2G+WnSuxEjYvkyp4uav2wDS4iHIaKP3NArfKktvEC5LWuL2KeDbgWhrzRwMeyJFfnZ00PGcEbKmkO+tSYRH6PpXo4g8FtJzkowQQu/9mqLFZg09Q9ZpTIEkn8GFKQxjjJJnb8x9A30iaG3iAyjk+NdOD2kRKrfpk8Gb6JdYt1M=
Received: by web8.messagingengine.com (Postfix, from userid 99)
        id 8C2DD3A805; Tue, 19 Jan 2010 14:51:34 -0500 (EST)
Message-Id: <1263930694.9779.1355491925@webmail.messagingengine.com>
X-Sasl-Enc: fwD5crpZ/k/x/oydMg+dPUlaMv+y2AWbCy1pgrz5VQwb 1263930694
From:   myuboot@fastmail.fm
To:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: MessagingEngine.com Webmail Interface
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4AD906D8.3020404@caviumnetworks.com>
Subject:  loadable kernel module link failure -  endianness incompatible with
 that of the selected emulation
In-Reply-To: <4AD906D8.3020404@caviumnetworks.com>
Date:   Tue, 19 Jan 2010 13:51:34 -0600
X-archive-position: 25614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12735

I got a link error when compiling 2 loadable kernel modules -
"endianness incompatible with that of the selected emulation". 

But both kernel and the kernel modules of error are in big endian. I
don't know what I should check or fix. Any suggestions? I checked the
endianess of the kernel by checking the elf header of vmlinux file, is
that the right way to do it?

Below are the error info and the readelf output, showing both the kernel
and a kernel module are in big endian.
Thanks for your help. Andrew

1) error log 
make -C /home/root123/sources/kernel/linux
CROSS_COMPILE=""/home/root123/sources/gcc3.4.3-be"/bin/mips-linux-"
M=/home/root123/sources/sdk/platform/src/linux/mxp/src modules    

  LD [M]  /home/root123/sources/sdk/platform/src/linux/mxp/src/mxpmod.o
/home/root123/sources/gcc3.4.3-be/bin/mips-linux-ld:
/home/root123/sources/sdk/platform/src/linux/mxp/src/mmxpcore.o:
compiled for a big endian system and target is little endian
/home/root123/sources/gcc3.4.3-be/bin/mips-linux-ld:
/home/root123/sources/sdk/platform/src/linux/mxp/src/mmxpcore.o:
endianness incompatible with that of the selected emulation
/home/root123/sources/gcc3.4.3-be/bin/mips-linux-ld: failed to merge
target specific data of file
/home/root123/sources/sdk/platform/src/linux/mxp/src/mmxpcore.o
make[13]: ***
[/home/root123/sources/sdk/platform/src/linux/mxp/src/mxpmod.o] Error 1

2) kernel is in big endian
readelf -h vmlinux
ELF Header:
  Magic:   7f 45 4c 46 01 02 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF32
  Data:                              2's complement, big endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           MIPS R3000
  Version:                           0x1
  Entry point address:               0x941aa000
  Start of program headers:          52 (bytes into file)
  Start of section headers:          1720624 (bytes into file)
  Flags:                             0x50001001, noreorder, o32, mips32
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         1
  Size of section headers:           40 (bytes)
  Number of section headers:         27
  Section header string table index: 24


3) kernel module is big endian.
readelf -h mmxpcore.o
ELF Header:
  Magic:   7f 45 4c 46 01 02 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF32
  Data:                              2's complement, big endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              REL (Relocatable file)
  Machine:                           MIPS R3000
  Version:                           0x1
  Entry point address:               0x0
  Start of program headers:          0 (bytes into file)
  Start of section headers:          81024 (bytes into file)
  Flags:                             0x10001001, noreorder, o32, mips2
  Size of this header:               52 (bytes)
  Size of program headers:           0 (bytes)
  Number of program headers:         0
  Size of section headers:           40 (bytes)
  Number of section headers:         34
  Section header string table index: 31
