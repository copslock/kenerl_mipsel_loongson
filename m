Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA91750 for <linux-archive@neteng.engr.sgi.com>; Tue, 9 Feb 1999 07:15:39 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA26618
	for linux-list;
	Tue, 9 Feb 1999 07:14:38 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA19730
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 9 Feb 1999 07:14:36 -0800 (PST)
	mail_from (eak@detroit.sgi.com)
Received: from detroit.sgi.com (cx1.detroit.sgi.com [169.238.130.4]) by dataserv.detroit.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA13720; Tue, 9 Feb 1999 10:14:28 -0500 (EST)
Message-ID: <36C04FC3.D7120153@detroit.sgi.com>
Date: Tue, 09 Feb 1999 07:09:55 -0800
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@sgi.com
Organization: SGI
X-Mailer: Mozilla 4.51C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex deVries <adevries@engsoc.carleton.ca>
CC: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Moving drivers/sgi around
References: <Pine.LNX.3.96.990208190349.11444F-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote:
> 
> Are there any objections to me moving drivers/sgi and merging them into
> the 'correct' places?  The places in question are:
> 
> newport and colsole stuff: drivers/video
> hal: drivers/sound
> vino: drivers/char (which is there, actually)
> 
> Any objections?
> 
> - Alex

Sounds like the right thing to do to me.


-- 
---------1---------2---------3---------4---------5---------6---------7
  Eric Kimminau           eak@sgi.com       Electronic Support Tools
      Vox:248-848-4455  Fax:248-848-5600  VNET:6-327-4455  

              "I speak my mind and no one else's."
 "I am a bomb technician. If you see me running, try to keep up..."
                    http://support.sgi.com
