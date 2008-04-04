Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2008 09:24:36 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:37841 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S526236AbYDDHWA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2008 09:22:00 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m347KF6f015363
	for <linux-mips@linux-mips.org>; Fri, 4 Apr 2008 00:20:16 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m347KmvY023956;
	Fri, 4 Apr 2008 08:20:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m347Km4c023955;
	Fri, 4 Apr 2008 08:20:48 +0100
Date:	Fri, 4 Apr 2008 08:20:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] [MIPS] unexport null_perf_irq() and make it static
Message-ID: <20080404072048.GF12086@linux-mips.org>
References: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com> <1207094318-21748-6-git-send-email-dmitri.vorobiev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1207094318-21748-6-git-send-email-dmitri.vorobiev@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 02, 2008 at 03:58:38AM +0400, Dmitri Vorobiev wrote:

> This patch unexports the null_perf_irq() symbol, and simultaneously
> makes this function static.
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>

Queued for 2.6.26 with your static fix folded in.  Thanks,

  Ralf
