Received:  by oss.sgi.com id <S553659AbQJQVES>;
	Tue, 17 Oct 2000 14:04:18 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:22009 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553646AbQJQVEG>;
	Tue, 17 Oct 2000 14:04:06 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9HL2Fx20218;
	Tue, 17 Oct 2000 14:02:15 -0700
Message-ID: <39ED2166.9B5F970@mvista.com>
Date:   Tue, 17 Oct 2000 21:04:54 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: The initial results (Re: stable binutils, gcc, glibc ...
References: <39E7EB73.9206D0DB@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I thank everybody who replied!  My noticable absence in the discussion
is merely an indication of my ignorance on this issue.  But I really
appreciate all the messages I got.

Over the past weekend and yesterday, I started to collect, compile and
package the toolchains.  Here is the first report.

I finally settled down with the old but deemed reliable versions :

a) binutils v2.8.1 + mips patch 

ftp://sourceware.cygnus.com/pub/binutils/releases/
ftp://oss.sgi.com/pub/linux/mips/binutils/binutils-2.8.1-3.diff.gz

b) egcs 1.0.3a + mips patch

ftp://ftp.mvista.com/pub/Area51/mips_le/misc/egcs-1.0.3a.tar.gz
ftp://oss.sgi.com/pub/linux/mips/egcs/egcs-1.0.3a-2.diff.gz

(Ralf, you cannot find egcs-1.0.3a.tar.gz release on the net anymore. 
You probably want to save this file on the same site with the diff
file.)

c) glibc 2.0.6 + mips patch

ftp://oss.sgi.com/pub/linux/mips/glibc/srpms/glibc-2.0.6-5lm.src.rpm

I also had success with latest binutils CVS tree.  I gave a try to the
latest gcc, but did not look into it further.

http://sourceware.cygnus.com/binutils
cvs -z 9 -d :pserver:anoncvs@anoncvs.cygnus.com:/cvs/src co -D "Oct 13,
2000" binutils

-----------

With the above tools, I hooked up with MontaVista's build machine and
generated a few dozens of userland packages.  You can find the RPMS and
SRPMS of the toolchain and applications on the following ftp site. 
Inside these packages you will find a lot of "MontaVista-ism". (yeah,
what a surprise!)

ftp://ftp.mvista.com/pub/Area51/mips_le/

If you have NEC DDB5476 board, you can also try out my kernel on the
following place.  This kernel supports nfs rootfs through on-board ether
port, IDE disk, PS/2 keyboard/mouse, Voodoo3 2000/3000 PCI graphic cards
(framebuffer driver).

ftp://ftp.mvista.com/pub/Area51/ddb-5476/

For your viewing pleasure, I also include a sleek microwindow demo,
which is tested working on DDB5476 board with voodoo3 cards, ps/2
keyboard/mouse.  I have not rpm-lized it yet.  You can find the binaries
on the following place:

ftp://ftp.mvista.com/pub/Area51/mips_le/microwindows

Please note all these packages are my own experimental stuff.  Please do
not call MontaVista's support engineers about bugs or problems.  I will
continue to do some more trials on MIPS toolchains, and post my results.

Thanks again to everyone who replied.


Jun

P.S., The ftp uploading is still running.  It should be completed in one
hour.
