Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Oct 2002 19:59:02 +0200 (CEST)
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:11693 "EHLO
	rwcrmhc53.attbi.com") by linux-mips.org with ESMTP
	id <S1123253AbSJYR7B>; Fri, 25 Oct 2002 19:59:01 +0200
Received: from lucon.org ([12.234.88.146]) by rwcrmhc53.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021025175853.GDRJ9096.rwcrmhc53.attbi.com@lucon.org>;
          Fri, 25 Oct 2002 17:58:53 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 4EBC12C4EC; Fri, 25 Oct 2002 10:58:53 -0700 (PDT)
Date: Fri, 25 Oct 2002 10:58:53 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Mark and Janice Juszczec <juszczec@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: cross gcj for mipsel
Message-ID: <20021025105853.A16659@lucon.org>
References: <F173QojAOq79phiaJcp0000aab1@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <F173QojAOq79phiaJcp0000aab1@hotmail.com>; from juszczec@hotmail.com on Fri, Oct 25, 2002 at 12:21:11PM +0000
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 25, 2002 at 12:21:11PM +0000, Mark and Janice Juszczec wrote:
> 
> Hello all
> 
> Is a cross gcj (x86 to mipsel) available anywhere?  If not, are there any 

I have one:

# ls -l /export/tools-3.2/bin/mipsel-linux-gcj 
-rwxr-xr-x    1 hjl      users      321336 Oct 19 18:48 /export/tools-3.2/bin/mipsel-linux-gcj

> instructions for building one?

You can try the spec file in my old toolchain src rpm, which is based
on gcc 2.96. I am working on a new one based on gcc 3.2 for my RedHat
8.0/mips port.


H.J.
