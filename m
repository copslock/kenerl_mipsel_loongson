Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2004 13:44:14 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:44512 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224916AbUALNoL>;
	Mon, 12 Jan 2004 13:44:11 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id WAA10108;
	Mon, 12 Jan 2004 22:44:05 +0900 (JST)
Received: 4UMDO00 id i0CDi4A03337; Mon, 12 Jan 2004 22:44:04 +0900 (JST)
Received: 4UMRO01 id i0CDi3F28152; Mon, 12 Jan 2004 22:44:04 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Mon, 12 Jan 2004 22:44:02 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.4] Update FrameBuffer for ITE IT8181
Message-Id: <20040112224402.6210545c.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I updated the patch for ITE IT8181 driver.

  http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v2.4/it8181fb-v24.diff

This driver is used for ITE 8172G board and IBM WorkPad z50.

This patch exists for linux_2_4 tag of linux-mips.org CVS.
Please apply this patch.

Yoichi
