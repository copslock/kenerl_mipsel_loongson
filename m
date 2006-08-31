Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Aug 2006 22:23:58 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:5061 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037647AbWHaVX4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 Aug 2006 22:23:56 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k7VLOPLb004274;
	Thu, 31 Aug 2006 22:24:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7VLON1c004273;
	Thu, 31 Aug 2006 22:24:23 +0100
Date:	Thu, 31 Aug 2006 22:24:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	imipak@yahoo.com, ths@networkno.de, treestem@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] 64K page size
Message-ID: <20060831212423.GA4233@linux-mips.org>
References: <20060823160011.GE20395@networkno.de> <20060823162324.43027.qmail@web31507.mail.mud.yahoo.com> <20060829140700.GD29289@linux-mips.org> <20060831124809.7118ab45.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060831124809.7118ab45.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 31, 2006 at 12:48:09PM +0900, Yoichi Yuasa wrote:

> > We're getting very close to a 2.6.18 release and 64kB pages are still
> > quite experimental, so I'm putting all the 64kB pagesize related fixes
> > into the queue branch.  16kB by now has a few users, so I give it
> > higher priority.
> 
> Which is your queue branch?
> I want to test 64k page size on vr41xx.

It's just named "queue" in the usual git repository on linux-mips.org.

  Ralf
