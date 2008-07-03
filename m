Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2008 16:24:42 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:5543 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20132635AbYGCPYj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Jul 2008 16:24:39 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m63FNc7j024829;
	Thu, 3 Jul 2008 17:24:03 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m63FNc3A024828;
	Thu, 3 Jul 2008 16:23:38 +0100
Date:	Thu, 3 Jul 2008 16:23:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] [MIPS] Add an appropriate header into display.c
Message-ID: <20080703152338.GC11434@linux-mips.org>
References: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi> <1213773503-23536-6-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1213773503-23536-6-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 18, 2008 at 10:18:23AM +0300, Dmitri Vorobiev wrote:

> The following errors were caught by sparse:
> 
> >>>>>>>>>>>
> 
> arch/mips/mips-boards/generic/display.c:30:6: warning: symbol
> 'mips_display_message' was not declared. Should it be static?
> 
> arch/mips/mips-boards/generic/display.c:58:6: warning: symbol
> 'mips_scroll_message' was not declared. Should it be static?
> 
> >>>>>>>>>>>
> 
> This patch includes the asm/mips-boards/prom.h header file into
> arch/mips/mips-boards/generic/display.c. This adds the needed
> function declarations, and the errors are gone.
> 
> Compile-tested using defconfigs for Malta, Atlas and SEAD boards.
> Runtime test was successfully performed by booting a Malta 4Kc
> board up to the shell prompt.
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>

Queued for 2.6.27.  Thanks,

  Ralf
