Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Apr 2003 10:17:54 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:19682 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225072AbTDRJRx>;
	Fri, 18 Apr 2003 10:17:53 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id SAA16670;
	Fri, 18 Apr 2003 18:17:48 +0900 (JST)
Received: 4UMDO00 id h3I9Hmp11547; Fri, 18 Apr 2003 18:17:48 +0900 (JST)
Received: 4UMRO00 id h3I9Hl210520; Fri, 18 Apr 2003 18:17:48 +0900 (JST)
	from pudding.montavista.co.jp (localhost [127.0.0.1]) (authenticated)
Date: Fri, 18 Apr 2003 18:17:48 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: simulate_ll and simulate_sc move to do_cpu from do_ri
Message-Id: <20030418181748.57f7789a.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Why did you move simulate_ll and simulate_sc to do_cpu from do_ri?
NEC VR4100 series need simulate_ll and simulate_sc in do_ri.

Yoichi
