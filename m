Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA71062 for <linux-archive@neteng.engr.sgi.com>; Fri, 28 Aug 1998 15:23:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA55503
	for linux-list;
	Fri, 28 Aug 1998 15:23:41 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA80480;
	Fri, 28 Aug 1998 15:23:12 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA14246; Fri, 28 Aug 1998 15:23:07 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-12.uni-koblenz.de [141.26.249.12])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA06797;
	Sat, 29 Aug 1998 00:22:58 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA01417;
	Fri, 28 Aug 1998 01:20:25 +0200
Message-ID: <19980828012025.B1381@uni-koblenz.de>
Date: Fri, 28 Aug 1998 01:20:25 +0200
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: Arnaud Le Neel <Arnaud.Le.Neel@cyceron.fr>, linux@cthulhu.engr.sgi.com
Subject: Re: boot problem for Indy
References: <35E59FBA.96A1900C@cyceron.fr> <Pine.LNX.3.96.980827131327.10299B-100000@lager.engsoc.carleton.ca> <19980827224215.C19688@aisa.fi.muni.cz> <199808272055.NAA06365@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199808272055.NAA06365@fir.engr.sgi.com>; from William J. Earl on Thu, Aug 27, 1998 at 01:55:29PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Aug 27, 1998 at 01:55:29PM -0700, William J. Earl wrote:

>       The PROM on older Indy systems, especially those with R4000
> processors, may only support MIPS ECOFF binaries.  Are you booting an
> ELF or an ECOFF kernel binary?  If you have an ELF kernel binary, and
> it cannot be converted to ECOFF, you may need a two-level loading scheme.
> Note that you could try loading sash from the local disk, and then
> have sash boot vmlinux via bootp(), since sash does know about 
> ELF binaries.

For Indys we currently only build ELF kernels.  I've implemented a clean
solution how to boot ECOFF systems because I needed that for the RC3230,
I'll publish it when it's debugged.

  Ralf
