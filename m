Received:  by oss.sgi.com id <S553786AbQJNMFA>;
	Sat, 14 Oct 2000 05:05:00 -0700
Received: from woody.ichilton.co.uk ([216.29.174.40]:47622 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553770AbQJNME7>;
	Sat, 14 Oct 2000 05:04:59 -0700
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 80D2B7C75; Sat, 14 Oct 2000 13:04:52 +0100 (BST)
Date:   Sat, 14 Oct 2000 13:04:52 +0100
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: ld problem
Message-ID: <20001014130452.B28429@woody.ichilton.co.uk>
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

> Which is probably the root of the evil - I assume at the point when it's
> crashing the new /etc/ld.so.conf file is still incomplete.  I don't have
> a theory what's causing that, sorry.

Do you think it could be something to do with the glibc-2.0.6-5lm?

or, what about ld.so?  I think I compiled v1.9.9


> Hmm...  Checkout your /etc/ld.so.conf file.  It should exist and contain
> a number of lines like:

I checked that before the origional post...ld.so.conf looks fine..


> A workaround which may try is the LD_LIBRARY_PATH variable:
>   export LD_LIBRARY_PATH=`tr '\n' ':' </etc/ld.so.conf`

Before I origionally posted, I tried doing:
export LD_LIBRARY_PATH=/usr/X11R6/bin
but this did the same thing...

I'll try the one you gave me soon
 

Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
