Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2004 16:00:29 +0100 (BST)
Received: from p508B7A8B.dip.t-dialin.net ([IPv6:::ffff:80.139.122.139]:36986
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225197AbUHTPAZ>; Fri, 20 Aug 2004 16:00:25 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7KF0Ieu007125;
	Fri, 20 Aug 2004 17:00:18 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7KF081t007124;
	Fri, 20 Aug 2004 17:00:08 +0200
Date: Fri, 20 Aug 2004 17:00:08 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] vr41xx: arch_init_irq
Message-ID: <20040820150008.GA7040@linux-mips.org>
References: <20040820231732.5cf3c099.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820231732.5cf3c099.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 20, 2004 at 11:17:32PM +0900, Yoichi Yuasa wrote:

> The following line isn't needed in arch_init_irq().
> Please apply this patch to v2.6 CVS tree.

Applied.  Thanks,

  Ralf
