Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 21:24:31 +0100 (BST)
Received: from p508B6E02.dip.t-dialin.net ([IPv6:::ffff:80.139.110.2]:46374
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226083AbUEZUWb>; Wed, 26 May 2004 21:22:31 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i4QKMUmL008506
	for <linux-mips@linux-mips.org>; Wed, 26 May 2004 22:22:30 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i4QKMUws008505
	for linux-mips@linux-mips.org; Wed, 26 May 2004 22:22:30 +0200
Resent-Message-Id: <200405262022.i4QKMUws008505@fluff.linux-mips.net>
Date: Wed, 26 May 2004 18:36:59 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][1/14] vr41xx: change to early_initcall
Message-ID: <20040526163659.GB30047@linux-mips.org>
References: <20040527005022.53033dd4.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527005022.53033dd4.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Resent-From: ralf@linux-mips.org
Resent-Date: Wed, 26 May 2004 22:22:30 +0200
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5197
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 27, 2004 at 12:50:22AM +0900, Yoichi Yuasa wrote:

> The some functions change to early_initcall from the call from prom_init().
> 
> Please apply to v2.6 CVS tree.

Applied,

   Ralf
