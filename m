Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id WAA12913
	for <pstadt@stud.fh-heilbronn.de>; Fri, 6 Aug 1999 22:53:42 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA02525; Fri, 6 Aug 1999 13:36:59 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA26270
	for linux-list;
	Fri, 6 Aug 1999 13:29:47 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA29019
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 6 Aug 1999 13:29:42 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: from calvin.tor.onramp.ca (calvin.tor.onramp.ca [204.225.88.15]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id NAA05037
	for <linux@cthulhu.engr.sgi.com>; Fri, 6 Aug 1999 13:29:38 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: (qmail 30734 invoked from network); 6 Aug 1999 20:29:36 -0000
Received: from imail.hgeng.com (HELO bart.hgeng.com) (199.246.72.233)
  by mail.onramp.ca with SMTP; 6 Aug 1999 20:29:36 -0000
Received: by BART with Internet Mail Service (5.5.2232.9)
	id <QK82N3FZ>; Fri, 6 Aug 1999 16:30:28 -0400
Message-ID: <E138DB347D10D3119C630008C79F5DEC07EB93@BART>
From: Mike Hill <mikehill@hgeng.com>
To: "'Ulf Carlsson'" <ulfc@thepuffingroup.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: RE: Floptical Drive
Date: Fri, 6 Aug 1999 16:30:25 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2232.9)
Content-Type: text/plain
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Same problem with 2.2, just a different error:

make[3]: Entering directory `/usr/src/mips/linux/drivers/net'
mips-linux-gcc -D__KERNEL__ -I/usr/src/mips/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
-mcpu=r4600 -mips2 -pipe   -c -o sgiseeq.o sgiseeq.c
sgiseeq.c: In function `sgiseeq_probe':
sgiseeq.c:741: `SGI_ENET_IRQ' undeclared (first use this function)
sgiseeq.c:741: (Each undeclared identifier is reported only once
sgiseeq.c:741: for each function it appears in.)
make[3]: *** [sgiseeq.o] Error 1
make[3]: Leaving directory `/usr/src/mips/linux/drivers/net'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/mips/linux/drivers/net'
make[1]: *** [_subdir_net] Error 2
make[1]: Leaving directory `/usr/src/mips/linux/drivers'
make: *** [_dir_drivers] Error 2


> -----Original Message-----
> From:	Ulf Carlsson [SMTP:ulfc@thepuffingroup.com]
> Sent:	Wednesday, August 04, 1999 2:30 PM
> To:	Mike Hill
> Cc:	linux@cthulhu.engr.sgi.com
> Subject:	Re: Floptical Drive
> 
> > When I try to add msdos or vfat filesystem support to the kernel (latest
> > CVS) I get the following failure:
> 
> Linus broke all filesystems some time ago, this is not MIPS specific.
> 
> Try the 2.2 kernel instead, I think they should be ok.
> 
> Ulf
