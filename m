Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 11:43:38 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:60441 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465567AbVI3Kma (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 11:42:30 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8UAgLug005536;
	Fri, 30 Sep 2005 11:42:24 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8TNwVFG004635;
	Fri, 30 Sep 2005 00:58:31 +0100
Date:	Fri, 30 Sep 2005 00:58:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: add __iomem to ioremap
Message-ID: <20050929235831.GD3983@linux-mips.org>
References: <20050926.001753.74752084.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050926.001753.74752084.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 26, 2005 at 12:17:53AM +0900, Atsushi Nemoto wrote:

> Some function like iounmap, read[bwlq], etc. have been using __iomem
> attribute, but ioremap does not use it.  Here is a patch to add
> __iomem to ioremap family.  This would kill some sparse warnings.

Thanks, applied.

  Ralf
