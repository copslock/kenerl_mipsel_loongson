Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2006 15:09:58 +0100 (BST)
Received: from ip-217-204-115-127.easynet.co.uk ([217.204.115.127]:15876 "EHLO
	apollo.linkchoose.co.uk") by ftp.linux-mips.org with ESMTP
	id S8133454AbWFZOJq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Jun 2006 15:09:46 +0100
Received: from [10.98.1.127] (helo=galaxy.dga.co.uk)
	by apollo.linkchoose.co.uk with esmtp (Exim 4.60)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1Furo8-0005pB-0b
	for linux-mips@linux-mips.org; Mon, 26 Jun 2006 15:11:20 +0100
Received: from [10.0.1.63]
	by galaxy.dga.co.uk with esmtp (Exim 4.62)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1FurmS-000461-Lz
	for linux-mips@linux-mips.org; Mon, 26 Jun 2006 15:09:36 +0100
From:	David Goodenough <david.goodenough@linkchoose.co.uk>
To:	linux-mips@linux-mips.org
Subject: initrd and ramdisk in ELF sections
Date:	Mon, 26 Jun 2006 15:09:34 +0100
User-Agent: KMail/1.9.1
Organization: Linkchoose Ltd
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606261509.35243.david.goodenough@linkchoose.co.uk>
Return-Path: <david.goodenough@linkchoose.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.goodenough@linkchoose.co.uk
Precedence: bulk
X-list: linux-mips

I have a kernel that I want to load into a Microtik RB500 (and hopefully later
into a RB112) via their network boot facility.  It is a 2.6.17 kernel.

I also want to be able to embed in the kernel a ramdisk image (squashfs)
that can be used as root when I first boot this kernel.  This root image will
be used to initialise the NAND flash which the boards have on them.  The
RB500 does have a Compact Flash socket, so I could do this by intialising
the CF on my laptop, but the RB112 has no such CF socket, and I want to 
get myself ready for that.

I read in a Microtik Wiki entry:-

http://wiki.mikrotik.com/wiki/RB500_Linux_SDK

about using objcopy --add-section, but I am having difficulty making it
work.  I also notice that the script mkvmlinux uses the same technique
but offers both initrd and ramdisk support.  But the Microtik wiki entry
is talking about a 2.4 kernel, which it would appear is different.

For reasons that I do not understand when I tried loading the root image
as an initrd with root=/dev/ram0 as a kernel parm, even though the 
squashfs code had been initialised (according to the system log which I 
am reading through a serial console) the initrd code assumed that the
image was a yaffs image and refused to proceed.  So I wanted (using
the model in mkvmlinux) to use the ramdisk option, as looking at the
code for that it will try looking for a squashfs.  But if I use ramdisk as
the section name in the objcopy it does not find it.

So I went Googling around to see if I could find any guidance, and 
found little or nothing.  So I asked a few people including Alan Cox and
they said that this level of intialisation is very architecture dependant
and that I should ask here.

Can anyone please point me at some documentation, or the right bit
of code, or if they have knowledge of this kind of thing provide me
with some pointers as to what to do.

Thanks in advance

David
