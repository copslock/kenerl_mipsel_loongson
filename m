Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 00:42:53 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:25737 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S1100373AbYCaWmt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2008 00:42:49 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2VMf8db015954
	for <linux-mips@linux-mips.org>; Mon, 31 Mar 2008 15:41:09 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2VMfhoB028487;
	Mon, 31 Mar 2008 23:41:43 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2VMfhW2028486;
	Mon, 31 Mar 2008 23:41:43 +0100
Date:	Mon, 31 Mar 2008 23:41:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] [MIPS] make some functions and variables static
Message-ID: <20080331224143.GA28473@linux-mips.org>
References: <1207001005-2633-1-git-send-email-dmitri.vorobiev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1207001005-2633-1-git-send-email-dmitri.vorobiev@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 01, 2008 at 02:03:19AM +0400, Dmitri Vorobiev wrote:

> I noticed that a few functions and variables in the MIPS-specific
> code can become static, and this series of patches cleans up the
> kernel global name space a little bit.

I've queued the whole series for 2.6.26.

Thanks,

  Ralf
