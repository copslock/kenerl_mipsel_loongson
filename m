Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78Fcg016536
	for linux-mips-outgoing; Wed, 8 Aug 2001 08:38:42 -0700
Received: from highland.isltd.insignia.com (highland.isltd.insignia.com [195.217.222.20])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78FcdV16522
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 08:38:40 -0700
Received: from wolf.isltd.insignia.com (wolf.isltd.insignia.com [172.16.1.3])
	by highland.isltd.insignia.com (8.11.3/8.11.3/check_local4.2) with ESMTP id f78Fcc403143
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 16:38:38 +0100 (BST)
Received: from snow (snow.isltd.insignia.com [172.16.17.209])
	by wolf.isltd.insignia.com (8.9.3/8.9.3) with SMTP id QAA05242
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 16:38:37 +0100 (BST)
Message-ID: <00bd01c12020$31041d00$d11110ac@snow.isltd.insignia.com>
From: "Andrew Thornton" <andrew.thornton@insignia.com>
To: <linux-mips@oss.sgi.com>
Subject: Re: How to build a kernel for the malta board?
Date: Wed, 8 Aug 2001 16:38:37 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Shuanglin,

This is what I did.

Download the Linux kernel source from the MIPS ftp site and extract it on
the development host:

 % tar -xzf linux-2.4.3.mips-src-01.00.tar.gz
 % cd linux-2.4.3

I patched this kernel to make the FPU emulator more reliable using patches
from this list's archive.

Setup the configuration file:

 % cp .config.malta .config
 % chmod +w .config

For little endian mode, edit this file changing the line:

 # CONFIG_CPU_LITTLE_ENDIAN is not set
to:
 CONFIG_CPU_LITTLE_ENDIAN=y

Setup the make file:

 % chmod +w Makefile

Edit this file changing the line:

 CROSS_COMPILE   =
to:
 CROSS_COMPILE   = mipsel-linux-

Build and install the kernel:

 % make oldconfig
 % make dep
 % make

To use TFTP to boot the kernel:

 % mipsel-linux-objcopy -O srec vmlinux vmlinux.srec
 % cp vmlinux.srec /tftpboot/mipsel-2.4.3

Andrew Thornton
