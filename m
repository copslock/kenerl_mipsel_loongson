Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g54I5xnC002854
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 4 Jun 2002 11:05:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g54I5xkp002853
	for linux-mips-outgoing; Tue, 4 Jun 2002 11:05:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g54I5qnC002850
	for <linux-mips@oss.sgi.com>; Tue, 4 Jun 2002 11:05:53 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id WAA07398;
	Tue, 4 Jun 2002 22:07:59 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id WAA13933; Tue, 4 Jun 2002 22:03:31 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id WAA07935; Tue, 4 Jun 2002 22:04:08 +0400 (MSK)
Message-ID: <3CFD0211.17024F14@niisi.msk.ru>
Date: Tue, 04 Jun 2002 22:08:17 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Bug in copy_user
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

There is bug in __copy_user (arch/mips*/lib/memcpy.S). Tested for 2.4.18
kernels, but versions 2.2, 2.4, and  2.5 for both mips and mips64 seems
to have similar bug.

For kernel 2.4.18 and mips
__copy_user returns wrong value if len = 4...7 and dst isn't accessible.

Other versions behave almost the same, just borders differ.

For example,
read(0,NULL,len), len=4...7 
getsockopt/ioctl(fd, *GET*, NULL, sizeof(int))

returns success. Fortunately, they don't write to at address 0.

The following patch seems to be OK for 2.4.18:

less_than_4units:
        /*
         * rem = len % NBYTES
         */
        beq     rem, len, copy_bytes
         nop
1:
EXC(    LOAD     t0, 0(src),            l_exc)
        ADD     src, src, NBYTES
        SUB     len, len, NBYTES
-EXC(    STORE   t0, 0(dst),             s_exc)
+EXC(    STORE   t0, 0(dst),             s_exc_p1u)
        bne     rem, len, 1b
         ADD    dst, dst, NBYTES

Any comments?

Regards,
Gleb.
