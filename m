Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 00:53:14 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:3973 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225072AbTC1AxB>;
	Fri, 28 Mar 2003 00:53:01 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id CA98246BA6; Fri, 28 Mar 2003 01:51:32 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: add .cvsignore
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Fri, 28 Mar 2003 01:51:32 +0100
Message-ID: <m23cl8b9ez.fsf@neno.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
	this is the same .cvsignore than for the 32bits branch.

Later, Juan.


 build/arch/mips64/boot/.cvsignore |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN /dev/null build/arch/mips64/boot/.cvsignore
--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ 24-quintela/build/arch/mips64/boot/.cvsignore	2003-03-28 00:27:04.000000000 +0100
@@ -0,0 +1,6 @@
+.depend
+.*.flags
+mkboot zImage zImage.tmp
+addinitrd
+elf2ecoff
+vmlinux.ecoff

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
