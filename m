Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 03:02:50 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:37320 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225362AbTLIDCr>;
	Tue, 9 Dec 2003 03:02:47 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id MAA08775
	for <linux-mips@linux-mips.org>; Tue, 9 Dec 2003 12:02:43 +0900 (JST)
Received: 4UMDO00 id hB932hs06738; Tue, 9 Dec 2003 12:02:43 +0900 (JST)
Received: 4UMRO00 id hB932gP09267; Tue, 9 Dec 2003 12:02:42 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131])
	for <linux-mips@linux-mips.org>; (authenticated)
Date: Tue, 9 Dec 2003 12:02:43 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: linux-mips@linux-mips.org
Subject: Undeclared atomic_lock in 2.6
Message-Id: <20031209120243.70d51420.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

The "atomic_lock" is undeclared in 2.6.

include/asm/atomic.h:156: error: `atomic_lock' undeclared (first use in this function)
include/asm/atomic.h:156: error: (Each undeclared identifier is reported only once
include/asm/atomic.h:156: error: for each function it appears in.)

Where should it be declared?

Yoichi
