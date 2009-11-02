Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 15:02:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43772 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493898AbZKBOCL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 15:02:11 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA2E3Xtl024047;
	Mon, 2 Nov 2009 15:03:34 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA2E3WJL024045;
	Mon, 2 Nov 2009 15:03:32 +0100
Date:	Mon, 2 Nov 2009 15:03:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com
Subject: Re: [PATCH -queue 6/7] [loongson] remove reference from bonito64
Message-ID: <20091102140332.GE21563@linux-mips.org>
References: <cover.1255673756.git.wuzhangjin@gmail.com> <2aaf6778010c608858cf7af1bd46d226f89bf355.1255673756.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aaf6778010c608858cf7af1bd46d226f89bf355.1255673756.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 16, 2009 at 02:17:19PM +0800, Wu Zhangjin wrote:

> There is a built-in northbridge in loongson2e/2f, which is bonito64
> compatiable, but it differs from bonito64. to avoid influencing the
> original bonito64 support and make the loongson support more
> maintainable, it's better to remove reference from bonito64.
> 
> And this patch is a very important preparation for the coming loongson2f
> family machines' support, all the coming patches depend on it.

Thanks, queued for 2.6.33.

  Ralf
