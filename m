Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2003 02:44:16 +0000 (GMT)
Received: from [IPv6:::ffff:218.1.66.80] ([IPv6:::ffff:218.1.66.80]:45994 "HELO
	mail.citiz.net") by linux-mips.org with SMTP id <S8225489AbTKCCoC> convert rfc822-to-8bit;
	Mon, 3 Nov 2003 02:44:02 +0000
Received: (umta 4025 invoked by uid 1820); 3 Nov 2003 02:43:50 -0000
X-Lasthop: 10.1.1.5
Received: from unknown (HELO app5) (unknown@10.1.1.5)
  by localhost with SMTP; 3 Nov 2003 02:43:50 -0000
Message-ID: <1067827721345.2149.app5.Naesasoft.WBRHE1TU>
Date: Mon, 3 Nov 2003 10:48:41 +0800 (CST)
From: embedlf@citiz.net
To: linux-mips@linux-mips.org
Subject: problem during compile glibc
Mime-Version: 1.0
Content-Type: text/plain; charset="GBK"
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-Mailer: Naesasoft Ares Mailer
Return-Path: <embedlf@citiz.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: embedlf@citiz.net
Precedence: bulk
X-list: linux-mips

when I compiled the glibc2.2.3 that download from gnu.org,I meet the problem.
message as follow:

make  -C misc subdir_lib
make[2]: Entering directory `/home/lf/libc/glibc-2.2.3/misc'
rm -f /home/lf/libc/mipsglibc2.3/misc/syscall-list.d-t
{ \
 echo '/* Generated at libc build time from kernel syscall list.  */';\
 echo ''; \
 echo '#ifndef _SYSCALL_H'; \
 echo '# error "Never use <bits/syscall.h> directly; include <sys/syscall.h> instead."'; \
 echo '#endif'; \
 echo ''; \
 SUNPRO_DEPENDENCIES='/home/lf/libc/mipsglibc2.3/misc/syscall-list.d-t /home/lf/libc/mipsglibc2.3/misc/syscall-list.d' \
 mips-linux-gcc -E -x c  ../sysdeps/unix/sysv/linux/sys/syscall.h -D_LIBC -dM | \
 sed -n 's@^#define __NR_\([^ ]*\) .*$@#define SYS_\1 __NR_\1@p'; \
} > /home/lf/libc/mipsglibc2.3/misc/syscall-list.h.new
../sysdeps/unix/sysv/linux/sys/syscall.h:25:23: asm/unistd.h: ?????????
mv -f /home/lf/libc/mipsglibc2.3/misc/syscall-list.h.new /home/lf/libc/mipsglibc2.3/misc/syscall-list.h
sed < /home/lf/libc/mipsglibc2.3/misc/syscall-list.d-t > /home/lf/libc/mipsglibc2.3/misc/syscall-list.d-t2 \
    -e 's,/home/lf/libc/mipsglibc2\.3/misc/syscall-list\.d,$(objpfx)syscall-list.h $(objpfx)syscall-list.d,'
/bin/sh: line 1: /home/lf/libc/mipsglibc2.3/misc/syscall-list.d-t: cann't find this file or folder
make[2]: *** [/home/lf/libc/mipsglibc2.3/misc/syscall-list.d] Error 1
make[2]: Leaving directory `/home/lf/libc/glibc-2.2.3/misc'
make[1]: *** [misc/subdir_lib] Error 2
make[1]: Leaving directory `/home/lf/libc/glibc-2.2.3'
make: *** [all] Error 2

--------------------------------------------------
多发多彩----上海热线彩信开通！
http://mms.online.sh.cn/mms/index.jsp
花一元去环艺看天地英雄http://sms.online.sh.cn/zhuanti/movie_tickets/top.html
发短信赢取秋季嘉年华门票http://sms.online.sh.cn/zhuanti/world_carnival/world_carnival.html

--------------------------------------------------
