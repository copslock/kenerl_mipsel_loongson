Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA25753 for <linux-archive@neteng.engr.sgi.com>; Sun, 27 Dec 1998 18:34:07 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA71081
	for linux-list;
	Sun, 27 Dec 1998 18:33:14 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.61.141])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id SAA84639;
	Sun, 27 Dec 1998 18:33:09 -0800 (PST)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id SAA18705; Sun, 27 Dec 1998 18:32:31 -0800
Date: Sun, 27 Dec 1998 18:32:31 -0800
Message-Id: <199812280232.SAA18705@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: Greg Chesson <greg@xtp.engr.sgi.com>,
        Alex deVries <adevries@engsoc.carleton.ca>,
        Ariel Faigon <ariel@cthulhu.engr.sgi.com>,
        Fredrik Rovik <fredrov@hotmail.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Status
In-Reply-To: <19981224190545.A648@uni-koblenz.de>
References: <Pine.LNX.3.96.981222224859.1946C-100000@lager.engsoc.carleton.ca>
	<adevries@engsoc.carleton.ca>
	<9812230951.ZM5336@xtp.engr.sgi.com>
	<19981224190545.A648@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
...
 > > What we need to do is make it easy for Linux to determine what
 > > chipsets are attached to the cpu.  Bill Earl might have some straightforward
 > > answers.  I'm in favor of simply publishing the relevant sections
 > > of Irix bootstrap code.  Perhaps Santa Claus can make a code drop this year.
 > 
 > Isn't that ``Full House'' vs. ``Guiness''?  Linux knows that difference since
 > it is running on the Indy.

       The basic difference is between "FullHouse" (Indigo2) and "Guinness"
(Indy).  Beyond that, there are smaller differences between Indy and Challenge S.
Challenge S does have an extra SCSI channel, but the configuration is not
identical to Indigo2.  (I will look into that later.)

      I am still working on an agreement to release more technical information
about a variety of our systems.  
