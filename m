Received:  by oss.sgi.com id <S553821AbQLSSCZ>;
	Tue, 19 Dec 2000 10:02:25 -0800
Received: from gatekeep.ti.com ([192.94.94.61]:30125 "EHLO gatekeep.ti.com")
	by oss.sgi.com with ESMTP id <S553816AbQLSSCQ>;
	Tue, 19 Dec 2000 10:02:16 -0800
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by gatekeep.ti.com (8.11.1/8.11.1) with ESMTP id eBJI2AH24746
	for <linux-mips@oss.sgi.com>; Tue, 19 Dec 2000 12:02:10 -0600 (CST)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA24408
	for <linux-mips@oss.sgi.com>; Tue, 19 Dec 2000 12:02:09 -0600 (CST)
Received: from dlep3.itg.ti.com (dlep3-maint.itg.ti.com [157.170.133.16])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA24394
	for <linux-mips@oss.sgi.com>; Tue, 19 Dec 2000 12:02:09 -0600 (CST)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.194])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA07870
	for <linux-mips@oss.sgi.com>; Tue, 19 Dec 2000 12:02:08 -0600 (CST)
Message-ID: <3A3FA2FD.B6B8CAD1@ti.com>
Date:   Tue, 19 Dec 2000 11:03:41 -0700
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     SGI news group <linux-mips@oss.sgi.com>
Subject: 1.0.3 = larger apps
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I am starting to cross-compile a bunch of the userland apps using the
1.0.3a-2 and binutils 2.8.1-1. I have noticed that each app has grown
about 10% (after stripping) over the original Hardhat distribution of
the app at the same rev. Since we are in a size constrained environment
I am trying to get the apps as small as possible. Is this growth normal?
Are there particular command line switches (or other tricks) during the
build which will produce smaller apps?
--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Brady Brown (bbrown@ti.com)       Work:(801)619-6103
Texas Instruments: Broadband Access Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
