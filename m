Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 18:56:07 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:31658 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20041986AbYFKRol (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jun 2008 18:44:41 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5BHiLMP002131;
	Wed, 11 Jun 2008 18:44:21 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5BHiFIh002094;
	Wed, 11 Jun 2008 18:44:15 +0100
Date:	Wed, 11 Jun 2008 18:44:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] [MIPS] The tickcount per-cpu variable can become
	static
Message-ID: <20080611174415.GE30400@linux-mips.org>
References: <12120730323761-git-send-email-dmitri.vorobiev@movial.fi> <12120730321843-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12120730321843-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 29, 2008 at 05:57:12PM +0300, Dmitri Vorobiev wrote:

> In arch/mips/mips-boards/generic/time.c, the `tickcount' per-cpu
> variable is needlessly defined global, and this patch makes it
> static.
> 
> Noticed by sparse. Tested by booting a Qemu-emulated Malta board
> up to the shell prompt.

Patch is ok - except it tries to fix a piece of code which I've already
removed so I'll drop this one.

  Ralf
