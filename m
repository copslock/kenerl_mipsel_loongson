Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Sep 2008 15:25:17 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:24763
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20031401AbYIAOZP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Sep 2008 15:25:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m81EPEvU011965;
	Mon, 1 Sep 2008 15:25:14 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m81EPEcu011964;
	Mon, 1 Sep 2008 15:25:14 +0100
Date:	Mon, 1 Sep 2008 15:25:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/6] TXx9: stop_unused_modules
Message-ID: <20080901142514.GA11942@linux-mips.org>
References: <1220275361-5001-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1220275361-5001-1-git-send-email-anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 01, 2008 at 10:22:36PM +0900, Atsushi Nemoto wrote:

> TXx9 SoCs have pin multiplex.  Stop some controller modules which can
> not be used due to pin configurations.

Whole series queued for 2.6.28.

  Ralf
