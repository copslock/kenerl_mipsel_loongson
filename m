Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA84313 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Apr 1999 18:21:41 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA26003
	for linux-list;
	Wed, 14 Apr 1999 18:20:07 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id SAA62155;
	Wed, 14 Apr 1999 18:20:04 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id SAA06008; Wed, 14 Apr 1999 18:20:04 -0700
Date: Wed, 14 Apr 1999 18:20:04 -0700
Message-Id: <199904150120.SAA06008@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Charles Lepple <clepple@foo.tho.org>
Cc: Linux/SGI list <linux@cthulhu.engr.sgi.com>
Subject: Re: installation problem
In-Reply-To: <37151B2A.C230B4A4@foo.tho.org>
References: <37151B2A.C230B4A4@foo.tho.org>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Charles Lepple writes:
 > After successfully (though not uneventfully ;-) installing HardHat on an
 > Indy/r5k, I am now faced with the quandry of installing to another
 > nearly identical machine. The only difference is that the second
 > machine's IRIX partitions were blown away when I tried to use fdisk (no,
 > I didn't finish reading the installation instructions at this point...).
 > 
 > All of the SGI employees out there are probably saying, "Reinstall
 > IRIX", but (it's a long story) I'd rather do this the Linux way. Any
 > suggestions? I looked at the prom man page, and I can get the box to
 > boot the kernel with a 'setenv diskless y' and 'setenv OSLoader
 > /var/boot/vmlinux' (and then some... I'm not in front of the machine at
 > the moment). However, with the IRIX dhcp_bootp daemon, I can't seem to
 > set the suggested nfs root partition, and now that sash is gone, I can't
 > seem to get command line parameters to work anymore (vmlinux is the
 > OSLoader, and it's not doing the sash thing), and hence, the kernel
 > won't boot.

      Try 

	boot -f bootp()boothost:vmlinux xxx yyy

where boothost is the host from which you want ot boot, and
xxx and yyy are your vmlinux options.  The "-f" avoids using OSLoader.

...
 > Also, on the working machine, is there a better way to boot it than
 > telling it to 'boot bootp():vmlinux' each time? Again, working with one
 > disk per machine, IRIX is gone (but I didn't blow sash away on this
 > one).

      You should be able to do something like:

	setenv -p OSLoadPartition bootp()
	setenv -p OSLoadFilename :vmlinux
	setenv -p OSLoadOptions auto
	setenv -p AutoLoad Y	

Without the system partition, you might be able to do

	setenv -p SystemPartition bootp()
	setenv -p OSLoader :vmlinux
