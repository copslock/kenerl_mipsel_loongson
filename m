Received:  by oss.sgi.com id <S553726AbQKONVr>;
	Wed, 15 Nov 2000 05:21:47 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:47887 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553695AbQKONV0>;
	Wed, 15 Nov 2000 05:21:26 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 63AAC7CD4; Wed, 15 Nov 2000 13:21:09 +0000 (GMT)
Date:   Wed, 15 Nov 2000 13:21:08 +0000
From:   Ian Chilton <ian@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: [mailinglist@ichilton.co.uk: Re: egcs 1.0.3a build error?]
Message-ID: <20001115132108.A22277@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

----- Forwarded message from Ian Chilton <mailinglist@ichilton.co.uk> -----

Date: Wed, 15 Nov 2000 13:19:58 +0000
From: Ian Chilton <mailinglist@ichilton.co.uk>
To: Brady Brown <bbrown@ti.com>
Subject: Re: egcs 1.0.3a build error?

Hello,

> /tmp/cca30501.s: Assembler messages:
> /tmp/cca30501.s:136: Internal error!

I have seen this with the new CVS GCC...

Try compiling with CFLAGS="-O1"
That fixed my problem.


Bye for Now,

Ian

                                \|||/
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton        (IRC Nick - GadgetMan)     ICQ #: 16007717  |
 |-----------------------------------------------------------------|
 |  E-Mail: ian@ichilton.co.uk     Web: http://www.ichilton.co.uk  |
 |-----------------------------------------------------------------|
 |       I used up all my sick days, so I'm calling in dead.       |
 \-----------------------------------------------------------------/


----- End forwarded message -----

-- 
Hello,




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
 |       I used up all my sick days, so I'm calling in dead.       |
 \-----------------------------------------------------------------/
