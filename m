Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 06:57:05 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:55717
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20023164AbYGKF5D (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2008 06:57:03 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6B5v1g2013791;
	Fri, 11 Jul 2008 06:57:02 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6B5v0jm013790;
	Fri, 11 Jul 2008 06:57:00 +0100
Date:	Fri, 11 Jul 2008 06:57:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] reorganize txx9 code
Message-ID: <20080711055700.GA9794@linux-mips.org>
References: <20080711.003136.106261691.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080711.003136.106261691.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 11, 2008 at 12:31:36AM +0900, Atsushi Nemoto wrote:

> Move arch/mips/{jmr3927,tx4927,tx4938} into arch/mips/txx9/ tree.
> This will help more code sharing and maintainance.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Applied, thanks.

  Ralf
