Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2004 15:22:09 +0000 (GMT)
Received: from p508B7DDE.dip.t-dialin.net ([IPv6:::ffff:80.139.125.222]:58693
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225349AbUCEPWI>; Fri, 5 Mar 2004 15:22:08 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i25FM7ex021571
	for <linux-mips@linux-mips.org>; Fri, 5 Mar 2004 16:22:07 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i25FM7sS021570
	for linux-mips@linux-mips.org; Fri, 5 Mar 2004 16:22:07 +0100
Date: Fri, 5 Mar 2004 16:22:07 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: gcc 3.2.0 bug causes kernel failure
Message-ID: <20040305152206.GA21264@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Me and Steven have tracked down a LTP failure in the capget tests to a
bug in gcc 3.2.0.  Reducing optimization to just -O seems to solve the
problem.  To this point we've found the capget LTP problem with 2.4
kernel built with 3.2.0; 2.6.3 built with 2.95.4 seems to be ok.  We've
also only tested 32-bit kernels.  We'de be interested in test results
from other configurations, in particular 2.4 kernels built by later 3.2.x
compiler revisions would be of interest.

  Ralf
