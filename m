Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBEJrBA07210
	for linux-mips-outgoing; Fri, 14 Dec 2001 11:53:11 -0800
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBEJqxo07206
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 11:52:59 -0800
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id KAA44161;
	Fri, 14 Dec 2001 10:52:57 -0800 (PST)
Date: Fri, 14 Dec 2001 10:52:57 -0800
From: Geoffrey Espin <espin@idiom.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: No bzImage target for MIPS
Message-ID: <20011214105257.A15033@idiom.com>
References: <200112140047.fBE0l9n02204@icarus.sanera.net> <1008292240.27799.134.camel@zeus> <20011213192846.A36207@idiom.com> <1008353149.27799.144.camel@zeus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <1008353149.27799.144.camel@zeus>; from Pete Popov on Fri, Dec 14, 2001 at 10:05:47AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> The "original" pmon has outlived its purpose, although it's still found
> on many boards. I've become a fan of MIPS Tech's yamon; it's small, it
> works, it has just the features I need in an embedded system, and, did I
> say it works?.  Unfortunately the code is released under NDA only. If
> MIPS opened the code, I think you would see it on many more boards.

I rest my case.  Linux is GPL, last I checked.  "LinuxMon", I'll
dub it, solves the problem... for all architectures. :-)  Attached
is the trivial 'reload' script for loading linux on top of linux.
It's just a wrapper for 'dd'.  Oh yeah, your reset.c:xxx_restart()
needs a quick check to see if a new kernel got loaded, and jump
to it, instead of PROM.

> > itself, as the "boot monitor" is best approach.  All reusable
> > code, fastest bootstrap (i.e. no 2nd stage loading), etc... But,
> > of course, not optimal for size, though my image is 1.3M which
> > includes a 580K cramfs ramdisk.
> That's fine once you've ported the kernel to your board. What do you do
> before that point?

With a ROM Emulator, bringing up Linux is no harder than bringing
up a boot monitor or any embedded RTOS, no?  A day or three, if
you are lucky and brilliant.  A somewhat longer if you're not
lucky.  :-)  Getting serial I/O is always the first nut to crack...
with Monta Vista's dbg_io.c, this is greatly simplified.  Of
course, I'm not counting all the extra drivers (Ethernet, ...)
and assuming a well supported architecture.

> patch.  But I fail to see how having this code in every <board>
> directory is better than having a separate boot directory like the ppc
> arch.  The ppc-like zImage support I added is a bit different from the

I quite agree that initrd stuff is not right, or rather builtin
ramdisk.o is not good for embedded.  Having it attached to the
end of vmlinux, possibly padded/aligned to a nice flash sector
boundary should be the general rule.  Having <board>/Boot.make
so one can customize the "make boot" target rule to do the right
thing on a board-by-board basis seems to be the way to go.  E.g.
in arch/mips/boot/Makefile, simply:

    #
    # This file is subject to the terms and conditions of the GNU General Public
    # License.  See the file "COPYING" in the main directory of this archive
    # for more details.
    #
    # Copyright (C) 1995, 1998, 2001 by Ralf Baechle
    #

    .S.s:
	    $(CPP) $(CFLAGS) $< -o $*.s
    .S.o:
	    $(CC) $(CFLAGS) -c $< -o $*.o
    ...
    ifdef CONFIG_NEC_KORVA
    include ../korva/Boot.make
    endif

    all: vmlinux.ecoff addinitrd
    ...

BTW, does any actually build 'vmlinux.ecoff'?

And sure, cluttering up yet another Makefile with CONFIG_XXX_BOARD
is not desirable... rather some magic like:

    include $?{CONFIG_BOARD:common}/Boot.make

would be nice.

Geoff
-- 
Geoffrey Espin espin@idiom.com
--
=reload.sh======================================================================
#!/bin/sh

IMAGE=vrvmlinux00-bfc.bin  # 0M
SKIP=64	                   # 64K for vrboot
SEEK=8                     # 8k (80002000) skip excep vecs to kernel offset

if [ `sed -n -e 's/8\([0-9]\).*bzero/\1/p' /proc/ksyms` -eq 0 ] ; then
	echo "$0: kernel not running at high memory (e.g. 16M), use reboot"
	exit 1
fi

if [ $# -eq 0 ] ; then
	echo "usage (nfs): $0 <user>"
	echo "usage (ftp): $0 <user> <password>"
	exit 1
fi

USER=$1
shift

VM="/home/${USER}/linux/arch/mips/boot/${IMAGE}"

if [ $# -eq 1 ] ; then
	PW=$1
	shift
	VMI="ftp://${USER}:${PW}@10.1.1.1${VM}"
	VM=/tmp/${IMAGE}
	echo wget -c ${VMI} -O ${VM}
	wget -c ${VMI} -O ${VM}
	if [ $? -ne 0 ] ; then
		echo "wget failed"
		exit 1
	fi
else
	# using NFS
fi

echo dd if=${VM} of=/dev/mem bs=1k skip=${SKIP} seek=${SEEK} conv=notrunc 
dd if=${VM} of=/dev/mem bs=1k skip=${SKIP} seek=${SEEK} conv=notrunc 

if [ $? -ne 0 ] ; then
	echo "dd failed"
	exit 1
fi

reboot

--
