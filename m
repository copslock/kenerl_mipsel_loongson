Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA87317 for <linux-archive@neteng.engr.sgi.com>; Sat, 20 Jun 1998 11:20:19 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA97061
	for linux-list;
	Sat, 20 Jun 1998 11:19:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA58408
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 20 Jun 1998 11:19:38 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id LAA29957
	for <linux@cthulhu.engr.sgi.com>; Sat, 20 Jun 1998 11:19:36 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA31911
	for <linux@cthulhu.engr.sgi.com>; Sat, 20 Jun 1998 14:19:34 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sat, 20 Jun 1998 14:19:34 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: New packages...
Message-ID: <Pine.LNX.3.95.980620141448.31445A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I've uploaded about 40 new binary RPMs that are scheduled to be included
in the Alpah 2 release of RH 5.1 that I hope to release tomorrow... if
anyone wants to get ahead, they're in:

ftp://ftp.linux.sgi.com/pub/redhat/devel/

There's also the patched source RPMs there, with diffs.  The full file
listing is below the .sig.

Also, to index the current release, the packages are nicely indexed at
http://www.linux.sgi.com/manhattan/rpm2html/ .


- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .

-rw-rw-r--    1 root     sys          111 Jun 20 11:14 README

RPMS:
total 16
drwxrwxr-x    2 root     sys         4096 Jun 20 11:09 RPMS
drwxrwxr-x    2 root     sys         4096 Jun 20 11:09 SRPMS

RPMS/RPMS:
total 99352
-rw-rw-r--    1 root     sys       273191 Jun 20 10:54 dhcp-2.0b1pl1-2.mipseb.rpm
-rw-rw-r--    1 root     sys        99507 Jun 20 10:54 findutils-4.1-24.mipseb.rpm
-rw-rw-r--    1 root     sys      3752159 Jun 20 10:55 gimp-0.99.28-10.mipseb.rpm
-rw-rw-r--    1 root     sys      4756167 Jun 20 10:56 gimp-data-extras-0.99a-9.noarch.rpm
-rw-rw-r--    1 root     sys        99237 Jun 20 10:56 gimp-devel-0.99.28-10.mipseb.rpm
-rw-rw-r--    1 root     sys        92302 Jun 20 10:56 gimp-libgimp-0.99.28-10.mipseb.rpm
-rw-rw-r--    1 root     sys       191572 Jun 20 10:56 gnome-core-0.13-9.mipseb.rpm
-rw-rw-r--    1 root     sys       418336 Jun 20 10:56 gnome-graphics-0.13-9.mipseb.rpm
-rw-rw-r--    1 root     sys       592446 Jun 20 10:56 gnome-libs-0.13-9.mipseb.rpm
-rw-rw-r--    1 root     sys       625321 Jun 20 10:56 gnome-libs-devel-0.13-9.mipseb.rpm
-rw-rw-r--    1 root     sys        26918 Jun 20 10:56 gnome-linuxconf-0.13-16rh.mipseb.rpm
-rw-rw-r--    1 root     sys       368941 Jun 20 10:56 imlib-1.4-10.mipseb.rpm
-rw-rw-r--    1 root     sys       216878 Jun 20 10:56 imlib-devel-1.4-10.mipseb.rpm
-rw-rw-r--    1 root     sys        34965 Jun 20 10:57 inews-1.7.2-9.mipseb.rpm
-rw-rw-r--    1 root     sys      1160411 Jun 20 10:57 inn-1.7.2-9.mipseb.rpm
-rw-rw-r--    1 root     sys        61941 Jun 20 10:57 inn-devel-1.7.2-9.mipseb.rpm
-rw-rw-r--    1 root     sys       764325 Jun 20 10:57 kernel-2.1.99-0.1.mipseb.rpm
-rw-rw-r--    1 root     sys       717744 Jun 20 10:57 kernel-headers-2.1.99-0.1.mipseb.rpm
-rw-rw-r--    1 root     sys      12855465 Jun 20 10:59 kernel-source-2.1.99-0.1.mipseb.rpm
-rw-rw-r--    1 root     sys        18131 Jun 20 10:59 kernelcfg-0.5-2.mipseb.rpm
-rw-rw-r--    1 root     sys        53569 Jun 20 10:59 mailx-8.1.1-1.mipseb.rpm
-rw-rw-r--    1 root     sys        34649 Jun 20 10:59 man-1.5d-3.mipseb.rpm
-rw-rw-r--    1 root     sys       183710 Jun 20 10:59 multimedia-2.1-10.mipseb.rpm
-rw-rw-r--    1 root     sys        52625 Jun 20 10:59 patch-2.5-4.mipseb.rpm
-rw-rw-r--    1 root     sys        51717 Jun 20 10:59 sysklogd-1.3-23.mipseb.rpm
-rw-rw-r--    1 root     sys      8592103 Jun 20 11:02 tetex-0.4pl8-11.mipseb.rpm
-rw-rw-r--    1 root     sys       169345 Jun 20 11:02 tetex-afm-0.4pl8-11.mipseb.rpm
-rw-rw-r--    1 root     sys       164895 Jun 20 11:02 tetex-dvilj-0.4pl8-11.mipseb.rpm
-rw-rw-r--    1 root     sys       240168 Jun 20 11:02 tetex-dvips-0.4pl8-11.mipseb.rpm
-rw-rw-r--    1 root     sys      2785344 Jun 20 11:03 tetex-latex-0.4pl8-11.mipseb.rpm
-rw-rw-r--    1 root     sys      5139177 Jun 20 11:03 tetex-texmf-src-0.4pl8-11.mipseb.rpm
-rw-rw-r--    1 root     sys        87434 Jun 20 11:04 tetex-xdvi-0.4pl8-11.mipseb.rpm
-rw-rw-r--    1 root     sys         8098 Jun 20 11:04 tmpwatch-1.5.1-2.mipseb.rpm
-rw-rw-r--    1 root     sys       192444 Jun 20 11:04 usermode-1.4.1-2.mipseb.rpm
-rw-rw-r--    1 root     sys        17902 Jun 20 11:04 usernet-1.0.7-2.mipseb.rpm
-rw-rw-r--    1 root     sys       950688 Jun 20 11:04 uucp-1.06.1-16.mipseb.rpm
-rw-rw-r--    1 root     sys       503897 Jun 20 11:04 xntp3-5.93-3.mipseb.rpm
-rw-rw-r--    1 root     sys      4337442 Jun 20 11:05 xscreensaver-2.16-4.mipseb.rpm
-rw-rw-r--    1 root     sys        90527 Jun 20 11:05 xterm-color-1.1-7.mipseb.rpm

RPMS/SRPMS:
total 9168
-rw-rw-r--    1 root     sys         2996 Jun 20 11:06 anonftp-2.5-2.src.rpm
-rw-rw-r--    1 root     sys        62418 Jun 20 11:06 autofs-3.1.1-5.src.rpm
-rw-rw-r--    1 root     sys        18496 Jun 20 11:06 eject-1.5-3.src.rpm
-rw-rw-r--    1 root     sys      1061164 Jun 20 11:07 elm-2.4.25-12.src.rpm
-rw-rw-r--    1 root     sys       253559 Jun 20 11:07 faces-1.6.1-10.src.rpm
-rw-rw-r--    1 root     sys       254316 Jun 20 11:07 faces-1.6.1-11.src.rpm
-rw-rw-r--    1 root     sys        53863 Jun 20 11:07 ncompress-4.2.4-11.src.rpm
-rw-rw-r--    1 root     sys       366530 Jun 20 11:07 pam-0.64-2.src.rpm
-rw-rw-r--    1 root     sys        98430 Jun 20 11:07 sysklogd-1.3-23.src.rpm
-rw-rw-r--    1 root     sys       537915 Jun 20 11:07 util-linux-2.7-19.src.rpm
-rw-rw-r--    1 root     sys      1957040 Jun 20 11:07 xntp3-5.93-3.src.rpm

SRPMS:
total 0

patches:
total 40
-rw-rw-r--    1 root     sys         1091 Jun 20 11:06 anonftp.diff
-rw-rw-r--    1 root     sys          869 Jun 20 11:06 autofs.diff
-rw-rw-r--    1 root     sys         1092 Jun 20 11:06 eject.diff
-rw-rw-r--    1 root     sys         1095 Jun 20 11:07 ncompress.diff
-rw-rw-r--    1 root     sys          747 Jun 20 11:07 xpilot.spec.diff
