Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 May 2006 11:15:43 +0200 (CEST)
Received: from NS4.Sony.CO.JP ([137.153.0.44]:39858 "HELO ns4.sony.co.jp")
	by ftp.linux-mips.org with SMTP id S8126616AbWE3JPf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 May 2006 11:15:35 +0200
Received: from mail5.sony.co.jp ([43.0.1.204])
Received: from mail5.sony.co.jp (localhost [127.0.0.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id k4U9FV5S025436
	for <linux-mips@linux-mips.org>; Tue, 30 May 2006 18:15:31 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id k4U9FVcl025425
	for <linux-mips@linux-mips.org>; Tue, 30 May 2006 18:15:31 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.4.191.32]) by smail1.sm.sony.co.jp (8.11.6p2/8.11.6) with ESMTP id k4U9FUY03104 for <linux-mips@linux-mips.org>; Tue, 30 May 2006 18:15:30 +0900 (JST)
Received: from localhost (tidal.sm.sony.co.jp [43.4.195.112])
	by imail.sm.sony.co.jp (8.12.11/3.7W) with ESMTP id k4U9FppE007500;
	Tue, 30 May 2006 18:15:51 +0900 (JST)
Date:	Tue, 30 May 2006 18:12:18 +0900 (JST)
Message-Id: <20060530.181218.74754108.kaminaga@sm.sony.co.jp>
To:	linux-mips@linux-mips.org
Cc:	kaminaga@sm.sony.co.jp
Subject: SIGSTKFLT in mips
From:	Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
X-Mailer: Mew version 4.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kaminaga@sm.sony.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaminaga@sm.sony.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

I'm using linux 2.6.16.11, and want to use SIGSTKFLT.

This signal is defined in most other architectures (in
include/asm-xxx/signal.h) but not in mips.

Any hint?


Thanks in Advance.

(Hiroki Kaminaga)
t
--
