Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB5GAm609953
	for linux-mips-outgoing; Wed, 5 Dec 2001 08:10:48 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB5GAio09948
	for <linux-mips@oss.sgi.com>; Wed, 5 Dec 2001 08:10:44 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA14382;
	Wed, 5 Dec 2001 07:10:35 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA02716;
	Wed, 5 Dec 2001 07:10:36 -0800 (PST)
Received: from copsun18.mips.com (copsun18 [192.168.205.28])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id fB5FAWA16809;
	Wed, 5 Dec 2001 16:10:32 +0100 (MET)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun18.mips.com (8.9.1/8.9.0) id QAA12575;
	Wed, 5 Dec 2001 16:10:33 +0100 (MET)
Message-Id: <200112051510.QAA12575@copsun18.mips.com>
Subject: Re: Booting from IDE
To: dant@mips.com (Dan Temple)
Date: Wed, 5 Dec 2001 16:10:33 +0100 (MET)
Cc: nitin.borle@broadcom.com (Nitin),
   linux-mips@oss.sgi.com (linux-mips@oss.sgi.com)
In-Reply-To: <3C0E3764.4EC8FE58@mips.com> from "Dan Temple" at Dec 05, 2001 04:04:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

If you feel lucky, you can also reserve space on your disk for the kernel - 
either in a separate partition, or outside the area used by your current
partitions. The YAMON 02.02 or later can read the kernel directly from disk
and execute it.

I do this on my Malta board with one disk.

/Hartvig


Dan Temple writes:
> 
> I guess you're installing as per:
> 
> ftp://ftp/pub/linux/mips/installation/redhat7.1/INSTALL
> 
> (If not, you might want to upgrade to that version).
> 
> YAMON can't read the disk file system, so you have to TFTP the kernel to memory from a remote filesystem, and then run it. The instructions are in the above file under "Booting linux on the target".
> 
> The latest version (2.02) of YAMON can read and write blocks from an IDE device (not a filesystem) so you could install a CompactFlash card and use that to store the kernel if you don't want to TFTP each time. 
> 
> There is also a $start environment variable if you want to auto-boot.
> 
> /Dan
> 
> Nitin wrote:
> > 
> > Hi,
> > I have a very basic query. I have a MIPS Malta board. I attached a IDE
> > hard disk to it and installed linux as per the instructions. At the end
> > of the installation, system rebooted and control gone to the board
> > monitor program(Yamon). How can I get the linux prompt? Do I need to
> > write an application program which will read boot sector from hard disk,
> > 
> > store it in memory and pass on control to that particular location?(If
> > yes, is such application already available?) Or is there a other way of
> > doing it.
> > 
> > Thanks,
> > Nitin
