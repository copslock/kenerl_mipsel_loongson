Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 18:45:30 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:46267 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021395AbXHFRp2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Aug 2007 18:45:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l76HjQ45004444;
	Mon, 6 Aug 2007 18:45:27 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l76HjPqF004443;
	Mon, 6 Aug 2007 18:45:25 +0100
Date:	Mon, 6 Aug 2007 18:45:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] vr41xx: add cpu_wait
Message-ID: <20070806174525.GA11275@linux-mips.org>
References: <20070807000917.6bbd2c19.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070807000917.6bbd2c19.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 07, 2007 at 12:09:17AM +0900, Yoichi Yuasa wrote:

> Add cpu_wait for NEC VR41xx

Queued for 2.6.24.

Thanks,

  Ralf

PS: I take it you've verified that using the standby instruction with
    interrupts is safe on VR41xx?  There are alot of architectural
    restrictions in that area.
