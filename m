Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2004 15:22:55 +0100 (BST)
Received: from p508B7B0E.dip.t-dialin.net ([IPv6:::ffff:80.139.123.14]:37683
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226320AbUFCOWF>; Thu, 3 Jun 2004 15:22:05 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i53ELxiZ021202;
	Thu, 3 Jun 2004 16:22:00 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i53ELwO6021201;
	Thu, 3 Jun 2004 16:21:58 +0200
Date: Thu, 3 Jun 2004 16:21:58 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] fix atomic_sub_if_positive() and atomic64_sub_if_positive()
Message-ID: <20040603142158.GA21089@linux-mips.org>
References: <20040603231331.46ac0070.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603231331.46ac0070.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5245
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 03, 2004 at 11:13:31PM +0900, Yoichi Yuasa wrote:

> I found the mistake about return value of atomic_sub_if_positive() 
> and atomic64_sub_if_positive().

Applied,

  Ralf
