Received:  by oss.sgi.com id <S42223AbQFIOim>;
	Fri, 9 Jun 2000 07:38:42 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:3144 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42199AbQFIOij>;
	Fri, 9 Jun 2000 07:38:39 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id HAA24144
	for <linux-mips@oss.sgi.com>; Fri, 9 Jun 2000 07:33:41 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id KAA01171; Fri, 9 Jun 2000 10:31:05 -0300
Date:   Fri, 9 Jun 2000 10:31:05 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
cc:     Linux-MIPS Mailing List <linux-mips@oss.sgi.com>
Subject: Re: Linux on Indy
In-Reply-To: <NAENLMKGGBDKLPONCDDOGEBOCMAA.mailinglist@ichilton.co.uk>
Message-ID: <Pine.SGI.4.10.10006091025370.1120-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Let's try and keep this discussion on the list as I'm going to be trying
the same thing in a few weeks.

>From what I have observed, the 5.1 tarball has under the mipseb directory
a minimal root file system with etc, sbin, lib, etc. in addition to the
RedHat/RPMS directory.  I suspect that you will need to get that minimal
root file system mounted, and then use that to run the install and explode
the RPMS to the disk.  I'm further going to speculate that you will
probably netboot the thing the first time and do an NFS mounted root to
make that happen.  But again, this is pure speculation...

-S-

--

J. Scott Kasten
Email: jsk AT tetracon-eng DOT net

"The only future you have is the one
 you choose to make for yourself..."

On Fri, 9 Jun 2000, Ian Chilton wrote:

> Hello,
> 
> OK...I now have a 2nd disk in my Indy. I have read the MIPS/HOWTO, the
> SGI/Linux mini-HOWTO (by: Raju) and the Hard Hat 5.1 installation
> instructions, but I still haven't got a clue how to do this....
> 
> I have an SGI Indy running Irix 6.5.8m (now with a 2nd hard disk).
> I also have a PC running Win98 and another running SuSE Linux.
> 
> I have got the hardhat-sgi-5.1tar.gz file...can't I just copy this to the
> Indy while running IRIX, and unpack from there?
> 
> Please could someone explain how I do this?
> (incl partitioning this new disk for Linux...I ran fx, but didn't have a
> clue how to use it...)
> 
> 
> Thanks!
> 
> 
> Bye for Now,
> 
> Ian
> 
> 
>                      \|||/
>                      (o o)
>  /----------------ooO-(_)-Ooo----------------\
>  |  Ian Chilton                              |
>  |  E-Mail : ian@ichilton.co.uk              |
>  \-------------------------------------------/
> 
> 
