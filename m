Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBEBoPI25435
	for linux-mips-outgoing; Fri, 14 Dec 2001 03:50:25 -0800
Received: from dell.zentropix.co.uk ([212.74.13.151])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBEBoJo25417
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 03:50:20 -0800
Received: from lineo.com (IDENT:seh@localhost.localdomain [127.0.0.1])
	by dell.zentropix.co.uk (8.9.3/8.9.3) with ESMTP id KAA21744
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 10:50:15 GMT
Message-ID: <3C19D967.58F2BC90@lineo.com>
Date: Fri, 14 Dec 2001 10:50:15 +0000
From: Stuart Hughes <stuarth@lineo.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19-rthal3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: problems with libpthread at start-up
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi everyone,

I've successfully built and deployed a system using a toolchain I built
using the instructions at:
http://www.ltc.com/~brad/mips/mips-cross-toolchain, which were very
helpful.  This gives a combination of:

binutils-2.11.90.0.25, gcc-3.0.1, glibc-2.2.3, linuxthreads-2.2.3 &
glibc-2.2.3-mips-base-addr-got.diff

A simple 'hello world' programs in both c and c++ work, statically and
dynamically linked, but as soon as I try to link or use pthreads I get
the following (dynamic linking):

#
./helloc                                                                      
[helloc:23] Illegal instruction 00000003 at 2ad0847c
ra=2ab76820                

My ldd shows

# /lib/ld.so.1 --list
./helloc                                                  
        libpthread.so.0 => //lib/libpthread.so.0
(0x2aaaa000)                   
        libc.so.6 => //lib/libc.so.6
(0x2ab05000)                               
        /lib/ld.so.1 => /lib/ld.so.1
(0x55550000)                               
        libgcc_s.so.1 => //lib/libgcc_s.so.1
(0x2acb1000)                       

I'm running on an IDT79RC32334

It seems as though I must have missed a patch or something.  Does anyone
know if there is a fix for this.

BTW, the hello program does not even create a pthread, all I did was add
-lpthread onto the compile line.

-- 
Regards, Stuart
