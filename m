Received:  by oss.sgi.com id <S305180AbQDRKTy>;
	Tue, 18 Apr 2000 03:19:54 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:33148 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305161AbQDRKTj>;
	Tue, 18 Apr 2000 03:19:39 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA13079; Tue, 18 Apr 2000 03:14:54 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id DAA78492; Tue, 18 Apr 2000 03:17:53 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA05056
	for linux-list;
	Tue, 18 Apr 2000 03:04:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA02866
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 18 Apr 2000 03:04:09 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA03264
	for <linux@cthulhu.engr.sgi.com>; Tue, 18 Apr 2000 03:04:08 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id F1B0584F; Tue, 18 Apr 2000 12:04:09 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 586FD8FC4; Tue, 18 Apr 2000 12:00:06 +0200 (CEST)
Date:   Tue, 18 Apr 2000 12:00:05 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc:     Mike Klar <mfklar@ponymail.com>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com, Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: Unaligned address handling, and the cause of that login prob
Message-ID: <20000418120005.A1940@paradigm.rfc822.org>
References: <NDBBIDGAOKMNJNDAHDDMAEGGCJAA.mfklar@ponymail.com> <XFMail.000417183334.Harald.Koerfgen@home.ivm.de> <20000418105348.A1247@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000418105348.A1247@paradigm.rfc822.org>; from Florian Lohoff on Tue, Apr 18, 2000 at 10:53:48AM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Apr 18, 2000 at 10:53:48AM +0200, Florian Lohoff wrote:

> But the (kernel) fix from Ralph concerning the sleep? syscalls seems
> to be incorrect or buggy - When calling top the display refreshes
> multiple times a second without a sleep and on the console i get
> an.
> 
> Setting flush to zero for top.
> schedule_timeout: wrong timeout value fffbd0b2 from 800942b8 

And NTP still doesnt work as it still has a to strong drift ...

status=c011 sync_alarm, sync_unspec, 1 event, event_restart
processor="mips", system="Linux2.3.99-pre3", leap=11, stratum=16,
precision=-18, rootdelay=0.00, rootdispersion=58.98, peer=0,
refid=0.0.0.0, reftime=00000000.00000000  Thu, Feb  7 2036  6:28:16.000,
poll=6, clock=bca6b000.defc8b00  Tue, Apr 18 2000  9:57:20.871, state=1,
phase=0.000, frequency=14.728, jitter=0.000, stability=0.000

~0.1 Seconds in 4 Seconds 

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
