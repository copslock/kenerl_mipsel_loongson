Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 17:41:15 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:50455 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133637AbWBTRkt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 17:40:49 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1KHlj50028716;
	Mon, 20 Feb 2006 17:47:46 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1KHljGf028715;
	Mon, 20 Feb 2006 17:47:45 GMT
Date:	Mon, 20 Feb 2006 17:47:45 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix wrong __user usage in  _sysn32_rt_sigsuspend
Message-ID: <20060220174745.GB28701@linux-mips.org>
References: <20060221.012759.41630456.anemo@mba.ocn.ne.jp> <20060220172024.GA18561@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220172024.GA18561@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 20, 2006 at 05:20:24PM +0000, Ralf Baechle wrote:
> Date: Mon, 20 Feb 2006 17:20:24 +0000
> From: Ralf Baechle <ralf@linux-mips.org>
> To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Cc: linux-mips@linux-mips.org
> Subject: Re: [PATCH] fix wrong __user usage in  _sysn32_rt_sigsuspend
> Content-Type: text/plain; charset=us-ascii
> 
> Applied,

Same for this one, I actually queued it for 2.6.17.

  Ralf
