Received:  by oss.sgi.com id <S553791AbRAKKKJ>;
	Thu, 11 Jan 2001 02:10:09 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:9735 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553687AbRAKKJy>;
	Thu, 11 Jan 2001 02:09:54 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id 6ED567CF3; Thu, 11 Jan 2001 10:09:52 +0000 (GMT)
Date:   Thu, 11 Jan 2001 10:09:52 +0000
From:   Ian Chilton <ian@ichilton.co.uk>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: R4X00 Kernel
Message-ID: <20010111100952.A27640@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20010110211341.A26347@woody.ichilton.co.uk> <20010111011456.A21226@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010111011456.A21226@bacchus.dhis.org>; from ralf@oss.sgi.com on Thu, Jan 11, 2001 at 01:14:56AM -0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

> > I it using gcc 2.95.2 + binutils 2.10.1 and the kernel from today's cvs
> > (10/01/01) which is just after Ralf checked in test12...
> 
> Since wealready know that this compiler is fishy I'm going to ignore this
> report for now.


What do you mean?  It's Macro's stuff...you said you
trusted his code  :)


Or do you mean the PIC thing?  I told you I already fixed that!


root@dale:~# echo __PIC__ | gcc -E -P -
1


So are you saying this is a compiler thing, not a kernel thing?


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
