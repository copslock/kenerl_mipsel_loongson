Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Aug 2003 02:49:09 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:56313 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225213AbTHBBtH>;
	Sat, 2 Aug 2003 02:49:07 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id SAA12240
	for <linux-mips@linux-mips.org>; Fri, 1 Aug 2003 18:49:05 -0700
Subject: udelay
From: Pete Popov <ppopov@mvista.com>
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1059788948.9224.62.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 Aug 2003 18:49:08 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Looks like the latest udelay in 2.4 is borked. Anyway else notice that
problem?  I did a 10 sec test: mdelay works, udelay is broken, at least
for the CPU and toolchain I'm using.

Pete
