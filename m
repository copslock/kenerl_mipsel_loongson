Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2003 15:53:53 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:47813 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225513AbTLTPxu>;
	Sat, 20 Dec 2003 15:53:50 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA24328;
	Sun, 21 Dec 2003 00:53:47 +0900 (JST)
Received: 4UMDO01 id hBKFrlx20236; Sun, 21 Dec 2003 00:53:47 +0900 (JST)
Received: 4UMRO00 id hBKFrkB17801; Sun, 21 Dec 2003 00:53:46 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Sun, 21 Dec 2003 00:53:42 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.4] New FrameBuffer for ITE IT8181
Message-Id: <20031221005342.4134af7f.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made the patch for ITE IT8181 driver.

  http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v2.4/it8181fb-v24.diff

This driver is used for ITE 8172G board and IBM WorkPad z50.

This patch exists for linux_2_4 tag of linux-mips.org CVS.
Please apply this patch.

Yoichi
