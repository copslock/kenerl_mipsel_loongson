Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6IGgXRw003065
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Jul 2002 09:42:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6IGgXms003064
	for linux-mips-outgoing; Thu, 18 Jul 2002 09:42:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from marvin.ffo.org (dialin-145-254-057-082.arcor-ip.net [145.254.57.82])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6IGgBRw003053
	for <linux-mips@oss.sgi.com>; Thu, 18 Jul 2002 09:42:18 -0700
Received: from localhost (localhost [[UNIX: localhost]])
	by marvin.ffo.org (8.11.6/8.10.2/SuSE Linux 8.10.0-0.3) id g6I5gcQ01010
	for linux-mips@oss.sgi.com; Thu, 18 Jul 2002 07:42:38 +0200
Message-Id: <200207180542.g6I5gcQ01010@marvin.ffo.org>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Frank Foerstemann <Foerstemann@web.de>
To: "linux-mips" <linux-mips@oss.sgi.com>
Subject: booting 2.5.3 kernel crashes
Date: Thu, 18 Jul 2002 07:42:37 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, hits=0.6 required=5.0 tests=TO_LOCALPART_EQ_REAL version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi.

I tried the 2.5.3 Kernel from CVS on my R44K-Indy. Compiling works fine, but 
when I try to boot the kernel it crashes after the message "Posix conformance 
testing ..." with the error:

"Kernel unaligned instruction access in: unaligned.c::do_ade, line 409 ..."

Does anybody know what's wrong ? 

Unfortunately I do not have a serial console connected to dump the whole 
message to disk. Is it possible to do that from the newport console ?

Regards.

Frank
