Received:  by oss.sgi.com id <S42249AbQE3ICS>;
	Tue, 30 May 2000 01:02:18 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:17705 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42238AbQE3ICB>;
	Tue, 30 May 2000 01:02:01 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA28170; Tue, 30 May 2000 01:03:15 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id BAA37346; Tue, 30 May 2000 01:07:38 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA38350
	for linux-list;
	Tue, 30 May 2000 00:57:08 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA91538
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 30 May 2000 00:57:07 -0700 (PDT)
	mail_from (R.vandenBerg@inter.NL.net)
Received: from altrade.nijmegen.inter.nl.net (altrade.nijmegen.inter.nl.net [193.67.237.6]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA04561
	for <linux@cthulhu.engr.sgi.com>; Tue, 30 May 2000 00:46:48 -0700 (PDT)
	mail_from (R.vandenBerg@inter.NL.net)
Received: from whale.dutch.mountain by altrade.nijmegen.inter.nl.net
	via 1Cust212.tnt9.rtm1.nl.uu.net [212.136.249.212] with ESMTP for <linux@cthulhu.engr.sgi.com>
	id JAA12897 (8.8.8/3.41); Tue, 30 May 2000 09:46:52 +0200 (MET DST)
Received: from localhost(really [127.0.0.1]) by whale.dutch.mountain
	via in.smtpd with smtp
	id <m12wgjJ-00024gC@whale.dutch.mountain>
	for <linux@cthulhu.engr.sgi.com>; Tue, 30 May 2000 09:46:25 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #2 built 1996-Nov-26)
Date:   Tue, 30 May 2000 09:46:24 +0200 (MET DST)
From:   Richard van den Berg <R.vandenBerg@inter.NL.net>
X-Sender: ravdberg@whale.dutch.mountain
To:     linux@cthulhu.engr.sgi.com
Subject: Re: Problems booting Indigo...
In-Reply-To: <20000530032958.D15930@lug-owl.de>
Message-ID: <Pine.LNX.3.95.1000530093412.580B-100000@whale.dutch.mountain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, 30 May 2000, Jan-Benedict Glaw wrote:

> I've now build a kernel which I would like to test on my Indigo;) The
> problem is that I can't load it;( I tried bootpd as well as ISC dhcpd.
> The result is actually just the same:
> 
> >> bootp()parkautomat:/tftpboot/vmlinux.ip12
>     
> No server for parkautomat:/tftpboot/vmlinux.ip12

Just after doing this, does the machine show in the server arp table with
`arp -a`? If so forget this mail, if not issue (of course with the right
addresses) `arp -s 192.168.1.15 08:00:2B:2D:90:C0`

DECstation <-> bootp has following quirk: power it on and let
automatically boot and all goes well. Power it on and leave for a while (a
quarter of an hour) at the PROM-console and then booting, forget it unless
I use the arp -s command...

Regards,
Richard
