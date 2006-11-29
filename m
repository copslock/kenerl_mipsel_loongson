Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2006 19:43:53 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:54994 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027689AbWK2Tnv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Nov 2006 19:43:51 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kATJhkDC027446;
	Wed, 29 Nov 2006 19:43:46 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kATJhkC8027445;
	Wed, 29 Nov 2006 19:43:46 GMT
Date:	Wed, 29 Nov 2006 19:43:46 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips tx4927 missing brace fix
Message-ID: <20061129194346.GA20892@linux-mips.org>
References: <200611292030.36170.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611292030.36170.m.kozlowski@tuxland.pl>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 29, 2006 at 08:30:35PM +0100, Mariusz Kozlowski wrote:

> 	This patch adds missing brace at the end of toshiba_rbtx4927_irq_isa_init().

Thanks Mariusz!  Applied,

  Ralf
