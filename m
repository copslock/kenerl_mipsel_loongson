Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2004 03:18:43 +0000 (GMT)
Received: from mail4.speakeasy.net ([IPv6:::ffff:216.254.0.204]:51850 "EHLO
	mail4.speakeasy.net") by linux-mips.org with ESMTP
	id <S8225592AbUCVDSm>; Mon, 22 Mar 2004 03:18:42 +0000
Received: (qmail 8439 invoked from network); 22 Mar 2004 03:18:37 -0000
Received: from descartes.jellydonut.org (HELO [10.0.1.102]) (dfrezell@[216.27.160.185])
          (envelope-sender <dfrezell@speakeasy.net>)
          by mail4.speakeasy.net (qmail-ldap-1.03) with SMTP
          for <linux-mips@linux-mips.org>; 22 Mar 2004 03:18:37 -0000
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <9C1F2DDC-7BAF-11D8-A797-00039394886E@speakeasy.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-mips@linux-mips.org
From: Andrew Frezell <dfrezell@speakeasy.net>
Subject: mounting fs from memory
Date: Sun, 21 Mar 2004 22:18:37 -0500
X-Mailer: Apple Mail (2.613)
Return-Path: <dfrezell@speakeasy.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dfrezell@speakeasy.net
Precedence: bulk
X-list: linux-mips

Hello All,

I have a bootloader that that is reading segments out of flash and into 
memory.  The segments are 3 compressed ext2 filesystems and the linux 
kernel.  After a signature check of each of the sections in memory the 
bootloader jumps to the kernel.

I would like to mount one filesystem section in RAM as the root 
filesystem.  I think it's easy enough to specify initrd as the offset 
and size of the section in RAM.  But I would also like to mount the 
remaining two filesystems in RAM when linux starts up.  This is where 
I'm having some trouble.  I have two questions:

1.  Is there some way to protect the memory regions in RAM from linux 
just trashing it?  I saw a function add_memory_region in 
arch/mips/kernel/setup.c that seems to do something, does anyone know 
what exactly this does?

2.  How do you mount an area of memory that you know has a filesystem 
already there under linux?  Is there some mount command where you can 
pass the address and size, and mount does the right thing?

Thank you in advance,

Drew Frezell
