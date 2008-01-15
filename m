Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 19:25:52 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:3031 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037947AbYAOTZu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 19:25:50 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0FJPmC9001478;
	Tue, 15 Jan 2008 19:25:48 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0FJPm8B001477;
	Tue, 15 Jan 2008 19:25:48 GMT
Date:	Tue, 15 Jan 2008 19:25:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Cobalt 64-bits kernels can be safely unmarked
	experimental
Message-ID: <20080115192548.GB15858@linux-mips.org>
References: <200801151942.58038.florian.fainelli@telecomint.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200801151942.58038.florian.fainelli@telecomint.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 15, 2008 at 07:42:57PM +0100, Florian Fainelli wrote:

> This patch removes the condition on
> CONFIG_EXPERIMENTAL since 64-bits
> cobalt kernels runs fine.

Applied, thanks.

  Ralf
