Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 19:56:52 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:12672 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225473AbSLST4v>;
	Thu, 19 Dec 2002 19:56:51 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 3780AD657; Thu, 19 Dec 2002 21:02:57 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: Remove 2 unused variables
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 21:02:57 +0100
Message-ID: <m2hed9ixou.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        errno and p are not used in that function at all.

Later, Juan.

Index: arch/mips64/kernel/syscall.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/syscall.c,v
retrieving revision 1.16.2.7
diff -u -r1.16.2.7 syscall.c
--- arch/mips64/kernel/syscall.c	5 Aug 2002 23:53:36 -0000	1.16.2.7
+++ arch/mips64/kernel/syscall.c	19 Dec 2002 19:48:43 -0000
@@ -189,9 +189,8 @@
 asmlinkage int
 sys_sysmips(int cmd, long arg1, int arg2, int arg3)
 {
-	int	*p;
 	char	*name;
-	int	tmp, len, errno;
+	int	tmp, len;
 
 	switch(cmd) {
 	case SETNAME: {


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
