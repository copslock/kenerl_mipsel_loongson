Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id QAA23530
	for <pstadt@stud.fh-heilbronn.de>; Wed, 30 Jun 1999 16:54:17 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA26232; Wed, 30 Jun 1999 07:51:46 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA24499
	for linux-list;
	Wed, 30 Jun 1999 07:50:04 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA55805
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 30 Jun 1999 07:50:02 -0700 (PDT)
	mail_from (eedthwo@eede.ericsson.se)
Received: from penguin.wise.edt.ericsson.se (penguin-ext.wise.edt.ericsson.se [194.237.142.110]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA01784
	for <linux@cthulhu.engr.sgi.com>; Wed, 30 Jun 1999 07:50:00 -0700 (PDT)
	mail_from (eedthwo@eede.ericsson.se)
Received: from eede.ericsson.se (eede.eede.ericsson.se [164.48.127.16])
	by penguin.wise.edt.ericsson.se (8.9.3/8.9.3/WIREfire-1.3) with SMTP id QAA20334;
	Wed, 30 Jun 1999 16:49:57 +0200 (MET DST)
Received: from sun168.eu (sun168.eede.ericsson.se) by eede.ericsson.se (4.1/SMI-4.1)
	id AA29506; Wed, 30 Jun 99 16:49:55 +0200
Received: by sun168.eu (SMI-8.6/SMI-SVR4)
	id QAA14683; Wed, 30 Jun 1999 16:49:55 +0200
Date: Wed, 30 Jun 1999 16:49:55 +0200
Message-Id: <199906301449.QAA14683@sun168.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Tom Woelfel <eedthwo@eede.ericsson.se>
To: "Dag Bakke" <dagb@oslo.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: IRIX Partations with HardHat Linux
In-Reply-To: <9906301627.ZM14888@dagb.oslo.sgi.com>
References: <Pine.GSO.4.10.9906301001520.8406-100000@z.glue.umd.edu>
	<weave@eng.umd.edu>
	<9906301627.ZM14888@dagb.oslo.sgi.com>
X-Mailer: VM 6.31 under 20.2 XEmacs Lucid
Reply-To: eedthwo@eede.ericsson.se
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Dag Bakke writes:
 > As I understand it, you only need to partition the disk with the SGI tools
 > (fx).
 > (If this is wrong, please feel free to correct me.)
 > Thus, you only need bootp and tftp to boot fx.

Yep. 

 > To boot fx on the Indy from the prom monitor (command monitor) enter:
 > setenv -p netaddr 123.456.789.123
 > boot -f bootp()remotemachine:/path/to/stand/fx.ARCS

After endeavouring with the bootp/tftp options for a couple of hours I
finally managed to get sash or fx loaded. But I've seen lot of
rejected requests during this session from the i386 server. But what's
the next step ? Do I have to change the bootfile-entry in bootptab to
point to the next requested file ? (Ooops, I'm at work - so I don't
have access to my Indy, but after partitioning the disk the Indy
requested something like sash(NN).)

I will try it once again and write down my experiences.

//Tom
