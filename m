Received:  by oss.sgi.com id <S553958AbQKMUBW>;
	Mon, 13 Nov 2000 12:01:22 -0800
Received: from serv1.is1.u-net.net ([195.102.240.129]:7626 "EHLO
        serv1.is1.u-net.net") by oss.sgi.com with ESMTP id <S553945AbQKMUAx>;
	Mon, 13 Nov 2000 12:00:53 -0800
Received: from [213.48.88.27] (helo=zurg)
	by serv1.is1.u-net.net with smtp (Exim 3.12 #1)
	id 13vPmU-0006fU-00; Mon, 13 Nov 2000 20:00:42 +0000
From:   "Ian Chilton" <ian@ichilton.co.uk>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     <linux-mips@oss.sgi.com>, <lfs-discuss@linuxfromscratch.org>
Subject: RE: User/Group Problem
Date:   Mon, 13 Nov 2000 20:02:21 -0000
Message-ID: <NAENLMKGGBDKLPONCDDOGEMADCAA.ian@ichilton.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.GSO.3.96.1001113195048.12211C-100000@delta.ds2.pg.gda.pl>
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

>  That's actually not a MIPS-specific problem.

I actually got round this by copying /lib/libnss* from glibc 2.0.6 over,
until I had finished compiling everything..


>From the LFS-Book:

------------ Quote --------------
Copying old NSS library files
If your normal Linux system runs glibc-2.0, you need to copy the NSS library
files to the LFS partition. Certain statically linked programs still depend
on the NSS library, especially programs that need to lookup
usernames,userid's and groupid's. You can check which C library version your
normal Linux system uses by running:

strings /lib/libc* | grep "release version"

The output of that command should tell you something like this:

GNU C Library stable release version 2.1.3, by Roland McGrath et al.

If you have a libc-2.0.x file copy the NSS library files by running:

cp -av /lib/libnss* $LFS/lib

--------------- End Quote --------------


Bye for Now,

Ian


                                \|||/
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton        (IRC Nick - GadgetMan)     ICQ #: 16007717  |
 |-----------------------------------------------------------------|
 |  E-Mail: ian@ichilton.co.uk     Web: http://www.ichilton.co.uk  |
 \-----------------------------------------------------------------/
