Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA97033 for <linux-archive@neteng.engr.sgi.com>; Tue, 12 Jan 1999 14:19:29 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA32125
	for linux-list;
	Tue, 12 Jan 1999 14:18:11 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fddi-sgi.engr.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA29006
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 12 Jan 1999 14:18:09 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by fddi-sgi.engr.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00944; Tue, 12 Jan 1999 14:16:41 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-25.uni-koblenz.de [141.26.249.25])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA19768;
	Tue, 12 Jan 1999 23:12:48 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id RAA00933;
	Tue, 12 Jan 1999 17:51:47 +0100
Message-ID: <19990112175147.C341@uni-koblenz.de>
Date: Tue, 12 Jan 1999 17:51:47 +0100
From: ralf@uni-koblenz.de
To: chad@sgi.engr.sgi.com, linux <linux@cthulhu.engr.sgi.com>
Cc: Alex deVries <adevries@engsoc.carleton.ca>
Subject: Re: same boot vmlinux trouble
References: <369AD0C2.977C04AC@dallas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <369AD0C2.977C04AC@dallas.sgi.com>; from Chad Carlin on Mon, Jan 11, 1999 at 10:34:10PM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jan 11, 1999 at 10:34:10PM -0600, Chad Carlin wrote:

> Still having the same problem. Anyone have a more recent vmlinux kernel?
> Does anyone have a sample of what this boot output looks like when it
> works? 
> 
> BTW I have mounted my linux dev directory on another linux machine and
> was able to write to the console device. Also was able to create new
> device files in the mounted directory and use those as well.
> 
> I'm pretty stuck here. Any help would be appreciated.

This old kernel doesn't handle R4000 / R4400 SC versions correctly, you'll
need a newer one.

Alex, could you brew a binary kernel from CVS?  Thanks.

  Ralf
