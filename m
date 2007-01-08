Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jan 2007 15:10:09 +0000 (GMT)
Received: from wf1.mips-uk.com ([194.74.144.154]:17891 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573921AbXAHPKI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jan 2007 15:10:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l08FAveA028699;
	Mon, 8 Jan 2007 15:10:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l08FAunB028698;
	Mon, 8 Jan 2007 15:10:56 GMT
Date:	Mon, 8 Jan 2007 15:10:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove unused rm9k_cpu_irq_disable()
Message-ID: <20070108151056.GA28691@linux-mips.org>
References: <20070108.002024.75184927.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108.002024.75184927.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 08, 2007 at 12:20:24AM +0900, Atsushi Nemoto wrote:

> rm9k_cpu_irq_disable() is unused since commit
> 1603b5aca4f15b34848fb5594d0c7b6333b99144.  Remove it.

Queued for 2.6.21,

  Ralf
