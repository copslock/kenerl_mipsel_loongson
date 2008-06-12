Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 08:41:12 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:26020 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S28577949AbYFLHlK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 08:41:10 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5C7epWm018277;
	Thu, 12 Jun 2008 08:40:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5C7epP4018270;
	Thu, 12 Jun 2008 08:40:51 +0100
Date:	Thu, 12 Jun 2008 08:40:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] [MIPS] unexport {allocate,free}_irqno
Message-ID: <20080612074051.GI30400@linux-mips.org>
References: <12124843631664-git-send-email-dmitri.vorobiev@movial.fi> <1212484363969-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1212484363969-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 03, 2008 at 12:12:43PM +0300, Dmitri Vorobiev wrote:

> The following routines
> 
> allocate_irqno()
> free_irqno()
> 
> seem not to be used outside of the core kernel code, hence
> exporting these functions is pointless. This patch removes
> the export.

And I don't see why one would want to use them in modules, so queue for
2.6.27 as well.  Thanks,

   Ralf
