Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Mar 2004 20:32:22 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:12393
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225198AbUCWUcV>; Tue, 23 Mar 2004 20:32:21 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1B5sZP-0007Sb-00; Tue, 23 Mar 2004 21:32:19 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1B5sZP-0001zr-00; Tue, 23 Mar 2004 21:32:19 +0100
Date: Tue, 23 Mar 2004 21:32:19 +0100
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] ABI selection fixes for unistd.h and asm.h
Message-ID: <20040323203219.GR26428@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oPmsXEqKQNHCSXW7"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello All,

the selection of the correct syscall wrapper ABI in unistd.h is
broken in an interesting way. I wonder why any kernel survived
this. Patch for 2.4 and 2.6 is attached.


Thiemo

--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="unistd-fix-2.4.diff"

Index: include/asm-mips/unistd.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/unistd.h,v
retrieving revision 1.29.2.7
diff -u -p -r1.29.2.7 unistd.h
--- include/asm-mips/unistd.h	31 Oct 2003 21:12:09 -0000	1.29.2.7
+++ include/asm-mips/unistd.h	23 Mar 2004 20:11:39 -0000
@@ -863,7 +863,7 @@ type name(atype a, btype b, ctype c, dty
 	return -1; \
 }
 
-#if (_MIPS_SIM == _MIPS_SIM_ABIN32)
+#if (_MIPS_SIM == _MIPS_SIM_ABI32)
 
 /*
  * Using those means your brain needs more than an oil change ;-)
@@ -931,9 +931,9 @@ type name(atype a, btype b, ctype c, dty
 	return -1; \
 }
 
-#endif /* (_MIPS_SIM == _MIPS_SIM_ABIN32) */
+#endif /* (_MIPS_SIM == _MIPS_SIM_ABI32) */
 
-#if (_MIPS_SIM == _MIPS_SIM_NABIN32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
+#if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
 
 #define _syscall5(type,name,atype,a,btype,b,ctype,c,dtype,d,etype,e) \
 type name (atype a,btype b,ctype c,dtype d,etype e) \
@@ -989,7 +989,7 @@ type name (atype a,btype b,ctype c,dtype
 	return -1; \
 }
 
-#endif /* (_MIPS_SIM == _MIPS_SIM_NABIN32) || (_MIPS_SIM == _MIPS_SIM_ABI64) */
+#endif /* (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64) */
 
 #ifdef __KERNEL_SYSCALLS__
 
Index: include/asm-mips64/unistd.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/Attic/unistd.h,v
retrieving revision 1.19.2.19
diff -u -p -r1.19.2.19 unistd.h
--- include/asm-mips64/unistd.h	28 Oct 2003 13:39:37 -0000	1.19.2.19
+++ include/asm-mips64/unistd.h	23 Mar 2004 20:11:39 -0000
@@ -865,7 +865,7 @@ type name(atype a, btype b, ctype c, dty
 	return -1; \
 }
 
-#if (_MIPS_SIM == _MIPS_SIM_ABIN32)
+#if (_MIPS_SIM == _MIPS_SIM_ABI32)
 
 /*
  * Using those means your brain needs more than an oil change ;-)
@@ -933,9 +933,9 @@ type name(atype a, btype b, ctype c, dty
 	return -1; \
 }
 
-#endif /* (_MIPS_SIM == _MIPS_SIM_ABIN32) */
+#endif /* (_MIPS_SIM == _MIPS_SIM_ABI32) */
 
-#if (_MIPS_SIM == _MIPS_SIM_NABIN32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
+#if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
 
 #define _syscall5(type,name,atype,a,btype,b,ctype,c,dtype,d,etype,e) \
 type name (atype a,btype b,ctype c,dtype d,etype e) \
@@ -991,7 +991,7 @@ type name (atype a,btype b,ctype c,dtype
 	return -1; \
 }
 
-#endif /* (_MIPS_SIM == _MIPS_SIM_NABIN32) || (_MIPS_SIM == _MIPS_SIM_ABI64) */
+#endif /* (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64) */
 
 #ifdef __KERNEL_SYSCALLS__
 

--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="unistd-fix-2.6.diff"

Index: include/asm-mips/asm.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/asm.h,v
retrieving revision 1.20
diff -u -p -r1.20 asm.h
--- include/asm-mips/asm.h	30 Dec 2003 06:01:04 -0000	1.20
+++ include/asm-mips/asm.h	23 Mar 2004 20:15:44 -0000
@@ -209,7 +209,7 @@ symbol		=	value
 #define ALSZ	7
 #define ALMASK	~7
 #endif
-#if (_MIPS_SIM == _MIPS_SIM_ABIN32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
+#if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
 #define ALSZ	15
 #define ALMASK	~15
 #endif
@@ -237,7 +237,7 @@ symbol		=	value
 #define REG_SUBU	subu
 #define REG_ADDU	addu
 #endif
-#if (_MIPS_SIM == _MIPS_SIM_ABIN32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
+#if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
 #define REG_S		sd
 #define REG_L		ld
 #define REG_SUBU	dsubu
@@ -386,7 +386,7 @@ symbol		=	value
 #define MFC0		mfc0
 #define MTC0		mtc0
 #endif
-#if (_MIPS_SIM == _MIPS_SIM_ABIN32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
+#if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
 #define MFC0		dmfc0
 #define MTC0		dmtc0
 #endif
Index: include/asm-mips/unistd.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/unistd.h,v
retrieving revision 1.58
diff -u -p -r1.58 unistd.h
--- include/asm-mips/unistd.h	11 Mar 2004 16:46:57 -0000	1.58
+++ include/asm-mips/unistd.h	23 Mar 2004 20:15:44 -0000
@@ -917,7 +917,7 @@ type name(atype a, btype b, ctype c, dty
 	return -1; \
 }
 
-#if (_MIPS_SIM == _MIPS_SIM_ABIN32)
+#if (_MIPS_SIM == _MIPS_SIM_ABI32)
 
 /*
  * Using those means your brain needs more than an oil change ;-)
@@ -985,9 +985,9 @@ type name(atype a, btype b, ctype c, dty
 	return -1; \
 }
 
-#endif /* (_MIPS_SIM == _MIPS_SIM_ABIN32) */
+#endif /* (_MIPS_SIM == _MIPS_SIM_ABI32) */
 
-#if (_MIPS_SIM == _MIPS_SIM_NABIN32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
+#if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
 
 #define _syscall5(type,name,atype,a,btype,b,ctype,c,dtype,d,etype,e) \
 type name (atype a,btype b,ctype c,dtype d,etype e) \
@@ -1043,7 +1043,7 @@ type name (atype a,btype b,ctype c,dtype
 	return -1; \
 }
 
-#endif /* (_MIPS_SIM == _MIPS_SIM_NABIN32) || (_MIPS_SIM == _MIPS_SIM_ABI64) */
+#endif /* (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64) */
 
 #ifdef __KERNEL_SYSCALLS__
 

--oPmsXEqKQNHCSXW7--
