Received:  by oss.sgi.com id <S553963AbQKEX5f>;
	Sun, 5 Nov 2000 15:57:35 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:28940 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553959AbQKEX5R>;
	Sun, 5 Nov 2000 15:57:17 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 524717CD4; Sun,  5 Nov 2000 23:57:15 +0000 (GMT)
Date:   Sun, 5 Nov 2000 23:57:15 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: Patch Problems with Glibc 2.2
Message-ID: <20001105235715.A5531@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I am having a problem with patch under glibc 2.2

patch: **** Only garbage was found in the patch input.

If I exit my chroot, back to my 2.0.6 base and use the same source dir, with the same patch there, it works fine, so it is definatly the patch program.

It was compiled exactly the same way as the 2.0.6 based base too. Tried re-compiling, and still the same..

Everything else so far seems to work under my 2.2 base, incl compiler etc..


Anyone seen this before?

Any ideas?


Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
