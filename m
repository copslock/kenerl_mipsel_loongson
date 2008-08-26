Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 14:09:45 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:649
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20030526AbYHZNJn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2008 14:09:43 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7QD9g4t002494;
	Tue, 26 Aug 2008 14:09:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7QD9fnH002492;
	Tue, 26 Aug 2008 14:09:41 +0100
Date:	Tue, 26 Aug 2008 14:09:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] TXx9: Fix txx9_pcode initialization
Message-ID: <20080826130941.GC1276@linux-mips.org>
References: <20080826.212958.128619116.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080826.212958.128619116.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 26, 2008 at 09:29:58PM +0900, Atsushi Nemoto wrote:

> The txx9_pcode variable was introduced in commit
> fe1c2bc64f65003b39f331a8e4b0d15b235a4afd ("TXx9: Add 64-bit support")
> but was not initialized properly.

Applied.  Thanks Atsushi-San!

  Ralf
