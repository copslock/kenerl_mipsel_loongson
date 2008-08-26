Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 22:29:11 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:16036
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20033309AbYHZV3J (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2008 22:29:09 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7QLT7lk014393;
	Tue, 26 Aug 2008 22:29:07 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7QLT7i3014391;
	Tue, 26 Aug 2008 22:29:07 +0100
Date:	Tue, 26 Aug 2008 22:29:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Probe initrd header only if explicitly specified
Message-ID: <20080826212907.GB13647@linux-mips.org>
References: <20080826.223457.41872931.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080826.223457.41872931.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 26, 2008 at 10:34:57PM +0900, Atsushi Nemoto wrote:

> Currently init_initrd() probes initrd header at the last page of
> kernel image, but it is valid only if addinitrd was used.  If
> addinitrd was not used, the area contains garbage so probing there
> might misdetect initrd header (magic number is not strictly robust).
> 
> This patch introduces CONFIG_PROBE_INITRD_HEADER to enable this
> probing explicitly.

Applied though I think the solution isn't quite the most elegant ...

  Ralf
