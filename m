Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id FAA360998 for <linux-archive@neteng.engr.sgi.com>; Sat, 24 Jan 1998 05:20:14 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA19865 for linux-list; Sat, 24 Jan 1998 05:16:45 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA19841 for <linux@cthulhu.engr.sgi.com>; Sat, 24 Jan 1998 05:16:39 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id FAA15208
	for <linux@cthulhu.engr.sgi.com>; Sat, 24 Jan 1998 05:16:38 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
From: ralf@mailhost.uni-koblenz.de
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id OAA10465;
	Sat, 24 Jan 1998 14:16:30 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id OAA14034; Sat, 24 Jan 1998 14:16:28 +0100
Message-ID: <19980124141627.19289@uni-koblenz.de>
Date: Sat, 24 Jan 1998 14:16:27 +0100
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Oliver Frommel <oliver@aec.at>, Mike Shaver <shaver@netscape.com>,
        Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: root-be-0.03.tar.gz
References: <34C6E304.680D7541@netscape.com> <Pine.LNX.3.96.980122130326.18071A-100000@web.aec.at> <19980123045725.54480@uni-koblenz.de> <19980123232420.65169@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-Mailer: Mutt 0.84e
In-Reply-To: <19980123232420.65169@alpha.franken.de>; from Thomas Bogendoerfer on Fri, Jan 23, 1998 at 11:24:20PM +0100
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by informatik.uni-koblenz.de id OAA10465
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jan 23, 1998 at 11:24:20PM +0100, Thomas Bogendoerfer wrote:

> On Fri, Jan 23, 1998 at 04:57:25AM +0100, ralf@uni-koblenz.de wrote:
> > Q: What filesystem types are supported directly by the ARC firmware i=
n the
> > ROMs?
>=20
> is there a way to do a raw disk access via ARC firmware ? Mabye we coul=
d
> use some bits from SILO (Sparc Linux Loader) and get ext2fs access this
> way.=20

That=B4s one way.  Another would be to do it like the Alpha Milo.

Raw access should work by accessing something like
scsi(0)disk(0)rdisk(1)partition(0) or so.  Milo should actually already
provide all the framework required for easy implementation of ext2fs
access.

   Ralf
