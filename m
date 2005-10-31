Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2005 11:26:30 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:33817 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133467AbVJaL0N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Oct 2005 11:26:13 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9VBQdaj020087;
	Mon, 31 Oct 2005 11:26:39 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9VBQc7n020086;
	Mon, 31 Oct 2005 11:26:38 GMT
Date:	Mon, 31 Oct 2005 11:26:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@stusta.de>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] OSS MIPS drivers: "extern inline" -> "static inline"
Message-ID: <20051031112638.GA13561@linux-mips.org>
References: <20051030000526.GP4180@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030000526.GP4180@stusta.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 30, 2005 at 02:05:26AM +0200, Adrian Bunk wrote:

> "extern inline" doesn't make much sense.

Thanks, applied.

  Ralf
