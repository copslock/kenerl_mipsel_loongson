Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 16:14:46 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:5375 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225289AbSLEPOp>;
	Thu, 5 Dec 2002 16:14:45 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB5FEONf029702;
	Thu, 5 Dec 2002 07:14:24 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA19301;
	Thu, 5 Dec 2002 07:14:23 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB5FELb14348;
	Thu, 5 Dec 2002 16:14:22 +0100 (MET)
Message-ID: <3DEF6D4D.C0E886B0@mips.com>
Date: Thu, 05 Dec 2002 16:14:21 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Dominic Sweetman <dom@algor.co.uk>
CC: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@linux-mips.org,
	dom@mips.com, chris@mips.com, kevink@mips.com
Subject: Re: Prefetches in memcpy
References: <3DC7CB8B.E2C1D4E5@mips.com>
		<20021105163806.A24996@bacchus.dhis.org>
		<3DEE19EC.DD007304@mips.com> <15855.7458.19248.593085@arsenal.algor.co.uk>
Content-Type: multipart/mixed;
 boundary="------------534F69F3F58268A8B4810BE7"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------534F69F3F58268A8B4810BE7
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Here's what I think we should do for now (attached patch).

/Carsten


Dominic Sweetman wrote:

> Carsten,
>
> > I think we should get rid of the prefetches until someone comes up with a
> > version that doesn't prefetch beyond the copy destination/source area.
>
> I agree.
>
> --
> Dominic

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------534F69F3F58268A8B4810BE7
Content-Type: text/plain; charset=iso-8859-15;
 name="memcpy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="memcpy.patch"

Index: arch/mips/lib/memcpy.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/lib/memcpy.S,v
retrieving revision 1.6.2.4
diff -u -r1.6.2.4 memcpy.S
--- arch/mips/lib/memcpy.S	19 Sep 2002 14:01:24 -0000	1.6.2.4
+++ arch/mips/lib/memcpy.S	5 Dec 2002 15:06:58 -0000
@@ -21,6 +21,17 @@
 #define src a1
 #define len a2
 
+/* 
+ * There is spread a number of PREF instructions in the memcpy function, but 
+ * there is no check if we are prefetching out-side the "memcpy" areas. 
+ * This is extremely dangerous because we might prefetch out-side the physical
+ * memory area causing e.g. a bus error or something even more nasty. 
+ * It could also hit a DMA buffer region, and there by break the PCI DMA 
+ * flushing scheme.
+ * So for now, we simply get rid of the PREFs here.
+ */
+#define PREF(hint,addr)
+	
 /*
  * Spec
  *
Index: arch/mips64/lib/memcpy.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/lib/memcpy.S,v
retrieving revision 1.9.2.3
diff -u -r1.9.2.3 memcpy.S
--- arch/mips64/lib/memcpy.S	19 Sep 2002 14:01:24 -0000	1.9.2.3
+++ arch/mips64/lib/memcpy.S	5 Dec 2002 15:06:59 -0000
@@ -21,6 +21,17 @@
 #define src a1
 #define len a2
 
+/* 
+ * There is spread a number of PREF instructions in the memcpy function, but 
+ * there is no check if we are prefetching out-side the "memcpy" areas. 
+ * This is extremely dangerous because we might prefetch out-side the physical
+ * memory area causing e.g. a bus error or something even more nasty. 
+ * It could also hit a DMA buffer region, and there by break the PCI DMA 
+ * flushing scheme.
+ * So for now, we simply get rid of the PREFs here.
+ */
+#define PREF(hint,addr)
+	
 /*
  * Spec
  *

--------------534F69F3F58268A8B4810BE7--
