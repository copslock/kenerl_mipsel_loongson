Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2004 04:25:00 +0100 (BST)
Received: from fw.osdl.org ([IPv6:::ffff:65.172.181.6]:3240 "EHLO
	mail.osdl.org") by linux-mips.org with ESMTP id <S8224930AbUFADYz>;
	Tue, 1 Jun 2004 04:24:55 +0100
Received: from midway.verizon.net (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i513Opr15187;
	Mon, 31 May 2004 20:24:52 -0700
Date: Mon, 31 May 2004 20:21:01 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-mips@linux-mips.org
Cc: ralf@gnu.org, rddunlap <rddunlap@osdl.org>
Subject: [PATCH] MIPS getdomainname() off by 1;
Message-Id: <20040531202101.4ace5e95.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <rddunlap@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rddunlap@osdl.org
Precedence: bulk
X-list: linux-mips


irix_getdomainname() max size appears to be off by 1;
other similar code in kernel uses __NEW_UTS_LEN as the max size,
and <domainname> includes an extra byte for the terminating
null character.

Does sysirix.c need to limit <len> to 63 instead of 64 for some
reason?


diffstat:=
 arch/mips/kernel/sysirix.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Naurp ./arch/mips/kernel/sysirix.c~uts_len_off1 ./arch/mips/kernel/sysirix.c
--- ./arch/mips/kernel/sysirix.c~uts_len_off1	2004-05-31 13:58:24.000000000 -0700
+++ ./arch/mips/kernel/sysirix.c	2004-05-31 20:11:42.000000000 -0700
@@ -913,8 +913,8 @@ asmlinkage int irix_getdomainname(char *
 		return error;
 
 	down_read(&uts_sem);
-	if(len > (__NEW_UTS_LEN - 1))
-		len = __NEW_UTS_LEN - 1;
+	if (len > __NEW_UTS_LEN)
+		len = __NEW_UTS_LEN;
 	error = 0;
 	if (copy_to_user(name, system_utsname.domainname, len))
 		error = -EFAULT;

--
~Randy
