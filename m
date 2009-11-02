Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 15:13:48 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54254 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493911AbZKBONm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 15:13:42 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA2EF1L9027114;
	Mon, 2 Nov 2009 15:15:01 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA2EExnq027112;
	Mon, 2 Nov 2009 15:14:59 +0100
Date:	Mon, 2 Nov 2009 15:14:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com
Subject: Re: [PATCH -queue 2/7] [loongson] mem.c: Register reserved memory
	pages
Message-ID: <20091102141459.GG21563@linux-mips.org>
References: <cover.1255673756.git.wuzhangjin@gmail.com> <c709487f102bcd028fd637f5692ff42d94c55b33.1255673756.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c709487f102bcd028fd637f5692ff42d94c55b33.1255673756.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 16, 2009 at 02:17:15PM +0800, Wu Zhangjin wrote:

> This patch registers the reserved pages for loongson family machines.

Hmm...  After our recent discussion on your hibernation issues I am
wondering if this patch is actually still required or useful?

  Ralf
