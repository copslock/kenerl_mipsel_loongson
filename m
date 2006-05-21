Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 May 2006 21:53:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:15004 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133901AbWEUTxS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 21 May 2006 21:53:18 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4LJrHO0016162;
	Sun, 21 May 2006 20:53:17 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4LJrGah016161;
	Sun, 21 May 2006 20:53:16 +0100
Date:	Sun, 21 May 2006 20:53:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Novoa III <mjn3@codepoet.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: qemu patches vs 2.6.17rc4
Message-ID: <20060521195316.GA14733@linux-mips.org>
References: <20060521190722.GA24079@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521190722.GA24079@codepoet.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 21, 2006 at 01:07:22PM -0600, Manuel Novoa III wrote:

> 2 patches attached...

Please only send one patch per email, with Signed-off-by: lines.

> q-vga.c.patch                gets virtual consoles working with qemu
> arch-mips-Kconfig.patch      enables setting little endian for qemu
> 
> The q-vga.c changes are just a literal port of some public domain vga
> code... specificly http://my.execpc.com/~geezer/osd/graphics/modes.c.

No problem with that.

There is one big issue with this patch however - it's putting a font under
arch.  Fonts have no business under arch/.  Can you try to find a way to
use the fonts we have under drivers/video/console?

  Ralf
