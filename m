Received:  by oss.sgi.com id <S305252AbQCaT3q>;
	Fri, 31 Mar 2000 11:29:46 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:46931 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305239AbQCaT3U>;
	Fri, 31 Mar 2000 11:29:20 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA07077; Fri, 31 Mar 2000 11:24:38 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA57108
	for linux-list;
	Fri, 31 Mar 2000 11:21:04 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA33948
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 31 Mar 2000 11:21:02 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA05326
	for <linux@cthulhu.engr.sgi.com>; Fri, 31 Mar 2000 11:20:56 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 704727D9; Fri, 31 Mar 2000 21:20:52 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 258BE8FC3; Fri, 31 Mar 2000 21:11:16 +0200 (CEST)
Date:   Fri, 31 Mar 2000 21:11:16 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Richard <richardh@penguin.nl>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: kernel for indigo2
Message-ID: <20000331211115.B20863@paradigm.rfc822.org>
References: <20000331194525.A20241@paradigm.rfc822.org> <38E4ECA1.2362D2B@penguin.nl> <20000331202859.A20863@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000331202859.A20863@paradigm.rfc822.org>; from Florian Lohoff on Fri, Mar 31, 2000 at 08:29:00PM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Mar 31, 2000 at 08:29:00PM +0200, Florian Lohoff wrote:

> The development is a little on hold here too as the Current Kernel CVS
> doesnt run on ANY of my platforms - On Decstation it boots but i cant
> login :( and on Indigo2 it simply crashes :( On decstation i am currently
> running 2.3.21 which crashes for me twice a day or something while compiling.

Another one - If i disable the LX Video Driver for the Indy the kernel
does not crash but "hang" - Means - No ouput - Now i tried to set the console
and now i get nothing on the Video output and it seems my serial cables dont
work - How do i reset the prom ?

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
