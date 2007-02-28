Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 15:46:06 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:21695 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039340AbXB1PqE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Feb 2007 15:46:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1SFjvtS016555;
	Wed, 28 Feb 2007 15:45:58 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1SFjto6016554;
	Wed, 28 Feb 2007 15:45:55 GMT
Date:	Wed, 28 Feb 2007 15:45:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH] Convert to RTC-class ds1742 driver
Message-ID: <20070228154555.GA16444@linux-mips.org>
References: <20070301.004021.41012099.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070301.004021.41012099.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 01, 2007 at 12:40:21AM +0900, Atsushi Nemoto wrote:

> The generic rtc-ds1742 driver can be used for RBTX4927 and JMR3927
> (with __swizzle_addr trick).  This patch also removes MIPS local
> DS1742 stuff.

Thanks, applied.

  Ralf
