Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2008 19:45:33 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:50818 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S529636AbYDDRpU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2008 19:45:20 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m34HidEV015907
	for <linux-mips@linux-mips.org>; Fri, 4 Apr 2008 10:44:40 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m34HjHsx004817;
	Fri, 4 Apr 2008 18:45:17 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m34HjHFw004816;
	Fri, 4 Apr 2008 18:45:17 +0100
Date:	Fri, 4 Apr 2008 18:45:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] rbhma4500: use generic txx9 gpio
Message-ID: <20080404174517.GC3546@linux-mips.org>
References: <20080405.005609.104641118.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080405.005609.104641118.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 05, 2008 at 12:56:09AM +0900, Atsushi Nemoto wrote:

> Use generic txx9 gpio (and gpiolib) for RBHMA4500 board.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks, queued for 2.6.26,

  Ralf
