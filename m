Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2004 23:52:15 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:62159 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225319AbUBQXwO>;
	Tue, 17 Feb 2004 23:52:14 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id IAA29170;
	Wed, 18 Feb 2004 08:52:09 +0900 (JST)
Received: 4UMDO00 id i1HNq8410747; Wed, 18 Feb 2004 08:52:08 +0900 (JST)
Received: 4UMRO00 id i1HNq8511624; Wed, 18 Feb 2004 08:52:08 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Wed, 18 Feb 2004 08:51:59 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: linux-mips <linux-mips@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH][2.4] Changed common setups for vr41xx
Message-Id: <20040218085159.6a133fdc.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

I made a patch for vr41xx.
This patch is getting together common setups to one place for vr41xx.
It is not good that the same code is in many somewhere else.

http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v24/vr41xx_platform-v24.diff

Thanks,

Yoichi
