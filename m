Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OFZPnC000398
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 08:35:25 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OFZPe5000397
	for linux-mips-outgoing; Mon, 24 Jun 2002 08:35:25 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OFZCnC000394;
	Mon, 24 Jun 2002 08:35:14 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id TAA27667;
	Mon, 24 Jun 2002 19:13:48 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id TAA26730; Mon, 24 Jun 2002 19:06:02 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id TAA28785; Mon, 24 Jun 2002 19:09:00 +0400 (MSK)
Message-ID: <3D17376B.59333E27@niisi.msk.ru>
Date: Mon, 24 Jun 2002 19:14:51 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Carsten Langgaard <carstenl@mips.com>
CC: Ralf Baechle <ralf@oss.sgi.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Bug in __copy_user
References: <3D1729F3.7241A74A@mips.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Carsten Langgaard wrote:
> 
> I have started to look a little bit at the LTP tests.
> And one of the testcases that fails (actually it doesn't fail as it
> supposed to do) is the syscall getsockopt.
> I think the failure is due to the copy_to_user(0, from, 4) call returns
> 0, which I wouldn't expect when the destination pointer is NULL.
> 
> I think the problem is in the __copy_user function in
> arch/mips/lib/memcpy.
> It tries to handle the exception, which we get because the destination
> pointer is NULL, by returning the number of uncopied bytes in $a2 to the
> caller.
> But in this case the length is only 4 bytes, and the copying is done by
> a single 'sw'. The problem is the length ($a2) is decreased by 4 before
> the 'sw' is executed.
> The 'sw' fails and __copy_user terminates, but returns with $a2 = 0
> (instead 4).
> 
> I thing the following patch will solve the problem.

Been here, done that. In fact, I posted the following patch few days ago
to the list:
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

This patch also solves the problem for mips in 2.4/2.5 kernel. My
question was about the patch for mips64 and mips in 2.2 kernel.

Shall memcpy.S from 2.4/2.5 be backported to 2.2 and mips64?

Regards,
Gleb.
