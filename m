Received:  by oss.sgi.com id <S553852AbQJNWzu>;
	Sat, 14 Oct 2000 15:55:50 -0700
Received: from woody.ichilton.co.uk ([216.29.174.40]:62728 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553833AbQJNWzV>;
	Sat, 14 Oct 2000 15:55:21 -0700
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 509CC7C75; Sat, 14 Oct 2000 23:55:20 +0100 (BST)
Date:   Sat, 14 Oct 2000 23:55:20 +0100
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: ld problem
Message-ID: <20001014235520.B29358@woody.ichilton.co.uk>
Reply-To: ian@ichilton.co.uk
References: <20001014011056.A27588@woody.ichilton.co.uk> <20001014123233.B4407@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.9i
In-Reply-To: <20001014123233.B4407@bacchus.dhis.org>; from ralf@oss.sgi.com on Sat, Oct 14, 2000 at 12:32:33PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

> > bash-2.04# /sbin/ldconfig 
> > Bus error


I recompiled glibc-2.0.6-5lm, but still get the same "Bus Error" with ldconfig  :(


>   export LD_LIBRARY_PATH=`tr '\n' ':' </etc/ld.so.conf`

This worked though...I got passwd that last error with X, just hit another problem to do with X..


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
