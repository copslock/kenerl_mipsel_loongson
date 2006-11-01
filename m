Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2006 12:51:45 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:32400 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039648AbWKAMvo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Nov 2006 12:51:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kA1CqAle015030;
	Wed, 1 Nov 2006 12:52:10 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kA1CqASR015029;
	Wed, 1 Nov 2006 12:52:10 GMT
Date:	Wed, 1 Nov 2006 12:52:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix warning LOAD_VGA_FONT is not defined
Message-ID: <20061101125210.GB11655@linux-mips.org>
References: <20061101184536.330411b1.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101184536.330411b1.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 01, 2006 at 06:45:36PM +0900, Yoichi Yuasa wrote:

> arch/mips/qemu/q-vga.c:140:5: warning: "LOAD_VGA_FONT" is not defined

Applied,

  Ralf
