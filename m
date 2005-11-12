Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2005 23:40:13 +0000 (GMT)
Received: from smtp2-g19.free.fr ([212.27.42.28]:15489 "EHLO smtp2-g19.free.fr")
	by ftp.linux-mips.org with ESMTP id S8136302AbVKLXgk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Nov 2005 23:36:40 +0000
Received: from groumpf (str90-1-82-238-123-182.fbx.proxad.net [82.238.123.182])
	by smtp2-g19.free.fr (Postfix) with ESMTP id CB126522F5;
	Sun, 13 Nov 2005 00:38:19 +0100 (CET)
Received: from jekyll.groumpf.homeip.net ([192.168.1.1] helo=jekyll)
	by groumpf with esmtp (Exim 4.50)
	id 1Eb4ws-0003IW-OZ; Sun, 13 Nov 2005 00:38:19 +0100
Received: from arnaud by jekyll with local (Exim 4.50)
	id 1Eb4ws-00007O-Hl; Sun, 13 Nov 2005 00:38:18 +0100
To:	ralf@linux-mips.org
Subject: [PATCH] Documentation typos
Cc:	linux-mips@linux-mips.org
Message-Id: <E1Eb4ws-00007O-Hl@jekyll>
From:	Arnaud Giersch <arnaud.giersch@free.fr>
Date:	Sun, 13 Nov 2005 00:38:18 +0100
Return-Path: <arnaud.giersch@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnaud.giersch@free.fr
Precedence: bulk
X-list: linux-mips

Fix documentation typos.

Signed-off-by: Arnaud Giersch <arnaud.giersch@free.fr>
---

 atomic.h |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/asm-mips/atomic.h b/include/asm-mips/atomic.h
--- a/include/asm-mips/atomic.h
+++ b/include/asm-mips/atomic.h
@@ -231,11 +231,12 @@ static __inline__ int atomic_sub_return(
 }
 
 /*
- * atomic_sub_if_positive - add integer to atomic variable
+ * atomic_sub_if_positive - conditionally subtract integer from atomic variable
+ * @i: integer value to subtract
  * @v: pointer of type atomic_t
  *
- * Atomically test @v and decrement if it is greater than 0.
- * The function returns the old value of @v minus 1.
+ * Atomically test @v and subtract @i if @v is greater or equal than @i.
+ * The function returns the old value of @v minus @i.
  */
 static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 {
@@ -556,11 +557,12 @@ static __inline__ long atomic64_sub_retu
 }
 
 /*
- * atomic64_sub_if_positive - add integer to atomic variable
+ * atomic64_sub_if_positive - conditionally subtract integer from atomic variable
+ * @i: integer value to subtract
  * @v: pointer of type atomic64_t
  *
- * Atomically test @v and decrement if it is greater than 0.
- * The function returns the old value of @v minus 1.
+ * Atomically test @v and subtract @i if @v is greater or equal than @i.
+ * The function returns the old value of @v minus @i.
  */
 static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 {
