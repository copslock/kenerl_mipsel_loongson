Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2006 16:59:45 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:38357 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038718AbWKNQ7n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Nov 2006 16:59:43 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kAEH07Z6005523;
	Tue, 14 Nov 2006 17:00:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kAEH0694005522;
	Tue, 14 Nov 2006 17:00:06 GMT
Date:	Tue, 14 Nov 2006 17:00:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] remove redundant r4k_blast_icache() calls
Message-ID: <20061114170006.GA27072@linux-mips.org>
References: <20060822.211547.92587044.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822.211547.92587044.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 22, 2006 at 09:15:47PM +0900, Atsushi Nemoto wrote:

> @@ -385,7 +382,6 @@ static inline void local_r4k_flush_cache
>  		return;
>  
>  	r4k_blast_dcache();
> -	r4k_blast_icache();
>  
>  	/*
>  	 * Kludge alert.  For obscure reasons R4000SC and R4400SC go nuts if we

R4000 / R4400 SC and MC indexed S-cache ops also affected the primary
caches so this code ends unnecessarily blowing away the D-cache twice.

  Ralf
