Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 14:42:11 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54358 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493895AbZKBNmI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 14:42:08 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA2DhQ2M023187;
	Mon, 2 Nov 2009 14:43:26 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA2DhPIs023185;
	Mon, 2 Nov 2009 14:43:25 +0100
Date:	Mon, 2 Nov 2009 14:43:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com
Subject: Re: [PATCH -queue 5/7] [loongson] add serial port support
Message-ID: <20091102134325.GD21563@linux-mips.org>
References: <cover.1255673756.git.wuzhangjin@gmail.com> <35c04cb5cd3aa4c2d2fc3cbb471304a7f3434ebb.1255673756.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35c04cb5cd3aa4c2d2fc3cbb471304a7f3434ebb.1255673756.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 16, 2009 at 02:17:18PM +0800, Wu Zhangjin wrote:

> This patch add serial port support for all of the existing loongson
> family machines. most of the board specific part are put in serial.c,
> and the base address of the serial ports are defined as macros in
> machine.h for sharing it between serial.c and early_printk.c

Thanks, queued for 2.6.33.

  Ralf
