Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2005 12:36:51 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:64784 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225928AbVCDMgg>; Fri, 4 Mar 2005 12:36:36 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j24CaBMc008106;
	Fri, 4 Mar 2005 12:36:11 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j24CaAuK008105;
	Fri, 4 Mar 2005 12:36:10 GMT
Date:	Fri, 4 Mar 2005 12:36:09 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.11 preemption fix
Message-ID: <20050304123609.GC7073@linux-mips.org>
References: <20050304.194341.01917677.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304.194341.01917677.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 04, 2005 at 07:43:41PM +0900, Atsushi Nemoto wrote:

> It seems 2.6.11 preemption kernel is broken.
> 
> The preempt_schedule_irq() expects preempt_count is 0.  Also trailing
> branch instructino have been lost.  How about this fix?

Looking good. Applied,

  Ralf
