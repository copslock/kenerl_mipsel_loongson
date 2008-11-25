Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 16:00:36 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:4580 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S23908129AbYKYQA3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2008 16:00:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mAPG0QuT021379;
	Tue, 25 Nov 2008 16:00:26 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mAPG0PiL021378;
	Tue, 25 Nov 2008 16:00:25 GMT
Date:	Tue, 25 Nov 2008 16:00:25 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Julia Lawall <julia@diku.dk>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/5] arch/mips/alchemy: change strict_strtol to
	strict_strtoul
Message-ID: <20081125160025.GA18083@linux-mips.org>
References: <Pine.LNX.4.64.0811251412010.11897@pc-004.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0811251412010.11897@pc-004.diku.dk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 25, 2008 at 02:12:32PM +0100, Julia Lawall wrote:

> Since memsize is unsigned, it would seem better to use strict_strtoul that
> strict_strtol.

Thanks, applied.

  Ralf
