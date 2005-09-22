Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2005 06:12:56 +0100 (BST)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:57770
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8224774AbVIVFMf>;
	Thu, 22 Sep 2005 06:12:35 +0100
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Wed, 21 Sep 2005 22:12:31 -0700
  id 0009871F.43323D3F.00007CDC
Message-ID: <43323D35.9030905@jg555.com>
Date:	Wed, 21 Sep 2005 22:12:21 -0700
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: MIPS64 NPTL Status
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Looking through the latest glibc snapshot they have removed linuxthreads 
and moved it to ports. I know Daniel has been working on getting NPTL to 
work on MIPS32, which it does. Thank you Daniel. I know from emails I 
read around linux-mips.org he was going to work on MIPS64 NPTL, just 
curious to the status.

For the record the current glibc snapshot will not build at all under 
MIPS64. Here is the error message I have received, still working on 
getting it to build properly

In file included from ../sysdeps/mips/libc-tls.c:20:
../sysdeps/generic/libc-tls.c: In function '__libc_setup_tls':
../sysdeps/generic/libc-tls.c:191: warning: implicit declaration of 
function 'INTERNAL_SYSCALL_DECL'
../sysdeps/generic/libc-tls.c:191: error: 'err' undeclared (first use in 
this function)
../sysdeps/generic/libc-tls.c:191: error: (Each undeclared identifier is 
reported only once
../sysdeps/generic/libc-tls.c:191: error: for each function it appears in.)
../sysdeps/generic/libc-tls.c:191: warning: implicit declaration of 
function 'INTERNAL_SYSCALL'
../sysdeps/generic/libc-tls.c:191: error: 'set_thread_area' undeclared 
(first use in this function)
../sysdeps/generic/libc-tls.c:191: warning: implicit declaration of 
function 'INTERNAL_SYSCALL_ERROR_P'
make[2]: *** [/mnt/lfs-mips64/build/glibc-cross-64bit/csu/libc-tls.o] 
Error 1
make[2]: Leaving directory `/mnt/lfs-mips64/build/glibc-20050919/csu'

-- 
----
Jim Gifford
maillist@jg555.com
