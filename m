Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2004 21:44:00 +0000 (GMT)
Received: from pD95621F5.dip.t-dialin.net ([IPv6:::ffff:217.86.33.245]:35909
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225339AbUKIVn4>; Tue, 9 Nov 2004 21:43:56 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id iA9Lhlap028324;
	Tue, 9 Nov 2004 22:43:47 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id iA9Lhhlw028323;
	Tue, 9 Nov 2004 22:43:43 +0100
Date: Tue, 9 Nov 2004 22:43:43 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] add iomap funtions
Message-ID: <20041109214343.GA28260@linux-mips.org>
References: <20041105011317.012b10ad.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105011317.012b10ad.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 05, 2004 at 01:13:17AM +0900, Yoichi Yuasa wrote:

> This patch adds iomap functions to MIPS system.
> Please apply this patch to v2.6.

Any reason you're not simply setting CONFIG_GENERIC_IOMAP?

  Ralf
