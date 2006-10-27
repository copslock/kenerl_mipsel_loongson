Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Oct 2006 23:43:44 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:47595 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037868AbWJ0Wnm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Oct 2006 23:43:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.7) with ESMTP id k9RFvxl9012441;
	Fri, 27 Oct 2006 17:00:39 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id k9RFvwRv012440;
	Fri, 27 Oct 2006 16:57:58 +0100
Date:	Fri, 27 Oct 2006 16:57:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, m_lachwani@yahoo.com,
	creideiki+linux-mips@ferretporn.se
Subject: Re: [PATCH] fix clocksource parameter for low frequency timer.
Message-ID: <20061027155757.GA10343@linux-mips.org>
References: <20061026.230937.41197595.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026.230937.41197595.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 26, 2006 at 11:09:37PM +0900, Atsushi Nemoto wrote:

> The current shift value in clocksource was not suitable for low
> frequency timer.  Find the shift value in runtime to avoid undesirable
> overflow.  Also calculate a somewhat reasonable rating value based on
> its frequency.

Looks fine to me and even Thomas Gleixner loves the idea of having code
to find the factor automatically, so it may become generic code after
2.6.19.

  Ralf
