Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2005 15:06:30 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:53268 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133482AbVJMOEW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Oct 2005 15:04:22 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9DE4G8L009770;
	Thu, 13 Oct 2005 15:04:17 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9DE4FWj009769;
	Thu, 13 Oct 2005 15:04:15 +0100
Date:	Thu, 13 Oct 2005 15:04:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix possible sleeping in atomic on setup/restore sigcontext
Message-ID: <20051013140415.GC2654@linux-mips.org>
References: <20051007.235152.75184664.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051007.235152.75184664.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 07, 2005 at 11:51:52PM +0900, Atsushi Nemoto wrote:

> The setup_sigcontect/restore_sigcontext might sleep on
> put_user/get_user with preemption disabled (i.e. atomic context).
> Sleeping in atomic context is not allowed.  This patch fixes this
> problem using temporary variable (struct sigcontext tmpsc).
> 
> Another possible fix might be rewriting
> restore_fp_context/save_fp_context to copy to/from current
> thread_struct and use them with restore_fp/save_fp.

I think much of the 87d54649f67d8ffe0a8d8176de8c210a6c4bb4a7 preemption
patch is flawed and the problem you were trying to fix are in part just
caused by it.

Rule of thumb - if there's a preempt_disable anywhere, it's probably
wrong ...

   Ralf
