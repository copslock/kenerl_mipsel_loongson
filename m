Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5P7CXnC031062
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 00:12:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5P7CXKq031061
	for linux-mips-outgoing; Tue, 25 Jun 2002 00:12:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5P7CLnC031054;
	Tue, 25 Jun 2002 00:12:22 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id AAA15932;
	Tue, 25 Jun 2002 00:15:35 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA06911;
	Tue, 25 Jun 2002 00:15:37 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5P7Fbb13213;
	Tue, 25 Jun 2002 09:15:37 +0200 (MEST)
Message-ID: <3D181898.837E864A@mips.com>
Date: Tue, 25 Jun 2002 09:15:36 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: LTP testing
Content-Type: multipart/mixed;
 boundary="------------AFB792D746638736CFC1E76F"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------AFB792D746638736CFC1E76F
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

The next LTP failure is:
mprotect01    1  FAIL  :  unexpected error - 14 : Bad address - expected
12

This has been fixed in the 2.4.19-pre4 patch.
But here is a local patch that solve the above problem, so we can have
this fixed before we have merged with kernel.org.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------AFB792D746638736CFC1E76F
Content-Type: text/plain; charset=iso-8859-15;
 name="mprotect.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mprotect.patch"

Index: mm/mprotect.c
===================================================================
RCS file: /home/repository/sw/linux-2.4.18/mm/mprotect.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mprotect.c
--- mm/mprotect.c	4 Mar 2002 11:13:35 -0000	1.1.1.1
+++ mm/mprotect.c	25 Jun 2002 07:00:55 -0000
@@ -284,7 +284,7 @@
 	down_write(&current->mm->mmap_sem);
 
 	vma = find_vma_prev(current->mm, start, &prev);
-	error = -EFAULT;
+	error = -ENOMEM;
 	if (!vma || vma->vm_start > start)
 		goto out;
 
@@ -317,7 +317,7 @@
 		nstart = tmp;
 		vma = next;
 		if (!vma || vma->vm_start != nstart) {
-			error = -EFAULT;
+			error = -ENOMEM;
 			goto out;
 		}
 	}

--------------AFB792D746638736CFC1E76F--
