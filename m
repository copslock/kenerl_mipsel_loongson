Received:  by oss.sgi.com id <S553729AbQKHS5u>;
	Wed, 8 Nov 2000 10:57:50 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:29453 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553706AbQKHS5Y>;
	Wed, 8 Nov 2000 10:57:24 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id BF0FA7CF1; Wed,  8 Nov 2000 18:57:11 +0000 (GMT)
Date:   Wed, 8 Nov 2000 18:57:11 +0000
From:   Ian Chilton <ian@ichilton.co.uk>
To:     pete <pete@blackhammer.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: MIPS linux
Message-ID: <20001108185711.A10689@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

> and noticed that you do not recommend using the hardhat distro based on

You can use it, but it is old and broken. It will get you booted into Linux, but IIRC you can not even compile a kernel  :(

I am currently putting together some base systems, which you can net-boot and/or copy to a HD. Also, will write an installation guide. Hoping to upload these after the weekend. I started with a Hardhat install, then used the Redhat 6.0 packages from ftp://oss.sgi.com/pub/linux/mips/redhat/test-6.0, but that was not an easy procedure  :)

Ralf is currently working on a Redhat 7.0 port, and Flo (lolo) has started uploading packages to debian.org

Then there is Simple Linux/MIPS, byt Keith...that is available from oss.sgi.com now...

So, there is lots in the pipeline, but not a lot to actually go on for end-users right now, more hackers :)

All the links should be on the links page at our site... (or the news page).

There are pointers to some installation guides..

In the redhat dir on oss, there is a file called instructions, which is the guide I used when I first started out...It describes setting up the network boot server etc...

As I say though, I am currently working on an installation guide for my bases (hoping to release a glibc 2.0.6/kernel 2.2.14 one and a kernel 2.4 / glibc 2.2 one, but the 2.2 is still being worked on  :)

So, i'd say, you can get in there and try some of the stuff downloadable, but if you are in no hurry, hang on for a bit, because there are developments happening...


If you are on IRC, join us on irc.openprojects.net, channel #mipslinux (I am GadgetMan), and definatly subscribe to the linux-mips mailinglist on oss.sgi.com

Hope this helps a bit!


Bye for Now,

Ian


                                \|||/ 
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton     (IRC Nick - GadgetMan)     ian@ichilton.co.uk  |
 |-----------------------------------------------------------------|
 |  Web Site      -->  http://www.ichilton.co.uk                   |
 |-----------------------------------------------------------------|
 |  "Unix is user friendly - it's just picky about it's friends."  |
 \-----------------------------------------------------------------/
