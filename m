Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id SAA09685
	for <pstadt@stud.fh-heilbronn.de>; Wed, 30 Jun 1999 18:57:17 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA17234; Wed, 30 Jun 1999 09:51:41 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA69173
	for linux-list;
	Wed, 30 Jun 1999 09:48:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA10662
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 30 Jun 1999 09:48:33 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup118-3-25.swipnet.se [130.244.118.153]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA07220
	for <linux@cthulhu.engr.sgi.com>; Wed, 30 Jun 1999 09:48:30 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10zNXF-003LoBC; Wed, 30 Jun 1999 18:48:33 +0200 (CEST)
Date: Wed, 30 Jun 1999 18:48:32 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: Dag Bakke <dagb@oslo.sgi.com>
Cc: swerner@fcc.net, Roald Lygre <roald@stavanger.sgi.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: Re: IRIX Partations with HardHat Linux
Message-ID: <19990630184832.A10104@thepuffingroup.com>
Mail-Followup-To: Dag Bakke <dagb@oslo.sgi.com>, swerner@fcc.net,
	Roald Lygre <roald@stavanger.sgi.com>, linux@cthulhu.engr.sgi.com
References: <3778E3EC.CCB6C133@fcc.net> <9906300843.ZM53756@roald.stavanger.sgi.com> <3779E179.F10978F8@fcc.net> <swerner@fcc.net> <9906301525.ZM14720@dagb.oslo.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <9906301525.ZM14720@dagb.oslo.sgi.com>; from Dag Bakke on Wed, Jun 30, 1999 at 03:25:00PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jun 30, 1999 at 03:25:00PM +0000, Dag Bakke wrote:
> No, you're not. Install linux 2.2.7 (.9?) on any i386 and enable experimental
> options and EFS.
> 
> Then you should be able to mount the CD on the linux-i386 box and set up tftp,
> bootp and nfs for remote booting/installing. (You don't need nfs for booting
> fx, though.)
> Something for a rainy day....

This would probably be much easier if you used the initrd stuff Thomas B.
recently wrote.  This is not tested, but I think it may work.  If it works you
may setup the initrd partition so that you have the tools you need to partition
the SCSI harddrive with a decent EFS disklabel (this partition is afterwards
appended on the end of the kernel).  I think Thomas has been working on a new
redhat installer using the initrd, but I doubt he finished it.

What's the current status?

Ulf
