Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id PAA12274
	for <pstadt@stud.fh-heilbronn.de>; Wed, 30 Jun 1999 15:38:32 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA3714357; Wed, 30 Jun 1999 06:36:56 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA53487
	for linux-list;
	Wed, 30 Jun 1999 06:32:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from roald.stavanger.sgi.com (roald.stavanger.sgi.com [144.253.219.14])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA94518
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 30 Jun 1999 06:32:43 -0700 (PDT)
	mail_from (roald@stavanger.sgi.com)
Received: (from roald@localhost) by roald.stavanger.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id PAA01967; Wed, 30 Jun 1999 15:32:38 +0200 (CEST)
From: "Roald Lygre" <roald@stavanger.sgi.com>
Message-Id: <9906301532.ZM1963@roald.stavanger.sgi.com>
Date: Wed, 30 Jun 1999 15:32:37 +0000
In-Reply-To: tor@spacetec.no (Tor Arntsen)
        "Re: IRIX Partations with HardHat Linux" (Jun 30,  3:24pm)
References: <199906301324.PAA14782@pallas.spacetec.no>
Reply_To: roald@stavanger.sgi.com
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: tor@spacetec.no (Tor Arntsen), swerner@fcc.net
Subject: Re: IRIX Partations with HardHat Linux
Cc: linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Jun 30,  3:24pm, Tor Arntsen wrote:
> Subject: Re: IRIX Partations with HardHat Linux
> On Jun 30, 14:22, "Shane W." wrote:
> >I do have an IRIX CD-ROM, but I do not have a SCSI CD-ROM drive.  Am I out
of
> >luck as far as installing SGI Linux goes?
>
> The Indy can access a CD-ROM drive on another host (it's via tftp when
> from the PROM I believe).
>


But you still need to be able to read the IRIX OS CD (it is in efs format). So
you need the kernel that supports efs, as Dag pointed out.

-Roald



-- 
    
---------------------------------------------------------------
| Company: SGI Norge A/S                                      |
| Email:   roald@sgi.com          Tlf:          +47 5184 3633 |
| Addr:    St Olavsgt 9           Mobil:        +47 909 33 903|
|          N-4004 Stavanger       VMail (SGI):  870-4679      |
|          NORWAY                 VMail(ext):   67114679      |
|                                                             |
| SGI Norway's WWW Home Page: http://www.sgi.no               |
---------------------------------------------------------------
