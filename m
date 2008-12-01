Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2008 08:33:13 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:45281 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24020795AbYLAIdI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Dec 2008 08:33:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mB18X7hA002422
	for <linux-mips@linux-mips.org>; Mon, 1 Dec 2008 08:33:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mB18X73s002420
	for linux-mips@linux-mips.org; Mon, 1 Dec 2008 08:33:07 GMT
Date:	Mon, 1 Dec 2008 08:33:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Defconfigs and RTC
Message-ID: <20081201083307.GA2277@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Quite a few of the defconfigs have not been updated for quite some time
and are beginning to be a bit useless.  Also since we switched to RTC_LIB
quite a few systems no longer read their RTCs on bootup so their
defconfigs should be updated to enable RTC_CLASS and CONFIG_RTC_HCTOSYS.
A hand full of systems is still using read_persistent_clock() to read
the RTC on bootup.  The use of this function should preferably be replaced
by RTC_CLASS and CONFIG_RTC_HCTOSYS.

  Ralf
