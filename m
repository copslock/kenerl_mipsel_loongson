Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jun 2004 21:09:29 +0100 (BST)
Received: from p508B79F9.dip.t-dialin.net ([IPv6:::ffff:80.139.121.249]:14944
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225363AbUFSUJZ>; Sat, 19 Jun 2004 21:09:25 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i5JK9OZN022442
	for <linux-mips@linux-mips.org>; Sat, 19 Jun 2004 22:09:24 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i5JK9NfH022441
	for linux-mips@linux-mips.org; Sat, 19 Jun 2004 22:09:23 +0200
Date: Sat, 19 Jun 2004 22:09:23 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Dummy keyboard driver
Message-ID: <20040619200923.GA22409@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Is there still a need for the dummy keyboard driver?  Right now DUMMY_KEYB
is being set for a bunch of platforms without having any effect so I take
to mean we can remove dummy_keyb.c.

  Ralf
