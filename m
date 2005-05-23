Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2005 16:52:18 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:62445 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225781AbVEWPwD>; Mon, 23 May 2005 16:52:03 +0100
Received: from localhost (p6118-ipad205funabasi.chiba.ocn.ne.jp [222.146.101.118])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id DEDC084F4
	for <linux-mips@linux-mips.org>; Tue, 24 May 2005 00:51:59 +0900 (JST)
Date:	Tue, 24 May 2005 00:54:47 +0900 (JST)
Message-Id: <20050524.005447.96686952.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: Re: yenta_socket
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050523184501.3e733eb3.toch@dfpost.ru>
References: <20050523184501.3e733eb3.toch@dfpost.ru>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 23 May 2005 18:45:01 +0400, Dmitriy Tochansky <toch@dfpost.ru> said:

toch> Im enable cardbus yenta type in kernel config and see the
toch> follow:

toch> yenta 0000:00:11.0: Preassigned resource 0 busy, reconfiguring...
toch> yenta 0000:00:11.0: Preassigned resource 1 busy, reconfiguring...

I think these messages are due to confliction with resource management
codes in drivers/pci/setup-bus.c.  Though I do not see details yet,
this quick workaround might solve this issue.

--- linux-mips/drivers/pcmcia/yenta_socket.c	2005-04-18 00:43:34.000000000 +0900
+++ linux/drivers/pcmcia/yenta_socket.c	2005-05-04 00:21:38.000000000 +0900
@@ -611,10 +611,12 @@
  */
 static void yenta_allocate_resources(struct yenta_socket *socket)
 {
+#if 0
 	yenta_allocate_res(socket, 0, IORESOURCE_MEM|IORESOURCE_PREFETCH);
 	yenta_allocate_res(socket, 1, IORESOURCE_MEM);
 	yenta_allocate_res(socket, 2, IORESOURCE_IO);
 	yenta_allocate_res(socket, 3, IORESOURCE_IO);	/* PCI isn't clever enough to use this one yet */
+#endif
 }
 
 
---
Atsushi Nemoto
