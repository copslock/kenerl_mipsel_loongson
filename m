Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2005 23:28:47 +0100 (BST)
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:55213 "EHLO
	jg555.com") by ftp.linux-mips.org with ESMTP id S8133368AbVIVW2b
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Sep 2005 23:28:31 +0100
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Thu, 22 Sep 2005 15:28:28 -0700
  id 00098710.4333300C.000062FE
Message-ID: <43333001.3080703@jg555.com>
Date:	Thu, 22 Sep 2005 15:28:17 -0700
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: MIPS64 NPTL Status
References: <43323D35.9030905@jg555.com> <20050922213020.GA15905@nevyn.them.org>
In-Reply-To: <20050922213020.GA15905@nevyn.them.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Daniel,
    He I still keeping getting this error with the currently 9192005 
snapshot of glibc.

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


-- 
----
Jim Gifford
maillist@jg555.com
