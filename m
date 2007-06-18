Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2007 15:12:04 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:23522 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023240AbXFROMC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Jun 2007 15:12:02 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5IE2fVK000919;
	Mon, 18 Jun 2007 15:03:02 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5IE2fZY000918;
	Mon, 18 Jun 2007 15:02:41 +0100
Date:	Mon, 18 Jun 2007 15:02:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Aurelien Jarno <aurelien@aurel32.net>, linux-mips@linux-mips.org,
	qemu-devel@nongnu.org
Subject: Re: 2.6.21 kernel on emulated/real Malta board
Message-ID: <20070618140241.GA757@linux-mips.org>
References: <20070616204834.GA610@farad.aurel32.net> <Pine.LNX.4.64.0706171005470.4497@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706171005470.4497@anakin>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jun 17, 2007 at 10:06:55AM +0200, Geert Uytterhoeven wrote:

> I guess it's just the printk buffer that's being output again to the new
> console, when the console subsystem switches from early console to real
> console.

Correct.

  Ralf
