Received:  by oss.sgi.com id <S553808AbQJYPHA>;
	Wed, 25 Oct 2000 08:07:00 -0700
Received: from woody.ichilton.co.uk ([216.29.174.40]:33796 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553805AbQJYPGw>;
	Wed, 25 Oct 2000 08:06:52 -0700
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 8321E7CD4; Wed, 25 Oct 2000 16:06:51 +0100 (BST)
Date:   Wed, 25 Oct 2000 16:06:51 +0100
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: Glibc Problem
Message-ID: <20001025160651.C17228@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.9i
Fcc:    /var/mail/sent-mail-oct2000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I am having this problem cross-compiling todays CVS glibc:

../sysdeps/generic/dl-cache.c: In function `_dl_load_cache_lookup':
../sysdeps/generic/dl-cache.c:177: warning: large integer implicitly truncated to unsigned type
../sysdeps/generic/dl-cache.c:181: `CACHEMAGIC_VERSION_NEW' undeclared (first use in this function)
../sysdeps/generic/dl-cache.c:181: (Each undeclared identifier is reported only once
../sysdeps/generic/dl-cache.c:181: for each function it appears in.)
make[2]: *** [/crossdev-build/mips-linux/glibc-001025-obj/elf/dl-cache.o] Error 1
make[2]: Leaving directory `/crossdev-build/src/glibc-001025/elf'
make[1]: *** [elf/subdir_lib] Error 2
make[1]: Leaving directory `/crossdev-build/src/glibc-001025'
make: *** [all] Error 2


It worked the other day  :-)
 

Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
