Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2007 13:56:48 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:38278 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023621AbXGMM4q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jul 2007 13:56:46 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6DCaUGU020037;
	Fri, 13 Jul 2007 13:36:31 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6D9fKeP009664;
	Fri, 13 Jul 2007 10:41:20 +0100
Date:	Fri, 13 Jul 2007 10:41:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com,
	rpjday@mindspring.com
Subject: Re: [PATCH] Kill CONFIG_TX4927BUG_WORKAROUND
Message-ID: <20070713094119.GA28355@linux-mips.org>
References: <20070713.020026.95064250.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070713.020026.95064250.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 13, 2007 at 02:00:26AM +0900, Atsushi Nemoto wrote:

> Kill workarounds for very early chip (perhaps pre-TX4927A).

Applied.

  Ralf
