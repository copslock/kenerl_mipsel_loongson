Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MDqmRw023981
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 06:52:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MDqmqT023980
	for linux-mips-outgoing; Mon, 22 Jul 2002 06:52:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MDqcRw023971
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 06:52:38 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6MDqlXb019720;
	Mon, 22 Jul 2002 06:52:47 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA14969;
	Mon, 22 Jul 2002 06:52:48 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6MDqlb28655;
	Mon, 22 Jul 2002 15:52:47 +0200 (MEST)
Message-ID: <3D3C0E26.676F4799@mips.com>
Date: Mon, 22 Jul 2002 15:52:46 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: sys32_execve fix
Content-Type: multipart/mixed;
 boundary="------------0967D9EF9A0F0F6F4EC3A5B9"
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------0967D9EF9A0F0F6F4EC3A5B9
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

The following test fails on the 64-bit kernel:

#include <unistd.h>
#include <errno.h>

main(void)
{
        int ret;

        ret = execve("/bin/ls", NULL, NULL);
        printf("ret = %d, errno = %d\n", ret, errno);
}


The problem is that "nargs" in arch/mips64/kernel/linux32.c fails when
argv is NULL, the patch below should fix the problem:

/Carsten



--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------0967D9EF9A0F0F6F4EC3A5B9
Content-Type: text/plain; charset=iso-8859-15;
 name="linux32.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux32.patch"

Index: arch/mips64/kernel/linux32.c
===================================================================
RCS file: /cvs/linux/arch/mips64/kernel/linux32.c,v
retrieving revision 1.42.2.6
diff -u -r1.42.2.6 linux32.c
--- arch/mips64/kernel/linux32.c	2002/07/01 00:17:14	1.42.2.6
+++ arch/mips64/kernel/linux32.c	2002/07/22 13:49:33
@@ -411,12 +411,14 @@
 	int n, ret;
 
 	n = 0;
+	ptr = NULL;
 	do {
 		/* egcs is stupid */
 		if (!access_ok(VERIFY_READ, arg, sizeof (unsigned int)))
 			return -EFAULT;
-		if (IS_ERR(ret = __get_user((long)ptr,(int *)A(arg))))
-			return ret;
+		if (arg)
+			if (IS_ERR(ret = __get_user((long)ptr,(int *)A(arg))))
+				return ret;
 		if (ap)		/* no access_ok needed, we allocated */
 			if (IS_ERR(ret = __put_user(ptr, ap++)))
 				return ret;

--------------0967D9EF9A0F0F6F4EC3A5B9--
