Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA76349 for <linux-archive@neteng.engr.sgi.com>; Thu, 17 Jun 1999 13:33:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA86741
	for linux-list;
	Thu, 17 Jun 1999 13:32:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA62300
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 17 Jun 1999 13:32:44 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: from calvin.tor.onramp.ca (calvin.tor.onramp.ca [204.225.88.15]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id NAA05668
	for <linux@cthulhu.engr.sgi.com>; Thu, 17 Jun 1999 13:32:43 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: (qmail 16403 invoked from network); 17 Jun 1999 20:32:42 -0000
Received: from imail.hgeng.com (HELO bart.hgeng.com) (199.246.72.233)
  by mail.onramp.ca with SMTP; 17 Jun 1999 20:32:42 -0000
Received: by BART with Internet Mail Service (5.5.2232.9)
	id <NCDWK6LM>; Thu, 17 Jun 1999 16:34:55 -0400
Message-ID: <E138DB347D10D3119C630008C79F5DEC07EA11@BART>
From: Mike Hill <mikehill@hgeng.com>
To: "'Andrew R. Baker'" <andrewb@uab.edu>
Cc: linux@cthulhu.engr.sgi.com
Subject: RE: Booting an Indigo2
Date: Thu, 17 Jun 1999 16:34:55 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2232.9)
Content-Type: text/plain
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Therefore if I were to connect my Indy Linux drive internally in the
Indigo2, I might be able to boot the kernel locally?

Thanks,

Mike

> -----Original Message-----
> From:	Andrew R. Baker [SMTP:andrewb@uab.edu]
> Sent:	Thursday, June 17, 1999 3:54 PM
> To:	Mike Hill
> Cc:	linux@cthulhu.engr.sgi.com
> Subject:	Re: Booting an Indigo2
> 
> This is on my todo list.  The SCSI driver only detects one (the internal)
> controller.  This is fine and dandy on the Indy 'cause it only has one
> SCSI controller.  The Indigo2 has two, so the driver needs to be modified
> to detect (and access) the second one.  I plan on doing this as soon as I
> get my home box up and running.
> 
> -Andrew
