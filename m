Received:  by oss.sgi.com id <S553688AbQKGQOb>;
	Tue, 7 Nov 2000 08:14:31 -0800
Received: from srvntsxconn3.toc.ixl.com ([216.99.0.139]:17670 "HELO
        srvntsxconn3.toc.ixl.com") by oss.sgi.com with SMTP
	id <S553679AbQKGQOR>; Tue, 7 Nov 2000 08:14:17 -0800
Received: from 216.99.0.139 by srvntsxconn3.toc.ixl.com (InterScan E-Mail VirusWall NT); Tue, 07 Nov 2000 11:14:00 -0500 (Eastern Standard Time)
Received: by srvntsxconn3.toc.ixl.com with Internet Mail Service (5.5.2650.21)
	id <TMPFL5TT>; Tue, 7 Nov 2000 11:13:59 -0500
Message-ID: <0A5319EEAF65D411825E00805FBBD8A1209C51@exchange.clt.ixl.com>
From:   tmaloney@ixl.com
To:     linux-mips@oss.sgi.com
Subject: RE: mips dist?
Date:   Tue, 7 Nov 2000 11:12:14 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

excellent, i await your reports.

-----Original Message-----
From: Ian Chilton [mailto:ian@ichilton.co.uk]
Sent: Tuesday, November 07, 2000 11:07 AM
To: Michl Ladislav
Cc: linux-mips@oss.sgi.com
Subject: Re: mips dist?


Hello,

> You could do following: download kernel and base-files from
> ftp://ftp.rfc822.org/pub/local/debian-mips/. install bootp, tftp and nfs
> server on another machine (howto can be found in archives) and boot linux
> from this remote computer. after that you can partition your harddisk,
> create filesystems and copy kernel and base-files. instruction how to boot
> linux directly from harddisk (for indy) can be found at:
>
http://honk.physik.uni-konstanz.de/linux-mips/indy-boot/indy-hd-boot-micro-h
owto.html
> now, you have fully functional Debian/GNU Linux, just wait for new
> packages :-)


I know about this. There is also Simple Linux/MIPS, and soon, my own base
systems which will be downloadable, but to answer the origional question,
there is no full distro for Linux/MIPS with a proper installer, except the
very old, outdated, broken Hardhat.

However, on a brigher note, things are moving on at the moment. Ralf is
working on a Redhat 7.0, based on glibc 2.2, and Flo (lolo) has started
uploading debian packages based on glibc 2.2 to debian.org, so we are moving
closed to having some working, easier to install systems.


Bye for Now,

Ian


                                \|||/ 
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton     (IRC Nick - GadgetMan)     ian@ichilton.co.uk  |
 |-----------------------------------------------------------------|
 |  Backup E-Mail -->  ian@ichilton.dhis.org      ICQ #: 16007717  |
 |  Web Site      -->  http://www.ichilton.co.uk                   |
 |-----------------------------------------------------------------|
 |  "Unix is user friendly - it's just picky about it's friends."  |
 \-----------------------------------------------------------------/
