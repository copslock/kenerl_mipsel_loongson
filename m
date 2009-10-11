Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Oct 2009 18:29:34 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53834 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492719AbZJKQ3b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Oct 2009 18:29:31 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9BGUiqL002875;
	Sun, 11 Oct 2009 18:30:44 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9BGUhgg002873;
	Sun, 11 Oct 2009 18:30:43 +0200
Date:	Sun, 11 Oct 2009 18:30:43 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH -queue] MIPS: Add IRQF_TIMER flag for timer interrupts
Message-ID: <20091011163043.GA2842@linux-mips.org>
References: <1255188395-6443-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255188395-6443-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 10, 2009 at 11:26:35PM +0800, Wu Zhangjin wrote:

> As the commit 3ee4c147 shows, we need to "Add IRQF_TIMER flag for timer
> interrupts", Atsushi Nemoto have reported that some other timer
> interrupts should be considered, Here it is.
> 
> (Hi, Ralf, if 3ee4c147 is not upstream yet, perhaps you can merge this
>  in)

Will do but only in the patch that goes to Linus, not for lmo.

Applied,

  Ralf
