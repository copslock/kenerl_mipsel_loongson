Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2008 16:22:38 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:62886 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20132325AbYGCPWc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Jul 2008 16:22:32 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m63FLVlt024063;
	Thu, 3 Jul 2008 17:21:56 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m63FLU09024056;
	Thu, 3 Jul 2008 16:21:30 +0100
Date:	Thu, 3 Jul 2008 16:21:30 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/5] [MIPS] 8253: make the pit_clockevent variable
	static
Message-ID: <20080703152130.GA11434@linux-mips.org>
References: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi> <1213773503-23536-2-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1213773503-23536-2-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 18, 2008 at 10:18:19AM +0300, Dmitri Vorobiev wrote:
> From: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
> Date: Wed, 18 Jun 2008 10:18:19 +0300
> To: ralf@linux-mips.org, linux-mips@linux-mips.org
> Subject: [PATCH 1/5] [MIPS] 8253: make the pit_clockevent variable static
> 
> The pit_clockevent symbol is needlessly defined global. This patch makes
> that variable static.
> 
> Spotted by sparse. Compile-tested using Malta defconfig.
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>

Queued for 2.6.27.  Thanks,

  Ralf
