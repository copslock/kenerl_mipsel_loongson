Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PAitnC007396
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 03:44:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PAitpJ007395
	for linux-mips-outgoing; Tue, 25 Jun 2002 03:44:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PAicnC007392;
	Tue, 25 Jun 2002 03:44:39 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id DAA16508;
	Tue, 25 Jun 2002 03:47:55 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA12708;
	Tue, 25 Jun 2002 03:47:55 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5PAlsb27260;
	Tue, 25 Jun 2002 12:47:55 +0200 (MEST)
Message-ID: <3D184A59.E755154B@mips.com>
Date: Tue, 25 Jun 2002 12:47:54 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: LTP testing
Content-Type: multipart/mixed;
 boundary="------------B685E88831FE5634C4CE0DD0"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------B685E88831FE5634C4CE0DD0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

The next LTP failure is:
msync05     1  FAIL  :  msync() fails, unexpected errno:14, expected:
ENOMEM

This has also been fixed in the 2.4.19-pre4 patch.
See the attached patch below.

/Carsten



--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------B685E88831FE5634C4CE0DD0
Content-Type: text/plain; charset=iso-8859-15;
 name="filemap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="filemap.patch"

Index: mm/filemap.c
===================================================================
RCS file: /home/repository/sw/linux-2.4.18/mm/filemap.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 filemap.c
--- mm/filemap.c	4 Mar 2002 11:13:34 -0000	1.1.1.1
+++ mm/filemap.c	25 Jun 2002 10:36:12 -0000
@@ -2179,18 +2179,18 @@
 		goto out;
 	/*
 	 * If the interval [start,end) covers some unmapped address ranges,
-	 * just ignore them, but return -EFAULT at the end.
+	 * just ignore them, but return -ENOMEM at the end.
 	 */
 	vma = find_vma(current->mm, start);
 	unmapped_error = 0;
 	for (;;) {
 		/* Still start < end. */
-		error = -EFAULT;
+		error = -ENOMEM;
 		if (!vma)
 			goto out;
 		/* Here start < vma->vm_end. */
 		if (start < vma->vm_start) {
-			unmapped_error = -EFAULT;
+			unmapped_error = -ENOMEM;
 			start = vma->vm_start;
 		}
 		/* Here vma->vm_start <= start < vma->vm_end. */

--------------B685E88831FE5634C4CE0DD0--
