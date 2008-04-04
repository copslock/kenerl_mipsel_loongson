Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2008 19:45:05 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:43138 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S529633AbYDDRpA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2008 19:45:00 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m34HiJ7b015863
	for <linux-mips@linux-mips.org>; Fri, 4 Apr 2008 10:44:20 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m34HiuWJ004793;
	Fri, 4 Apr 2008 18:44:56 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m34HisAF004792;
	Fri, 4 Apr 2008 18:44:54 +0100
Date:	Fri, 4 Apr 2008 18:44:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] make fallback gpio.h gpiolib-friendly
Message-ID: <20080404174454.GA3546@linux-mips.org>
References: <20080405.005524.108306693.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080405.005524.108306693.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 05, 2008 at 12:55:24AM +0900, Atsushi Nemoto wrote:

> If gpiolib was selected, asm-generic/gpio.h provides some prototypes
> for gpio API and implementation helpers.  With this patch, platform
> code can implement its GPIO API using gpiolib without custom gpio.h
> file.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks, queued for 2.6.26,

  Ralf
