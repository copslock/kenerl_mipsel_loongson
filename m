Received:  by oss.sgi.com id <S553685AbQKGQHA>;
	Tue, 7 Nov 2000 08:07:00 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:1037 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553677AbQKGQGw>;
	Tue, 7 Nov 2000 08:06:52 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 026AA7CF1; Tue,  7 Nov 2000 16:06:50 +0000 (GMT)
Date:   Tue, 7 Nov 2000 16:06:50 +0000
From:   Ian Chilton <ian@ichilton.co.uk>
To:     Michl Ladislav <xmichl03@stud.fee.vutbr.cz>
Cc:     linux-mips@oss.sgi.com
Subject: Re: mips dist?
Message-ID: <20001107160650.A8493@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

> You could do following: download kernel and base-files from
> ftp://ftp.rfc822.org/pub/local/debian-mips/. install bootp, tftp and nfs
> server on another machine (howto can be found in archives) and boot linux
> from this remote computer. after that you can partition your harddisk,
> create filesystems and copy kernel and base-files. instruction how to boot
> linux directly from harddisk (for indy) can be found at:
> http://honk.physik.uni-konstanz.de/linux-mips/indy-boot/indy-hd-boot-micro-howto.html
> now, you have fully functional Debian/GNU Linux, just wait for new
> packages :-)


I know about this. There is also Simple Linux/MIPS, and soon, my own base systems which will be downloadable, but to answer the origional question, there is no full distro for Linux/MIPS with a proper installer, except the very old, outdated, broken Hardhat.

However, on a brigher note, things are moving on at the moment. Ralf is working on a Redhat 7.0, based on glibc 2.2, and Flo (lolo) has started uploading debian packages based on glibc 2.2 to debian.org, so we are moving closed to having some working, easier to install systems.


Bye for Now,

Ian


                                \|||/ 
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton     (IRC Nick - GadgetMan)     ian@ichilton.co.uk  |
 |-----------------------------------------------------------------|
 |  Backup E-Mail -->  ian@ichilton.dhis.org      ICQ #: 16007717  |
 |  Web Site      -->  http://www.ichilton.co.uk                   |
 |-----------------------------------------------------------------|
 |  "Unix is user friendly - it's just picky about it's friends."  |
 \-----------------------------------------------------------------/
