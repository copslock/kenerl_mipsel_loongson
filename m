Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA80626 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Mar 1999 15:05:43 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA38217
	for linux-list;
	Fri, 5 Mar 1999 15:04:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA18237
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 5 Mar 1999 15:03:41 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA04201
	for <linux@cthulhu.engr.sgi.com>; Fri, 5 Mar 1999 15:03:39 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-3.uni-koblenz.de [141.26.131.3])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA00669
	for <linux@cthulhu.engr.sgi.com>; Fri, 5 Mar 1999 23:58:33 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id KAA05467;
	Fri, 5 Mar 1999 10:11:39 +0100
Message-ID: <19990305101139.H2111@uni-koblenz.de>
Date: Fri, 5 Mar 1999 10:11:39 +0100
From: ralf@uni-koblenz.de
To: Ben Payne <bpayne@propeller.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Debuggers?
References: <51C3D69B3643D21194AD00400551982C5103@dino-192.propeller.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <51C3D69B3643D21194AD00400551982C5103@dino-192.propeller.com>; from Ben Payne on Wed, Mar 03, 1999 at 01:04:55PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Mar 03, 1999 at 01:04:55PM -0800, Ben Payne wrote:

> I recently installed Linux on an Indy and was looking for GDB.  It's not
> part of the hardhat install, and the source doesn't support the
> mips-linux host.  I need to develop an application on the mips-linux
> architecture is there any debuggers available?  I saw a mention of a
> patch to GDB in the list archive.  Is this solution stable?  And where
> can I get the latest GDB patch?

The GDB source is available via anonymous CVS from linus.linux.sgi.com.
It's not perfectly stable yet.

  Ralf
