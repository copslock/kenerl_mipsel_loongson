Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id PAA14209
	for <pstadt@stud.fh-heilbronn.de>; Wed, 30 Jun 1999 15:53:17 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA03175; Wed, 30 Jun 1999 06:51:25 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA29107
	for linux-list;
	Wed, 30 Jun 1999 06:48:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA59254
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 30 Jun 1999 06:48:51 -0700 (PDT)
	mail_from (eedthwo@eede.ericsson.se)
Received: from penguin.wise.edt.ericsson.se (penguin-ext.wise.edt.ericsson.se [194.237.142.110]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA07696
	for <linux@cthulhu.engr.sgi.com>; Wed, 30 Jun 1999 06:48:49 -0700 (PDT)
	mail_from (eedthwo@eede.ericsson.se)
Received: from eede.ericsson.se (eede.eede.ericsson.se [164.48.127.16])
	by penguin.wise.edt.ericsson.se (8.9.3/8.9.3/WIREfire-1.3) with SMTP id PAA05335;
	Wed, 30 Jun 1999 15:48:38 +0200 (MET DST)
Received: from sun168.eu (sun168.eede.ericsson.se) by eede.ericsson.se (4.1/SMI-4.1)
	id AA27397; Wed, 30 Jun 99 15:48:36 +0200
Received: by sun168.eu (SMI-8.6/SMI-SVR4)
	id PAA13995; Wed, 30 Jun 1999 15:48:36 +0200
Date: Wed, 30 Jun 1999 15:48:36 +0200
Message-Id: <199906301348.PAA13995@sun168.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Tom Woelfel <eedthwo@eede.ericsson.se>
To: "Dag Bakke" <dagb@oslo.sgi.com>
Cc: swerner@fcc.net, Roald Lygre <roald@stavanger.sgi.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: IRIX Partations with HardHat Linux
In-Reply-To: <9906301525.ZM14720@dagb.oslo.sgi.com>
References: <3778E3EC.CCB6C133@fcc.net>
	<9906300843.ZM53756@roald.stavanger.sgi.com>
	<3779E179.F10978F8@fcc.net>
	<swerner@fcc.net>
	<9906301525.ZM14720@dagb.oslo.sgi.com>
X-Mailer: VM 6.31 under 20.2 XEmacs Lucid
Reply-To: eedthwo@eede.ericsson.se
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Dag Bakke writes:
 > No, you're not. Install linux 2.2.7 (.9?) on any i386 and enable experimental
 > options and EFS.
 > 
 > Then you should be able to mount the CD on the linux-i386 box and set up tftp,
 > bootp and nfs for remote booting/installing. (You don't need nfs for booting
 > fx, though.)
 > Something for a rainy day....

Hmm, is there a FAQ on how to set up such an environment ? 

I've alreayd tried to boot/install from a remote mounted cdrom. This
always results in an error. Then I've tried to copy the Irix-CD to a
directory and install from this directory. I was able to invoke fx on
the Indy, but I was not able to proceed with the installation.

(During Linux/SGI install I made propably an error which results in a
corrupted Indy-filesystem - so I'm forced to reinstall Irix on my
Indy.)

//Tom


  
