Received:  by oss.sgi.com id <S553956AbQKARaM>;
	Wed, 1 Nov 2000 09:30:12 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:34314 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553952AbQKAR3q>;
	Wed, 1 Nov 2000 09:29:46 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id CED697CF1; Wed,  1 Nov 2000 17:29:45 +0000 (GMT)
Date:   Wed, 1 Nov 2000 17:29:45 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: GCC Compile Failed
Message-ID: <20001101172945.A27594@woody.ichilton.co.uk>
Reply-To: ian@ichilton.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.9i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I am trying to compile GCC 001019 using egcs 1.0.3a. Compiling natively on an I2

I get the following:

/usr/bin/ld:libgcc.map:1: parse error in VERSION script
collect2: ld returned 1 exit status
make[3]: *** [libgcc_s.so] Error 1
make[3]: Leaving directory `/mnt/hd2/lfstmp/gcc-001019/gcc-build/gcc'
make[2]: *** [libgcc.a] Error 2
make[2]: Leaving directory `/mnt/hd2/lfstmp/gcc-001019/gcc-build/gcc'
make[1]: *** [stage_a] Error 2
make[1]: Leaving directory `/mnt/hd2/lfstmp/gcc-001019/gcc-build/gcc'
make: *** [bootstrap] Error 2

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
