Received:  by oss.sgi.com id <S42229AbQFJDks>;
	Fri, 9 Jun 2000 20:40:48 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:17019 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42199AbQFJDkV>;
	Fri, 9 Jun 2000 20:40:21 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id UAA01096
	for <linux-mips@oss.sgi.com>; Fri, 9 Jun 2000 20:35:24 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id XAA02748; Fri, 9 Jun 2000 23:33:00 -0300
Date:   Fri, 9 Jun 2000 23:33:00 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
cc:     Linux-MIPS Mailing List <linux-mips@oss.sgi.com>
Subject: RE: Linux on Indy
In-Reply-To: <NAENLMKGGBDKLPONCDDOAEDLCMAA.mailinglist@ichilton.co.uk>
Message-ID: <Pine.SGI.4.10.10006092319540.2700-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


> > You should start by setting up bootp/tftp/nfs on the machine that will
> > serve the installation image to the indy.
> 
> Right...i'll have ago!!  <gulp>
> 
> Where do I get bootp/tftp from ?

OK, let's step back here just a bit to clarify things.  You'll have two
machines.  The Indy to which you wish to install Linux, and a second
machine such as an x86, or anything really, that is already running Linux,
BSD, or some such thing.

The second machine is only needed for the actuall install, to help the
Indy get up and going.  You'll set up bootp, tftp, and NFS on that second
machine.  It will be the boot server.  Using bootp protocol, the Indy will
"discover" the name of the boot server and the kernel file it needs to
load. The Indy will then use the tftp protocol to download the boot strap
kernel image from the server.  (tftp is similar to ftp, but is dumbed down
so it can be put in ROM code)  After the kernel is started, it's first
instruction is to attempt to mount a temporary root file system.  The big
tarball holds this file system.  Your boot server will export this using
NFS, and the Indy will mount it as if it were a local disk.  It will then
mount the real disk under that and then start exploding the RPMS from the
root image to the real disk.

The bootp and tftp server daemons are included in most Linux and BSD
distros. You'll find the man pages under bootpd and tftpd - appending a
'd' to mean server daemon rather than the client.  The configuration files
will be in /etc.  You can do a man on the configuration file names
themselves to get even more info.  If you're still stuck, don't forget to
check out those NetBSD net install help pages I mentioned earlier as they
explain and give examples of the type of stuff that goes into those files
for both Linux and BSD.
