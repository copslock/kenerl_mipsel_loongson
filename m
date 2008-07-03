Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2008 16:24:17 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:3751 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20132595AbYGCPYN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Jul 2008 16:24:13 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m63FNC2u024667;
	Thu, 3 Jul 2008 17:23:37 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m63FN6gY024635;
	Thu, 3 Jul 2008 16:23:06 +0100
Date:	Thu, 3 Jul 2008 16:23:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] [MIPS] Make gcmp_probe() static
Message-ID: <20080703152306.GB24232@linux-mips.org>
References: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi> <1213773503-23536-5-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1213773503-23536-5-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 18, 2008 at 10:18:22AM +0300, Dmitri Vorobiev wrote:

> The gcmp_probe() function is needlessly defined global, and
> this patch makes it static.
> 
> Tested by booting a Malta 4Kc board up to the shell prompt.
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>

Queued for 2.6.27.  Thanks,

  Ralf
