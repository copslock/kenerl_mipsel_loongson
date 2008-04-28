Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2008 16:27:11 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:37510 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S20175442AbYD1P1I (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Apr 2008 16:27:08 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3SFQ4FQ000835
	for <linux-mips@linux-mips.org>; Mon, 28 Apr 2008 08:26:10 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3SFQmMs006592;
	Mon, 28 Apr 2008 16:26:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3SFQlkc006579;
	Mon, 28 Apr 2008 16:26:47 +0100
Date:	Mon, 28 Apr 2008 16:26:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: kill useless #include's, #define's and
	extern's (take 4)
Message-ID: <20080428152646.GA25466@linux-mips.org>
References: <200804232243.55944.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200804232243.55944.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 23, 2008 at 10:43:55PM +0400, Sergei Shtylyov wrote:

> Please update the queued patch again, probably indeed for the last time. :-)

Applied.  To make things a little more confusing, the MIPS git tree
contains take 3 and take 4 is what will be going to Linus.  I'll sort
out the differences when I pull from him again.

  Ralf
