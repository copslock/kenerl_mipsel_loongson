Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA324787 for <linux-archive@neteng.engr.sgi.com>; Mon, 2 Mar 1998 16:42:39 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id QAA162000 for linux-list; Mon, 2 Mar 1998 16:41:15 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA144030 for <linux@cthulhu.engr.sgi.com>; Mon, 2 Mar 1998 16:41:13 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980205.SGI.8.8.8/980301.SGI-antispam) via ESMTP id QAA05005
	for <linux@cthulhu.engr.sgi.com>; Mon, 2 Mar 1998 16:41:11 -0800 (PST)
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-21.uni-koblenz.de [141.26.249.21])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id BAA18556
	for <linux@cthulhu.engr.sgi.com>; Tue, 3 Mar 1998 01:41:09 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA10081;
	Tue, 3 Mar 1998 01:28:49 +0100
Message-ID: <19980303012847.49483@uni-koblenz.de>
Date: Tue, 3 Mar 1998 01:28:47 +0100
To: "Chris. Rupnik" <chrisr@hp817.speedware.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Netbooting Questions
References: <199803022337.SAA07626@hp817.speedware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199803022337.SAA07626@hp817.speedware.com>; from Chris. Rupnik on Mon, Mar 02, 1998 at 06:37:01PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Mar 02, 1998 at 06:37:01PM -0500, Chris. Rupnik wrote:

> Hi All,
>  I am attempting to netboot my MIPS machine. I have bfs running, now i am 
>  just looking for something to boot!
> 
>  This is what i get on the serial console. Note that the machine is in
>  big endian mode.
> 
>  Rx4230 MIPS Monitor: Version 5.60 OPT-EB Wed Jun 17 11:23:28 PDT 1992 root
> 
>  now, from the instructions that Paul Antoine wrote about a year ago,
>  the correct command to boot would be 
> 
> 
>  boot -f bfs()_filename_
> 
>  ok, so here we go
> 
>  >> boot -f bfs()coco       
>  No server for coco                                                             
>  couldn't load bfs()coco                                                        
>  >> 
> 
> 
>  That is cool , as there is nothing in the directory called coco

Indeed it is cool because I had reports that our version of bfsd isn't
working.

>  but, i need a first stage loader, i believe, like the SASH that is 
>  installed by RISC/OS. I have access to an SGI Webforce, but it does not
>  have any sash on the machine. I also cannot mount the IRIX install cd in
>  any other machine. The CD is not in CD9660 format, it appears.

The IRIX CD is EFS format and therefore not readable by the Magnum firmware.
Anyway, IRIX and IRIX's sash won't run on the box.

The sash binary is hidden in the volume header in kind of a very, very
primitive filesystem - more similar to an ar archive than to a filesystem.

I *suppose* that the way the IRIX and the RISC/os disks are layed out is
similar.  Anybody more details?

In order to see how things look like on IRIX you may take a look at
prtvtoc(1M), fx(1M), dvhtool(1M) and vh(7M).  Furthermore the headerfile
/usr/include/sys/dvh.h contains helpful stuff about how the volumeheader of
the box looks like.

>  So , i am looking for a little advice on getting to the next step. If anyone
>  has any ideas, please let me know!

Bad news.  The big endian mode of the Magnum isn't supported so far.
Therefore there is nothing sash alike yet.  I hope hope the Magnum gurus at
SGI can tell us more.

  Ralf
