Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 17:01:54 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:47571 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038322AbXB1RBw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Feb 2007 17:01:52 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1SH1jqq018386;
	Wed, 28 Feb 2007 17:01:45 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1SH1itd018385;
	Wed, 28 Feb 2007 17:01:44 GMT
Date:	Wed, 28 Feb 2007 17:01:44 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] No need to write c0_compare in plat_timer_setup
Message-ID: <20070228170144.GA17038@linux-mips.org>
References: <20070301.015313.01916691.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070301.015313.01916691.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 01, 2007 at 01:53:13AM +0900, Atsushi Nemoto wrote:

> If R4k counter was used for hpt_timer and interrupt source,
> c0_hpt_timer_init() initializes the c0_compare register.

Applied.  Thanks,

  Ralf
