Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Dec 2004 11:42:36 +0000 (GMT)
Received: from host181-209-dsl.dols.net.pk ([IPv6:::ffff:202.147.181.209]:34698
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225011AbULaLmb>; Fri, 31 Dec 2004 11:42:31 +0000
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2448.0)
	id <ZYJ9722X>; Fri, 31 Dec 2004 16:32:45 +0500
Message-ID: <1B701004057AF74FAFF851560087B161064698@1aurora.enabtech>
From: Mudeem Iqbal <mudeem@Quartics.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: cross compiling gcc for mips
Date: Fri, 31 Dec 2004 16:32:44 +0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <mudeem@Quartics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mudeem@Quartics.com
Precedence: bulk
X-list: linux-mips

Hi,

I am building a toolchain for mips platform. I am using

binutils-2.15
gcc-3.4.3
glibc-2.3.3
linux-2.6.9	(from linux-mips.org)

First I built binutils and now I was setting up the bootstrap compiler.
However when I do "make all-gcc" I get the following errors.


In file included from ./gthr-default.h:1,
                 from ../../gcc-3.4.3/gcc/gthr.h:96,
                 from ../../gcc-3.4.3/gcc/unwind-dw2.c:42:
../../gcc-3.4.3/gcc/gthr-posix.h:43:21: pthread.h: No such file or directory
../../gcc-3.4.3/gcc/gthr-posix.h:44:20: unistd.h: No such file or directory
In file included from ./gthr-default.h:1,
                 from ../../gcc-3.4.3/gcc/gthr.h:96,
                 from ../../gcc-3.4.3/gcc/unwind-dw2.c:42:
../../gcc-3.4.3/gcc/gthr-posix.h:46: error: parse error before
"__gthread_key_t"
../../gcc-3.4.3/gcc/gthr-posix.h:46: warning: type defaults to `int' in
declaration of `__gthread_key_t'
../../gcc-3.4.3/gcc/gthr-posix.h:46: warning: data definition has no type or
storage class
../../gcc-3.4.3/gcc/gthr-posix.h:47: error: parse error before
"__gthread_once_t"
../../gcc-3.4.3/gcc/gthr-posix.h:47: warning: type defaults to `int' in
declaration of `__gthread_once_t'
../../gcc-3.4.3/gcc/gthr-posix.h:47: warning: data definition has no type or
storage class
../../gcc-3.4.3/gcc/gthr-posix.h:48: error: parse error before
"__gthread_mutex_t"
../../gcc-3.4.3/gcc/gthr-posix.h:48: warning: type defaults to `int' in
declaration of `__gthread_mutex_t'
../../gcc-3.4.3/gcc/gthr-posix.h:48: warning: data definition has no type or
storage class
../../gcc-3.4.3/gcc/gthr-posix.h: In function `__gthread_active_p':
../../gcc-3.4.3/gcc/gthr-posix.h:96: error: `pthread_create' undeclared
(first use in this function)
../../gcc-3.4.3/gcc/gthr-posix.h:96: error: (Each undeclared identifier is
reported only once
../../gcc-3.4.3/gcc/gthr-posix.h:96: error: for each function it appears
in.)
../../gcc-3.4.3/gcc/gthr-posix.h: At top level:
../../gcc-3.4.3/gcc/gthr-posix.h:456: error: parse error before '*' token
../../gcc-3.4.3/gcc/gthr-posix.h:456: error: parse error before ')' token
../../gcc-3.4.3/gcc/gthr-posix.h:465: error: parse error before '*' token
../../gcc-3.4.3/gcc/gthr-posix.h:465: error: parse error before ')' token
../../gcc-3.4.3/gcc/gthr-posix.h:471: error: parse error before "key"
../../gcc-3.4.3/gcc/gthr-posix.h:472: warning: function declaration isn't a
prototype
../../gcc-3.4.3/gcc/gthr-posix.h: In function `__gthread_key_delete':
../../gcc-3.4.3/gcc/gthr-posix.h:472: warning: old-style parameter
declaration
../../gcc-3.4.3/gcc/gthr-posix.h:473: warning: implicit declaration of
function `pthread_key_delete'
../../gcc-3.4.3/gcc/gthr-posix.h:473: error: `key' undeclared (first use in
this function)
../../gcc-3.4.3/gcc/gthr-posix.h: At top level:
../../gcc-3.4.3/gcc/gthr-posix.h:477: error: parse error before "key"
../../gcc-3.4.3/gcc/gthr-posix.h:478: warning: function declaration isn't a
prototype
../../gcc-3.4.3/gcc/gthr-posix.h: In function `__gthread_getspecific':
../../gcc-3.4.3/gcc/gthr-posix.h:478: warning: old-style parameter
declaration
../../gcc-3.4.3/gcc/gthr-posix.h:479: warning: implicit declaration of
function `pthread_getspecific'
../../gcc-3.4.3/gcc/gthr-posix.h:479: error: `key' undeclared (first use in
this function)
../../gcc-3.4.3/gcc/gthr-posix.h:479: warning: return makes pointer from
integer without a cast
../../gcc-3.4.3/gcc/gthr-posix.h: At top level:
../../gcc-3.4.3/gcc/gthr-posix.h:483: error: parse error before "key"
../../gcc-3.4.3/gcc/gthr-posix.h:484: warning: function declaration isn't a
prototype
../../gcc-3.4.3/gcc/gthr-posix.h: In function `__gthread_setspecific':
../../gcc-3.4.3/gcc/gthr-posix.h:484: warning: old-style parameter
declaration
../../gcc-3.4.3/gcc/gthr-posix.h:485: warning: implicit declaration of
function `pthread_setspecific'
../../gcc-3.4.3/gcc/gthr-posix.h:485: error: `key' undeclared (first use in
this function)
../../gcc-3.4.3/gcc/gthr-posix.h:485: error: `ptr' undeclared (first use in
this function)
../../gcc-3.4.3/gcc/gthr-posix.h: At top level:
../../gcc-3.4.3/gcc/gthr-posix.h:489: error: parse error before '*' token
../../gcc-3.4.3/gcc/gthr-posix.h:490: warning: function declaration isn't a
prototype
../../gcc-3.4.3/gcc/gthr-posix.h: In function `__gthread_mutex_lock':
../../gcc-3.4.3/gcc/gthr-posix.h:490: warning: old-style parameter
declaration
../../gcc-3.4.3/gcc/gthr-posix.h:492: warning: implicit declaration of
function `pthread_mutex_lock'
../../gcc-3.4.3/gcc/gthr-posix.h:492: error: `mutex' undeclared (first use
in this function)
../../gcc-3.4.3/gcc/gthr-posix.h: At top level:
../../gcc-3.4.3/gcc/gthr-posix.h:498: error: parse error before '*' token
../../gcc-3.4.3/gcc/gthr-posix.h:499: warning: function declaration isn't a
prototype
../../gcc-3.4.3/gcc/gthr-posix.h: In function `__gthread_mutex_trylock':
../../gcc-3.4.3/gcc/gthr-posix.h:499: warning: old-style parameter
declaration
../../gcc-3.4.3/gcc/gthr-posix.h:501: warning: implicit declaration of
function `pthread_mutex_trylock'
../../gcc-3.4.3/gcc/gthr-posix.h:501: error: `mutex' undeclared (first use
in this function)
../../gcc-3.4.3/gcc/gthr-posix.h: At top level:
../../gcc-3.4.3/gcc/gthr-posix.h:507: error: parse error before '*' token
../../gcc-3.4.3/gcc/gthr-posix.h:508: warning: function declaration isn't a
prototype
../../gcc-3.4.3/gcc/gthr-posix.h: In function `__gthread_mutex_unlock':
../../gcc-3.4.3/gcc/gthr-posix.h:508: warning: old-style parameter
declaration
../../gcc-3.4.3/gcc/gthr-posix.h:510: warning: implicit declaration of
function `pthread_mutex_unlock'
../../gcc-3.4.3/gcc/gthr-posix.h:510: error: `mutex' undeclared (first use
in this function)
../../gcc-3.4.3/gcc/unwind-dw2.c: In function `uw_frame_state_for':
../../gcc-3.4.3/gcc/unwind-dw2.c:1013: warning: implicit declaration of
function `memset'
../../gcc-3.4.3/gcc/unwind-dw2.c: In function `uw_init_context_1':
../../gcc-3.4.3/gcc/unwind-dw2.c:1291: error: syntax error before
"once_regsizes"
../../gcc-3.4.3/gcc/unwind-dw2.c:1292: warning: implicit declaration of
function `__gthread_once'
../../gcc-3.4.3/gcc/unwind-dw2.c:1292: error: `once_regsizes' undeclared
(first use in this function)
../../gcc-3.4.3/gcc/unwind-dw2.c: In function `uw_install_context_1':
../../gcc-3.4.3/gcc/unwind-dw2.c:1341: warning: implicit declaration of
function `memcpy'
make[2]: *** [libgcc/./unwind-dw2.o] Error 1
make[2]: Leaving directory
`/home/mudeem/ashwaria_rai/build-tools/build-boot-gcc/gcc'
make[1]: *** [libgcc.a] Error 2
make[1]: Leaving directory
`/home/mudeem/ashwaria_rai/build-tools/build-boot-gcc/gcc'
make: *** [all-gcc] Error 2


Thanx in advance.

Regards

Mudeem
