Received:  by oss.sgi.com id <S305173AbQCALtT>;
	Wed, 1 Mar 2000 03:49:19 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:55379 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQCALtN>;
	Wed, 1 Mar 2000 03:49:13 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA24353; Wed, 1 Mar 2000 03:44:39 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA75531
	for linux-list;
	Wed, 1 Mar 2000 03:39:27 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA11278
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Mar 2000 03:39:23 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA01318
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Mar 2000 03:39:22 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C9CBE7F5; Wed,  1 Mar 2000 12:39:21 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 4EF718FC3; Wed,  1 Mar 2000 12:26:50 +0100 (CET)
Date:   Wed, 1 Mar 2000 12:26:50 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: 2.3.47 success on Decstation 5000/150, problems with login
Message-ID: <20000301122650.A5186@paradigm.rfc822.org>
References: <20000301115053.A4608@paradigm.rfc822.org> <Pine.GSO.4.10.10003011222500.13477-100000@dandelion.sonytel.be> <20000301122329.B4608@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000301122329.B4608@paradigm.rfc822.org>; from Florian Lohoff on Wed, Mar 01, 2000 at 12:23:29PM +0100
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Mar 01, 2000 at 12:23:29PM +0100, Florian Lohoff wrote:
> On Wed, Mar 01, 2000 at 12:25:02PM +0100, Geert Uytterhoeven wrote:
> > 
> > What does `ssh -v root@repeat.rfc822.org' say?
> 
> (flo@ping)~# ssh -v root@repeat.rfc822.org 
> SSH Version 1.2.26 [i586-unknown-linux], protocol version 1.5.
> Standard version.  Does not use RSAREF.

BTW:

ssh root@repeat.rfc822.org reboot 

Works - So it has to be something with the "interactive session" therefor
i suspected PTY98 things ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
