Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id PAA07954
	for <pstadt@stud.fh-heilbronn.de>; Wed, 30 Jun 1999 15:30:22 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA04766; Wed, 30 Jun 1999 06:28:52 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA26439
	for linux-list;
	Wed, 30 Jun 1999 06:25:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgoslo.oslo.sgi.com (sgoslo.oslo.sgi.com [144.253.213.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA57926
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 30 Jun 1999 06:25:03 -0700 (PDT)
	mail_from (dagb@dagb.oslo.sgi.com)
Received: from dagb.oslo.sgi.com (dagb.oslo.sgi.com [144.253.213.35]) by sgoslo.oslo.sgi.com (980427.SGI.8.8.8/19990607.SGI.AUTOCF.hoststrip-1.1) via ESMTP id PAA64077; Wed, 30 Jun 1999 15:25:08 +0200 (MEST)
Received: (from dagb@localhost) by dagb.oslo.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id PAA14847; Wed, 30 Jun 1999 15:25:02 +0200 (CEST)
From: "Dag Bakke" <dagb@oslo.sgi.com>
Message-Id: <9906301525.ZM14720@dagb.oslo.sgi.com>
Date: Wed, 30 Jun 1999 15:25:00 +0000
In-Reply-To: "Shane W." <swerner@fcc.net>
        "Re: IRIX Partations with HardHat Linux" (Jun 30,  9:20)
References: <3778E3EC.CCB6C133@fcc.net> 
	<9906300843.ZM53756@roald.stavanger.sgi.com> 
	<3779E179.F10978F8@fcc.net>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: swerner@fcc.net, Roald Lygre <roald@stavanger.sgi.com>
Subject: Re: IRIX Partations with HardHat Linux
Cc: linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

No, you're not. Install linux 2.2.7 (.9?) on any i386 and enable experimental
options and EFS.

Then you should be able to mount the CD on the linux-i386 box and set up tftp,
bootp and nfs for remote booting/installing. (You don't need nfs for booting
fx, though.)
Something for a rainy day....


Dag B


On Jun 30,  9:20, Shane W. wrote:
> Subject: Re: IRIX Partations with HardHat Linux
> I do have an IRIX CD-ROM, but I do not have a SCSI CD-ROM drive.  Am I out of
> luck as far as installing SGI Linux goes?
>
> -s
>
>
> Roald Lygre wrote:
>
> > On Jun 29,  3:19pm, Shane W. wrote:
> > > Subject: IRIX Partations with HardHat Linux
> > > Hi,
> > >
> > >   I am trying to install HardHat linux on an "Indy r5000", the SCSI disk
> > > was blank and I was running into problems so I did a mkfs on it.  Now
> > > the install script keeps asking me to initalize the drive.  I do not
> > > have access to an Irix machine to repartation it or anything of the
> > > such.  Any ideas?
> > >
> >
> > If you have an IRIX operating system CD available (must be marked with
> > "Contains installation tools"), you could boot the disk maint tool "fx"
from
> > the CD.
> >
> > Contact me directly if you have the CD (and CDROM player) and need specific
> > instructions on how to repartition.
> >
> > -Roald
> >
> > --
> >
> > ---------------------------------------------------------------
> > | Company: SGI Norge A/S                                      |
> > | Email:   roald@sgi.com          Tlf:          +47 5184 3633 |
> > | Addr:    St Olavsgt 9           Mobil:        +47 909 33 903|
> > |          N-4004 Stavanger       VMail (SGI):  870-4679      |
> > |          NORWAY                 VMail(ext):   67114679      |
> > |                                                             |
> > | SGI Norway's WWW Home Page: http://www.sgi.no               |
> > ---------------------------------------------------------------
>-- End of excerpt from Shane W.



-- 
Dag Bakke   -   System Support Engineer, SGI Norway
-------------------------------------------------------------------
        SGI Norge			tel:	67 11 46 01
        Strandveien 20			fax:	67 11 47 00
        1325 Lysaker			email:	dagb@oslo.sgi.com
