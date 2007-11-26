Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 16:20:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:43958 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039146AbXKZQUU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Nov 2007 16:20:20 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAQGJWLD023229;
	Mon, 26 Nov 2007 16:19:33 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAQGJVoE023228;
	Mon, 26 Nov 2007 16:19:31 GMT
Date:	Mon, 26 Nov 2007 16:19:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [UPDATED PATCH] IP22ZILOG: fix lockup and sysrq
Message-ID: <20071126161931.GA22879@linux-mips.org>
References: <20071126160538.507EAC2B22@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071126160538.507EAC2B22@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 26, 2007 at 04:58:03PM +0100, Thomas Bogendoerfer wrote:

> - fix lockup when switching from early console to real console
> - make sysrq reliable
> - fix panic, if sysrq is issued before console is opened
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Several Indy users have reported the issues fixed by this patch so it's
2.6.24 material.

  Ralf
