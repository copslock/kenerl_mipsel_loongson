Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2003 23:57:18 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:63988 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225212AbTGIW5Q>;
	Wed, 9 Jul 2003 23:57:16 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h69Musm32613;
	Wed, 9 Jul 2003 15:56:54 -0700
Date: Wed, 9 Jul 2003 15:56:54 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] _syscall macros
Message-ID: <20030709155654.L27926@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


In testing some new syscalls, I found that the current 
_syscall macros do not return the right errno.  A little
further probing shows that errno now is a function call,
and on returning from the call original __v0 from syscall
is corrupted.

Here is a patch to fix this.  Looks good?

Jun

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030709.a-errno-messed-up-in-syscall-macros.patch"

diff -Nru link/include/asm-mips/unistd.h.orig link/include/asm-mips/unistd.h
--- link/include/asm-mips/unistd.h.orig	Thu Nov  7 14:05:44 2002
+++ link/include/asm-mips/unistd.h	Wed Jul  9 15:42:32 2003
@@ -276,7 +276,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -302,7 +302,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -325,7 +325,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -349,7 +349,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -373,7 +373,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -406,7 +406,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -437,7 +437,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -471,7 +471,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
diff -Nru link/include/asm-mips64/unistd.h.orig link/include/asm-mips64/unistd.h
--- link/include/asm-mips64/unistd.h.orig	Wed Apr  9 14:40:24 2003
+++ link/include/asm-mips64/unistd.h	Wed Jul  9 15:43:11 2003
@@ -729,7 +729,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -755,7 +755,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -778,7 +778,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -802,7 +802,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -826,7 +826,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -853,7 +853,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -884,7 +884,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -916,7 +916,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -951,7 +951,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -982,7 +982,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 
@@ -1016,7 +1016,7 @@
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
-	errno = __v0; \
+	{ int ret = __v0; errno = ret; } \
 	return -1; \
 }
 

--wac7ysb48OaltWcw--
