Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id FAA00319
	for <pstadt@stud.fh-heilbronn.de>; Sat, 18 Sep 1999 05:57:49 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA03835; Fri, 17 Sep 1999 20:54:46 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA31373
	for linux-list;
	Fri, 17 Sep 1999 20:49:28 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA17381;
	Fri, 17 Sep 1999 20:49:25 -0700 (PDT)
	mail_from (eak@detroit.sgi.com)
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id UAA15203; Fri, 17 Sep 1999 20:49:23 -0700 (PDT)
Received: from cx1.detroit.sgi.com (cx1.detroit.sgi.com [169.238.130.4]) by dataserv.detroit.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA03791; Fri, 17 Sep 1999 23:49:22 -0400 (EDT)
Received: from detroit.sgi.com (localhost [127.0.0.1]) by cx1.detroit.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id XAA28756; Fri, 17 Sep 1999 23:48:30 -0400 (EDT)
Message-ID: <37E30B8D.4A946727@detroit.sgi.com>
Date: Fri, 17 Sep 1999 23:48:29 -0400
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@sgi.com
Organization: sgi
X-Mailer: Mozilla 4.61C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Rory Hunter <roryh@dcs.ed.ac.uk>
CC: Ariel Faigon <ariel@cthulhu.engr.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: about the O2..
References: <199909172104.OAA58099@oz.engr.sgi.com> <37E2D8C0.CD183739@dcs.ed.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Rory Hunter wrote:
> 
> Hi,
> 
> > Pretty clean, doesn't interfere with IRIX apps and work
> > pretty well for thousands of SGI customers.
> 
> That's all good and well, except the software that installs
> these damn things appears to require 'ls' (since it's usually
> a reasonable assumption that it'll be there). I tried to
> install the necessary tardist but the program screamed and
> died.
> 
> I would have expected the installer to be more independant,
> in case IRIX newbies (like moi) fuck up so badly.
> 
> I still prefer Linux >:))
> 
> Rory Hunter
> 
> "SunOS or IRIX? It's a bit like a choice between
> warm beer or dying of thirst, either way you lose."

Rory,

1: a tardist file is justa tared inst distribution. 
move it to a directory, cd to directory
tar xvf filename.tardist
then, as root, run the command "inst -f ."
k *
i d
conf
l i
check that it is installing everything you like
go
quit
inst is the command line version of softwaremanager

Personally, I wish Linux would convert to the IRIX filesystem layout.
I prefer IRIX to Linux, but then its going to be a while before the
power of IRIX is available within Linux.

Please let me know if I can give you a hand with your IRIX system. I
strongly suggest at IRIX 6.3 you go get the entire 6.3 recommended
patchset and get it installed yesterday. You will see a great
improvement in how the entire system functions. Take a look at
http://support.sgi.com and click on New Membership if you don't
already have a surfzone ID.

Good Luck!
                    Eric.



-- 
.--------1---------2---------3---------4---------5---------6---------7.
  Eric Kimminau           eak@sgi.com       Electronic Support Tools
      Vox:248-848-4455  Fax:248-848-5600  VNET:6-327-4455  
              "I speak my mind and no one else's."
 "I am a bomb technician. If you see me running, try to keep up..."
                    http://support.sgi.com
