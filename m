Received:  by oss.sgi.com id <S553871AbQKCUEl>;
	Fri, 3 Nov 2000 12:04:41 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:51979 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553862AbQKCUEe>;
	Fri, 3 Nov 2000 12:04:34 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 25F077CF1; Fri,  3 Nov 2000 20:04:32 +0000 (GMT)
Date:   Fri, 3 Nov 2000 20:04:32 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
Cc:     linux-mips@oss.sgi.com
Subject: Re: More GCC problems
Message-ID: <20001103200432.A2615@woody.ichilton.co.uk>
Reply-To: ian@ichilton.co.uk
References: <20001103143725.A2123@woody.ichilton.co.uk> <20001103100728.A8133@chem.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
In-Reply-To: <20001103100728.A8133@chem.unr.edu>; from wesolows@chem.unr.edu on Fri, Nov 03, 2000 at 10:07:28AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> Don't blame the compiler. This is a gas problem. You should be able to
> get around it by using optimization; -O2 is sufficient I believe. If
> not, you may have to use -Os.

-Os?


> I have no idea how to build a static compiler.

make -LDFLAGS=-static
but just make didn't work either..


> The approach I took t
> get my working native 1019 compiler was to cross-build it with the
> same versiona


The problem is, I can't cross-compile either  :(


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
