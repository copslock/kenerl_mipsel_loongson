Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 16:43:35 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:20415 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S1101666AbYDAOn3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2008 16:43:29 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m31Eflj8024742
	for <linux-mips@linux-mips.org>; Tue, 1 Apr 2008 07:41:48 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m31EgLJk013831;
	Tue, 1 Apr 2008 15:42:21 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m31EgKJX013830;
	Tue, 1 Apr 2008 15:42:20 +0100
Date:	Tue, 1 Apr 2008 15:42:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	linux-mips@linux-mips.org, Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH] Fix xss1500 compilation
Message-ID: <20080401144220.GC12879@linux-mips.org>
References: <200804011553.25850.florian.fainelli@telecomint.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200804011553.25850.florian.fainelli@telecomint.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 01, 2008 at 03:53:25PM +0200, Florian Fainelli wrote:

> This patch fixes the compilation of the Au1000 XSS1500
> board setup and irqmap code.

I'm okay with the patch this case raises the question how popular if at
all this platform still is ...

  Ralf
