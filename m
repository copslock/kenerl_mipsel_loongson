Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2008 16:48:33 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:3517 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S538533AbYDIOs3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 Apr 2008 16:48:29 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m39ElkIE028224
	for <linux-mips@linux-mips.org>; Wed, 9 Apr 2008 07:47:47 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m39EmNUK003628;
	Wed, 9 Apr 2008 15:48:23 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m39EmNZ8003627;
	Wed, 9 Apr 2008 15:48:23 +0100
Date:	Wed, 9 Apr 2008 15:48:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP27: Fix bootmem memory setup
Message-ID: <20080409144823.GA3607@linux-mips.org>
References: <20080408214346.ECFF7C2C03@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080408214346.ECFF7C2C03@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 08, 2008 at 11:43:46PM +0200, Thomas Bogendoerfer wrote:

> Changes in the generic bootmem code broke memory setup for IP27. This
> patch fixes this by replacing lots of special IP27 code with generic
> bootmon code. This has been tested only on a single node.

I have a dual-node for testing, will give it a spin later.

  Ralf
