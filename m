Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA43107 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Mar 1999 14:55:53 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA76038
	for linux-list;
	Wed, 10 Mar 1999 14:54:55 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA35042
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 10 Mar 1999 14:54:53 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA06467
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Mar 1999 14:54:47 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-10.uni-koblenz.de [141.26.131.10])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA28858
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Mar 1999 23:54:45 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id RAA05987;
	Wed, 10 Mar 1999 17:54:06 +0100
Message-ID: <19990310175351.G497@uni-koblenz.de>
Date: Wed, 10 Mar 1999 17:53:51 +0100
From: ralf@uni-koblenz.de
To: eedthwo@eede.ericsson.se, Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Illegal f_magic number while install-procedure
References: <199903081247.NAA02741@sun168.eu> <19990309000234.A2804@alpha.franken.de> <199903100920.KAA01213@sun168.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199903100920.KAA01213@sun168.eu>; from Tom Woelfel on Wed, Mar 10, 1999 at 10:20:19AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Mar 10, 1999 at 10:20:19AM +0100, Tom Woelfel wrote:

> My Indy has seen the light ;-). The kernel boots and goes it's way
> through the device checking. All disk's are recognized and the
> mount-request for the root-file-system is send to the server. The
> (root)-dir is mounted from the Indy. (I can see this in the server-log)
> Then the prom-memory is freed and the last thing I see is: 
> freeing unused kernel memory 52k
> 
> Then nothing happens anymore. I think the next thing to come should be 
> the 'init' process (init doesn't need to be an ECOFF - exec ?).
> 
> Or do I nedd a modified init to jump into setup?

No, you definately don't need any other changes than the kernel since the
kernel image is the only file that is ever being touched by the PROM.

  Ralf
