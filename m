Received:  by oss.sgi.com id <S42281AbQIHWIF>;
	Fri, 8 Sep 2000 15:08:05 -0700
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.30]:7188 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S42227AbQIHWHi>; Fri, 8 Sep 2000 15:07:38 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.31] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 2.05 #1 (Debian))
	id 13XWJ6-0002Ku-00; Sat, 9 Sep 2000 00:07:36 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 13XWJ6-0001Zq-00; Sat, 09 Sep 2000 00:07:36 +0200
Date:   Sat, 9 Sep 2000 00:07:36 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     linux-mips@oss.sgi.com
Subject: glibc again
Message-ID: <20000909000736.A6050@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
with latest cvs I've been able to crossbuild glibc. When trying 
to crosscompile programs against it I ended up with
lots of unresolved symbols. This all changed when I edited
/usr/local/mips-linux/lib/libc.so from 
GROUP ( /lib/libc.so.6 /usr/lib/libc_nonshared.a ) to 
GROUP ( libc.so.6 libc_nonshared.a )
Should I consider this a bug in a) my "setup", b) glibc c) to be
intended behavior?
Regards,
 -- Guido
 
