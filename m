Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 May 2006 19:48:56 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:18919 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133479AbWEPRst (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 May 2006 19:48:49 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4GHmmat030739;
	Tue, 16 May 2006 18:48:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4GHmmO6030738;
	Tue, 16 May 2006 18:48:48 +0100
Date:	Tue, 16 May 2006 18:48:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix interrupt handling for R2 CPUs
Message-ID: <20060516174848.GA30064@linux-mips.org>
References: <20060515172747.GF9026@networkno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515172747.GF9026@networkno.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 15, 2006 at 06:27:47PM +0100, Thiemo Seufer wrote:

> a) only the low bit is used for status flags if CONFIG_CPU_MIPSR2,
>    consistent with the use of di/ei.
> 
> b) the ERL/EXL bits get cleared as well.

Does this patch make a difference for you anywhere?

  Ralf
