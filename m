Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBF0jsH13304
	for linux-mips-outgoing; Fri, 14 Dec 2001 16:45:54 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBF0jWo13297
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 16:45:33 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA06994
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 15:44:50 -0800 (PST)
	mail_from (ppopov@mvista.com)
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fBENdrB28585;
	Fri, 14 Dec 2001 15:39:53 -0800
Subject: RE: No bzImage target for MIPS
From: Pete Popov <ppopov@mvista.com>
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: "'Geoffrey Espin '" <espin@idiom.com>,
   "'linux-mips '"
	 <linux-mips@oss.sgi.com>
In-Reply-To: <25369470B6F0D41194820002B328BDD2195AE3@ATLOPS>
References: <25369470B6F0D41194820002B328BDD2195AE3@ATLOPS>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 14 Dec 2001 15:42:41 -0800
Message-Id: <1008373362.27799.173.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2001-12-14 at 14:59, Marc Karasek wrote:
>  What about redboot?  It is Open Source and has support for a variety of
> processors.  The structure is such that adding support for a new
> platform/processor is very easy.  It has support for booting a linux kernel
> and as an added bonus support for ecos is pretty much done once you get it
> ported. 

If you're doing your own board, redboot may be fine. But typically
vendors of referrence boards want you to use whatever boot code they
already have running because they are not willing to pay for new boot
code. 

Pete

> 
> 
> 
> -----Original Message-----
> From: Pete Popov
> To: Geoffrey Espin
> Cc: linux-mips
> Sent: 12/14/01 2:11 PM
> Subject: Re: No bzImage target for MIPS
> 
> On Fri, 2001-12-14 at 10:52, Geoffrey Espin wrote:
> > 
> > > The "original" pmon has outlived its purpose, although it's still
> found
> > > on many boards. I've become a fan of MIPS Tech's yamon; it's small,
> it
> > > works, it has just the features I need in an embedded system, and,
> did I
> > > say it works?.  Unfortunately the code is released under NDA only.
> If
> > > MIPS opened the code, I think you would see it on many more boards.
> > 
> > I rest my case.  Linux is GPL, last I checked.  "LinuxMon", I'll
> > dub it, solves the problem... for all architectures. :-)  Attached
> > is the trivial 'reload' script for loading linux on top of linux.
> > It's just a wrapper for 'dd'.  Oh yeah, your reset.c:xxx_restart()
> > needs a quick check to see if a new kernel got loaded, and jump
> > to it, instead of PROM.
> > 
> > > > itself, as the "boot monitor" is best approach.  All reusable
> > > > code, fastest bootstrap (i.e. no 2nd stage loading), etc... But,
> > > > of course, not optimal for size, though my image is 1.3M which
> > > > includes a 580K cramfs ramdisk.
> > > That's fine once you've ported the kernel to your board. What do you
> do
> > > before that point?
> > 
> > With a ROM Emulator, bringing up Linux is no harder than bringing
> > up a boot monitor or any embedded RTOS, no?  A day or three, if
> > you are lucky and brilliant.  A somewhat longer if you're not
> > lucky.  :-)  Getting serial I/O is always the first nut to crack...
> > with Monta Vista's dbg_io.c, this is greatly simplified.  Of
> > course, I'm not counting all the extra drivers (Ethernet, ...)
> > and assuming a well supported architecture.
> 
> True, if you can use a rom emulator on the given board, which you can't
> do with all boards.  But then you need to connect the emulator to the
> board every time you want to do something ... I don't know, give me a
> working boot loader with enet support and I'll take that instead.
>  
> > > patch.  But I fail to see how having this code in every <board>
> > > directory is better than having a separate boot directory like the
> ppc
> > > arch.  The ppc-like zImage support I added is a bit different from
> the
> > 
> > I quite agree that initrd stuff is not right, or rather builtin
> > ramdisk.o is not good for embedded.  Having it attached to the
> > end of vmlinux, possibly padded/aligned to a nice flash sector
> > boundary should be the general rule.  Having <board>/Boot.make
> > so one can customize the "make boot" target rule to do the right
> > thing on a board-by-board basis seems to be the way to go.  
> 
> Exactly. That's why the <board> directory in arch/mips/zboot :-) BTW, I
> added the new zboot directory in sourceforge because arch/mips/boot was
> in the way and I didn't want to mess with that one. 
> 
> Ultimately I don't care if the zImage support is in each <board>
> directory or in a new directory like arch/mips/zboot, as long as the
> support for zImages and, eventually, initrd, is there. 
> 
> BTW, if you don't package up your work in a patch that Ralf would take,
> the bits get lost over time. I don't know if you care, but that's how
> linux evolves so I hope you submit your patches upstream rather than
> allowing them to get lost in mailing lists.
> 
> Pete
> 
> > E.g.
> > in arch/mips/boot/Makefile, simply:
> > 
> >     #
> >     # This file is subject to the terms and conditions of the GNU
> General Public
> >     # License.  See the file "COPYING" in the main directory of this
> archive
> >     # for more details.
> >     #
> >     # Copyright (C) 1995, 1998, 2001 by Ralf Baechle
> >     #
> > 
> >     .S.s:
> > 	    $(CPP) $(CFLAGS) $< -o $*.s
> >     .S.o:
> > 	    $(CC) $(CFLAGS) -c $< -o $*.o
> >     ...
> >     ifdef CONFIG_NEC_KORVA
> >     include ../korva/Boot.make
> >     endif
> > 
> >     all: vmlinux.ecoff addinitrd
> >     ...
> > 
> > BTW, does any actually build 'vmlinux.ecoff'?
> > 
> > And sure, cluttering up yet another Makefile with CONFIG_XXX_BOARD
> > is not desirable... rather some magic like:
> > 
> >     include $?{CONFIG_BOARD:common}/Boot.make
> > 
> > would be nice.
> > 
> > Geoff
> > -- 
> > Geoffrey Espin espin@idiom.com
> > --
> >
> =reload.sh==============================================================
> ========
> > #!/bin/sh
> > 
> > IMAGE=vrvmlinux00-bfc.bin  # 0M
> > SKIP=64	                   # 64K for vrboot
> > SEEK=8                     # 8k (80002000) skip excep vecs to kernel
> offset
> > 
> > if [ `sed -n -e 's/8\([0-9]\).*bzero/\1/p' /proc/ksyms` -eq 0 ] ; then
> > 	echo "$0: kernel not running at high memory (e.g. 16M), use
> reboot"
> > 	exit 1
> > fi
> > 
> > if [ $# -eq 0 ] ; then
> > 	echo "usage (nfs): $0 <user>"
> > 	echo "usage (ftp): $0 <user> <password>"
> > 	exit 1
> > fi
> > 
> > USER=$1
> > shift
> > 
> > VM="/home/${USER}/linux/arch/mips/boot/${IMAGE}"
> > 
> > if [ $# -eq 1 ] ; then
> > 	PW=$1
> > 	shift
> > 	VMI="ftp://${USER}:${PW}@10.1.1.1${VM}"
> > 	VM=/tmp/${IMAGE}
> > 	echo wget -c ${VMI} -O ${VM}
> > 	wget -c ${VMI} -O ${VM}
> > 	if [ $? -ne 0 ] ; then
> > 		echo "wget failed"
> > 		exit 1
> > 	fi
> > else
> > 	# using NFS
> > fi
> > 
> > echo dd if=${VM} of=/dev/mem bs=1k skip=${SKIP} seek=${SEEK}
> conv=notrunc 
> > dd if=${VM} of=/dev/mem bs=1k skip=${SKIP} seek=${SEEK} conv=notrunc 
> > 
> > if [ $? -ne 0 ] ; then
> > 	echo "dd failed"
> > 	exit 1
> > fi
> > 
> > reboot
> > 
> > --
> 
