Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g78DRjRw015136
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 8 Aug 2002 06:27:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g78DRjrc015135
	for linux-mips-outgoing; Thu, 8 Aug 2002 06:27:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g78DRXRw015117;
	Thu, 8 Aug 2002 06:27:33 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g78DOsXb020449;
	Thu, 8 Aug 2002 06:24:54 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA17574;
	Thu, 8 Aug 2002 06:24:53 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g78DOmb12558;
	Thu, 8 Aug 2002 15:24:50 +0200 (MEST)
Message-ID: <3D52711F.D5C6A8FC@mips.com>
Date: Thu, 08 Aug 2002 15:24:47 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   linux-mips@oss.sgi.com
Subject: memcpy.S patch in 64-bit
Content-Type: multipart/mixed;
 boundary="------------F6E7F0A5F1691FA9120D6760"
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------F6E7F0A5F1691FA9120D6760
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

The __copy_user function (in arch/mips64/lib/memcpy.S) calls __bzero.
We can't do that because __bzero might modify len, which we want to
return in case of an error.
The following patch take care of the problem.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------F6E7F0A5F1691FA9120D6760
Content-Type: text/plain; charset=iso-8859-15;
 name="memcpy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="memcpy.patch"

Index: arch/mips64/lib/memcpy.S
===================================================================
RCS file: /cvs/linux/arch/mips64/lib/memcpy.S,v
retrieving revision 1.9.2.1
diff -u -r1.9.2.1 memcpy.S
--- arch/mips64/lib/memcpy.S	2002/08/05 23:53:36	1.9.2.1
+++ arch/mips64/lib/memcpy.S	2002/08/08 13:19:10
@@ -762,8 +762,18 @@
 	dsubu	a2, AT, ta0			# a2 bytes to go
 	daddu	a0, ta0				# compute start address in a1
 	dsubu	a0, a1
-	j	__bzero
-	 move	a1, zero
+	/*
+	 * Clear len bytes starting at dst.  Can't call __bzero because it
+	 * might modify len.  An inefficient loop for these rare times...
+	 */
+	beqz	a2, 2f
+	 dsubu	a1, a2, 1
+1:	sb	zero, 0(a0)
+	daddu	a0, a0, 1
+	bnez	a1, 1b
+	 dsubu	a1, a1, 1
+2:	jr	ra
+	 nop
 
 s_fixup:
 	jr	ra

--------------F6E7F0A5F1691FA9120D6760--
