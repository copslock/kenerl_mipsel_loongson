Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2005 01:59:54 +0000 (GMT)
Received: from fw.osdl.org ([IPv6:::ffff:65.172.181.6]:15492 "EHLO
	mail.osdl.org") by linux-mips.org with ESMTP id <S8225239AbVATB7t>;
	Thu, 20 Jan 2005 01:59:49 +0000
Received: from build.pdx.osdl.net (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with ESMTP id j0K1xkl31108;
	Wed, 19 Jan 2005 17:59:46 -0800
Received: (from chrisw@localhost)
	by build.pdx.osdl.net (8.11.6/8.11.6) id j0K1xjg20910;
	Wed, 19 Jan 2005 17:59:45 -0800
Date:	Wed, 19 Jan 2005 17:59:45 -0800
From:	Chris Wright <chrisw@osdl.org>
To:	akpm@osdl.org, torvalds@osdl.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] mips default mlock limit fix
Message-ID: <20050119175945.K469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <chrisw@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chrisw@osdl.org
Precedence: bulk
X-list: linux-mips

Mips RLIMIT_MEMLOCK incorrectly defaults to unlimited, it was confused
with RLIMIT_NPROC.  Found while consolidating resource.h headers.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== include/asm-mips/resource.h 1.6 vs edited =====
--- 1.6/include/asm-mips/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-mips/resource.h	2005-01-19 17:34:25 -08:00
@@ -53,8 +53,8 @@
 	{ INR_OPEN,      INR_OPEN      },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MLOCK_LIMIT,     MLOCK_LIMIT },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ 0,             0             },		\
+	{ MLOCK_LIMIT,   MLOCK_LIMIT   },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
