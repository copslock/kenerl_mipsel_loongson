Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2008 09:21:36 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:28625 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S526199AbYDDHVI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2008 09:21:08 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m347JQ6T015175
	for <linux-mips@linux-mips.org>; Fri, 4 Apr 2008 00:19:27 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m347K1f7023921;
	Fri, 4 Apr 2008 08:20:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m347K1un023920;
	Fri, 4 Apr 2008 08:20:01 +0100
Date:	Fri, 4 Apr 2008 08:20:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] [MIPS] unexport copy_to_user_page()
Message-ID: <20080404072001.GC12086@linux-mips.org>
References: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com> <1207094318-21748-3-git-send-email-dmitri.vorobiev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1207094318-21748-3-git-send-email-dmitri.vorobiev@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 02, 2008 at 03:58:35AM +0400, Dmitri Vorobiev wrote:

> The copy_to_user_page() function is called only in the core kernel
> code. Therefore, there is no need to export it. This patch removes
> EXPORT_SYMBOL(copy_to_user_page).
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>

Queued for 2.6.26.  Thanks,

  Ralf
