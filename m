Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OEEOnC031036
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 07:14:24 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OEEObN031035
	for linux-mips-outgoing; Mon, 24 Jun 2002 07:14:24 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OEECnC031032;
	Mon, 24 Jun 2002 07:14:12 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id HAA11862;
	Mon, 24 Jun 2002 07:17:24 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA04198;
	Mon, 24 Jun 2002 07:17:25 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5OEHOb08148;
	Mon, 24 Jun 2002 16:17:24 +0200 (MEST)
Message-ID: <3D1729F3.7241A74A@mips.com>
Date: Mon, 24 Jun 2002 16:17:23 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Bug in __copy_user
Content-Type: multipart/mixed;
 boundary="------------4EBBDD03DDAA4619AEF963D7"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------4EBBDD03DDAA4619AEF963D7
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

I have started to look a little bit at the LTP tests.
And one of the testcases that fails (actually it doesn't fail as it
supposed to do) is the syscall getsockopt.
I think the failure is due to the copy_to_user(0, from, 4) call returns
0, which I wouldn't expect when the destination pointer is NULL.

I think the problem is in the __copy_user function in
arch/mips/lib/memcpy.
It tries to handle the exception, which we get because the destination
pointer is NULL, by returning the number of uncopied bytes in $a2 to the
caller.
But in this case the length is only 4 bytes, and the copying is done by
a single 'sw'. The problem is the length ($a2) is decreased by 4 before
the 'sw' is executed.
The 'sw' fails and __copy_user terminates, but returns with $a2 = 0
(instead 4).

I thing the following patch will solve the problem.

/Carsten



--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------4EBBDD03DDAA4619AEF963D7
Content-Type: text/plain; charset=iso-8859-15;
 name="memcpy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="memcpy.patch"

Index: arch/mips/lib/memcpy.S
===================================================================
RCS file: /home/repository/sw/linux-2.4.18/arch/mips/lib/memcpy.S,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 memcpy.S
--- arch/mips/lib/memcpy.S	4 Mar 2002 11:12:21 -0000	1.1.1.1
+++ arch/mips/lib/memcpy.S	24 Jun 2002 13:46:07 -0000
@@ -248,8 +248,8 @@
 1:
 EXC(	LOAD	 t0, 0(src),		l_exc)
 	ADD	src, src, NBYTES
-	SUB	len, len, NBYTES
 EXC(	STORE	t0, 0(dst),		s_exc)
+	SUB	len, len, NBYTES
 	bne	rem, len, 1b
 	 ADD	dst, dst, NBYTES
 

--------------4EBBDD03DDAA4619AEF963D7--
