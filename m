Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jan 2007 14:39:40 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:45725 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28583673AbXATOjj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 20 Jan 2007 14:39:39 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0KEdZdN030376;
	Sat, 20 Jan 2007 14:39:36 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0KEdMYb030375;
	Sat, 20 Jan 2007 14:39:22 GMT
Date:	Sat, 20 Jan 2007 14:39:22 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@stusta.de>
Cc:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] mips: remove the broken BINFMT_IRIX code
Message-ID: <20070120143922.GA30336@linux-mips.org>
References: <20070120140135.GT9093@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070120140135.GT9093@stusta.de>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 20, 2007 at 03:01:35PM +0100, Adrian Bunk wrote:

> The BINFMT_IRIX code:
> - has been marked as BROKEN for more than two years years and
> - is still marked as BROKEN.
> 
> Code that has been marked as BROKEN for such a long time seem to be 
> unlikely to be revived in the forseeable future.
> 
> But if anyone wants to ever revive this driver, the code is still
> present in the older kernel releases.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

NAK.

Steven Hill is working on it and the reason why it's marked broken is tiny
anyway.

  Ralf
