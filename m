Received:  by oss.sgi.com id <S553884AbRAPSJg>;
	Tue, 16 Jan 2001 10:09:36 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:13065 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553882AbRAPSJQ>;
	Tue, 16 Jan 2001 10:09:16 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id E7F7F7D10; Tue, 16 Jan 2001 18:09:14 +0000 (GMT)
Date:   Tue, 16 Jan 2001 18:09:14 +0000
From:   Ian Chilton <ian@ichilton.co.uk>
To:     David Keen <dkeen@bellsouth.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Debian Base for MIPS Available
Message-ID: <20010116180914.A26581@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20010116165015.A26345@woody.ichilton.co.uk> <3A64887A.27920A7A@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A64887A.27920A7A@bellsouth.net>; from dkeen@bellsouth.net on Tue, Jan 16, 2001 at 11:44:26AM -0600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

> Mr. Chilton,

Call me Ian!   (or GadgetMan if you use IRC and come to #mipslinux !)


> Is this tarball a good starting point for me to net boot to my indy?

I have not tried that base yet and I won't be able to before the
weekend. My I2 is 60 miles away and I have a remote session, but am
compiling my own new system...my Indy is in the same place but turned
off..

But yes, it should be OK..

There is also ICLinux v1, but this uses older stuff...you are probably
better using the new base...

I am working on ICLinux v2 now..


Problem is, the port is still in a very developent stage, so there is
little documentation, and you have to be prepared to do a little
hacking around to get things working..


You should have a look round the documents and links at
http://linuxmips.ichilton.co.uk and you could also have a look at the
install guide for IClinux v1 at:

http://download.ichilton.co.uk/linux-mips/iclinux/INSTALL

again, this is out of date and needs updating.


Don't know if you are familiar with network booting, but it is
mentioned in there...also notes on booting an Indy/I2 in the I2-HOWTO
which is on the Documentation page on http://linuxmips.ichilton.co.uk



The other problem is finding a working kernel. At the moment, the CVS
tree is broken...it is being worked on..

I have a working but old kernel for the Indy/I2 which will get you
going, and you can update later:
http://download.ichilton.co.uk/linux-mips/kernels/vmlinux-001027-test9-r4x00.gz
or
ftp://download.ichilton.co.uk/pub/ichilton/linux-mips/kernels/vmlinux-001027-test9-r4x00.gz

(there is also a non-gzip'd version at the same place without the .gz)



Hope this helps a bit...


Bye for Now,

Ian


                                \|||/ 
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton        (IRC Nick - GadgetMan)     ICQ #: 16007717  |
 |-----------------------------------------------------------------|
 |  E-Mail: ian@ichilton.co.uk     Web: http://www.ichilton.co.uk  |
 |-----------------------------------------------------------------|
 |         Budget: A method for going broke methodically.          |
 \-----------------------------------------------------------------/
