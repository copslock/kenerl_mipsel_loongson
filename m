Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2003 03:31:27 +0100 (BST)
Received: from p508B62D9.dip.t-dialin.net ([IPv6:::ffff:80.139.98.217]:22728
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224861AbTGKCbZ>; Fri, 11 Jul 2003 03:31:25 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6B2V7DB010905;
	Fri, 11 Jul 2003 04:31:08 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6B2V1Rt010904;
	Fri, 11 Jul 2003 04:31:01 +0200
Date: Fri, 11 Jul 2003 04:31:01 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: renwei <renwei@huawei.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch]: gdb/insight 5.3 buggy   in kernel module debug
Message-ID: <20030711023101.GA10643@linux-mips.org>
References: <003501c34526$f5adfcc0$6efc0b0a@huawei.com> <20030709123657.GA30305@linux-mips.org> <000701c34752$3263d680$6efc0b0a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000701c34752$3263d680$6efc0b0a@huawei.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 11, 2003 at 10:14:44AM +0800, renwei wrote:

> Here's my patch to this problem, change the read pc on mips32 cpu.

Don't send GDB patches to me, I'm not maintaining GDB; drow@mvista.com is
probably a better address.

Also a standard rant - never ever send ed-style patches; any maintainer
will probably just drop them.

  Ralf
