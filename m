Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA17642; Mon, 17 Jun 1996 14:20:50 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA01426 for linux-list; Mon, 17 Jun 1996 21:20:44 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA01414 for <linux@cthulhu.engr.sgi.com>; Mon, 17 Jun 1996 14:20:41 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA17636; Mon, 17 Jun 1996 14:20:40 -0700
Date: Mon, 17 Jun 1996 14:20:40 -0700
Message-Id: <199606172120.OAA17636@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: linux@neteng.engr.sgi.com
Subject: native Linux/MIPS binaries
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I'm going to be away giving talks in the U.K. until Thursday
afternoon.  With that in mind I'm going to show people how they can
begin to become acquainted with the work that is already done, and
how to setup a cross-compilation environment both for the kernel and
for userland binaries.

If you want to checkout and build your own SGILinux kernels, Larry and
myself have set things up so that this is possible on neteng.  Just
ask Larry to put you into group 'hackers' on neteng and you'll be able
to check out a CVS kernel source tree.

Step 1:  Get added to group 'hackers' on neteng.
Step 2:  Make sure the following are close to the beginning of your
	 PATH:

	/usr/local/gnu-cross-seb/bin

		These are the cross gcc/binutils utilities necessary
		to build a SGI Linux kernel.

	/hosts/neteng/usr/people/dm/install/bin

		These are miscellaneous GNU utilities such as CVS,
		GNU make, and GNU awk, which are required for the
		build process.

Step 3:  Set CVSROOT environment variable to /hosts/tanya/cvs and
	 checkout your very own kernel.

	$ export CVSROOT=/hosts/tanya/cvs
	$ mkdir src
	$ cd src
	$ cvs checkout linux

	 If you've had a tree for a while, or see some updates on
	 linux-progress you would like integrated into your tree
	 do this.

	$ cd src
	$ cvs update linux

	 If you want to make changes to the source, and feel overly
	 free to, specify the file to be 'committed' back into the
	 CVS repository like this.

	$ cd src/linux/drivers/net
	$ cvs commit -m "My cool checkin message." sgiseeq.c sgiseeq.h

	 CVS has a lot of other powerful features such as revision
	 diffs, automatic commit conflict detection etc.

Step 4:  Configure and build.

	$ cd linux
	$ make oldconfig
	$ make dep; make clean
	$ make vmlinux

	 Or if you like parallel builds (neteng can build Linux
	 kernels in around 2 1/2 minutes flat) replace the last
	 command with.

	$ make -j

Step 5:  If you want, boot the thing.

	$ cp vmlinux /usr/local/boot

	 Go into the ARCS boot monitor prompt on the other machine
	 and say something like

	>> bootp()server:vmlinux

	 And it should at least do something interesting ;-)


For userland, unfortunately, I can only point you at where the current
Linux/MIPS information is located.  I will be doing some detective
work on native userland binaries myself when I return, but people can
check it out for now if they would like to.

The current main distribution site is:

ftp.fnet.fr:/linux-mips/

The current library the other MIPS are using as a basis cannot be
obtained from the above site, it is a pre-test release of GNU libc,
you can obtain snapshots of these prereleases from:

alpha.gnu.ai.mit.edu:/roland/

These are developer snapshots, so don't be surprised if it doesn't
work without applying a hammer to the code/makefiles. ;-)

I believe that the cross-development tools provided on ftp.fnet.fr can
be used to compile the GNU libc and subsequently the userlevel
binaries linked with GNU libc.

The Linux/MIPS web site hasn't been talking to me lately, seems like a
configuration on their end, but for reference it is:

http://www.fnet.fr/linux-mips/

The documation provided there can be found at the Linux/MIPS ftp site
as well I believe.

Later,
David S. Miller
dm@sgi.com
	
