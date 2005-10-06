Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 17:41:15 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:64014 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133533AbVJFQlA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Oct 2005 17:41:00 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j96Getud002174;
	Thu, 6 Oct 2005 17:40:55 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j96Geq7f002173;
	Thu, 6 Oct 2005 17:40:52 +0100
Date:	Thu, 6 Oct 2005 17:40:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] protect CU1 bit manipulation from preempt
Message-ID: <20051006164052.GB15275@linux-mips.org>
References: <20051007.004359.25909892.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051007.004359.25909892.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 07, 2005 at 12:43:59AM +0900, Atsushi Nemoto wrote:

> The ptrace temporarily enable CP1 without fpu-ownership.  These
> regions should be protected from preempt.

Applied with quite some additions to take care of the MT ASE as well.

  Ralf
