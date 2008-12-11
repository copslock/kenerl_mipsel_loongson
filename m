Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2008 11:03:51 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:50867 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24065444AbYLKLDo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Dec 2008 11:03:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mBBB3hCk016527;
	Thu, 11 Dec 2008 11:03:43 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mBBB3hiZ016525;
	Thu, 11 Dec 2008 11:03:43 GMT
Date:	Thu, 11 Dec 2008 11:03:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH v2] [MIPS] Kconfig: fix the arch-specific header path
Message-ID: <20081211110343.GA16406@linux-mips.org>
References: <1228941516-22487-1-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1228941516-22487-1-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 10, 2008 at 10:38:36PM +0200, Dmitri Vorobiev wrote:

> The header path in the help text for the RUNTIME_DEBUG config
> option is obsolete and needs to be updated to match the new
> location of architecture-specific header files. While at it,
> fix the spelling mistake.
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>

Thanks, applied.

  Ralf
