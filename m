Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2004 17:20:09 +0000 (GMT)
Received: from dsl-64-30-195-78.lcinet.net ([IPv6:::ffff:64.30.195.78]:1229
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8225274AbUKSRUE>;
	Fri, 19 Nov 2004 17:20:04 +0000
Received: from [172.16.0.150] (w2rz8l4s02.jg555.com [::ffff:172.16.0.150])
  (AUTH: PLAIN jim, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Fri, 19 Nov 2004 09:17:34 -0800
  id 0000C642.419E2AAF.0000520F
Message-ID: <419E2B1E.2050602@jg555.com>
Date: Fri, 19 Nov 2004 09:19:26 -0800
From: Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Glibc - Current CVS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Hi everyone, I'm one of the editors for Linux From Scratch, and we have 
had a lot of requests to make LFS compatible with other platforms. So I 
have been tasked to get a mips version up and running. The biggest issue 
I have faced has been the current glibc snapshot. I have fixed most of 
the issues based on the information located here on this list. But there 
is one error I have seen mentioned, but no word on how to fix it.

Any help will be appreciated.

Here is the error message.

: /mnt/lfs/build/glibc-build/rt/librt_pic.a
gcc -B/tools/bin/ -mabi=32   -shared -static-libgcc -Wl,-O1  -Wl,-z,defs 
-Wl,-dynamic-linker=/tools/lib/ld.so.1  
-B/mnt/lfs/build/glibc-build/csu/  
-Wl,--version-script=/mnt/lfs/build/glibc-build/librt.map 
-Wl,-soname=librt.so.1  -Wl,--enable-new-dtags,-z,nodelete 
-L/mnt/lfs/build/glibc-build -L/mnt/lfs/build/glibc-build/math 
-L/mnt/lfs/build/glibc-build/elf -L/mnt/lfs/build/glibc-build/dlfcn 
-L/mnt/lfs/build/glibc-build/nss -L/mnt/lfs/build/glibc-build/nis 
-L/mnt/lfs/build/glibc-build/rt -L/mnt/lfs/build/glibc-build/resolv 
-L/mnt/lfs/build/glibc-build/crypt 
-L/mnt/lfs/build/glibc-build/linuxthreads 
-Wl,-rpath-link=/mnt/lfs/build/glibc-build:/mnt/lfs/build/glibc-build/math:/mnt/lfs/build/glibc-build/elf:/mnt/lfs/build/glibc-build/dlfcn:/mnt/lfs/build/glibc-build/nss:/mnt/lfs/build/glibc-build/nis:/mnt/lfs/build/glibc-build/rt:/mnt/lfs/build/glibc-build/resolv:/mnt/lfs/build/glibc-build/crypt:/mnt/lfs/build/glibc-build/linuxthreads 
-o /mnt/lfs/build/glibc-build/rt/librt.so -T 
/mnt/lfs/build/glibc-build/shlib.lds 
/mnt/lfs/build/glibc-build/csu/abi-note.o -Wl,--whole-archive 
/mnt/lfs/build/glibc-build/rt/librt_pic.a -Wl,--no-whole-archive 
/mnt/lfs/build/glibc-build/elf/interp.os 
/mnt/lfs/build/glibc-build/libc.so 
/mnt/lfs/build/glibc-build/libc_nonshared.a 
/mnt/lfs/build/glibc-build/linuxthreads/libpthread_nonshared.a 
/mnt/lfs/build/glibc-build/linuxthreads/libpthread.so 
/mnt/lfs/build/glibc-build/elf/ld.so
/mnt/lfs/build/glibc-build/rt/librt_pic.a(mq_setattr.os)(.text+0x0): 
undefined reference to `__syscall_error'
/mnt/lfs/build/glibc-build/rt/librt_pic.a(mq_timedsend.os)(.text+0x0): 
undefined reference to `__syscall_error'
/mnt/lfs/build/glibc-build/rt/librt_pic.a(mq_timedreceive.os)(.text+0x0): 
undefined reference to `__syscall_error'
collect2: ld returned 1 exit status
make[2]: *** [/mnt/lfs/build/glibc-build/rt/librt.so] Error 1
make[2]: Leaving directory `/mnt/lfs/build/glibc-20041115/rt'

-- 
----
Jim Gifford
maillist@jg555.com
