Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id RAA107281 for <linux-archive@neteng.engr.sgi.com>; Tue, 7 Oct 1997 17:31:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA04199 for linux-list; Tue, 7 Oct 1997 17:30:45 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA04183 for <linux@engr.sgi.com>; Tue, 7 Oct 1997 17:30:43 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id RAA22931; Tue, 7 Oct 1997 17:30:41 -0700
Date: Tue, 7 Oct 1997 17:30:41 -0700
Message-Id: <199710080030.RAA22931@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: More Linux/SGI status
In-Reply-To: <199710072241.RAA01259@athena.nuclecu.unam.mx>
References: <199710072241.RAA01259@athena.nuclecu.unam.mx>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza writes:
...
 > 	3. Would it be possible to negotiate with SGI management 
 > 	   the posibility of shipping the IRIX runtime libraries and
 > 	   the X server as found on IRIX with a Linux disrtibution?
...

      Perhaps Ariel can check on this, but I suspect that there are licensing
problems.  Each SGI system comes with a license to use one copy of the
software, where the fees which SGI must pay for each copy are bundled
in the cost of the system.  That is, if you have a system, the system 
includes the license.  The licenses involved include more than just
the basic UNIX and NFS licenses.  For example, the X server includes
optional Display Postscript support licensed from Adobe.  

      You could consider a scheme for automatically extracting the parts
you need from an IRIX distribution CD.  That is, the system normally
comes with the CD for the software (although that may be lost for an older
system), and the user has the right to use the CD on that system.
If the linux installation were willing to mount that CD and pull out
the components, the user model would not be too awkward (although obviously
not as nice as having one distribution).  If you were able to run the
IRIX inst on linux, you could extract it from the CD and ask it
to pull the files from the distribution.  (There is a miniroot EFS file
system image on the CD, and inst is on that image; the rest of the distribution
is in packed data files decoded by inst.)
