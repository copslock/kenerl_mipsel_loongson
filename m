Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2008 22:22:37 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:59821 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S526214AbYDDUWd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2008 22:22:33 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m34KLqrN014239
	for <linux-mips@linux-mips.org>; Fri, 4 Apr 2008 13:21:52 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m34KMTLp013006;
	Fri, 4 Apr 2008 21:22:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m34KMSLv013005;
	Fri, 4 Apr 2008 21:22:28 +0100
Date:	Fri, 4 Apr 2008 21:22:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alchemy: move UART platform code to its proper place
	(take 2)
Message-ID: <20080404202228.GB5959@linux-mips.org>
References: <200804041733.45170.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200804041733.45170.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 04, 2008 at 05:33:45PM +0400, Sergei Shtylyov wrote:

> Move the code registering the Alchemy UART platform devices from drivers/serial
> to its proper place, into the Alchemy platform code.  Fix the related Kconfig
> entry, while at it...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

2.6.26 queue updated,

  Ralf
