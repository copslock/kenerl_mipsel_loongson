Received:  by oss.sgi.com id <S42190AbQIGMzq>;
	Thu, 7 Sep 2000 05:55:46 -0700
Received: from [216.29.174.40] ([216.29.174.40]:62469 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S42183AbQIGMz3>;
	Thu, 7 Sep 2000 05:55:29 -0700
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 239B87CEE; Thu,  7 Sep 2000 13:55:28 +0100 (BST)
Date:   Thu, 7 Sep 2000 13:55:27 +0100
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: Problems with various packages on MIPS
Message-ID: <20000907135527.A4620@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I am currently building a Linux system from scratch on my Indy.

I am having problems compiling groff and Perl...

groff 1.16 gives the following error:

Making tbl.n from tbl.man
sed: -e expression #19, char 22: Unterminated `s' command
make[2]: *** [tbl.n] Error 1
make[2]: Leaving directory `/mnt/lfs-script/tmp/groff-1.16/src/preproc/tbl'
make[1]: *** [src/preproc/tbl] Error 2
make[1]: Leaving directory `/mnt/lfs-script/tmp/groff-1.16'
make: *** [all] Error 2


Perl, I have tried the normal v5.6.0, and then when that didn't work, I downloaded the SRPM for Perl 5.004_04, from oss.sgi.com, unpacked that, patched it with the patches from the srpm, and it does exactly the same thing:

bash-2.04# make 
makefile:531: *** target pattern contains no `%'.  Stop.
bash-2.04# 

Any ideas?


Also, please could someone tell me where the latest util-linux patch is for MIPS?


Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
