Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA13974; Fri, 13 Jun 1997 13:37:57 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA01106 for linux-list; Fri, 13 Jun 1997 13:37:37 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA01101; Fri, 13 Jun 1997 13:37:35 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id NAA29267; Fri, 13 Jun 1997 13:37:35 -0700
Date: Fri, 13 Jun 1997 13:37:35 -0700
Message-Id: <199706132037.NAA29267@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ariel@sgi.com (Ariel Faigon)
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: gcc for Irix.
In-Reply-To: <199706131750.KAA09670@yon.engr.sgi.com>
References: <199706131654.JAA28555@fir.engr.sgi.com>
	<199706131750.KAA09670@yon.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ariel Faigon writes:
 > :
 > :Miguel de Icaza writes:
 > :...
 > : >    I am running into a little problem.  The binary gcc that is
 > : > available on the free software collection is for Irix 5.3 and the
 > : > include files that are packaged with it are not quite ok for Irix 6.2
 > :...
 > :
 > :      In what way do the 5.3 include files cause problems?
 > :
 > 
 > [Note: I'm taking care of Miguel in private email]
 > 
 > The headers that come with gcc are:
 > 
 > 	1) Only a very small subset of the full set of headers
 > 	   which were preprocessed by gcc 'fix_header' utility.
 > 
 > 	2) Correspond to the OS version on which gcc was built
 > 	   which may be incompatible in subtle ways with the
 > 	   runtime libraries on a later OS version.
 > 
 > Since Miguel's Indy is (apparently) a 6.2 IRIX, possibly
 > without all the necessary header patches, and the gcc he
 > is trying was built on 5.3, I can see why he has header
 > problems.

       If the old headers do not work on the new system, that is a
bug, not a feature.  There had better not be any subtle
incompatibilities.  (New headers will not work on an old system, but
that is a different problem.)
