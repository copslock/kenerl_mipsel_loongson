Received:  by oss.sgi.com id <S553946AbQKGLG3>;
	Tue, 7 Nov 2000 03:06:29 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:60684 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553909AbQKGLGL>;
	Tue, 7 Nov 2000 03:06:11 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 2FC137CD4; Tue,  7 Nov 2000 11:06:10 +0000 (GMT)
Date:   Tue, 7 Nov 2000 11:06:10 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com, lfs-discuss@linuxfromscratch.org
Subject: User/Group Problem
Message-ID: <20001107110610.A8074@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I am building a Linux system on an SGI I2 (MIPS) with glibc 2.2

I am having the following problem....any ideas?

bash-2.04# chown root test.c 
chown: root: invalid user

bash-2.04# chgrp root test.c 
chgrp: invalid group name `root'



bash-2.04# cat /etc/passwd
root:1D0t80HeWTfNE:0:0:root:/root:/bin/bash

bash-2.04# cat /etc/group 
root:x:0:
 

Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
