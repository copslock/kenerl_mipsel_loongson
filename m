Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 11:47:36 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:40439 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225265AbSLEKrf>;
	Thu, 5 Dec 2002 11:47:35 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB5AlPNf028681;
	Thu, 5 Dec 2002 02:47:25 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA10411;
	Thu, 5 Dec 2002 02:47:25 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB5AlQb24460;
	Thu, 5 Dec 2002 11:47:26 +0100 (MET)
Message-ID: <3DEF2EBE.F273B44A@mips.com>
Date: Thu, 05 Dec 2002 11:47:26 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Compiler problems with zero-length array in the middle of a struct
Content-Type: multipart/mixed;
 boundary="------------263E4BD1E717834E31EFD8E6"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------263E4BD1E717834E31EFD8E6
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Some compiler reject a zero-length array in the middle of a structure,
and report it as an error.
So could we please redo the change, that has recently been done to
include/linux/raid/md_p.h (see patch below).

/Carsten



--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------263E4BD1E717834E31EFD8E6
Content-Type: text/plain; charset=iso-8859-15;
 name="md_p.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="md_p.patch"

Index: include/linux/raid/md_p.h
===================================================================
RCS file: /home/cvs/linux/include/linux/raid/md_p.h,v
retrieving revision 1.3
diff -u -r1.3 md_p.h
--- include/linux/raid/md_p.h	28 Nov 2000 03:59:04 -0000	1.3
+++ include/linux/raid/md_p.h	5 Dec 2002 10:40:55 -0000
@@ -151,10 +151,12 @@
 	 */
 	mdp_disk_t disks[MD_SB_DISKS];
 
+#if MD_SB_RESERVED_WORDS
 	/*
 	 * Reserved
 	 */
 	__u32 reserved[MD_SB_RESERVED_WORDS];
+#endif
 
 	/*
 	 * Active descriptor

--------------263E4BD1E717834E31EFD8E6--
