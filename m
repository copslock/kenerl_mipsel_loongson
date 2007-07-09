Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2007 11:35:44 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34981 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022065AbXGIKfl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jul 2007 11:35:41 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l69ARtOl024582;
	Mon, 9 Jul 2007 11:27:56 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l69ARtvI024581;
	Mon, 9 Jul 2007 11:27:55 +0100
Date:	Mon, 9 Jul 2007 11:27:55 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@stusta.de>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] include/asm-mips/processor.h: "extern inline" ->
	"static inline"
Message-ID: <20070709102754.GB24487@linux-mips.org>
References: <20070707010330.GY3492@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070707010330.GY3492@stusta.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 07, 2007 at 03:03:30AM +0200, Adrian Bunk wrote:

> "extern inline" will have different semantics with gcc 4.3,
> and "static inline" is correct here.

The idea was to have a linker error in case gcc should deciede for some
reason not to inline this function which as I understand will continue
to be the behaviour of gcc 4.3?

  Ralf
