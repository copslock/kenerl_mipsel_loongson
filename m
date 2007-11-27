Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2007 16:16:43 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:23213 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029701AbXK0QQl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Nov 2007 16:16:41 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lARGGbVj026660;
	Tue, 27 Nov 2007 16:16:37 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lARGGaOi026659;
	Tue, 27 Nov 2007 16:16:36 GMT
Date:	Tue, 27 Nov 2007 16:16:36 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] qemu: do not enable IP7 blindly
Message-ID: <20071127161636.GA23642@linux-mips.org>
References: <20071123.004406.108119126.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071123.004406.108119126.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 23, 2007 at 12:44:06AM +0900, Atsushi Nemoto wrote:

> IP7 will be enabled automatically in mips_clockevent_init(), if it was
> available.

Applied.

   Ralf
