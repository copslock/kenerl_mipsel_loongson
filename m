Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA42179 for <linux-archive@neteng.engr.sgi.com>; Wed, 27 Jan 1999 15:28:51 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA25894
	for linux-list;
	Wed, 27 Jan 1999 15:28:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA26628
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 27 Jan 1999 15:27:59 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA02217
	for <linux@cthulhu.engr.sgi.com>; Wed, 27 Jan 1999 15:27:57 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-22.uni-koblenz.de [141.26.131.22])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA15654
	for <linux@cthulhu.engr.sgi.com>; Thu, 28 Jan 1999 00:27:54 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id AAA16826;
	Thu, 28 Jan 1999 00:25:51 +0100
Message-ID: <19990128002550.F909@uni-koblenz.de>
Date: Thu, 28 Jan 1999 00:25:50 +0100
From: ralf@uni-koblenz.de
To: "Mark A. Zottola" <asnmaz01@asc.edu>,
        SGI Linux Group <linux@cthulhu.engr.sgi.com>
Subject: Re: FORTRAN Compoiler
References: <36AF5027.80A9F6CD@asc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <36AF5027.80A9F6CD@asc.edu>; from Mark A. Zottola on Wed, Jan 27, 1999 at 11:43:03AM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jan 27, 1999 at 11:43:03AM -0600, Mark A. Zottola wrote:

> I am leading the effort to build a Beowulf cluster out of Indigo2's on
> the UAB campus. My student Andrew posted our intentions to this list a
> few days ago. While we are in the process of getting started in the
> porting process, I would like to do some benchmarking on the System we
> currently have. Therefore I need a compiler (or much less optimally -
> compilers) which run on MIPS architecture and can be used both with
> LINUX and IRIX. A tall order to be sure. I really do NOT want to use the
> gnu f77 compiler (and I do not know whether it will work on IRIX or
> not).

You can try to either porting g77 or alternativly f2c which is already
available on ftp.linux.sgi.com.  I'm shure there is no other commercial
quality (whatever that means ...) compiler available.

  Ralf
