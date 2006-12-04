Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2006 13:31:08 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:31648 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038831AbWLDNbH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Dec 2006 13:31:07 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB4DV6dp032556;
	Mon, 4 Dec 2006 13:31:06 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB4DV5D9032548;
	Mon, 4 Dec 2006 13:31:05 GMT
Date:	Mon, 4 Dec 2006 13:31:05 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc:	linux-mips@linux-mips.org, Willy Tarreau <wtarreau@hera.kernel.org>
Subject: Re: [2.4 PATCH] mips/mips64 mv64340 parenthesis fixes
Message-ID: <20061204133105.GA30410@linux-mips.org>
References: <200612041036.21953.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200612041036.21953.m.kozlowski@tuxland.pl>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 04, 2006 at 10:36:21AM +0100, Mariusz Kozlowski wrote:

>         This patch fixes parenthesis mv64340 stuff in both mips and mips64 code.

Applied.  Not that anybody case much, the broken macros were unused ...

  Ralf
