Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jan 2007 15:05:31 +0000 (GMT)
Received: from wf1.mips-uk.com ([194.74.144.154]:57545 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573844AbXAHPFa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jan 2007 15:05:30 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l08E4xSv014924;
	Mon, 8 Jan 2007 14:07:39 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l08E4xgp014923;
	Mon, 8 Jan 2007 14:04:59 GMT
Date:	Mon, 8 Jan 2007 14:04:59 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] SMTC build fix
Message-ID: <20070108140459.GB10909@linux-mips.org>
References: <20070108.005034.104640508.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108.005034.104640508.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 08, 2007 at 12:50:34AM +0900, Atsushi Nemoto wrote:

> Pass "irq" to __DO_IRQ_SMTC_HOOK() macro.

Applied,

  Ralf
