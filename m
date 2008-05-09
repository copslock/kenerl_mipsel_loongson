Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2008 17:37:36 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:41648 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021919AbYEIQhd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 May 2008 17:37:33 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m49GbXFB002939;
	Fri, 9 May 2008 17:37:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m49GbVAO002921;
	Fri, 9 May 2008 17:37:31 +0100
Date:	Fri, 9 May 2008 17:37:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Au1200: MMC resource size off by one
Message-ID: <20080509163730.GB14170@linux-mips.org>
References: <200805082306.17553.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200805082306.17553.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 08, 2008 at 11:06:17PM +0400, Sergei Shtylyov wrote:

> Au12x0 MMC platform device strangely claims 0x41 bytes for its memory-mapped
> registers.  Make it claim the whole 0x80000 instead according to the memory
> map given in the datasheets.

Thanks, applied.

  Ralf
