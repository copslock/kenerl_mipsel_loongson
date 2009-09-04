Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Sep 2009 18:11:35 +0200 (CEST)
Received: from p549F7BBC.dip.t-dialin.net ([84.159.123.188]:47471 "EHLO
	h5.dl5rb.org.uk" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S1492859AbZIDQL2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Sep 2009 18:11:28 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n84GBmTe006881;
	Fri, 4 Sep 2009 17:11:52 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n84GBYTe006877;
	Fri, 4 Sep 2009 17:11:34 +0100
Date:	Fri, 4 Sep 2009 17:11:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, davem@davemloft.net
Subject: Re: [PATCH] txx9: Disable PM capability of TX493[89] internal ether
Message-ID: <20090904161134.GA6699@linux-mips.org>
References: <1252069744-4553-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1252069744-4553-1-git-send-email-anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 04, 2009 at 10:09:04PM +0900, Atsushi Nemoto wrote:

> Some tc35815 variants (i.e. TX493[89] internal ether) report existance
> of PM registers though they are not supported.  Disable PM features by
> clearing pdev->pm_cap.

Thanks, applied.

  Ralf
