Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2006 19:49:10 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:6316 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039061AbWLETtJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Dec 2006 19:49:09 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB5Jn8k4001185;
	Tue, 5 Dec 2006 19:49:08 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB5Jn7Cj001184;
	Tue, 5 Dec 2006 19:49:07 GMT
Date:	Tue, 5 Dec 2006 19:49:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
Message-ID: <20061205194907.GA1088@linux-mips.org>
References: <20061206.012311.86891097.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206.012311.86891097.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 06, 2006 at 01:23:11AM +0900, Atsushi Nemoto wrote:

> Import many updates from i386's i8259.c, especially genirq
> transitions.

With this patch applied Malta fails ...

  Ralf
