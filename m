Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id QAA17656
	for <pstadt@stud.fh-heilbronn.de>; Wed, 30 Jun 1999 16:32:38 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA23407; Wed, 30 Jun 1999 07:30:13 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA67408
	for linux-list;
	Wed, 30 Jun 1999 07:27:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgoslo.oslo.sgi.com (sgoslo.oslo.sgi.com [144.253.213.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA44263
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 30 Jun 1999 07:27:32 -0700 (PDT)
	mail_from (dagb@dagb.oslo.sgi.com)
Received: from dagb.oslo.sgi.com (dagb.oslo.sgi.com [144.253.213.35]) by sgoslo.oslo.sgi.com (980427.SGI.8.8.8/19990607.SGI.AUTOCF.hoststrip-1.1) via ESMTP id QAA41572 for <@sgoslo.oslo.sgi.com:linux@cthulhu.engr.sgi.com>; Wed, 30 Jun 1999 16:27:47 +0200 (MEST)
Received: (from dagb@localhost) by dagb.oslo.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id QAA14864 for linux@cthulhu.engr.sgi.com; Wed, 30 Jun 1999 16:27:44 +0200 (CEST)
From: "Dag Bakke" <dagb@oslo.sgi.com>
Message-Id: <9906301627.ZM14888@dagb.oslo.sgi.com>
Date: Wed, 30 Jun 1999 16:27:42 +0000
In-Reply-To: Vince Weaver <weave@eng.umd.edu>
        "Re: IRIX Partations with HardHat Linux" (Jun 30, 10:06)
References: <Pine.GSO.4.10.9906301001520.8406-100000@z.glue.umd.edu>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Re: IRIX Partations with HardHat Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

As I understand it, you only need to partition the disk with the SGI tools
(fx).
(If this is wrong, please feel free to correct me.)
Thus, you only need bootp and tftp to boot fx.


I am sure there is a linux tftp and bootp howto somewehere. If not, please read
the man-pages and write the HOWTO afterwards.


To boot fx on the Indy from the prom monitor (command monitor) enter:
setenv -p netaddr 123.456.789.123
boot -f bootp()remotemachine:/path/to/stand/fx.ARCS

And please note that 'remotemachine' should be by name, not IPaddress. Please
avoid routers between client and server. (It is doable, but often requires more
work.) If the server uses a 'non-standard' (very narrow) netmask, you may have
to tweak the bootp-line somewhat. I don't remember the exact syntax. Let us
know if this becomes a problem.


Dag B


On Jun 30, 10:06, Vince Weaver wrote:
> Subject: Re: IRIX Partations with HardHat Linux
> On Wed, 30 Jun 1999, Tom Woelfel wrote:
>
> > Dag Bakke writes:
> >  > No, you're not. Install linux 2.2.7 (.9?) on any i386 and enable
experimental
> >  > options and EFS.
> >  >
> >  > Then you should be able to mount the CD on the linux-i386 box and set up
tftp,
> >  > bootp and nfs for remote booting/installing. (You don't need nfs for
booting
> >  > fx, though.)
> >  > Something for a rainy day....
> >
> > Hmm, is there a FAQ on how to set up such an environment ?
>
> my friend and I managed to upgrade Irix6.2 to Irix6.5 on a Indigo2 with no
> CD-ROM this way.
>
> It involved a Linux box with an early 2.3.x kernel on it [2.3.2 I think]
> with efs support compiled it.
>
> It took many hours of tweaking the booptab file and tftp, but finally we
> got the SASH off the Irix CD to load, and eventually a miniroot.
>
> The one thing that really helped was putting the Debug Messages in bootp
> up as high as possible, so you can see what files the SGI is requesting,
> and then mess around with your bootp server until it gets the file it is
> looking for.
>
> I would be a bit more explicit but the final breakthrough was made late at
> night after many, many, many randomly guessed attempts, and we were so
> happy to get it working we were afraid to try and replicate it because we
> never thought we'd figure it out again.
>
> Vince
>
> ____________
> \  /\  /\  /  Vince Weaver
>  \/__\/__\/   weave@eng.umd.edu     http://www.glue.umd.edu/~weave
>-- End of excerpt from Vince Weaver



-- 
Dag Bakke   -   System Support Engineer, SGI Norway
-------------------------------------------------------------------
        SGI Norge			tel:	67 11 46 01
        Strandveien 20			fax:	67 11 47 00
        1325 Lysaker			email:	dagb@oslo.sgi.com
