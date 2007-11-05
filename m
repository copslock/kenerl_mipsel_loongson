Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 11:43:31 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:9936 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029893AbXKELn3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 11:43:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA5BhDQU028741;
	Mon, 5 Nov 2007 11:43:13 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA5BhDCB028740;
	Mon, 5 Nov 2007 11:43:13 GMT
Date:	Mon, 5 Nov 2007 11:43:13 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Roel Kluin <12o3l@tiscali.nl>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] iounmap if in vr41xx_pciu_init() pci clock is over
	33MHz
Message-ID: <20071105114313.GE27893@linux-mips.org>
References: <472DB446.3020804@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472DB446.3020804@tiscali.nl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 04, 2007 at 01:00:06PM +0100, Roel Kluin wrote:

> iounmap if pci clock is over 33MHz

Applied.  Note that this is purely cosmetic; for 64-bit kernels or
anything in the low 512MB of physcial address space ioremap on a 32-bit
kernel ioremap can never fail on MIPS and iounmap is a nop in this case.

  Ralf
