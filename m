Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA98356; Fri, 15 Aug 1997 13:39:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA07913 for linux-list; Fri, 15 Aug 1997 13:38:50 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA07875 for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 13:38:47 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA27142
	for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 13:38:45 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id QAA21985; Fri, 15 Aug 1997 16:38:14 -0400
Date: Fri, 15 Aug 1997 16:38:14 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Ariel Faigon <ariel@sgi.com>
cc: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Re: boot linux - wish
In-Reply-To: <199708152017.NAA04153@oz.engr.sgi.com>
Message-ID: <Pine.LNX.3.95.970815163117.21813A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, 15 Aug 1997, Ariel Faigon wrote:
> 
> Could someone rise to the challenge of writing a utility
> that will install Linux on an IRIX machine?

I don't mind rising to that challenge, but one huge obstacle is how do we
get the utility to partition the Linux drive? 

I'm guessing the solution is to write a utility that from within Irix
talks directly to the raw SCSI disk to setup the partitions.  I have NO
idea how to do this as I doubt the raw disk interface is anything like
that in Linux. Clues accepted.

Does anyone have any suggestions to this?

> 	On what partition do you want to install Linux on [/dev/sdb7]?
> 
> And give hints like:
> 	Sorry you don't have the e2fs tools installed on IRIX yet
> 	should I download them from ftp.linux.sgi.com [y/n]?

Er, does such a tool in fact exist?


In any case, I don't mind handling the writing of such a utility so long
as I get help with the two parts I'm as of yet unable to address:
partitioning and setting up boot options without entering the boot
monitor.

- Alex
