Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2003 03:31:58 +0100 (BST)
Received: from p508B60B5.dip.t-dialin.net ([IPv6:::ffff:80.139.96.181]:5043
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225246AbTGQCb4>; Thu, 17 Jul 2003 03:31:56 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6H2UXDB006109;
	Thu, 17 Jul 2003 04:30:33 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6H2UVpP006108;
	Thu, 17 Jul 2003 04:30:31 +0200
Date: Thu, 17 Jul 2003 04:30:30 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Chris Fouts <ChrisF@SCC-INC.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Co-Proc. 0
Message-ID: <20030717023030.GA2378@linux-mips.org>
References: <4019CBE63D5A174F8F55FE25BC82D04102B46815@Mailserver.scc-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4019CBE63D5A174F8F55FE25BC82D04102B46815@Mailserver.scc-inc.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 16, 2003 at 09:11:22AM -0400, Chris Fouts wrote:

> What options do I use for the compiler to recoginze the C0 specific
> op-codes,
> e.g., mfc0, mtc0, etc? I tried -mips1, -mips2, -mips3 and arch=RM7000 to no
> avail.

No options needed at all.

  Ralf
