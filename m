Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2004 07:20:20 +0000 (GMT)
Received: from p508B6890.dip.t-dialin.net ([IPv6:::ffff:80.139.104.144]:28558
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224948AbUAIHUU>; Fri, 9 Jan 2004 07:20:20 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i097KIfY002142
	for <linux-mips@linux-mips.org>; Fri, 9 Jan 2004 08:20:19 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i097KIgp002141
	for linux-mips@linux-mips.org; Fri, 9 Jan 2004 08:20:18 +0100
Resent-Message-Id: <200401090720.i097KIgp002141@fluff.linux-mips.net>
Date: Fri, 9 Jan 2004 08:06:15 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][2.4] cache workaround for VR4131
Message-ID: <20040109070615.GA1576@linux-mips.org>
References: <20040109022554.49768c94.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109022554.49768c94.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4i
Resent-From: ralf@linux-mips.org
Resent-Date: Fri, 9 Jan 2004 08:20:18 +0100
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 09, 2004 at 02:25:54AM +0900, Yoichi Yuasa wrote:

> I made a patch for cache workaround of VR4131.
> This patch moves cache workaround to common part from board dependence part.
> 
> Please apply this patch.

Applied - but please keep arch/mips/mm/c-r4k.c and arch/mips64/mm/c-r4k.c
in sync; the same applies to many other files that are identical in both
mips and mips64.

  Ralf
