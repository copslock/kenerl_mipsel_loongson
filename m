Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 13:36:04 +0000 (GMT)
Received: from p3EE07C05.dip.t-dialin.net ([IPv6:::ffff:62.224.124.5]:24435
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225462AbVBCNfu>; Thu, 3 Feb 2005 13:35:50 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j13DZnCV009773;
	Thu, 3 Feb 2005 14:35:49 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j13DZi05009772;
	Thu, 3 Feb 2005 14:35:44 +0100
Date:	Thu, 3 Feb 2005 14:35:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manish Lachwani <mlachwani@mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] read_can_lock and write_can_lock for MIPS
Message-ID: <20050203133544.GA9688@linux-mips.org>
References: <20050201212603.GA24787@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201212603.GA24787@prometheus.mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 01, 2005 at 01:26:03PM -0800, Manish Lachwani wrote:

> Hi Ralf,
> 
> With SMP+PREEMPT, read_can_lock() and write_can_lock() need to be defined. Attached
> patch does this. Please review.

Thanks, applied.  In addition I copied the comments from the i386 code
into the spinlocks.h.

  Ralf
