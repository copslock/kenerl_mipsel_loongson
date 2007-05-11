Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 12:41:45 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:35200 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022566AbXEKLlo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 May 2007 12:41:44 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4BBfdZX004391;
	Fri, 11 May 2007 12:41:39 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4BBfctM004390;
	Fri, 11 May 2007 12:41:38 +0100
Date:	Fri, 11 May 2007 12:41:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] time: replace board_time_init() by plat_clk_setup()
Message-ID: <20070511114138.GH2732@linux-mips.org>
References: <1178293006633-git-send-email-fbuihuu@gmail.com> <11782930063123-git-send-email-fbuihuu@gmail.com> <20070506.010313.41199101.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070506.010313.41199101.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 06, 2007 at 01:03:13AM +0900, Atsushi Nemoto wrote:

> How about keeping board_time_init pointer as is and adding
> plat_clk_setup only for simple platforms?

The idea of having such function pointer is quite nice.  In theory.  In
practice it seems alot of people who are bringing up Linux on a new
platform miss those hooks.  A new mandatory platform hook that if missing
is resulting in a linker error is preferable, I think.

  Ralf
