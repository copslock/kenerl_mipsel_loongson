Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 19:06:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:61909 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133574AbWEORGO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 May 2006 19:06:14 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4FH6Dpj032164;
	Mon, 15 May 2006 18:06:13 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4FH6BPx032163;
	Mon, 15 May 2006 18:06:11 +0100
Date:	Mon, 15 May 2006 18:06:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] unify mips_fpu_soft_struct and mips_fpu_hard_struct
Message-ID: <20060515170611.GA30806@linux-mips.org>
References: <20060516.012603.41010976.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516.012603.41010976.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 16, 2006 at 01:26:03AM +0900, Atsushi Nemoto wrote:

> The struct mips_fpu_soft_struct and mips_fpu_hard_struct are
> completely same now and the kernel fpu emulator assumes that.  This
> patch unifies them to mips_fpu_struct and get rid of mips_fpu_union.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Indeed, one of the things I always meant to do.  The split into an
emulator and a hardware structure goes back to day one of the kernel when
I copied that from i386.

Queued,

  Ralf
