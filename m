Received:  by oss.sgi.com id <S305173AbQCALiJ>;
	Wed, 1 Mar 2000 03:38:09 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:32620 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbQCALhu>; Wed, 1 Mar 2000 03:37:50 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id DAA04702; Wed, 1 Mar 2000 03:40:58 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA31075
	for linux-list;
	Wed, 1 Mar 2000 03:26:10 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA88490
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Mar 2000 03:25:57 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA07844
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Mar 2000 03:25:54 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id MAA16829;
	Wed, 1 Mar 2000 12:25:02 +0100 (MET)
Date:   Wed, 1 Mar 2000 12:25:02 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: 2.3.47 success on Decstation 5000/150, problems with login
In-Reply-To: <20000301115053.A4608@paradigm.rfc822.org>
Message-ID: <Pine.GSO.4.10.10003011222500.13477-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, 1 Mar 2000, Florian Lohoff wrote:
> The problem is that i am NOT able to log in via SSH afterwards which
> works flawlessly with 2.3.21 i am running right now ... Might this
> be a devpts PTY98 problem ?
> 
> --------------------------------------------------------
> (flo@ping)~# ssh root@repeat.rfc822.org
> root@repeat.rfc822.org's password: 
> Warning: Remote host denied X11 forwarding, perhaps xauth program could not be run on the server side.
> Connection to repeat.rfc822.org closed by remote host.
> Connection to repeat.rfc822.org closed.
> --------------------------------------------------------

What does `ssh -v root@repeat.rfc822.org' say?

BTW, does this mean you have a Debian/mipsel ssh package now?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
