Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Feb 2008 14:43:23 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:11736 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28583759AbYBYOnV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Feb 2008 14:43:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1PEhLg1005745;
	Mon, 25 Feb 2008 14:43:21 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1PEhKs4005744;
	Mon, 25 Feb 2008 14:43:20 GMT
Date:	Mon, 25 Feb 2008 14:43:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS, 2.6.16, PATCH] Re-enable sync instruction for non-R2
	CPUs
Message-ID: <20080225144320.GA29391@linux-mips.org>
References: <20080225142112.GA25530@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080225142112.GA25530@networkno.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 25, 2008 at 02:21:14PM +0000, Thiemo Seufer wrote:

> This patch re-enables the use of sync instructions for non-R2 CPUs.
> It is only relevant for the linux-2.6.16-stable branch.

Thanks, applied.

  Ralf
