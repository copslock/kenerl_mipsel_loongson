Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2007 16:42:17 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:63405 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022445AbXCNQmQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Mar 2007 16:42:16 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2EGeMhJ014463;
	Wed, 14 Mar 2007 16:40:23 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2EGeMOW014462;
	Wed, 14 Mar 2007 16:40:22 GMT
Date:	Wed, 14 Mar 2007 16:40:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] jmr3927 cleanup
Message-ID: <20070314164021.GA14430@linux-mips.org>
References: <20070315.005828.37531652.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070315.005828.37531652.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 15, 2007 at 12:58:28AM +0900, Atsushi Nemoto wrote:

> * Kill dead codes
> * Rearrange irq chip handlers
> * Minimize defconfig
> 
> compile-tested.

Would be cool if somebody could actually test this on silicon ...

Anyway, queued up for 2.6.22.

  Ralf
