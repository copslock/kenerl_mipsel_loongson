Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g47AVXwJ006155
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 03:31:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g47AVXPD006153
	for linux-mips-outgoing; Tue, 7 May 2002 03:31:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g47AVTwJ006150
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 03:31:30 -0700
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id 173BF8D37; Tue,  7 May 2002 12:32:49 +0200 (CEST)
Date: Tue, 7 May 2002 12:32:49 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Cc: ralf@gnu.org
Subject: howto pass ramdisk loaddress to kernel
Message-ID: <20020507123249.A9827@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com, ralf@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
in order to get rid of some ip22 specific hacks in setup.c as well as
addinitrd/elf2ecoff I've written a small tool that links kernel+initrd
as type "binary" into the data segment of the bootloader. This file can
then be fetched by the prom via tftp(or from a CD or whatever). The
bootloader copies the kernel to its loaddress and puts the initrd just
after the kernel.
My question is now: how do i properly pass the initrd's memory address
to the kernel? Choices are:
1) on the commandline: rd_start=0x...
2) a bootparameter block like on i386 or sparc in head.S
3) rely on the kernel to identify if a radisk has
  been loaded by a magic number

I'd prefer (1) but it seems none of the other arches does this. Is there
a reason for that? If not could we just introduce a new kernel
commandline parameter rd_start which has a memory address as a
parameter. Ralf, would you let this into the kernel?
 -- Guido
