Received:  by oss.sgi.com id <S553838AbQKCME2>;
	Fri, 3 Nov 2000 04:04:28 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:43019 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553821AbQKCMET>;
	Fri, 3 Nov 2000 04:04:19 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 8BF3E7CF1; Fri,  3 Nov 2000 12:04:18 +0000 (GMT)
Date:   Fri, 3 Nov 2000 12:04:18 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: CVS GCC Broken (001103)
Message-ID: <20001103120418.A1950@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I have been trying to compile GCC from today nativly, but it gives me the same error I got with the 07102000 one from oss.

It works when cross-compiling with make-cross though....


Nativly (with egcs 1.0.3a) I get :

/usr/bin/ld:libgcc.map:1: parse error in VERSION script
collect2: ld returned 1 exit status
make[3]: *** [libgcc_s.so] Error 1
make[3]: Leaving directory `/mnt/hd2/lfstmp/gcc/gcc-build/gcc'
make[2]: *** [libgcc.a] Error 2
make[2]: Leaving directory `/mnt/hd2/lfstmp/gcc/gcc-build/gcc'
make[1]: *** [stage_a] Error 2
make[1]: Leaving directory `/mnt/hd2/lfstmp/gcc/gcc-build/gcc'
make: *** [bootstrap] Error 2


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
