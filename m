Received:  by oss.sgi.com id <S554042AbRAQN4W>;
	Wed, 17 Jan 2001 05:56:22 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:48905 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S554038AbRAQN4G>;
	Wed, 17 Jan 2001 05:56:06 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id 1A7817D12; Wed, 17 Jan 2001 13:56:05 +0000 (GMT)
Date:   Wed, 17 Jan 2001 13:56:04 +0000
From:   Ian Chilton <ian@ichilton.co.uk>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com, ralf@oss.sgi.com
Subject: Re: 2.4.0 Kernel - Summary
Message-ID: <20010117135604.A29542@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

> I can reboot - but with "reboot -f" which is - Immediate reset
> which is not good(tm) for your filesystems. The bug is definitly
> a sgiserial.c problem as it doesnt happen on newport console.

I have only tried the once, because it's not easy with the machine
being remote...but I typed: shutdown -r now. It said:

Changing to Runlevel 0
£^T%&%£^$%&^%$£
£%$&£%^££"%$"£$"£
$"£*$%£"$%£"^%£"$&
etc...

and that was it  :(


Both this and swap worked fine on 001027 (test9)


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
