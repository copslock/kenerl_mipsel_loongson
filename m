Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA04903 for <linux-archive@neteng.engr.sgi.com>; Mon, 29 Mar 1999 23:44:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA07237
	for linux-list;
	Mon, 29 Mar 1999 23:43:58 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA41040
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 29 Mar 1999 23:43:31 -0800 (PST)
	mail_from (eedthwo@eede.ericsson.se)
Received: from penguin.wise.edt.ericsson.se (penguin-ext.wise.edt.ericsson.se [194.237.142.5]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id XAA06874
	for <linux@cthulhu.engr.sgi.com>; Mon, 29 Mar 1999 23:43:26 -0800 (PST)
	mail_from (eedthwo@eede.ericsson.se)
Received: from eede.ericsson.se (eede.eede.ericsson.se [164.48.127.16])
	by penguin.wise.edt.ericsson.se (8.9.0/8.9.0/WIREfire-1.2) with SMTP id JAA24885;
	Tue, 30 Mar 1999 09:43:20 +0200 (MET DST)
Received: from sun168.eu (sun168.eede.ericsson.se) by eede.ericsson.se (4.1/SMI-4.1)
	id AA16359; Tue, 30 Mar 99 09:43:16 +0200
Received: by sun168.eu (SMI-8.6/SMI-SVR4)
	id JAA15859; Tue, 30 Mar 1999 09:43:16 +0200
Date: Tue, 30 Mar 1999 09:43:16 +0200
Message-Id: <199903300743.JAA15859@sun168.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Tom Woelfel <eedthwo@eede.ericsson.se>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux@cthulhu.engr.sgi.com
Subject: New Indy kernel uploaded
In-Reply-To: <19990329012602.A3227@alpha.franken.de>
References: <19990329012602.A3227@alpha.franken.de>
X-Mailer: VM 6.31 under 20.2 XEmacs Lucid
Reply-To: eedthwo@eede.ericsson.se
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thomas Bogendoerfer writes:
 > After killing a lot of SCSI bugs during the last weeks, I've made a new
 > kernel with all of the fixes in it. It also contains a workaround 
 > for the problem with hanging after "Freeing unused kernel memory".
 > 
 > Everyone, who had problems with older kernels, please test this kernel.

Yep, done. Works without problems - Linux is up and running. How do
you solve the problems with the ECOFF/ELF thing ? Is there some kind
of backwards-compatibility ? 

Thanx a lot :-)))

If you need testing support for some more kernels simply drop a note.

//Tom
