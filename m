Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id GAA07946 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 06:35:10 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA21563 for linux-list; Wed, 14 Jan 1998 06:31:20 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA21328 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 06:29:59 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA26847
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 06:29:51 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id PAA29598;
	Wed, 14 Jan 1998 15:29:37 +0100 (MET)
Received: by zaphod (SMI-8.6/KO-2.0)
	id PAA25634; Wed, 14 Jan 1998 15:29:35 +0100
Message-ID: <19980114152935.14483@uni-koblenz.de>
Date: Wed, 14 Jan 1998 15:29:35 +0100
From: ralf@uni-koblenz.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Oliver Frommel <oliver@aec.at>, adevries@engsoc.carleton.ca,
        linux@cthulhu.engr.sgi.com
Subject: Re: The world's worst RPM
References: <Pine.LNX.3.96.980114142642.12148A-100000@web.aec.at> <m0xsTvW-0005FsC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <m0xsTvW-0005FsC@lightning.swansea.linux.org.uk>; from Alan Cox on Wed, Jan 14, 1998 at 02:36:17PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jan 14, 1998 at 02:36:17PM +0000, Alan Cox wrote:

> I've stuck some more new rpms on ftp.uk.linux.org incoming and SGI dir
> including sox, xmorph, ncompress, sysklogd 

Have you taken care of the fact that ncompress makes assumptions about
the byteorder of the machine it's running on?  For MIPS it's broken, but
I don't remember if it was on big or little endian ...

  Ralf
