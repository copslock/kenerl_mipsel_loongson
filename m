Received:  by oss.sgi.com id <S42294AbQE3RJI>;
	Tue, 30 May 2000 10:09:08 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:56338 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42302AbQE3QgZ>;
	Tue, 30 May 2000 09:36:25 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA29697; Tue, 30 May 2000 09:13:53 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA80381
	for linux-list;
	Tue, 30 May 2000 09:09:05 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA28983
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 30 May 2000 09:09:01 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from thor ([207.246.91.243]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id IAA05860
	for <linux@cthulhu.engr.sgi.com>; Tue, 30 May 2000 08:41:08 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA05643; Tue, 30 May 2000 11:36:59 -0300
Date:   Tue, 30 May 2000 11:36:59 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Richard van den Berg <R.vandenBerg@inter.NL.net>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Problems booting Indigo...
In-Reply-To: <Pine.LNX.3.95.1000530093412.580B-100000@whale.dutch.mountain>
Message-ID: <Pine.SGI.4.10.10005301133150.5585-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Sounds like it's using RARP first to translate it's MAC into an IP
address, then hitting the bootp server secondly - already knowing it's IP
address - and just requesting info on the server/file to actually boot
strap itself.  Sun boxes work that way.  You need to add a static arp
entry for them if they netboot.  Otherwise, after about 10 - 15 minutes or
so when other boxes on the net start flushing their arp caches, your
stuck.

--

J. Scott Kasten
Email: jsk AT tetracon-eng DOT net

"The only future you have is the one
 you choose to make for yourself..."

On Tue, 30 May 2000, Richard van den Berg wrote:

> On Tue, 30 May 2000, Jan-Benedict Glaw wrote:
> 
> > I've now build a kernel which I would like to test on my Indigo;) The
> > problem is that I can't load it;( I tried bootpd as well as ISC dhcpd.
> > The result is actually just the same:
> > 
> > >> bootp()parkautomat:/tftpboot/vmlinux.ip12
> >     
> > No server for parkautomat:/tftpboot/vmlinux.ip12
> 
> Just after doing this, does the machine show in the server arp table with
> `arp -a`? If so forget this mail, if not issue (of course with the right
> addresses) `arp -s 192.168.1.15 08:00:2B:2D:90:C0`
> 
> DECstation <-> bootp has following quirk: power it on and let
> automatically boot and all goes well. Power it on and leave for a while (a
> quarter of an hour) at the PROM-console and then booting, forget it unless
> I use the arp -s command...
> 
> Regards,
> Richard
> 
> 
