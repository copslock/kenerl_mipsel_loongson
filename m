Received:  by oss.sgi.com id <S553956AbRAPUWJ>;
	Tue, 16 Jan 2001 12:22:09 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:26633 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553944AbRAPUWA>;
	Tue, 16 Jan 2001 12:22:00 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id A21447D10; Tue, 16 Jan 2001 20:21:55 +0000 (GMT)
Date:   Tue, 16 Jan 2001 20:21:55 +0000
From:   Ian Chilton <ian@ichilton.co.uk>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Current CVS (010116) Boots OK
Message-ID: <20010116202155.A27085@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

>  Could you please change "#undef DEBUG" into "#define DEBUG" in
> arch/mips/arc/memory.c and check if your system boots this way, either?
> I would also appreciate an output from '/proc/iomem' (once you boot into
> a shell).

The Indy is off again now and the I2 is compiling..

So, unless I get chance to try it on the I2 later this week, it will be
the weekend before I get to try this.....


Unless someone else can verify this and make the change..


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
