Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2004 17:37:30 +0100 (BST)
Received: from p508B6C63.dip.t-dialin.net ([IPv6:::ffff:80.139.108.99]:37451
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225477AbUEQQha>; Mon, 17 May 2004 17:37:30 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i4HGaexT032761;
	Mon, 17 May 2004 18:36:40 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i4HGadPm032760;
	Mon, 17 May 2004 18:36:39 +0200
Date: Mon, 17 May 2004 18:36:39 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Alexander Markley <alex@cyberMalex.com>, linux-mips@linux-mips.org
Subject: Re: SGI O2 MIPS R5000 bootp problems
Message-ID: <20040517163639.GA32507@linux-mips.org>
References: <40A8E08B.7070203@cyberMalex.com> <20040517161515.GA5706@umax645sx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517161515.GA5706@umax645sx>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 17, 2004 at 06:15:16PM +0200, Ladislav Michl wrote:

> > 7536
> > Cannot load bootp():r5000_boot.img.
> > Range check failure: text start 0x88802000, size 0x1d70.
>                                   ^^^^^^^^^^
> What kernel version are you running? This bug was fixed quite long ago.
> I'd recommend using recent cvs and patch by Ilya
> http://www.total-knowledge.com/progs/mips/patches

Looks like an attempt to load an IP22 kernel into an IP32.

  Ralf
