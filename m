Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id GAA30354
	for <pstadt@stud.fh-heilbronn.de>; Thu, 23 Sep 1999 06:00:23 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id UAA10328; Wed, 22 Sep 1999 20:56:37 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA98185
	for linux-list;
	Wed, 22 Sep 1999 20:51:52 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA91104
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 22 Sep 1999 20:51:50 -0700 (PDT)
	mail_from (eak@detroit.sgi.com)
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id UAA27527; Wed, 22 Sep 1999 20:51:44 -0700 (PDT)
Received: from cx1.detroit.sgi.com (cx1.detroit.sgi.com [169.238.130.4]) by dataserv.detroit.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA14529; Wed, 22 Sep 1999 23:51:43 -0400 (EDT)
Received: from detroit.sgi.com (localhost [127.0.0.1]) by cx1.detroit.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id XAA45243; Wed, 22 Sep 1999 23:50:42 -0400 (EDT)
Message-ID: <37E9A391.1BF899DE@detroit.sgi.com>
Date: Wed, 22 Sep 1999 23:50:41 -0400
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@sgi.com
Organization: sgi
X-Mailer: Mozilla 4.61C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Rory Hunter <roryh@dcs.ed.ac.uk>
CC: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: oddness
References: <37E95D52.AC2CE967@dcs.ed.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Rory Hunter wrote:
> 
> hi,
> 
> I noticed yesteday that it appears that a partition has been set aside
> by the previous owners of my O2 for /proc... assuming that 'df' isn't
> lying to me, can anyone think of a reason why an 800Mb partition would
> be set aside for /proc?
> 
> Cheers,
> 
> Rory Hunter

proc is your process table - it isn't taking file system space.
pretent it doesnt exist. Ignore it. Its "kernel stuff"


-- 
.--------1---------2---------3---------4---------5---------6---------7.
  Eric Kimminau           eak@sgi.com       Electronic Support Tools
      Vox:248-848-4455  Fax:248-848-5600  VNET:6-327-4455  
              "I speak my mind and no one else's."
 "I am a bomb technician. If you see me running, try to keep up..."
                    http://support.sgi.com
