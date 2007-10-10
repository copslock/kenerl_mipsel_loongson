Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 14:55:24 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:15777 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023332AbXJJNzW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 14:55:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9ADtM4E006923;
	Wed, 10 Oct 2007 14:55:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9ADtLhQ006922;
	Wed, 10 Oct 2007 14:55:21 +0100
Date:	Wed, 10 Oct 2007 14:55:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add missing generic GPIO option support for au1000
Message-ID: <20071010135521.GA26832@linux-mips.org>
References: <200710101455.58249.florian.fainelli@telecomint.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200710101455.58249.florian.fainelli@telecomint.eu>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 10, 2007 at 02:55:55PM +0200, Florian Fainelli wrote:

> With the generic GPIO support for au1000, we do not
> select it in the kernel configuration.

So I wonder how this one went unnoticed for so long unnoticed - turns out
your previous GPIO patch's Kconfig segment for Alchemy from May 22 looks
different in GIT than what you mailed out and I think that was a class
case of quilt using patch with by default has the bl**dy fuzz factor
enabled ...

I'll fix this one ...

   Ralf
