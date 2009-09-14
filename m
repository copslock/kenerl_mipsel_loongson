Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2009 16:55:37 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58259 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492834AbZINOza (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Sep 2009 16:55:30 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8EEuRGN003028;
	Mon, 14 Sep 2009 16:56:28 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8EEuJOs003023;
	Mon, 14 Sep 2009 16:56:19 +0200
Date:	Mon, 14 Sep 2009 16:56:18 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Julia Lawall <julia@diku.dk>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/8] arch/mips/txx9: introduce missing kfree, iounmap
Message-ID: <20090914145618.GB1934@linux-mips.org>
References: <Pine.LNX.4.64.0909111820370.10552@pc-004.diku.dk> <20090913.232548.253168283.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64.0909131708190.25903@ask.diku.dk> <20090914.003321.160496287.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64.0909132113520.31000@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0909132113520.31000@ask.diku.dk>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Sep 13, 2009 at 09:15:18PM +0200, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> Error handling code following a kzalloc should free the allocated data.
> Error handling code following an ioremap should iounmap the allocated data.
> 
> The semantic match that finds the first problem is as follows:
> (http://www.emn.fr/x-info/coccinelle/)

Guess this one looks right, applied.

Thanks,

  Ralf
