Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2005 21:31:26 +0000 (GMT)
Received: from p508B6DDD.dip.t-dialin.net ([IPv6:::ffff:80.139.109.221]:11825
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225259AbVAQVbW>; Mon, 17 Jan 2005 21:31:22 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0HLVF0T003870;
	Mon, 17 Jan 2005 22:31:15 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j0HLV0Nd003850;
	Mon, 17 Jan 2005 22:31:00 +0100
Date: Mon, 17 Jan 2005 22:31:00 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6.11-rc1] add local_irq_enable() to cpu_idle()
Message-ID: <20050117213100.GA3026@linux-mips.org>
References: <20050118014958.1d9e484e.yuasa@hh.iij4u.or.jp> <41EBEEFA.6040701@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EBEEFA.6040701@mips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 17, 2005 at 05:59:38PM +0100, Kevin D. Kissell wrote:

> There have been times when having local_irq_enable() in my idle loop
> would have prevented a hang in some of my experimental kernels, too,
> but it's always been because I had screwed up somewhere else and
> forgotten to re-enable interrupts.  Is there some good reason why
> the kernel should end up in idle with interrupts turned off?

No, never.  It'd result in the scheduler being called with interrupts
disabled which depending if you're lucky or not may happen to reenable
interrupts or not, so you're outside of defined behaviour starting that
point.

  Ralf
