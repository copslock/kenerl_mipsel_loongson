Received:  by oss.sgi.com id <S553682AbQKWNV0>;
	Thu, 23 Nov 2000 05:21:26 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:29971 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553650AbQKWNVL>;
	Thu, 23 Nov 2000 05:21:11 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 317197CF5; Thu, 23 Nov 2000 13:21:04 +0000 (GMT)
Date:   Thu, 23 Nov 2000 13:21:04 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Cc:     wesolows@foobazco.org
Subject: Another GCC Problemo ?
Message-ID: <20001123132104.A6627@woody.ichilton.co.uk>
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

I have been busy this week, and have not had chance to compile anything
since the weekend.

I am trying to use make-cross with current gcc, binutils and linux (no
patches except one for gcc from oss,,,,/simple/crossdev/.

I am using an older glibc because Keith said current was broken
(001027).

I however get this:

malloc.c:1527: storage size of `arena_key' isn't known
make[2]: ***
[/crossdev-build/mips-linux/glibc-001027-obj/malloc/malloc.o] Error 1


I tried a different glibc (001116) and it still does it..
I then tried an older binutils, and it still does it..


Another GCC Problem?
 

Thanks!


Bye for Now,

Ian

                                \|||/
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton        (IRC Nick - GadgetMan)     ICQ #: 16007717  |
 |-----------------------------------------------------------------|
 |  E-Mail: ian@ichilton.co.uk     Web: http://www.ichilton.co.uk  |
 |-----------------------------------------------------------------|
 |        Proofread carefully to see if you any words out.         |
 \-----------------------------------------------------------------/
