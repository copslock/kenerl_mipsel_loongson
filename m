Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA09278 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Feb 1999 03:33:27 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA42579
	for linux-list;
	Wed, 3 Feb 1999 03:32:26 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA32662;
	Wed, 3 Feb 1999 03:32:23 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA01859; Wed, 3 Feb 1999 03:32:22 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-2.uni-koblenz.de [141.26.131.2])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id MAA18031;
	Wed, 3 Feb 1999 12:32:15 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id EAA04818;
	Wed, 3 Feb 1999 04:42:07 +0100
Message-ID: <19990203044207.E3920@uni-koblenz.de>
Date: Wed, 3 Feb 1999 04:42:07 +0100
From: ralf@uni-koblenz.de
To: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>, chad@sgi.com
Cc: Alexander Graefe <nachtfalke@usa.net>, linux@cthulhu.engr.sgi.com
Subject: Re: What kernel to use to install RH on a R4400 ?
References: <36B74206.8E63A799@roctane.dallas.sgi.com> <Pine.SGI.4.05.9902021026050.3770-100000@tantrik.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.SGI.4.05.9902021026050.3770-100000@tantrik.engr.sgi.com>; from Shrijeet Mukherjee on Tue, Feb 02, 1999 at 10:30:39AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Feb 02, 1999 at 10:30:39AM -0800, Shrijeet Mukherjee wrote:

> yeah the 2.1.131 kernel seemed to detect my SCSI devices and just stop ..
> not being NFS bootable would explain that ..

It should not just stop but print a message like ``Cannot mount root
filesystem''.

  Ralf
