Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 15:08:49 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44127 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493906AbZKBOIq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 15:08:46 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA2EAAOT026986;
	Mon, 2 Nov 2009 15:10:10 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA2EA6OE026984;
	Mon, 2 Nov 2009 15:10:06 +0100
Date:	Mon, 2 Nov 2009 15:10:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com
Subject: Re: [PATCH -queue 7/7] [loongson] fuloong2e: update config file
Message-ID: <20091102141006.GF21563@linux-mips.org>
References: <cover.1255673756.git.wuzhangjin@gmail.com> <3f07a3ecf42181a5642d734d070da4676cad51f3.1255673756.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f07a3ecf42181a5642d734d070da4676cad51f3.1255673756.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 16, 2009 at 02:17:20PM +0800, Wu Zhangjin wrote:

> This patch enable Hibernation support by default, and choose SPARSEMEM
> memory model to avoid Hibernation failure with FLATMEM and also save
> memory wasted by FLATMEM.

Thanks, queued for 2.6.33.

  Ralf
