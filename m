Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB2ECpL31559
	for linux-mips-outgoing; Sun, 2 Dec 2001 06:12:51 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fB2ECgo31555
	for <linux-mips@oss.sgi.com>; Sun, 2 Dec 2001 06:12:42 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fB2DCX918319;
	Mon, 3 Dec 2001 00:12:33 +1100
Date: Mon, 3 Dec 2001 00:12:33 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Kjeld Borch Egevang <kjelde@mips.com>
Cc: Mark Salter <msalter@redhat.com>, linux-mips@oss.sgi.com
Subject: Re: math emulator patch
Message-ID: <20011203001233.A13616@dea.linux-mips.net>
References: <200111300138.fAU1cOA31059@deneb.localdomain> <Pine.LNX.4.33.0112010033480.29161-100000@coplin19.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112010033480.29161-100000@coplin19.mips.com>; from kjelde@mips.com on Sat, Dec 01, 2001 at 12:36:44AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Dec 01, 2001 at 12:36:44AM +0100, Kjeld Borch Egevang wrote:

> Great. The same problem exists for sp_tlong.c and dp_tlong.c.

Ok, this is what I'm going to checkin for both 2.4 and 2.5.  Tell me if
that's ok.

Btw, we've got so many almost identical sourcefiles in the fp emulation
code, something should be done about that ...

  Ralf

Index: arch/mips/math-emu/dp_tint.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/math-emu/dp_tint.c,v
retrieving revision 1.4
diff -u -r1.4 dp_tint.c
--- arch/mips/math-emu/dp_tint.c	2001/10/09 23:56:18	1.4
+++ arch/mips/math-emu/dp_tint.c	2001/12/02 13:10:44
@@ -50,6 +50,9 @@
 		break;
 	}
 	if (xe >= 31) {
+		/* look for valid corner case */
+		if (xe == 31 && xs && xm == DP_HIDDEN_BIT)
+			return -2147483648;
 		/* Set invalid. We will only use overflow for floating
 		   point overflow */
 		SETCX(IEEE754_INVALID_OPERATION);
Index: arch/mips/math-emu/dp_tlong.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/math-emu/dp_tlong.c,v
retrieving revision 1.5
diff -u -r1.5 dp_tlong.c
--- arch/mips/math-emu/dp_tlong.c	2001/11/21 15:53:51	1.5
+++ arch/mips/math-emu/dp_tlong.c	2001/12/02 13:10:44
@@ -49,6 +49,9 @@
 		break;
 	}
 	if (xe >= 63) {
+		/* look for valid corner case */ 
+		if (xe == 63 && xs && xm == DP_HIDDEN_BIT)
+			return -9223372036854775808LL;
 		/* Set invalid. We will only use overflow for floating
 		   point overflow */
 		SETCX(IEEE754_INVALID_OPERATION);
Index: arch/mips/math-emu/sp_tint.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/math-emu/sp_tint.c,v
retrieving revision 1.4
diff -u -r1.4 sp_tint.c
--- arch/mips/math-emu/sp_tint.c	2001/10/09 23:56:19	1.4
+++ arch/mips/math-emu/sp_tint.c	2001/12/02 13:10:44
@@ -50,6 +50,9 @@
 		break;
 	}
 	if (xe >= 31) {
+		/* look for valid corner case */
+		if (xe == 31 && xs && xm == SP_HIDDEN_BIT)
+			return -2147483648;
 		/* Set invalid. We will only use overflow for floating
 		   point overflow */
 		SETCX(IEEE754_INVALID_OPERATION);
Index: arch/mips/math-emu/sp_tlong.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/math-emu/sp_tlong.c,v
retrieving revision 1.4
diff -u -r1.4 sp_tlong.c
--- arch/mips/math-emu/sp_tlong.c	2001/10/09 23:56:19	1.4
+++ arch/mips/math-emu/sp_tlong.c	2001/12/02 13:10:44
@@ -49,6 +49,9 @@
 		break;
 	}
 	if (xe >= 63) {
+		/* look for valid corner case */
+		if (xe == 63 && xs && xm == SP_HIDDEN_BIT)
+			return -9223372036854775808LL;
 		/* Set invalid. We will only use overflow for floating
 		   point overflow */
 		SETCX(IEEE754_INVALID_OPERATION);
