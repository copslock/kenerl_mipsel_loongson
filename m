Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 13:37:25 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:12165 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025281AbXJaNhX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Oct 2007 13:37:23 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9VDb7MI015414;
	Wed, 31 Oct 2007 13:37:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9VDb7T1015413;
	Wed, 31 Oct 2007 13:37:07 GMT
Date:	Wed, 31 Oct 2007 13:37:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] More time cleanup
Message-ID: <20071031133707.GB15332@linux-mips.org>
References: <20071031.012103.128619208.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071031.012103.128619208.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 31, 2007 at 01:21:03AM +0900, Atsushi Nemoto wrote:

> * Do not include unnecessary headers.
> * Do not mention time.README.
> * Do not mention mips_timer_ack.
> * Make clocksource_mips static.  It is now dedicated to c0_timer.
> * Initialize clocksource_mips.read statically.
> * Remove null_hpt_read.
> * Remove an argument of plat_timer_setup.  It is just a placeholder.

Thanks, applied.

  Ralf
