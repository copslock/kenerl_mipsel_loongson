Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9M6GFB26973
	for linux-mips-outgoing; Sun, 21 Oct 2001 23:16:15 -0700
Received: from ns5.sony.co.jp (NS5.Sony.CO.JP [146.215.0.105])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9M6GBD26970
	for <linux-mips@oss.sgi.com>; Sun, 21 Oct 2001 23:16:12 -0700
Received: from mail2.sony.co.jp (GateKeeper8.Sony.CO.JP [146.215.0.71])
	by ns5.sony.co.jp (R8/Sony) with ESMTP id f9M6GAL29936;
	Mon, 22 Oct 2001 15:16:10 +0900 (JST)
Received: from mail2.sony.co.jp (localhost [127.0.0.1])
	by mail2.sony.co.jp (R8) with ESMTP id f9M6G9H02620;
	Mon, 22 Oct 2001 15:16:09 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail2.sony.co.jp (R8) with ESMTP id f9M6G8A02569;
	Mon, 22 Oct 2001 15:16:08 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id PAA15409; Mon, 22 Oct 2001 15:20:28 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id PAA05995; Mon, 22 Oct 2001 15:16:06 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id f9M6G6e11799; Mon, 22 Oct 2001 15:16:06 +0900 (JST)
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: linux-mips@oss.sgi.com
Subject: csum_ipv6_magic()
X-Mailer: Mew version 1.94.2 on Emacs 19.28 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011022151606V.machida@sm.sony.co.jp>
Date: Mon, 22 Oct 2001 15:16:06 +0900
From: Machida Hiroyuki <machida@sm.sony.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I guess that csum_ipv6_magic() in include/asm-mips/checksum.h 
needs "addu %0, $1" at the next of "sltu $1, %0, $1".
Without this, you cannot add a carry of the last addtion.


--- checksum.h.ORG      Mon Oct 22 15:09:32 2001
+++ checksum.h  Mon Oct 22 15:09:51 2001
@@ -249,6 +249,7 @@ static __inline__ unsigned short int csu
        "addu\t%0, $1\n\t"
        "addu\t%0, %1\n\t"
        "sltu\t$1, %0, $1\n\t"
+       "addu\t%0, $1\n\t"
        ".set\tnoat\n\t"
        ".set\tnoreorder"
        : "=r" (sum), "=r" (proto)

---
Hiroyuki Machida
Sony Corp.
