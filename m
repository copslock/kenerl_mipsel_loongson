Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2004 12:33:18 +0100 (BST)
Received: from skl1.ukl.uni-freiburg.de ([IPv6:::ffff:193.196.199.1]:6076 "EHLO
	relay1.uniklinik-freiburg.de") by linux-mips.org with ESMTP
	id <S8225768AbUE0LdF>; Thu, 27 May 2004 12:33:05 +0100
Received: from wh85.ukl.uni-freiburg.de (ktl77.ukl.uni-freiburg.de [193.196.226.77])
	by relay1.uniklinik-freiburg.de (Email) with ESMTP id DA29B2F47D
	for <linux-mips@linux-mips.org>; Thu, 27 May 2004 13:33:00 +0200 (CEST)
From: Max Zaitsev <maksik@gmx.co.uk>
Organization: Mutella Dev co.
To: linux-mips@linux-mips.org
Subject: help needed : cannot install linux on SGI O2 R5000
Date: Thu, 27 May 2004 13:33:04 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405271333.04712.maksik@gmx.co.uk>
Return-Path: <maksik@gmx.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksik@gmx.co.uk
Precedence: bulk
X-list: linux-mips

Hi List,

couple of days ago I've acquired an oldish O2 box with 180MHz R5k CPU, 256MB 
ram and ~10GB HD space. Since then I'm trying to get linux installed on that 
thing, but apparently with no success. I've managed to connect it to a linux 
box and get bootp() and NFS to work. However, I cannot find a working kernel/
rootfs combination to proceed. 

As it follows from the mailing list postings I've read I shall try installing 
gentoo distribution. However, the binary kernel for net-install from 
http://dev.gentoo.org/~kumba/mips/netboot/ip32/ does not seem to boot and 
hangs straight after the download. The same applies to the older kernel image 
located in the same place.

What I found to work was the 64 bit binary kernel from glaurung 
(http://www.linux-mips.org/~glaurung/). It boots nicely, but I have no root 
partition to go on with. I've tried to use the contents of the initrd image 
for gentoo netinstall, but it hangs in the busybox after diplaying one line 
with version information.

I would like to avoid installing the complete crosscompilation toolchain on my 
linux box in order to get the recent CVS version of the kernel compiled. 
Another point is that I have no idea what would be to configuration options 
to get it to work on my O2. Apparently, it's not straitforward. Can somebody 
point me a location of the working binary kernel for gentoo install or are 
there better (or just other) solutions?

Regards,
Max
