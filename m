Received:  by oss.sgi.com id <S553769AbQJNLga>;
	Sat, 14 Oct 2000 04:36:30 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:38673 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553760AbQJNLgJ>;
	Sat, 14 Oct 2000 04:36:09 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B98B67F8; Sat, 14 Oct 2000 13:36:07 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 9DBB4900C; Sat, 14 Oct 2000 13:35:02 +0200 (CEST)
Date:   Sat, 14 Oct 2000 13:35:02 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com, debian-mips@lists.debian.org
Subject: delo 0.1 / Decstation Boot Loader 
Message-ID: <20001014133502.A1685@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
i started to hack on a Decstation bootloader - It is currently
not booting anything but i thought of letting you know.

I put the stuff i already have at

ftp://ftp.rfc822.org/pub/local/debian-mipsel/experimental

And it is called "delo" - The Decstation Loader - It is loosly
designed like "SILO" the Sparc Loader.

I have a small application called "writeboot" which is based on
lilo and bootprep and inserts the extents to load into the
bootsector of the defined disk. This seems to work quiet well.
I succeeded to load a full kernel dumped with objcopy like this.

The second thing is the "loader" which will (when finished) use
the libe2fs to open an ext2 filesystem, load the kernel and run it.

Goal is to be able to select the kernel image to be loaded on the
prom command line like

boot 3/rz0 /boot/vmlinux root=/dev/sda5 console=ttyS2

Although i am not shure on how to select the partition/filesystem
on which to look for the kernel. Also MS-DOS Disklabel support
has to be added to be able to automatically find the partitions.
Currently i am using the first partition starting at 64 (Although
the open_ext2 currently fails :( )

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
