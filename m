Received:  by oss.sgi.com id <S42232AbQFISAD>;
	Fri, 9 Jun 2000 11:00:03 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:18977 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42199AbQFIR7t>;
	Fri, 9 Jun 2000 10:59:49 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id KAA22617
	for <linux-mips@oss.sgi.com>; Fri, 9 Jun 2000 10:54:52 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id NAA01543; Fri, 9 Jun 2000 13:52:49 -0300
Date:   Fri, 9 Jun 2000 13:52:49 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
cc:     Linux-MIPS Mailing List <linux-mips@oss.sgi.com>
Subject: RE: Linux on Indy
In-Reply-To: <NAENLMKGGBDKLPONCDDOKECBCMAA.mailinglist@ichilton.co.uk>
Message-ID: <Pine.SGI.4.10.10006091342380.1512-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On Fri, 9 Jun 2000, Ian Chilton wrote:

> eakkK!
> 
> Sorry to be a pain..but is there anyone that wouldn't mind spening a few
> mins just to list the commands that I would use to do this...


Actually, net booting is not as hard or as bad as it sounds.  Typically,
you'll need utilities like rarp, bootp/dhcp, bootparamd, tftp, and NFS to
pull it off.  I've not gone through the process first hand yet with an
SGI, but from what I've glanced at somewhere here in the docs it looks to
be slightly different from what a Sun does.  I know this will sound
strange, but go to www.netbsd.org and look at their docs on net booting
Sun boxes to do a network install of NetBSD.  Their docs are quite
thurough on how to set up tftp, rarp, etc on BSD and Linux servers for net
booting a Sun client.  Although some of the details will be different for
an SGI client, the docs are still invaluable to you as they describe how
to edit the configuration files on the server to get what you want.
Comming from the Bill's world, it will also help give you a basic
understanding of how the process works so you'll know better what
questions to ask if you do get stuck.
