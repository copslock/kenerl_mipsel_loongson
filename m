Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA2448943 for <linux-archive@neteng.engr.sgi.com>; Tue, 31 Mar 1998 08:02:02 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id IAA5992804
	for linux-list;
	Tue, 31 Mar 1998 08:01:26 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA5906067
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 31 Mar 1998 08:01:23 -0800 (PST)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id IAA01759
	for <linux@cthulhu.engr.sgi.com>; Tue, 31 Mar 1998 08:01:21 -0800 (PST)
	mail_from (dliu@npiww.com)
Received: from mailhub.networkprograms.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id LAA02923; Tue, 31 Mar 1998 11:09:23 -0500
Date: Tue, 31 Mar 1998 11:16:21 -0500
Message-Id: <199803311616.LAA16707@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: compile problem with kernel
In-Reply-To: <19980331091452.41730@uni-koblenz.de>
References: <19980330154244.19782@uni-koblenz.de>
	<Pine.LNX.3.96.980331092426.411B-100000@calypso.saturn>
	<19980331091452.41730@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > On Tue, Mar 31, 1998 at 09:26:20AM +0200, Ulf Carlsson wrote:
 > > > In the vanilla FSF sources the .previous pseudo is broken resulting in
 > > > these messages.  The fix is in 2.7-4 and newer.
 > > 
 > > What are the vanilla FSF sources? The only FSF I have knowlegde of is the
 > > Free Software Foundation :-)
 > 
 > Sorry, but the FSF doesn't over any other flavour except vanilla ;-)
 > 
 > > Do I need a new crosscompiler?
 > 
 > Not really, if you have a native compiler setup.  A crosscompiler is
 > however very handy and sometimes even necessary when bootstrapping for a
 > new system.
 > 
 >   Ralf
 > 

I also have the same problem, however I don't have a native compiler,
I can't make the pre-compiled kernel boot on my Indy:), I'm cross
compiling it on i486-linux I got my binutils from 

ftp://ftp.linux.sgi.com/pub/crossdev/i486-linux/mips-linux

Where can I ftp binutils 2.7-4 ?

Thanks!

Dong
