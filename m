Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2005 11:25:52 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:13316
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225875AbVDVKZg>; Fri, 22 Apr 2005 11:25:36 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 22 Apr 2005 10:25:34 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id B9DFD1F325;
	Fri, 22 Apr 2005 19:25:30 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id A4CC31F2E4;
	Fri, 22 Apr 2005 19:25:30 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j3MAPUoj014343;
	Fri, 22 Apr 2005 19:25:30 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 22 Apr 2005 19:25:30 +0900 (JST)
Message-Id: <20050422.192530.65824230.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: 2.4.30 do_readv_writev32 fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Hi.  Here is a patch to fix a bug introduced on 2.4.30 ...

--- linux-mips-2.4/arch/mips64/kernel/linux32.c	2005-04-18 11:44:19.000000000 +0900
+++ linux-2.4/arch/mips64/kernel/linux32.c	2005-04-22 19:15:32.358642423 +0900
@@ -1101,6 +1101,7 @@
 	 * specially as they have atomicity guarantees and can handle
 	 * iovec's natively
 	 */
+	inode = file->f_dentry->d_inode;
 	if (inode->i_sock) {
 		int err;
 		err = sock_readv_writev(type, inode, file, iov, count, tot_len);
